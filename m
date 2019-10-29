Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF70921479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572374420;
	bh=m4HQJu+UK0nOWAdGK5auazksuVTW6KUMKDGaIoTEGVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ytXP2Iz+bxoMjPXa+7nN60hPXamNnPE+cc10uDeWE7xS5djhKpHONImZpShuL7Mgf
	 GnlNuuJHlO1KoleDPaemsN/cNraA/I+FABop1gmOJ2yc3Bz1SgZKt/Hl9aU5z7jdW0
	 WpFypqPipP3fX85FMFVBCVJkrI8ZWA9aBzGo9NOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfJ2SkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:40:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41747 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfJ2SkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:40:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id 94so10654333oty.8;
        Tue, 29 Oct 2019 11:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iDxdZruyiKYu6zF9b1JiWGiLIkNbAfqYufuqttmPvyM=;
        b=hg3YAV2dqSRfF+V1UOq2d7OPrNIUkgcjcjAfhF8p0l32iL9bvjUq3yvBEXX3djVE3E
         sl6vthF/BiNtxC/e0WspOGjLBJQIodQgQ4oIVvm+IEeCbytbx6cPuXJ2RM8zhVDJs6Ud
         G6/BeWoQ8vu1OFzRSC7LKMMLwBpch9rc5aevWutz+JQEWwukNuwiCbFDECUB3PLJlror
         MqLO0bX+/xD/+Ms/Leak9F2m7AmrSIY7LEZGTyfcyntrBEUILbmbEOKXUDRxeNqcVdnZ
         f49Q6xK6LnI1anoy11w/d2nihoDagfEDlAzDNfv4ma6ISvs7y5A6Z505wiq1nXNKCWsW
         xMXg==
X-Gm-Message-State: APjAAAWK4bnx+SizqAnoidOhn5+ZfJ51/4K2eRAqO4est80TNnhaQvl9
        UapqyvAGX1mP52Z2EFeTSQ==
X-Google-Smtp-Source: APXvYqxGDWSxCV3m1MjSffGqN3eqpsL9XchgtHMl706xJRcvchuAFMgZoqmBkf0ja7eF7gUpCpJdCQ==
X-Received: by 2002:a9d:ef0:: with SMTP id 103mr18967111otj.2.1572374416544;
        Tue, 29 Oct 2019 11:40:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z1sm3178864oih.14.2019.10.29.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:40:15 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:40:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: arasan: Update Documentation
 for the input clock
Message-ID: <20191029184014.GA837@bogus>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
 <1572345042-101207-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572345042-101207-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 16:00:36 +0530, Manish Narani wrote:
> Add documentation for an optional input clock which is essentially used
> in sampling the input data coming from the card.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
