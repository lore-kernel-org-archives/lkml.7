Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F3C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D482073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="c7x5yCf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfDOMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:30:08 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44120 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDOMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:30:08 -0400
Received: by mail-qt1-f180.google.com with SMTP id w5so18738021qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WaGY23/aKBXv/22Nfcg3k8t9q+qYeT1eKiuNyGDw0p0=;
        b=c7x5yCf5Ow30egwi6LE0VHDAmhbfJBKZ/55Q56a/r71xLVCnrWY+v96CYQfPK+JPsM
         svTQ3xX2dmW9vccadijIttuvAcECISJ2JoA9712nXO/1GTgO8I+Sd6xk4vPkmukC0WdA
         gxwtaGl+8Bs1g9e2mxQi3lJf2hgwJsMXTg6UbTmSPKfpT/JEKG8ANachszSIKcduMi+2
         wCytpDwM/LQgrqNoXI7EMWTuevrXg2blq97NRiC6y/oMmJGkUXZL28YDfIcxSJhnQ4Mj
         PdVEninSbBJS0YzB5+uqTvgIXPdnhsguwMECYNQRMxa5vmVmiTsO+sRoPmXLpZZMYM0z
         Ierw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WaGY23/aKBXv/22Nfcg3k8t9q+qYeT1eKiuNyGDw0p0=;
        b=WvYoJ5wAixV2ru7egjURzfvAf3ewUZ0Pua2KR+XUC3GAot8rn2cRdQexQk00pVUGXJ
         pBzPJ7RJTAExXn2j4FsKDFjlHsXSRHzYsjNfYwEZbjRX4MWxuwGMpKKidHdC9N5ZHAzb
         KkYi6SrTlD4Pg93jyCt/wmPToveLLIGzKRGbQ5MehAgs3bJqti0Btypvbzt+QkogSDDt
         GNyq1CcQcj0s6IaMQ5Plx5LrlfaI2yFJ1+Pb3/zOyKmYzR4vtLqusTVOwVfSr/jJ0JHm
         wrS8VpARhaKw25S5B+7dzhH25lAfCk2utZ7kX5TF+VvoKvdMycU2JiUUVRR2T3GELDOb
         QY9Q==
X-Gm-Message-State: APjAAAVTrAdTeUwa1t8L35AxUQjJhZeBzdU/DY9zJCW5KhissL3LuK9z
        +WMsUorMNhYIS89JRSOWd8ovqg==
X-Google-Smtp-Source: APXvYqxTrVm5X9yB19z5r/GOa5SixpFmNyeNbkIDHxI5PoVDjIk2Qy8wg8mh8acBwtoHNGMrt/Z7eQ==
X-Received: by 2002:a0c:c110:: with SMTP id f16mr61436082qvh.190.1555331407032;
        Mon, 15 Apr 2019 05:30:07 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id w68sm25878408qka.18.2019.04.15.05.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 05:30:05 -0700 (PDT)
Message-ID: <6ae8b9daa0cf406ab604e802bbb6d46736266bd5.camel@ndufresne.ca>
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Mon, 15 Apr 2019 08:30:03 -0400
In-Reply-To: <CAAFQd5BmDvou6qdaw6uSAWTyLBXeTH8RvnBi7dCGCRdedvHPMg@mail.gmail.com>
References: <20190124100419.26492-1-tfiga@chromium.org>
         <20190124100419.26492-3-tfiga@chromium.org>
         <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl>
         <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
         <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
         <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl>
         <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
         <6cb0caf1-61a6-0719-1ade-1dcf8ed8a020@xs4all.nl>
         <CAAFQd5DdDv+Nu0Dry1XRpYAnz0DrSE5kEf7GxY64tg6aJebzMQ@mail.gmail.com>
         <1ec36515-b6ec-b355-47fb-2fe5ad4b3241@xs4all.nl>
         <03751bb884a443ec1cea7b5c023c9d520ffcc3a0.camel@ndufresne.ca>
         <CAAFQd5BmDvou6qdaw6uSAWTyLBXeTH8RvnBi7dCGCRdedvHPMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 15 avril 2019 à 17:56 +0900, Tomasz Figa a écrit :
> > Sounds like we need something similar to the SOURCE_CHANGE event
> > mechanism if we want to allow dynamic bitrate control which would
> > require re-allocation of the capture buffer queue. (Or any other
> > runtime control on our encoders, which is really expected to be
> > supported these days).
> 
> Sounds like it. Or we could just assume that one needs to stop both
> queues to do a resolution change, since most codes would anyway reset
> the stream (e.g. send PPS/SPS, etc. for H.264) to change the
> resolution. Not sure if that assumption always holds, though.

I think for resolution/profile/level changes you have a good point, as
you said, we need to start a new stream (new header, new IDR). Maybe
then we should simply require the driver to allocate enough buffer to
support the highest bitrate for the selected resoltion/profile/level?
Though, this could create situation where we waste a lot of memory. On
the other side, if you need to reallocate your buffers on bitrate
change, it might create a visible freeze.

Nicolas

