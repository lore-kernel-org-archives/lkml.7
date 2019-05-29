Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15730C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8D821734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMPu4bTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfE2EtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:49:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfE2EtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:49:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so575658pgm.7;
        Tue, 28 May 2019 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UBkxEJYcGn6+s1SysMWi5wo25MUrw19X+MbK0vtZQEU=;
        b=pMPu4bTrEd96EezjpUlQV3YFd6XRMwzsxzvluGGivPkNhxxKWnUS7ExAxoUZUrPU56
         6mXhn4gceGJaPX4T81BuQJaDu8ZqCzQeSeYnPbullUCio6WveRQWMSSPpUDc9sEYgVPx
         4SGxbnZM1MeCbOT5e7A2+5MuOfRQ41zhzqmegduQl1Wr9n9Wmiz2+PZ1c4oXIQRbodql
         8Abe08sux/7uDsj2pELrrkGJ6ukjjHSIh+HHJIXCdZHOSZ+PbQhY/Smdkse6iD+6m/ZV
         KJEozcWxOk0i7Wao93DbaptJXLVLy5hcnI/Hl1DynYoQzAVRP4tQdwf1yQwnhaeU5USu
         RQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBkxEJYcGn6+s1SysMWi5wo25MUrw19X+MbK0vtZQEU=;
        b=Mnjncr1PuvoMwyAP6NvakwjhYpJZBre/VHOtYeupLh5g14+HMkXiZTBBTESX5iQBjH
         FMsFyCJWNTZlGkPsDRF6ic+Jg3s7NamDww/4+4N+Pf7qZKomc1T7bEtaE85DJTrayQ9v
         aFI6h3LbzHGDsmNGjhy5V4ZqzDOVSV3OfKW2aTSjyQxwclg6tJL5cStSiiXD2wpYX8pz
         NqPyeqmPgh17ItCz/G2m27vLwRb9a9+ODFKAud14nDqOeUNN1eaiZFN3Hc/Z7Lqe9nlv
         3km8R7UYLxBZck06C2OkdBBYLRD3yMHsW9yhy9wEL/KoQbsZibJX2DQEd6L5DrtrOxmd
         3M5Q==
X-Gm-Message-State: APjAAAX6zuBQSat70XdiDOAHk/LBmmtV01F/WJjZI1iVaR14YmI8OVIo
        8YAJYOPrtBTx7i/4WenH+N8=
X-Google-Smtp-Source: APXvYqxoUje5duyDnEPS6mGgFOvSrW7Zm05auAFcO9KUVG4bFBZoHWQfwrAjWSyXs16iRP4C5VsYSA==
X-Received: by 2002:a65:494a:: with SMTP id q10mr41447263pgs.201.1559105356065;
        Tue, 28 May 2019 21:49:16 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id r7sm4255547pjb.8.2019.05.28.21.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 21:49:14 -0700 (PDT)
Date:   Tue, 28 May 2019 21:49:12 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: dsa: mv88e6xxx: Let taggers specify a
 can_timestamp function
Message-ID: <20190529044912.cyg44rqvdo73oeiu@localhost>
References: <20190528235627.1315-1-olteanv@gmail.com>
 <20190528235627.1315-4-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528235627.1315-4-olteanv@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:56:25AM +0300, Vladimir Oltean wrote:
> The newly introduced function is called on both the RX and TX paths.

NAK on this patch.
 
> The boolean returned by port_txtstamp should only return false if the
> driver tried to timestamp the skb but failed.

So you say.
 
> Currently there is some logic in the mv88e6xxx driver that determines
> whether it should timestamp frames or not.
> 
> This is wasteful, because if the decision is to not timestamp them, then
> DSA will have cloned an skb and freed it immediately afterwards.

No, it isn't wasteful.  Look at the tests in that driver to see why.
 
> Additionally other drivers (sja1105) may have other hardware criteria
> for timestamping frames on RX, and the default conditions for
> timestamping a frame are too restrictive.

I'm sorry, but we won't change the frame just for one device that has
design issues.

Please put device specific workarounds into its driver.

Thanks,
Richard
