Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D448C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2312B2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578347843;
	bh=BZqjl5C0O+IW5Z5GFdY8nA7SPKsDOaxMIOyGcQ3RhWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pH6kYg/E+ACKk79XlgPqZ2mCb0D0ZOkHbloKbZ6RJp3HsLkEbSnBTUwc+70gUkcPk
	 FgPIzehdriZV1qlDIdqrELONy3EgnOctpdsNtrNtpOVd3oq+vPl0HecoxlhVy44375
	 S5aerc0ZccGCgtqgkNWjH/Q0OAkHkLUY9UhMXh68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAFV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:57:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36977 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:57:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id z64so10673752oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGQuR1M/qYi2xyMJHlEfzvhIn09Q2tETaZrs1ID5PBc=;
        b=iqOg8U2zLanN0k7OOW27jHIAlMUGotdpFW0AUla5K01fajV7AQdFv4z/B2crCIGLtD
         Rkngl0JVvwervnVz2VAuXmfzRKiwZgXaXeyLmT9FpgrjuvjLaedH7Xm3s80Njk+Xv571
         eqIw+sWCdU1Q1gflsHjezPVPqhrjnBrlf4pz4S+9/RWNvVYtIAiU6KGrJOaMiK3JgEpB
         zqm9fHPAGS9YjYcqNcGZfDy2kSrAtqVosW29SKgTXid089ktBTp5VjE0xUHLsDH6gEMs
         MJbc17X2buMcrmIK8YwLuG/Y1TPKgDAZ29uFtHg6oiEeFJGBoxPonPf0AKa/tAeLFrzY
         rpSQ==
X-Gm-Message-State: APjAAAVP8M+b6lzkTWS0N6yNc7m7pA6gNWpDfe3O/ikmzaZF3HTmyIJY
        NrUoJXpFSfUKcG0YB9YBx6g/kuQ=
X-Google-Smtp-Source: APXvYqyU3tR9Vgu32Dxbi/FJCzzEASTY+BZWl7tm7AcoapEtyBfK+5oQ/U1mtBg1wiyVG/mb0UX8KQ==
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr5991721oic.44.1578347840795;
        Mon, 06 Jan 2020 13:57:20 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id m185sm16487778oia.26.2020.01.06.13.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 13:57:19 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220d32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 15:57:16 -0600
Date:   Mon, 6 Jan 2020 15:57:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chao Hao <chao.hao@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: mediatek: Add bindings for MT6779
Message-ID: <20200106215716.GA31059@bogus>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
 <20200105104523.31006-2-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105104523.31006-2-chao.hao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jan 2020 18:45:05 +0800, Chao Hao wrote:
> This patch adds description for MT6779 IOMMU.
> 
> MT6779 has two iommus, they are MM_IOMMU and APU_IOMMU which
> use ARM Short-Descriptor translation format.
> 
> The MT6779 IOMMU hardware diagram is as below, it is only a brief
> diagram about iommu, it don't focus on the part of smi_larb, so
> I don't describe the smi_larb detailedly.
> 
> 			     EMI
> 			      |
> 	   --------------------------------------
> 	   |					|
>         MM_IOMMU                            APU_IOMMU
> 	   |					|
>        SMI_COMMOM-----------		     APU_BUS
>           |		   |			|
>     SMI_LARB(0~11)  SMI_LARB12(FAKE)	    SMI_LARB13(FAKE)
> 	  |		   |			|
> 	  |		   |		   --------------
> 	  |		   |		   |	 |	|
>    Multimedia engine	  CCU		  VPU   MDLA   EMDA
> 
> All the connections are hardware fixed, software can not adjust it.
> 
> >From the diagram above, MM_IOMMU provides mapping for multimedia engine,
> but CCU is connected with smi_common directly, we can take them as larb12.
> APU_IOMMU provides mapping for APU engine, we can take them larb13.
> Larb12 and Larb13 are fake larbs.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         |   2 +
>  include/dt-bindings/memory/mt6779-larb-port.h | 215 ++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
