Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CCBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862EA2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ4AnJwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfDJRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:52:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44367 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbfDJRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:52:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so1851033pll.11;
        Wed, 10 Apr 2019 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q6vMYeKcOVpG8+cf+myp9kRl+55Hdk3n7iRz3oEomxg=;
        b=lZ4AnJwPqrYpOXLlwsXmye9Kjw/QTaGGTQ/SWt2WSeIvfUQDZb/Q8CDjLQT5u3TdHN
         gaFzj7fu35Ey5SRWMyNjhDcBoSx4i6Df5SWSxKtN3VdETKeXD2V4eNpQqT8dqGAnuTA/
         Tj0bX62zHSlnJqSHzoL6HCIdTjNkwSQXKPInwT6MjwbXdNnwrLs68KOjiFOJSkX9mt8B
         ORZOOXyBN7LJug/nFbKYGEzLDO/yumS1IvZR7tm+Ei4sFd3OsRGnbrYsez5tYehDbDS9
         2mUrt4l0eOHv/BHQRu/blXBG8+XDBk5aow7ehJhYcl4stAPbgamnWRbmZsyWUQnEClvc
         9eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q6vMYeKcOVpG8+cf+myp9kRl+55Hdk3n7iRz3oEomxg=;
        b=lEHwVTSf9YVeGdHomN035Yp1u0Q9zXooaNfhGYT3NVuzzgYU7wVFPLK9a3CFTWbvnz
         SDqYyNfRqzD+DCeSK3XOUz47+ZI9CKmVNFlB6QAomjUR/raYc6Y6sosbeaS8i3wsHzSy
         +a4n38YUGPbpTMknRxT+KDLTFNvAzcHYGSGm6JaQMghOg1ArN190SUJXV1TcWdDOy2H0
         xZtCckAvBX4FxWhmAAQw+s3roANLm62Xxce7TbgbQuGRtSnMK6pWEPEKHZvcT0XCdBuV
         x16+LGPjgjYArdMEWAI+V1Z6GfdUpeyrXANUQ8y6Y4ss/HToFSJGGNGZ4DDlcGCLI8Ew
         mLAA==
X-Gm-Message-State: APjAAAU/sh5XqlAbtYJP8X78+7EUqPFK5pDS8FTrjcKGRPeJAth3hasu
        kRVU5R8BNraFKFhlAqGqPhNgz42W
X-Google-Smtp-Source: APXvYqyYAr070mCEgCOdEwxn0JzLGuhE+1VYlxcSGQxthBDZLWuUHTQzOcPFDnSLhPxUXDPeeV46/A==
X-Received: by 2002:a17:902:e704:: with SMTP id co4mr4527330plb.30.1554918722850;
        Wed, 10 Apr 2019 10:52:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a12sm41223688pgq.21.2019.04.10.10.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 10:52:02 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:51:57 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
        "perex@perex.cz" <perex@perex.cz>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Message-ID: <20190410175156.GA24002@Asurada-Nvidia.nvidia.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
 <1554892497.14997.13.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554892497.14997.13.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:34:57AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> 
> On Ma, 2019-04-09 at 21:29 -0700, Nicolin Chen wrote:
> > WARNING: This email was created outside of NXP. DO NOT CLICK links or
> > attachments unless you recognize the sender and know the content is
> > safe.
> > 
> > 
> > 
> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > 
> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > > 
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > > 
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++-----------
> > > ---------
> > >  1 file changed, 23 insertions(+), 20 deletions(-)
> > > 
> > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv,
> > > 0, NULL,
> > > +                                                0);
> > Would you please send a separate patch to replace "pdev->dev"?
> 
> Thank you for review. Yes, will send V3.

Ah...when I said that, I was literally saying that you should
send a separate patch individually, not resend the series.

Now I see you sent v3/v4 almost at the same time as "Applied"
mails from Mark. And I am totally confused which version got
applied....

Please rebase your local tree and find out which version got
applied and then send the diff with a separate patch.

Thanks
Nicolin
