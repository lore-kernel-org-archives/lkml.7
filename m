Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3907FC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C51207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573083630;
	bh=aWpquujQswob80glZ0nqffhkfBSbv/6/PkoNQ+HYCnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UAaE1aOPh9DtNoycSsjSISrFSbiy8tW5Y9NOcCyArmqWwhsRy7y3X9w1ZSBtXDkPx
	 pZfc6AfSaJuc/Ho3+FmZfTM20V9RlHsTn166qxoBrVAz/lI5xzCynW+cCmDqcu0Pq6
	 ZIazzpOFsVQoCN/e67sXwVwTlkMTOzJADN7aFx4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfKFXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:40:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46950 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKFXk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:40:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id n14so275203oie.13;
        Wed, 06 Nov 2019 15:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9+XxF3bme0TDxNV87CvWxfYp74g7+cBn1OYi++I3PY=;
        b=Me42EjJ69VCvkEPHBlga6AUg2dwgkqMLgU9yIIydr9Jt7EWAGYrx4dmtuJmhw66PWN
         hlYt59hwphwkidieyUC+IRU2xyC4uDrjKNkwDE1544wVaTEQrW3Pf+eOta3k/rmNi+y1
         WWTdmMJERqCuaXi892Cd6SDDFpXhmZWIDRo93/zOEzOTm4ZbezSAuzZJMM452Hyr5g9d
         DLvjenouM/1Ftt2uCczyaGpbpzJCV7cyQE2cmi1l25Rcao7Y0U+HClfZpwXRVoZnw9w8
         reLTaRQ5yqTaXazFU5dR+gA4y6QYXJiUs8rkDTSaQUNPld5ru56GYxMD12MfAo4anCgU
         Hbbg==
X-Gm-Message-State: APjAAAUhyiyq5FhAEUWP+gZG12P9ZbYFynBv9xB1GysY375IItAG45Oy
        Qx4u7lSwEqbokZR4g7F7DQ==
X-Google-Smtp-Source: APXvYqySo4f8qKaS3Uh1xjvS4bwqGL+HLtxodI5d2sqmKN62Uk9p/GW8ZMzcEf/idpRcKBR9Z7JIMA==
X-Received: by 2002:a05:6808:3b1:: with SMTP id n17mr565821oie.50.1573083627798;
        Wed, 06 Nov 2019 15:40:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u4sm140222otb.35.2019.11.06.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:40:26 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:40:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chao Hao <chao.hao@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Guangming Cao <guangming.cao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: Re: [RESEND,PATCH 01/13] dt-bindings: mediatek: Add bindings for
 MT6779
Message-ID: <20191106234020.GA19463@bogus>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
 <20191104115238.2394-2-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104115238.2394-2-chao.hao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 19:52:26 +0800, Chao Hao wrote:
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
>  include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++++++++++++
>  2 files changed, 219 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
