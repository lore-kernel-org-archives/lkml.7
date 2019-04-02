Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F3EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfDBIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:34:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:34:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2536374wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M5eUx46CylrNIT8vZVyZVQtg1EEiYvZzZf4VDuWRMzI=;
        b=RUvHku7dNWzcFb7xUDyTOyKqqnD4dbb4whEcgmX5Fc/0bhzTFP8LVDL6aDzw5nfw6+
         3QxAn/mAxjEDJtm05Td7CK3ZPmdFPH/ff4jcxWcm2VCEPGQpeLN8JrZml+bGL25N+0ca
         vuACxtyZetFPlzklo4K114h3ld6sznDTD/zTYj55HEpcon/2YS+idMAGlvb9m/pnLd7f
         RBdN2cxEnlD9sMwiCpnyY7YNbcfjMNe0SAZeYLNqc6UNP+NZXgZ2eLXaUJ7kuYyOIOhV
         huJzwrgzH7dmQ8auGtBhIAO2HNgp9pqVVV8JAnKamkdCGIXe78fHiLzzPnGufvMgObUp
         cTwA==
X-Gm-Message-State: APjAAAUQUjBA79S8uNDirzHeo/stExxSe/rxwB/QW0x/IlaGVmc8br4T
        26mdCMLqunGyuGbFNhSNsH72EQm4
X-Google-Smtp-Source: APXvYqxr3HlV3iadRx3CSGPrlFnlMA8thugbvnCvksgm/DqbbcrQQaUQXtTIlAC42NqOTaaWpgE80Q==
X-Received: by 2002:a1c:7208:: with SMTP id n8mr2820178wmc.46.1554194050698;
        Tue, 02 Apr 2019 01:34:10 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id v14sm12070441wrr.20.2019.04.02.01.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 01:34:10 -0700 (PDT)
Subject: Re: [PATCH v3] tty: rocket: Fix a kernel address leakage in rp_ioctl
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190331115127.29731-1-huangfq.daxian@gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e8e20b1b-d853-968e-d380-a142877e9b9d@suse.cz>
Date:   Tue, 2 Apr 2019 10:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190331115127.29731-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 03. 19, 13:51, Fuqian Huang wrote:
> If the cmd is RCPK_GET_STRUCT, copy_to_user will copy info to
> user space. As info->port.ops is the address of a constant object
> rocket_port_ops (assigned in init_r_port), a kernel address leakage.
> 
> This patch sets all the pointer fields to NULL before copy the
> object to user space to avoid kernel address leakage.
> 
> All pointer fields except
> .magic field and the pointer in .dep_map field in struct mutex
> which only exist under debug configurations of CONFIG_DEBUG_MUTEXES
> and CONFIG_DEBUG_LOCK_ALLOC
> are set to NULL.
> 
> The set NULL pointer fields are address of kernel objects:
>  - pointers to constant objects: port.ops, port.client_ops
>  - pointers to tty_struct instance
>  - pointer.xmit_buf (allocated in rp_open)
>  - pointer fields of wait_queue_head_t and struct mutex
> 
> I cannot think of a scenario where user space needs the address of
> these kernel objects. So I set them all NULL before copy_to_user.
> Another reason is that I have checked all uses of copy_to_user and
> copy_from_user in this file, they do not use any of these pointer
> fields. So these pointer fields can be set NULL safely.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/tty/rocket.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index b121d8f8f3d7..df0b8ebab266 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1271,6 +1271,48 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
>  	return 0;
>  }
>  
> +static int get_struct(struct r_port *info, void *argp)
> +{
> +	struct r_port *new;
> +	int ret = 0;
> +
> +	new = kzalloc(sizeof(struct r_port), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +	memcpy(new, info, sizeof(struct r_port));
> +	new->port.buf.head = NULL;
> +	memset(&new->port.buf.work.entry, 0, sizeof(struct list_head));
> +	new->port.buf.work.func = NULL;
> +#ifdef CONFIG_LOCKDEP
> +	new->port.buf.work.lockdep_map.key = NULL;
> +	memset(&new->port.buf.work.lockdep_map.class_cache, 0,
> +		sizeof(struct lock_class *) * NR_LOCKDEP_CACHING_CLASSES);
> +	new->port.buf.work.lockdep_map.name = NULL;
> +#endif
> +	memset(&new->port.buf.lock.wait_list, 0, sizeof(struct list_head));
> +	new->port.buf.sentinel.next = NULL;
> +	memset(&new->port.buf.free, 0, sizeof(struct llist_head));
> +	new->port.buf.tail = NULL;
> +	new->port.tty = NULL;
> +	new->port.itty = NULL;
> +	new->port.ops = NULL;
> +	new->port.client_ops = NULL;
> +	memset(&new->port.open_wait.head, 0, sizeof(struct list_head));
> +	memset(&new->port.delta_msr_wait.head, 0, sizeof(struct list_head));
> +	memset(&new->port.mutex.wait_list, 0, sizeof(struct list_head));
> +	memset(&new->port.buf_mutex.wait_list, 0, sizeof(struct list_head));
> +	new->port.xmit_buf = NULL;
> +	new->port.client_data = NULL;
> +	new->ctlp = NULL;
> +	new->channel.CtlP = NULL;
> +	new->xmit_buf = NULL;
> +	memset(&new->write_mtx.wait_list, 0, sizeof(struct list_head));
> +	if (copy_to_user(argp, new, sizeof(struct r_port)))
> +		ret = -EFAULT;
> +	kfree(new);
> +	return ret;

Ugh, no.

1) The structure is defined as rocket _internal-only_.
2) It changed many times over time (whenever tty_port was changed at least).
3) Differs depending on various CONFIG_* options.

I seriously doubt anybody used the ioctl, ever. (What size would they
pass, so that copy_to_user won't fail?)

So now, I am in favor of killing the ioctl completely. We also never
exposed the ioctl number to userspace.

> +}
> +
>  /*  IOCTL call handler into the driver */
>  static int rp_ioctl(struct tty_struct *tty,
>  		    unsigned int cmd, unsigned long arg)
> @@ -1284,8 +1326,7 @@ static int rp_ioctl(struct tty_struct *tty,
>  
>  	switch (cmd) {
>  	case RCKP_GET_STRUCT:
> -		if (copy_to_user(argp, info, sizeof (struct r_port)))
> -			ret = -EFAULT;
> +		ret = get_struct(info, argp);
>  		break;
>  	case RCKP_GET_CONFIG:
>  		ret = get_config(info, argp);
> 

thanks,
-- 
js
suse labs
