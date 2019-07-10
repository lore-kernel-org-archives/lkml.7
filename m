Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FABDC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91F92084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO7Fk8sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGJK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:58:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:58:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so1945549wrp.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2sT+oGvC0W6TXp3DJLMLSUCPXzdSnjaT6jI9OQ5BPH4=;
        b=gO7Fk8sLsyUWXz44hx5WnF9wFLqzfaSjOcDy15DI2kpmYpjR9c0Nmbcmy6HEKP7SZy
         pIbKRt03eJNCGslrDwoGRfWRqkqh/e82F+kiqtPAZ2hnU4jY+5zRmUnPEU0BExOzFecb
         TW6nURXyFIKv7kM5jzh8fvf3Kb2O2d6m9dX3R0qnXri9LPR2AcYXgIpC/2fvAmjdQR+4
         WCreZwsx8AARBm2GbJac2+Vd3sor7Exu6fOclQ9KV4S2TJAFRPHeKfydhQZOMbbaGFEG
         9YCFeMNwOinlwxcahrrTOHfXTJNNrM9u10uqu6PGB2ZzgvQqy1BqTxMXUfkcaa4HxHCS
         WPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2sT+oGvC0W6TXp3DJLMLSUCPXzdSnjaT6jI9OQ5BPH4=;
        b=DsUYJltbG439jbd8RGhsCzrsO4N88zuhT8S2aBXq4hmY8Lmzqyk3GwUZ/JYyO2+GMn
         e9vZliLhQ/NcYQPtRZEfUmC3QlIy0L9u5QOq3qpyBjhbzCimKpf0D3UVDMtCmTv0hSvF
         rRBfsJZKRddYJZakQzieI4RKVtCEBoOGjTAHnUZ3OAxFrwMmKaGSA5sjvgpZpk0XsQSV
         eHn+ZQd0FUqrcoH5j8cVCQzMo9tqYYeafaG3srZAC0vW1AA+ZC2OBszLs5sAdEcjfFos
         tal/aRn951+E4Nz1HIMt5TI+0bP1vVRYw6xhsBwwLCO/rfNYYKtY8jU1zkmp3Emqt6Wx
         jADg==
X-Gm-Message-State: APjAAAUYXTzygVXnN0UcUvUqD/ijCBiAcMOfksGwcqGujUqvxTNkVU6J
        dqhD8z5Xh/8/a7SVhaQUAUu69+/f
X-Google-Smtp-Source: APXvYqw8KUi86oRLtvVJh6b2yivIxG8Q6GKE2mrwk4yEnFE6iV6Lycols/Yc7V6/xDCjTS26tmYmUg==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr31232112wrw.64.1562756325658;
        Wed, 10 Jul 2019 03:58:45 -0700 (PDT)
Received: from [192.168.8.147] (31.172.185.81.rev.sfr.net. [81.185.172.31])
        by smtp.gmail.com with ESMTPSA id e3sm1788460wrt.93.2019.07.10.03.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 03:58:45 -0700 (PDT)
Subject: Re: [PATCH] fs/seq_file.c: Fix a UAF vulnerability in seq_release()
To:     bsauce <bsauce00@gmail.com>, alexander.h.duyck@intel.com
Cc:     vbabka@suse.cz, mgorman@suse.de, l.stach@pengutronix.de,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org, alex@ghiti.fr,
        adobriyan@gmail.com, mike.kravetz@oracle.com, rientjes@google.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com, ksspiers@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <32e544a6-575e-a47e-fd8a-647145ac1972@gmail.com>
Date:   Wed, 10 Jul 2019 12:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/19 12:26 PM, bsauce wrote:
> In seq_release(), 'm->buf' points to a chunk. It is freed but not cleared to null right away. It can be reused by seq_read() or srm_env_proc_write().
> For example, /arch/alpha/kernel/srm_env.c provide several interfaces to userspace, like 'single_release', 'seq_read' and 'srm_env_proc_write'.
> Thus in userspace, one can exploit this UAF vulnerability to escape privilege.
> Even if 'm->buf' is cleared by kmem_cache_free(), one can still create several threads to exploit this vulnerability.
> And 'm->buf' should be cleared right after being freed.
> 
> Signed-off-by: bsauce <bsauce00@gmail.com>
> ---
>  fs/seq_file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index abe27ec..de5e266 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -358,6 +358,7 @@ int seq_release(struct inode *inode, struct file *file)
>  {
>  	struct seq_file *m = file->private_data;
>  	kvfree(m->buf);
> +	m->buf = NULL;
>  	kmem_cache_free(seq_file_cache, m);
>  	return 0;
>  }
> 

This makes no sense, since m is freed right away anyway.

So whatever is trying to 'reuse' m is in big trouble.

