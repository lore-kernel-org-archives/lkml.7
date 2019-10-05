Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E8C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD10520830
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfJEACh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 20:02:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42812 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJEACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:02:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so8988090wrw.9;
        Fri, 04 Oct 2019 17:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJY323ptNq5iteV7TuRcRazZgxFU0ETiSK6yIFchgJ0=;
        b=VZr2087ZtAgUL/eAsRWo/9uk9V9gfkFXGOmFzrsM6GeAMly6jKG8cFjpmGh/+ar2Fq
         ROL9iyZAeXRCZnsD6Cmu9RsQvcQ47Vg7KyQpr5XJoOAovvfqiz3PI2YKw5lFN4U6PLnZ
         LGdsUc3Bw+NvWkMGJVUAWC3fH4cIe2uTqtZVz+8HYa5sbVwC+kYSjwzB8ZT49nlviVtL
         XDo64npQeWgxk67pmt2q+awfYCzq74lmMOuv6zFWCj9CmnS9H6kRq5Z2ce/jnOaTZ5ro
         v7iBLcqBFqAQcHqeKKmwxJH7gCHrLBYROc/Gi+/O2OAqlazbqTjaeLjNwF1DFcSsnzxk
         7BGQ==
X-Gm-Message-State: APjAAAWwP5p5qhZU4ENnaItgQp7cFnVp0Ad6rj5+cR9HryeRZntR0lBv
        XOCiW9f9VPPbwRFaATkHaCmVKvGT
X-Google-Smtp-Source: APXvYqywzxXdSMIcTUOp2QhVjpd6bCxB+ayx1RxNoyn2judgDukJITAS5OAEsB61xQ+0L5JjfhjuKA==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr9287812wrp.191.1570233752675;
        Fri, 04 Oct 2019 17:02:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a4sm6583334wmm.10.2019.10.04.17.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 17:02:32 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix uninitialized return of ret when
 sysfs_create_link fails
To:     Colin King <colin.king@canonical.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191002124328.17264-1-colin.king@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17e3dc55-6e6e-a4e8-f082-4b57144467af@grimberg.me>
Date:   Fri, 4 Oct 2019 17:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002124328.17264-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was already fixed and merged (by Dan)

On 10/2/19 5:43 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to sysfs_create_link fails the error exit
> path returns an uninitialized value in variable ret. Fix this by
> returning the error code returned from the failed call to
> sysfs_create_link.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controller list")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/nvme/host/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 63b37d08ac98..f6acbff3e3bc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2540,8 +2540,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		list_add_tail(&subsys->entry, &nvme_subsystems);
>   	}
>   
> -	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
> -			dev_name(ctrl->device))) {
> +	ret = sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
> +				dev_name(ctrl->device));
> +	if (ret) {
>   		dev_err(ctrl->device,
>   			"failed to create sysfs link from subsystem.\n");
>   		goto out_put_subsystem;
> 
