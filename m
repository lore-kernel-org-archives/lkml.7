Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF1ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D1821872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pi2vCaoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfJVMFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:05:17 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:42028 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbfJVMFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:05:17 -0400
Received: by mail-lj1-f181.google.com with SMTP id u4so2761764ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VGTfUe//Lkyyq1CFsi2Aw+FdHH2W9Ju5Bb6Df3fquDw=;
        b=pi2vCaoItbcXJ3F6Bo71yn+jXqd3pUZmK66jHNjAkxWt9qjAswyRHIIsKKK72IkTXF
         /IvctVUS5+Et1kRm85+/fTdAMG6rzkj4+bC/284zs0NqpGElHvrvhM6VtG5Oteyu3d8z
         X3/6G6g//2ckZ/demrHv7AuYYD7M7xSSbVgMj0XayXZhIwSodnRNmXSaxpCWbszhUD68
         wQb6DLFyZ+Hj85zp69FgdmjvHHjZuGsYd56eKrruHekeB9s2DSlxgz1TYs2RZPVqBGKj
         yaiHok3rmXo/vPDzoXU0deh8jdiYvdZaUgncHbfuyUiknG+ebmixBr2n3MkfWfs2FE7w
         hKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VGTfUe//Lkyyq1CFsi2Aw+FdHH2W9Ju5Bb6Df3fquDw=;
        b=hoJ2+gojh2mlhsENsLaDUx5zhf6AioPWGJuaHi9xWlmDkkZ3FXG2klBf6JxJVtJEVM
         8tEdCy/YsjdDw1DJp+Q6BaMx/ub5rhIUCBewQY/9iNmxQwUqIB7xWrdUFH/ryzFj7aiy
         WUm582pYFtlfLh14kiwROcxfVqyEhQaEsV++hTDHjUPAmiLrfw9ZaGpHE8dvFWauKFKg
         VQCWoNtBxl8GBPiFxacrFPLKu7FCoe2Pzlxu1frLVi3azNNhFfKQOlWPVZuHyWwFhTL8
         Hi50NP4Lr2d6OkYpCXf1FOEB3KwXsiVUEUC8SCaka4w0Aj2pXZNrJepS1foBQilZfAWl
         ZTsw==
X-Gm-Message-State: APjAAAXrJIEm03VBxiGlTwlNzkwrHOy+KUevIuia3Oyi+I28EfHuaUo5
        UUmKN5Ge+FFBggqJ211NnIEqNg==
X-Google-Smtp-Source: APXvYqw73VgC0S976eZM9uQqGSZ6Ma0RPqQ57qIGOHoyqFCwxrGlaeFe6OIdIpOCQtqa5/Z8vQsNJA==
X-Received: by 2002:a2e:9b46:: with SMTP id o6mr2071632ljj.90.1571745914535;
        Tue, 22 Oct 2019 05:05:14 -0700 (PDT)
Received: from localhost.localdomain (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id r75sm6940248lff.93.2019.10.22.05.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 05:05:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:10:39 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Message-ID: <20191022111039.GA8762@localhost.localdomain>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
 <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
 <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-22 10:19, Peng Ma wrote:
> Hi Anders && Viod,
> 
> I sent v6 patch to fix the build error, please check.

oh I will check, didn't see them when I sent out my email. =/

Cheers,
Anders

> Patchwork link:
> https://patchwork.kernel.org/project/linux-dmaengine/list/?series=191397
> 
> Best Regards,
> Peng
> >-----Original Message-----
> >From: Anders Roxell <anders.roxell@linaro.org>
> >Sent: 2019年10月22日 17:27
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: Vinod Koul <vkoul@kernel.org>; dan.j.williams@intel.com; Leo Li
> ><leoyang.li@nxp.com>; linux-kernel@vger.kernel.org;
> >dmaengine@vger.kernel.org
> >Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
> >DPDMAI(Data Path DMA Interface) support
> >
> >Caution: EXT Email
> >
> >On Thu, 17 Oct 2019 at 08:16, Peng Ma <peng.ma@nxp.com> wrote:
> >>
> >> Hi Vinod,
> >>
> >> Thanks very much for your reply.
> >>
> >> Best Regards,
> >> Peng
> >> >-----Original Message-----
> >> >From: Vinod Koul <vkoul@kernel.org>
> >> >Sent: 2019年10月17日 12:11
> >> >To: Peng Ma <peng.ma@nxp.com>
> >> >Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> >> >linux-kernel@vger.kernel.org; dmaengine@vger.kernel.org
> >> >Subject: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
> >> >DPDMAI(Data Path DMA Interface) support
> >> >
> >> >Caution: EXT Email
> >> >
> >> >On 30-09-19, 02:04, Peng Ma wrote:
> >> >> The MC(Management Complex) exports the DPDMAI(Data Path DMA
> >> >Interface)
> >> >> object as an interface to operate the DPAA2(Data Path Acceleration
> >> >> Architecture 2) qDMA Engine. The DPDMAI enables sending frame-based
> >> >> requests to qDMA and receiving back confirmation response on
> >> >> transaction completion, utilizing the DPAA2 QBMan(Queue Manager and
> >> >> Buffer Manager
> >> >> hardware) infrastructure. DPDMAI object provides up to two
> >> >> priorities for processing qDMA requests.
> >> >> The following list summarizes the DPDMAI main features and capabilities:
> >> >>       1. Supports up to two scheduling priorities for processing
> >> >>       service requests.
> >> >>       - Each DPDMAI transmit queue is mapped to one of two service
> >> >>       priorities, allowing further prioritization in hardware between
> >> >>       requests from different DPDMAI objects.
> >> >>       2. Supports up to two receive queues for incoming transaction
> >> >>       completion confirmations.
> >> >>       - Each DPDMAI receive queue is mapped to one of two receive
> >> >>       priorities, allowing further prioritization between other
> >> >>       interfaces when associating the DPDMAI receive queues to DPIO
> >> >>       or DPCON(Data Path Concentrator) objects.
> >> >>       3. Supports different scheduling options for processing received
> >> >>       packets:
> >> >>       - Queues can be configured either in 'parked' mode (default),
> >> >>       or attached to a DPIO object, or attached to DPCON object.
> >> >>       4. Allows interaction with one or more DPIO objects for
> >> >>       dequeueing/enqueueing frame descriptors(FD) and for
> >> >>       acquiring/releasing buffers.
> >> >>       5. Supports enable, disable, and reset operations.
> >> >>
> >> >> Add dpdmai to support some platforms with dpaa2 qdma engine.
> >> >
> >> >Applied both, thanks
> >
> >I see this error when I'm building.
> >
> >WARNING: modpost: missing MODULE_LICENSE() in
> >drivers/dma/fsl-dpaa2-qdma/dpdmai.o
> >see include/linux/module.h for more information
> >ERROR: "dpdmai_enable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_set_rx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_tx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_rx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_attributes"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_open" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_close" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_disable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_reset" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >make[2]: *** [../scripts/Makefile.modpost:95: __modpost] Error 1
> >make[1]: *** [/srv/src/kernel/next/Makefile:1282: modules] Error 2
> >make: *** [Makefile:179: sub-make] Error 2
> >make: Target 'Image' not remade because of errors.
> >make: Target 'modules' not remade because of errors.
> >
> >any other that see the same ?
> >
> >Cheers,
> >Anders
