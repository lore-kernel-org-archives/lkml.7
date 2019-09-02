Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDD3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DF522DCC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431623;
	bh=1MpB7+dGqH4khxznPka9JwEeioPre6aYiSDv4MiN2W8=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=SS+etwGxjCEhqXQwW2/YJzgJGXCGxts4qagENB5PAcSzZpokem6pXXqSwqcljzjt9
	 Bf6mpuiV29lhQsNOvPm/Xjn91a3caLiQPiDRmsKEM5EHTGUb1Tpci1WfghgiPUl+fS
	 DQHAixt3kUpSruMgjAV7qEKh1e08ee82jeFse2MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfIBNkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:40:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38954 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbfIBNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id n2so13266573wmk.4;
        Mon, 02 Sep 2019 06:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=VHM7wVxbM3iFjk6g2BqysfNSZL4bn6Yh6NOKIm6VeQ8=;
        b=GGG8Qyg+r3ce23l4JaTY51j6Y6J13+wPxHp+G0+m5cNBERwlL6wbSv6/kMOuIHThQE
         qQ/QgLjhZaIrYp6YON7JgkL92AYaZkbXUCyGicy9kAYXvenxBKh0Yfcpsx0gJmaQgSe2
         RQR8h/9JEE3meVKRRcOaicf9dbEkHFPActutDAoJ5z0yjOZ4/ZtRiIgV9Gc9a4VZil2i
         xNieQwTYdTMwjA7Dg+Iy+41G10uMzyrnEFYxQ/Q3K8Pl6h7zUQjxNSfH0o/O8tTGoojS
         yE59HhZBG7KE40nPLcJCrq9qtHraI27vjhhMBZ14oBMJHJ9pvDdcLlaqa2Uv7Hg/MUjC
         UThg==
X-Gm-Message-State: APjAAAWcZ3vNH2CsEfr5zxqbJmw2fNgvX1kqUJKM9RD5TtWlRvTCXdvT
        dZA/hLExvW/XXfLUoIHOSw==
X-Google-Smtp-Source: APXvYqy0KNBQfCwq+9RzjWG+pvrwpi4rW7y8999LenlesG4VEWMuewwgiR5JlpctG/2+f2gTGGix0A==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr4331454wmj.93.1567431535461;
        Mon, 02 Sep 2019 06:38:55 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id h8sm16761794wrq.49.2019.09.02.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:54 -0700 (PDT)
Message-ID: <5d6d1b6e.1c69fb81.c6a88.9b11@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:54 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
References: <20190829111407.17191-1-thierry.reding@gmail.com> <20190829111407.17191-2-thierry.reding@gmail.com>
In-Reply-To: <20190829111407.17191-2-thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Thierry Reding <thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 13:14:06 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This is an implementation that IOMMU drivers can use to obtain reserved
> memory regions from a device tree node. It uses the reserved-memory DT
> bindings to find the regions associated with a given device. These
> regions will be used to create 1:1 mappings in the IOMMU domain that
> the devices will be attached to.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  8 ++++++++
>  2 files changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

