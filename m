Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2025C12
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1VgT/UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfE3PBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:01:51 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38036 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3PBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:01:50 -0400
Received: by mail-pf1-f180.google.com with SMTP id a186so3439361pfa.5;
        Thu, 30 May 2019 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bXVTnzNn3OxqQjLNbsEEP+BrmVnoXEVTBRZDLOj4oHM=;
        b=G1VgT/UKdoz05v6wch8nRGcrrAV+f/3iU8QVjpfS42vxcl1vp0ILPmBbFfAseVs/X/
         TgrES4P78oNrJkkLYoWfitx0IpQ8vvgD//hea0R69UkQTh6rjtkTly0OtkGvSsWVj6FF
         ZlaNNJfFThBZEbnhJfC68eJEqYaQ55ODIghMyd7I/mIz3cy/nfOV5pyBpYaRgf4SFUn9
         q/Yp7Iud0KqDzvnvBRuM6ooGp4SF2QbQHWzvehM14dS209vikfPEiAjKrA6OGeLR5RJB
         AGgvvvCbkNlK3FvfqaVjTd0Sd3O1lboGY1MKgj4oYrx8wS8TR2cd+nLeeVvhs4PuH7wr
         XJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bXVTnzNn3OxqQjLNbsEEP+BrmVnoXEVTBRZDLOj4oHM=;
        b=UbZ79anT6f+BUXXwjSq1I851fvRAXIOTjCwUlhf38cB1awCB/56YPWIdXoJMTtoQXZ
         +43R1WWcMc9x/L4HwHb1W98Qe4NcRqWcuGHKx+Go6QSDDvCDhoIvWVAxl28AsOkYQiOC
         2440tuSnrSTFbuG4wA1pQfPci55bt/N+dJ8Au2vJSA19BM3W6CFG1P52HGn+q4toskWo
         yVgvbdLan/P0xeyylVMAADqjlIDqXISRlz5j/FEetQD9rhgmDPOWDfuDVrw5jcPMjpwB
         LnTi6IUH2fu6qT3LPXDbcSH+nTAbbI4mkbA9mL4FXPl9z1WHVpBOMrs/i0VRPhgjU2B3
         4Ylw==
X-Gm-Message-State: APjAAAXiroE9r4XHQ4vdtyn59fGLFEakoI+zU44HcAqYjwMhGEXn4HYA
        ubSomEhuH8iPEFRj3T+kwtQ=
X-Google-Smtp-Source: APXvYqwV0TP2oFy7+ywo2/3FPXHDNDA3z9y3edHq3PfZrDdxNEABb5YEa5aizPl2O3sY89ROYEFtMg==
X-Received: by 2002:a63:5024:: with SMTP id e36mr4249736pgb.220.1559228510204;
        Thu, 30 May 2019 08:01:50 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id q3sm2546792pgv.21.2019.05.30.08.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 08:01:49 -0700 (PDT)
Date:   Thu, 30 May 2019 08:01:47 -0700
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
Message-ID: <20190530150147.kyokyfu462bhtvnf@localhost>
References: <20190528235627.1315-1-olteanv@gmail.com>
 <20190528235627.1315-4-olteanv@gmail.com>
 <20190529044912.cyg44rqvdo73oeiu@localhost>
 <CA+h21hoNrhcpAONTvJra5Ekk+yJ6xP0VAaPSygaLOw31qsGPTg@mail.gmail.com>
 <20190530035112.qbn3nnoxrgum7anz@localhost>
 <CA+h21hqko57LB0BB2TSGSr4p9_czPM-g9krO+wnU7PgvaMdSDA@mail.gmail.com>
 <20190530142356.vxkhsjalxfytvx2c@localhost>
 <CA+h21hqqO2RYv_zG3gW17c_NBJR80ag8PSVVan66douQN+MQpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqqO2RYv_zG3gW17c_NBJR80ag8PSVVan66douQN+MQpw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:47:55PM +0300, Vladimir Oltean wrote:
> Yes, they don't identify the original frame.
> The hardware's line of thinking seems to be "The meta frame is sent
> immediately after the trapped frame that triggered the action." (quote
> from https://www.nxp.com/docs/en/user-guide/UM10944.pdf).

Hm.

> If there was any other way to retrieve RX timestamps I would have done
> it already.

So it cannot even possibly work.
 
Sorry,
Richard

