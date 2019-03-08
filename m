Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F94C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9002085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q4L5a5zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCHTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:15:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39703 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCHTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:15:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so14818038pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FxDRnMK2hBrkGM9q7EoRDgAZcC5p1d4FV3FKIjG4i9s=;
        b=Q4L5a5zur7a13HV856+/5wWT5UsWeuzfdLAJpbYKrTEXHI4W6p7ZvzZjx6dVLti3zL
         reeoBe4/RzaBt+UToQz8aQyWVEAByHsJP5x5hz1CgBps8dxZbGX5+I7bg6hSGiBxswh7
         /ysmEKIs0IsytND3X9a+KXOPRFly9d8MwufXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FxDRnMK2hBrkGM9q7EoRDgAZcC5p1d4FV3FKIjG4i9s=;
        b=DgWgZ1uSMNZdrtAcnxX7Dg1s9uqZNwJ58C+5jWWj4I4AIJ1/2YmEjl9M4Je5wn+glW
         QoKj7xpiSZtJ6lG6mNPkceQk4ohN3DjJANwwRfWQvtcfeYdJSkHaAgDS0O655dXTs/XM
         VWyTQmsM04pKtAgEZnQ8R+JvL9Fq7DxNx9uCzb2IRwcbx42aKGvPCLp6b+OSBcPxj/3I
         zTPD1ktH2dlSdsWqcjoWV8i/NB2yEQwEnGjzyuh/i/MwzsnzW0vxpKAOMOyhOUbJIsM7
         B4DZZaPWApMPVRddKaCNLa+Os489rcpwim0wypDtL4tRUhELyiJkBnXr0jdom/X02O0/
         75lg==
X-Gm-Message-State: APjAAAVrneXevO64YQzACmVY8DpJauMrqqlz8dssKMndICYnmFbYJsln
        w580FdZHol+b9EgyXcse80vNSxa7M+acEvno5hRB3b2UuFrLZBzb61jgSHW19KjvQgmgxMwiVsL
        421Kul0DwfrY7F2sJQur2zmy6aUXeOpqvGCKoLTpQJmBUjNsR7bYERXfDjF3eJvr72K0w5Ktnb8
        a0KC0=
X-Google-Smtp-Source: APXvYqxzAO1nIUF4Gd0mOEJCPKDT3XhMI7O296JtlwinuaMLgI6rOMckeYsP32XjA47Zw24B5g+zxg==
X-Received: by 2002:a17:902:1744:: with SMTP id i62mr20227415pli.24.1552072537736;
        Fri, 08 Mar 2019 11:15:37 -0800 (PST)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n74sm15791985pfb.188.2019.03.08.11.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:15:36 -0800 (PST)
Subject: Re: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190223185108.GA6706@embeddedor>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <b383ade6-f8fe-eb81-4d9c-a822e573390d@broadcom.com>
Date:   Fri, 8 Mar 2019 11:15:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190223185108.GA6706@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2019 10:51 AM, Gustavo A. R. Silva wrote:
> Update the code to use a zero-sized array instead of a pointer in
> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
>
> Notice that one of the more common cases of allocation size calculations
> is finding the size of a structure that has a zero-sized array at the end,
> along with memory for some number of elements for that array. For example:
>
> struct foo {
> 	int stuff;
> 	struct boo entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(struct boo) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/nvme/target/fc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1e9654f04c60..23baec38f97e 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>   	struct nvmet_cq			nvme_cq;
>   	struct nvmet_sq			nvme_sq;
>   	struct nvmet_fc_tgt_assoc	*assoc;
> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>   	struct list_head		fod_list;
>   	struct list_head		pending_cmd_list;
>   	struct list_head		avail_defer_list;
>   	struct workqueue_struct		*work_q;
>   	struct kref			ref;
> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>   } __aligned(sizeof(unsigned long long));
>   
>   struct nvmet_fc_tgt_assoc {
> @@ -588,9 +588,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (qid > NVMET_NR_QUEUES)
>   		return NULL;
>   
> -	queue = kzalloc((sizeof(*queue) +
> -				(sizeof(struct nvmet_fc_fcp_iod) * sqsize)),
> -				GFP_KERNEL);
> +	queue = kzalloc(struct_size(queue, fod, sqsize), GFP_KERNEL);
>   	if (!queue)
>   		return NULL;
>   
> @@ -603,7 +601,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (!queue->work_q)
>   		goto out_a_put;
>   
> -	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
>   	queue->qid = qid;
>   	queue->sqsize = sqsize;
>   	queue->assoc = assoc;

Reviewed-by:  James Smart <james.smart@broadcom.com>

I guess this is a better style.

-- james

