Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D04C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A342744C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0pXOe0S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfFCRVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:21:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36891 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfFCRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:21:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so929810qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=x7mTqHfW25Yfgg2m6bdYw6M5XlwzGvI7rSJIno4dGcg=;
        b=0pXOe0S3UATwQJ3foBGdeblPbc59sDMnw5rDa66bcJ7G6nqdYwsQk8hCfb5up0XMmM
         Xy01qTNfOqEqK9rjJEe66Nr2RxfnaGNnjoSo8ZbBnNJreVKYmqsILtZwHNg4hZhpRkNU
         YPvtf6KKMyygMqKeEOZ3ltOcu96YjOhtKbV7ZKGpqx1fO5zJGT8U8sIjlLmqq1jKniSX
         Jb9Pgaj2cceEhgjBZE7RNL6I1QnfxIcCDY7L0Zsy9t5Ss1TVs4EHzOD31w0h6d3UhiHg
         +Pw/XQ5+7tXPZyBDTJnK0Xv3aM8ZL6AO4j02CnutvdBDb+NXgHs7Md9385ZYFvG2M2H6
         tctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=x7mTqHfW25Yfgg2m6bdYw6M5XlwzGvI7rSJIno4dGcg=;
        b=XKNheq/Wr2oBZhpK+VFVr9GlR4Lil7hjq9HN6yq4/c8PHAStTS1rB+NK7py0kZrm7l
         ElhoHxsnnDM/F9js0vBG4N2yxP4D27CbDW8J3yWD2DbCRtelu7FB2yBL4k0auB8OOEUC
         P9lop+AmsELaLFntyaEl+UdH6FbU0zikkm78VhfBSw0mMCHyZ35yLN5Fxosf77YaK7il
         DokrUkNqo7eQa+7bCmxvEvZQREcGS3poLDICzjoeJWQohDRupDhzLVfVtRGVJLoLHR3B
         POj66oK+HGBpf74NMmNMrqL7VFo5eDH7vrOCqvlZx82XarGOMuRQO9ho49RboS3LoMNg
         qZlQ==
X-Gm-Message-State: APjAAAUiizh31lPvKKCOx5RmoASdbRPApArQSmY51gkH8GGoulshZp+c
        dL5FgCkn98BxzqTP5qT2g8oP1w==
X-Google-Smtp-Source: APXvYqzLGOq03x63kPvRAktqQgITC5ecSo/OEEL09HH061JSrHRVkAQ5hmpnP8/k5LqHiSqlUAfRNw==
X-Received: by 2002:ae9:ed0a:: with SMTP id c10mr22414632qkg.207.1559582506309;
        Mon, 03 Jun 2019 10:21:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 100sm8493263qtb.53.2019.06.03.10.21.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 10:21:46 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:21:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bpf: remove redundant assignment to err
Message-ID: <20190603102140.70fee157@cakuba.netronome.com>
In-Reply-To: <20190603170247.9951-1-colin.king@canonical.com>
References: <20190603170247.9951-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 18:02:47 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is assigned with the value -EINVAL that is never
> read and it is re-assigned a new value later on.  The assignment is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  kernel/bpf/devmap.c | 2 +-
>  kernel/bpf/xskmap.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 5ae7cce5ef16..a76cc6412fc4 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -88,7 +88,7 @@ static u64 dev_map_bitmap_size(const union bpf_attr *attr)
>  static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
>  {
>  	struct bpf_dtab *dtab;
> -	int err = -EINVAL;
> +	int err;
>  	u64 cost;

Perhaps keep the variables ordered longest to shortest?

>  	if (!capable(CAP_NET_ADMIN))
> diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
> index 22066c28ba61..26859c6c9491 100644
> --- a/kernel/bpf/xskmap.c
> +++ b/kernel/bpf/xskmap.c
> @@ -17,7 +17,7 @@ struct xsk_map {
>  
>  static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
>  {
> -	int cpu, err = -EINVAL;
> +	int cpu, err;
>  	struct xsk_map *m;
>  	u64 cost;

And here.

