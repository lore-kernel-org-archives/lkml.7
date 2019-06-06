Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0603C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C702083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay6RwqsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFFAQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:16:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44033 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:16:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so307178pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cK/gGt5PDimlIevfbs8g1ARiYxKpO3It4jGHeUdOAXQ=;
        b=Ay6RwqsM05DNTHbEStXHw3SHZKFvhBkjCx8hE4XKG0cWnEjcpqh9Jb33U70NaQK5P5
         JRB8pq/Yv1iSxEVJIdwTFVeT956CEFAyRS+KdKadsqMAOE1dxxx+kkZc0J6ibY/EiQyk
         T9Y5dPWUBdYx++K6X+6MKeB2LVaUPXV+C4qmTvSoXFCUYIy/2stW9i01QSf95M6u7QZS
         yOWMQZbN/65Ot9oZZLwrgeVSLMaOpkZZHSFhYVwnf0bi9BYjcCMKc2jmCZTqpbWUoaaD
         hN0xLeFv976DkIpB+bXcUTrk7gNaxhhJrKKpNfMfJZGgFogEMT2CIntoAluVsBdoA8Xi
         m6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cK/gGt5PDimlIevfbs8g1ARiYxKpO3It4jGHeUdOAXQ=;
        b=kpMclDq+Pd5Hl0zo2QnbLbSsUyy3jiXBaKUsRs5COEwLumG6a4wuNqZqYmEZhONTNM
         Chp84MGTWFENBi5YZfhjqL4jqwP9rkyoLS4NPakehYHzmOlf/goWV7N9f15ndG3da63A
         THvhzD2JckKrNS/ss+rUdZrhfkjoRB0N/KuFO3s5lP2pgS5yhhmioDRQeIcO15C/q7+s
         WqQcG5kPvrkD8QcmR6ViMPWTCOI2D3qp6gWuDd9uNYKuBbEx8DncDVD1bKmhMGU+8MSX
         1+SUl9eVEew8RIrzBschnNLf/JMmmoBfqgkZMath90FU3aHgpjd1+l6sIOGPfChNxRO6
         CvHg==
X-Gm-Message-State: APjAAAVVcc1WWBsJ8MAxAZJp5uKU+iRfDmgqLeWCVL+DMaogloGfXbcv
        WXIdw2JBY7iKXEeECopu/hA=
X-Google-Smtp-Source: APXvYqxwKRXiNuveG7RIUpRL8Y8GH4zg3HqUKLfaIlbElDmZUZU2dbjjzlJ33UBzpFgTEcuhwJbeAA==
X-Received: by 2002:a17:90a:338e:: with SMTP id n14mr46596229pjb.35.1559780204786;
        Wed, 05 Jun 2019 17:16:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 10sm93476pfh.179.2019.06.05.17.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 17:16:44 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:16:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Message-ID: <20190606001644.GA20103@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu,

On Wed, Jun 05, 2019 at 10:29:37AM +0000, S.j. Wang wrote:
> > > ETDR is not volatile,  if we mark it is volatile, is it correct?
> > 
> > Well, you have a point -- it might not be ideally true, but it sounds like a
> > correct fix to me according to this comments.
> > 
> > We can wait for Mark's comments or just send a patch to the mail list for
> > review.
> 
> I test this patch, we don't need to reset the FIFO, and regcache_sync didn't
> Write the ETDR even the EDTR is not volatile.  This fault maybe caused by

The fsl_esai driver uses FLAT type cache so regcache_sync() would
go through regcache_default_sync() that would bypass cache sync at
the regcache_reg_needs_sync() check when the cached register value
matches its default value: in case of ETDR who has a default value
0x0, it'd just "continue" without doing that _regmap_write() when
the cached value equals to 0x0.

> Legacy, in the beginning we add this patch in internal branch, there maybe
> Something cause this issue, but now can't reproduced. 

The "legacy" case might happen to have two mismatched ETDR values
between the cached value and default 0x0. And I am worried it may
appear once again someday.

So I feel we still need to change ETDR to volatile type. And for
your question "ETDR is not volatile,  if we mark it is volatile,
is it correct?", I double checked the definition of volatile_reg,
and it says:
 * @volatile_reg: Optional callback returning true if the register
 *		  value can't be cached. If this field is NULL but

So it seems correct to me then, as the "volatile" should be also
transcribed as "non-cacheable".

Thanks
Nicolin
