Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC4FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937372171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOogLk7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIA5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:57:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGIA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:57:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so4522984pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ovvmvLXcN2WNj4sNwe4p/Xee5jrLgpchDLjIPq6YmSs=;
        b=jOogLk7Rn8Qffuitf+GhyMJJEvfkhY9IoNwS0oiC7kgcxvC7hcWLNLfZCUrkWrDkCt
         wzgyXYIcGChGJDMVffK9I1JdgAzPspuhFwRarpxbV5ScMXNuEvxZrvEDGbU9z1nQ4Pby
         C1yDzOfctZM5xNzF2j2UiOwnIsTn51sw0qWaQVMSzViDl+vwipjaZe3fUkopGq3l/Wbx
         tt9cdaScy+RIVLtLU3i1ovTXtDGK1YWnixyAl+r9uq9Helzuk0UuLWE7CoJP4gsVraSN
         4HLbVTv9AgzQmw/bN8ZC1ZEZN6TgykRtfBo51TTpeNsibZ2dTmm3NDlHDEP7S8r4r5/M
         F3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ovvmvLXcN2WNj4sNwe4p/Xee5jrLgpchDLjIPq6YmSs=;
        b=oCgUw4ZeTQ+eRSbJjqgWDwfBMoSSLnl/zKd5iqVPxs69XNtexvvzgmT6joK8gmH8kd
         zuk5eYxaWyjZ6Jp5GUurYag9Plw7jjluuGRrkng4AN+bViG4CpU+Blq6zvbEfk+EvUvv
         w94HdvO/w1NVNSLnwdo6Q1IQG8bzJqvO0Zlpkznzvl8+waDJRhb5eQatiKhwxknyta18
         V6jo4XYLZ0fwv49j9isbe8zI/F+Y1KH/+05/O8u9wAg5RaEFKhs3EvcQUPODN4O0eZml
         ZCWdNP6SisGJmNNmeDZbib3wUn3VQSvqqIm8wXYUGMQmUtA0fzNwlLw8B4LUQ2jBWjLu
         /nCg==
X-Gm-Message-State: APjAAAWHV94hBjA6gYaFQGf58+sbO8xv/QfZRNAMmcOk+q9I6oFvI/lM
        gGy1upjHHg2H2eN/Hw6Mm3c=
X-Google-Smtp-Source: APXvYqzSNUuTjgHJHseb1sIy2Pn9KXojzGnULdltP79uHnrMd5CKKPPe2fjbRm0R5Ggc8XUaiEF+bw==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr29371769pjr.8.1562633861026;
        Mon, 08 Jul 2019 17:57:41 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm32442857pfn.178.2019.07.08.17.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 17:57:40 -0700 (PDT)
Date:   Mon, 8 Jul 2019 17:58:10 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Message-ID: <20190709005809.GA28003@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 07:03:47AM +0000, S.j. Wang wrote:
> > 
> > > +
> > > +     /* restore registers by regcache_sync */
> > > +     fsl_esai_register_restore(esai_priv);
> > > +
> > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > +                        ESAI_xCR_xPR_MASK, 0);
> > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > > +                        ESAI_xCR_xPR_MASK, 0);
> > 
> > And just for curious, can (or shall) we stuff this personal reset to the reset()
> > function? I found this one is a part of the reset routine being mentioned in
> > the RM -- it was done after ESAI reset is done via ECR register.
> > 
> 
> There is a problem to do this, TPR/RPR need to be clear after configure the control
> register. (TCCR, TCR). So it seems not only one place (reset function) need to be
> changed.

Do you know (or remember) why we suddenly involve this TPR/PRP?
The driver has no problem so far, even if we don't have them.

The "personal reset" sounds like a feature that we would use to
reset TX or RX individually, while this hw_reset() does a full
reset for both TX and RX. So I wonder whether they're necessary.
