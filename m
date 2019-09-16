Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD3EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCB921670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3YqvSe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbfIPNGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:06:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36244 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbfIPNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:06:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id t3so10295975wmj.1;
        Mon, 16 Sep 2019 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sIVQ04sXbtRDPC23vD1rE8CSxbsV5Z0Y5ojuZ/wNZpk=;
        b=m3YqvSe/4vcHzepLoMnqpXvXP8e+8ov4gmJ49ZFmzEPmlzYsHf3Vi5uvPV/wwRvibD
         kHPd5LJdYK2ioRVNyLF467TZkr2oe7rQl62hhxI4KEGsrTez/dYPLM+x6QlKQi+ypqHq
         UP+fnpx44zAB8cg7PKpYbCOms6voKoKhkfO5jLrX9ZgR8fTQ7UJjEmudWjP+voDGlm3k
         6IGUZSTl8IMqMw8BWQPbZkbgImR8GUETuOvlUGtl3Hx4u78NdPZvbW+QbTQuT0nz67Ek
         aVlN+DONJpIlMxZAZslpVW2HBh3oMEniCp8PKsmLFn2sZ3rXopig/AlWPObAKaTSwekg
         Splg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sIVQ04sXbtRDPC23vD1rE8CSxbsV5Z0Y5ojuZ/wNZpk=;
        b=DaN3ijHaG9nCQnQSyuL4p2JpD51LC+proUAktRgYUfNtu/cMgr9MAKwUWu19uOd0X9
         EghChPxGM1FJXor5d4pdKZNjbTr106YSTbPCmry5C9ea4pkHHBICLXwWOLFu911IQsmD
         x2Xpa6YnugBLnq7DSIoqAAUbdRnH9787z24JzNV9YtnuUv8fNjySON7fQXhYTCgezWUR
         ViwYjoFI/cCwsvzjcw1brI5iUnz4vbyDr/oSbkTleNFjdcfrElPeXTGLmsjhLmCNVLUg
         J+2Jrlv+By8CB1SQfneH4fuxrUfd7C4Edlsc9EotaUtsuNDZUvu3JGzlBKUS9Xt1ruK+
         6PiQ==
X-Gm-Message-State: APjAAAUj++8R8WqjumNxdwfKmWJ0ci9ClVC6CuAf69+qxd77+mH5EnmC
        GkDPoRK4wg/w4fZLv85RMbA=
X-Google-Smtp-Source: APXvYqwtxlI1qOa2qQlAR2X0AyFfrrLHbOVlnn4CIXRAYrvyhOOilm8R+aJgzIXbhKbm9YwamftRfg==
X-Received: by 2002:a05:600c:248a:: with SMTP id 10mr1127779wms.97.1568639167343;
        Mon, 16 Sep 2019 06:06:07 -0700 (PDT)
Received: from ubuntu-buildhost (ipb21b6e0b.dynamic.kabel-deutschland.de. [178.27.110.11])
        by smtp.gmail.com with ESMTPSA id e30sm71943733wra.48.2019.09.16.06.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 06:06:06 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:06:04 +0000
From:   Markus Kueffner <kueffner.markus@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Message-ID: <20190916130604.GA3140@ubuntu-buildhost>
References: <20190411065440.GB26817@dragon>
 <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
 <20190415091150.GB18917@X250.skyworth_vap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415091150.GB18917@X250.skyworth_vap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:11:51PM +0800, Shawn Guo wrote:
> On Sat, Apr 13, 2019 at 03:19:36PM +0200, Markus Kueffner wrote:
> > Add Pincfgs to enable the i.MX6's OTG feature for UDOO
> > 
> > Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
> 
> Applied, thanks.

Hello, 

I was wondering when this might get merged into a release. 
Is there anything else I need to fix?

Best Regards, 
Markus
