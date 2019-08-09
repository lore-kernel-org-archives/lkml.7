Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA0C214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vXxLrrrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfHIUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:25:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:25:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79KPd7C066866;
        Fri, 9 Aug 2019 15:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565382339;
        bh=o2d4QWhw4Uk2L7QvDmAqwOQHBdtU+aYcyU4/pNV+AAU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vXxLrrrz5Xh8rhhiZyQYlhILQPEfu1bHh4v4z1XSeLZ6jYWBmDsbtiKcHRsgIDvUc
         ESw6uWXtRfAknamoZJ2K+8ZutfRSvaL+uHj3Wy7cXhkzibTGV5Fl3nWFeAHpFN9dKx
         Z81cy3ihT34YDa4szazuDPKcQjaDao6m7qzrjudo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79KPdOK081000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 15:25:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 15:25:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 15:25:38 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79KPcqc121268;
        Fri, 9 Aug 2019 15:25:38 -0500
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181024011909.21674-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <40831f80-1e36-66ca-b8e5-684d46ba167e@ti.com>
Date:   Fri, 9 Aug 2019 15:25:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20181024011909.21674-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 10/23/18 8:19 PM, Suman Anna wrote:
> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
> printing the vring buffer address. This prints only a hashed
> pointer even for previliged users. Use "%pK" instead so that
> the address can be printed during debug using kptr_restrict
> sysctl.

Seems to have been lost among the patches, can you pick up this trivial
patch for 5.4? Should apply cleanly on the latest HEAD as well.

regards
Suman

> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index f29dee731026..1345f373a1a0 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  		goto vqs_del;
>  	}
>  
> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
>  		bufs_va, &vrp->bufs_dma);
>  
>  	/* half of the buffers is dedicated for RX */
> 

