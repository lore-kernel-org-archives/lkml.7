Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB087C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706BC2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6pwB6+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCTEyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:54:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43363 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfCTEyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:54:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so1159561wre.10;
        Tue, 19 Mar 2019 21:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WwuaKTPR4oq7iRRr0EQJf+bfmHKLxcy5jJviiAT5pi8=;
        b=a6pwB6+jGhCKRLaD4k64O0C4iHdmuywggoL1N0WDobSspQ6m2xyJFgdvzc5WCktPF4
         0irp+XgIOis/JrcsVg2QealOkivUOnXRXw1UFrb7vmUpkekSIesKeRnKY0H8hNYwlPgG
         atf35kAhFNdms4kvaDBuJEuDhmZJWUBECniVxXVLPE9xZQOjlkfS4wlZ7ULRd9SqjB5k
         EBzmJSXmUYziBrS+Y/KK4G3PRYcay9uTDZj3iXGWwqKceD1yjm2Ir/TXP4bKlij7FgHc
         tsdv50brkjmpK6D597fFm+RAryeIKA0n79y5xRqaQRp6gHKqtVQyWxjpQVte1VTFETby
         TaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WwuaKTPR4oq7iRRr0EQJf+bfmHKLxcy5jJviiAT5pi8=;
        b=eYAZ/8uFyZfQP7bUxff+7e6zRLEGrZVzlI29hNqpJzVGJiDW5CEZZtnc5xgQkx2L4R
         UzKu3eMlDLIjLFgd5gfSYsW2UaEWlp6+xgFQAUM2oQsdwVneXf51S0aD6U6rmvJ3pXSi
         p7AJ7ed1EtOlkwF10UUIjdRGpN3WOthWncHJIuFqEGeVBnPt6RRSO7wxX8vLz2+hVYpF
         /iFzq2DYGluk0Oyl+XXkfEW5ktieIuKcPacUzNZuKwtCLa39DMk6zr1mfszjuJ+7ruSV
         8NoacDulCGfWCcN1ZTYbuoPm1k6/7egxRpXkAzaE/fIMsP3lMVl7/TShKPoX3madHwKB
         DGbA==
X-Gm-Message-State: APjAAAVRwdxiVnGwJ4jllG9q0i3n76a777lJIF9mML7YpZWVBDRixvv5
        t/jpv7NZtMsYa6TKUoHD2z1jA946
X-Google-Smtp-Source: APXvYqzWPEDsAkRi8IE3S76/Oxf7Nxv0BZf14MoGYTIC+lgdZ6nO2zrg3qSZzbVCpuey2NcNNnp4cg==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr8602421wrm.322.1553057651452;
        Tue, 19 Mar 2019 21:54:11 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id j64sm952443wmb.36.2019.03.19.21.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 21:54:10 -0700 (PDT)
Subject: Re: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190319214244.20212-1-pakki001@umn.edu>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d65ddd7e-6553-00a4-c261-bd88b7476626@gmail.com>
Date:   Tue, 19 Mar 2019 21:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190319214244.20212-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/19/2019 02:42 PM, Aditya Pakki wrote:
> idr_find() can return a NULL value to 'flow' which is used without a
> check. The patch adds a check to avoid potential NULL pointer dereference.
> 
> In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
> using kzalloc.
> 
> Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
> ---
> v3: Reorder buf allocations and flow check.
> v2: failure to return in case of flow failure.
> v1: Failed to free buf in case of flow failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> index 5cf5f2a9d51f..8de64e88c670 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> @@ -217,15 +217,21 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
>  	void *cmd;
>  	int ret;
>  
> +	rcu_read_lock();
> +	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
> +	rcu_read_unlock();

This looks suspect (even before your patch)

What prevents flow from disappearing after this rcu_read_lock() ?

IMO your patch might prevent a NULL deref, but not use-after-free.

> +
> +	if (!flow) {
> +		WARN_ONCE(1, "Received NULL pointer for handle\n");
> +		return -EINVAL;
> +	}
> +
>  	buf = kzalloc(size, GFP_ATOMIC);
>  	if (!buf)
>  		return -ENOMEM;
>  
>  	cmd = (buf + 1);
>  
> -	rcu_read_lock();
> -	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
> -	rcu_read_unlock();
>  	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
>  
>  	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
> @@ -238,6 +244,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
>  	buf->complete = mlx_tls_kfree_complete;
>  
>  	ret = mlx5_fpga_sbu_conn_sendmsg(mdev->fpga->tls->conn, buf);
> +	if (ret < 0)
> +		kfree(buf);
>  
>  	return ret;
>  }
> 
