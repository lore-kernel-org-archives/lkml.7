Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58777C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADBA21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGQPH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:07:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46917 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:07:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so23639086qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKjB19WpZnjz3jo720PWZOtMKEqDcxAGDRdZ6CCSf0s=;
        b=mkMXl3nZeFm5BkoP/Y+Ec9CKJvTQH36UAW47CmEX9TVrhCMrd7sEm3N/6T/zkwzKB5
         BOvgzj8B0yt9pb7DGmHXbsHaArUQSmuoKnCEN0B8VGHL8DggMJjAcm7OBG502jg/wxVc
         LQAAMwzZigs2MObcSmqjIqfmSazr7XNOLCgwhSKj7dqOHU7+g0KRD+vfyV+A7+zyYTM2
         lM4F+NiG7wBoKyrGvLolAcMizq4q6HMnWW8oHCe1naUasYz7MN6yecIUXpV8pAkEGGbN
         CDe5XiBi2NfgRSMdcJHHrdG254qD4vf6gTpQpF9lSoCMk2M01LHYOmX3hVOf4/VgWMAy
         POPA==
X-Gm-Message-State: APjAAAXVE7qnRcB7b/nFo1ITj+7/kD1Yhw+iW6nv7JJwJd0ePKK/d5Ti
        UA69N2nf0rXNmNOxKfkqTYa8Xg==
X-Google-Smtp-Source: APXvYqzNmWG7Hd9yodNjEs32oG/e5XZor3q9i7E5uaM8LrpeOf9mvzsXb3xCrYLcCHrTNpUHGwPHAg==
X-Received: by 2002:ac8:31d6:: with SMTP id i22mr29197459qte.338.1563376076783;
        Wed, 17 Jul 2019 08:07:56 -0700 (PDT)
Received: from [10.193.21.226] ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id n3sm10364744qkk.54.2019.07.17.08.07.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 08:07:55 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: Remove unused rbtree for
 ion_buffer
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Cc:     sumit.semwal@linaro.org, gregkh@linuxfoundation.org,
        riandrews@android.com, arve@android.com,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        YJ Chiang <yj.chiang@mediatek.com>
References: <20190712084717.12441-1-lecopzer.chen@mediatek.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <52dc3872-3d08-1d0d-6d8f-10223bc186bc@redhat.com>
Date:   Wed, 17 Jul 2019 11:07:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712084717.12441-1-lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 4:47 AM, Lecopzer Chen wrote:
> ion_buffer_add() insert ion_buffer into rbtree every time creating
> an ion_buffer but never use it after ION reworking.
> Also, buffer_lock protects only rbtree operation, remove it together.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Cc: YJ Chiang <yj.chiang@mediatek.com>
> Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>   drivers/staging/android/ion/ion.c | 36 -------------------------------
>   drivers/staging/android/ion/ion.h | 10 +--------
>   2 files changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 92c2914239e3..e6b1ca141b93 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -29,32 +29,6 @@
>   static struct ion_device *internal_dev;
>   static int heap_id;
>   
> -/* this function should only be called while dev->lock is held */
> -static void ion_buffer_add(struct ion_device *dev,
> -			   struct ion_buffer *buffer)
> -{
> -	struct rb_node **p = &dev->buffers.rb_node;
> -	struct rb_node *parent = NULL;
> -	struct ion_buffer *entry;
> -
> -	while (*p) {
> -		parent = *p;
> -		entry = rb_entry(parent, struct ion_buffer, node);
> -
> -		if (buffer < entry) {
> -			p = &(*p)->rb_left;
> -		} else if (buffer > entry) {
> -			p = &(*p)->rb_right;
> -		} else {
> -			pr_err("%s: buffer already found.", __func__);
> -			BUG();
> -		}
> -	}
> -
> -	rb_link_node(&buffer->node, parent, p);
> -	rb_insert_color(&buffer->node, &dev->buffers);
> -}
> -
>   /* this function should only be called while dev->lock is held */
>   static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>   					    struct ion_device *dev,
> @@ -100,9 +74,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>   
>   	INIT_LIST_HEAD(&buffer->attachments);
>   	mutex_init(&buffer->lock);
> -	mutex_lock(&dev->buffer_lock);
> -	ion_buffer_add(dev, buffer);
> -	mutex_unlock(&dev->buffer_lock);
>   	return buffer;
>   
>   err1:
> @@ -131,11 +102,6 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
>   static void _ion_buffer_destroy(struct ion_buffer *buffer)
>   {
>   	struct ion_heap *heap = buffer->heap;
> -	struct ion_device *dev = buffer->dev;
> -
> -	mutex_lock(&dev->buffer_lock);
> -	rb_erase(&buffer->node, &dev->buffers);
> -	mutex_unlock(&dev->buffer_lock);
>   
>   	if (heap->flags & ION_HEAP_FLAG_DEFER_FREE)
>   		ion_heap_freelist_add(heap, buffer);
> @@ -694,8 +660,6 @@ static int ion_device_create(void)
>   	}
>   
>   	idev->debug_root = debugfs_create_dir("ion", NULL);
> -	idev->buffers = RB_ROOT;
> -	mutex_init(&idev->buffer_lock);
>   	init_rwsem(&idev->lock);
>   	plist_head_init(&idev->heaps);
>   	internal_dev = idev;
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> index e291299fd35f..74914a266e25 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -23,7 +23,6 @@
>   
>   /**
>    * struct ion_buffer - metadata for a particular buffer
> - * @node:		node in the ion_device buffers tree
>    * @list:		element in list of deferred freeable buffers
>    * @dev:		back pointer to the ion_device
>    * @heap:		back pointer to the heap the buffer came from
> @@ -39,10 +38,7 @@
>    * @attachments:	list of devices attached to this buffer
>    */
>   struct ion_buffer {
> -	union {
> -		struct rb_node node;
> -		struct list_head list;
> -	};
> +	struct list_head list;
>   	struct ion_device *dev;
>   	struct ion_heap *heap;
>   	unsigned long flags;
> @@ -61,14 +57,10 @@ void ion_buffer_destroy(struct ion_buffer *buffer);
>   /**
>    * struct ion_device - the metadata of the ion device node
>    * @dev:		the actual misc device
> - * @buffers:		an rb tree of all the existing buffers
> - * @buffer_lock:	lock protecting the tree of buffers
>    * @lock:		rwsem protecting the tree of heaps and clients
>    */
>   struct ion_device {
>   	struct miscdevice dev;
> -	struct rb_root buffers;
> -	struct mutex buffer_lock;
>   	struct rw_semaphore lock;
>   	struct plist_head heaps;
>   	struct dentry *debug_root;
> 

Acked-by: Laura Abbott <labbott@redhat.com>
