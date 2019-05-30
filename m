Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B79EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B99925AD7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMJxlnxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE3OYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:24:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37095 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3OYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:24:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so4085318pff.4;
        Thu, 30 May 2019 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aqu62B/DKxla8ndIhEipp1qRgwp9oqBg86uO64aK/fw=;
        b=HMJxlnxJErTsQDLyfwoNeDIG5q3g/Bp40rZMlMSl5GtwYdNtW65QBIryuUiLa/QDjs
         /Y8iQbJgneYRKpyKqwdtQ6BhKIk3w75Zxxa+A0BxAvJ/C+Sa6H24WYxVFC1yrW2lp1lL
         cEvOq1oOC31YPsDULTabzzkHAVybxcthpyygqUAsL2lE0rF2stjkAxlGeZrNLVb96F6K
         EZySuoon5/6ueCgnOHQLs8AymOCmjDP7FntlEQ/G8WjL5RoKuVwzAu+2UDkFhuEhwbsv
         8v5vfURhH9LbX1rs11Hr00fLYV84DUyTqsjUHpY3kWLAGHS4lHPzJzloTLLx6tFfl/GX
         26zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aqu62B/DKxla8ndIhEipp1qRgwp9oqBg86uO64aK/fw=;
        b=GLI6DQt1pW5H7R3FFsnthJZdSF2voSoFDrg2CebMgprbqywEKRoYQ8bXAZPF0/8gyK
         SnuIj3+UY3FQVemY1+giYyJqOb5I3wkUfEc9SYpQ9PpalTLPE/Cti0HpfbTb81BlpU6d
         fV9txorQRF3dRObHwA2ds7fRhvkMo938+BoBrGg7L/r6QZFa8M38s11rgqSkLcPNOhT3
         9XAwwsLPxglSs5Yuvqtzm1lG5XhWA2J4WZ2OXoWnV/hnWr3m+LViXZZs66gnZehXFagk
         AKLZjKHtmGf2c8BK5aKhOJlq1FWpoFb4V16Tb3RWYGEtKGSzVE7wgrJ9DZw161B17yqu
         VAKQ==
X-Gm-Message-State: APjAAAWegkvPTg4EMgaXq1GGzH2MmfwevqV/EDQGaYL6eq1zWPnXwEWr
        2y9y8wmDFW+Que5JmdIuEk5sOC2a
X-Google-Smtp-Source: APXvYqwDm5nkekcJ7+8rVNtAGhVaUqWNPjush0pCuR+bMv37uZqwFXmvRk76eH94CEIO6fShKXbAXQ==
X-Received: by 2002:a65:514a:: with SMTP id g10mr3930486pgq.328.1559226240381;
        Thu, 30 May 2019 07:24:00 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id 194sm3466122pfb.125.2019.05.30.07.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 07:23:59 -0700 (PDT)
Date:   Thu, 30 May 2019 07:23:56 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net: dsa: mv88e6xxx: Let taggers specify a
 can_timestamp function
Message-ID: <20190530142356.vxkhsjalxfytvx2c@localhost>
References: <20190528235627.1315-1-olteanv@gmail.com>
 <20190528235627.1315-4-olteanv@gmail.com>
 <20190529044912.cyg44rqvdo73oeiu@localhost>
 <CA+h21hoNrhcpAONTvJra5Ekk+yJ6xP0VAaPSygaLOw31qsGPTg@mail.gmail.com>
 <20190530035112.qbn3nnoxrgum7anz@localhost>
 <CA+h21hqko57LB0BB2TSGSr4p9_czPM-g9krO+wnU7PgvaMdSDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqko57LB0BB2TSGSr4p9_czPM-g9krO+wnU7PgvaMdSDA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:42:41AM +0300, Vladimir Oltean wrote:
> The meta frames generated by the SJA1105 do not contain any seqid.

So this cannot ever work...

> They contain:
> * A globally programmable DMAC
> * A globally programmable SMAC

Don't know what these are, but doesn't sound like they uniquely
identify the original frame.

> * The 0x8 EtherType
> * A partial (24-bit or 32-bit) RX timestamp
> * Two bytes from the initial (pre follow-up) frame's DMAC, before the
> switch mangled those with the source port and switch id. The driver is
> supposed to patch these bytes from the follow-up back into the initial
> frame before passing them up the stack.
> * The source port that generated the meta frame
> * The switch id that generated the meta frame

None of these match to the original frame uniquely.  Looks like this
is a dead end.

I recommend forgetting about these meta frames.  Instead, read out the
time stamps over MDIO.

Thanks,
Richard
