Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB77BC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TpLju8xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDHCSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:18:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42904 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDHCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:18:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so13665305qtc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QGrPOs7NcK88mGiIdZN7etxYjvNgl8QMTOMOjy/LUJk=;
        b=TpLju8xxzRgC51DnkCB0GS3K+vgDB8xwXY57kmRhHcWKQGud75plI9ZxdQTdsLStDE
         phUbCXO8Yl2yzcuaw0G13/by+dhDya4wZr/+19cZQ1hGhBPmukaW1nLITkqktbI6yGp8
         GcqLX0k07tEQ12tPb0pcJD+YTi5YUcMFdgcD22hLXbxpMP+r1S0RtIqrcLK1nWR5AcmM
         7WscM7CLPv2qq3DBv+0tDTsJgpo+k/JQAy2a/SgZQsuYAGX29PHDwn9xtNaoYw9XfC7k
         mtnW4C3bq3cKuSLOYJyw8jk018PEAvbEysaY/Z1o75AlYL7AE8YAhCu7ULpShhZ6dI7f
         +BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QGrPOs7NcK88mGiIdZN7etxYjvNgl8QMTOMOjy/LUJk=;
        b=LfpsMA+gR/lgisez1kLZpR/q5mTDriFcneVGxFzEtFtPAjVAH1i4YPHm1QsXk4ahUa
         0C/O5+PomeVsFS/DqlMvXFPBQVTAKcWHccR9TQhCvrbsLH2fzh+l9+8mpqCDxnohZjZJ
         0o87VsZ3+A/zPnyZAastv3zf/54ZKFXdWrGWrAmDkM9CjhhTeuQWmVZ7nhUjmglZ3Jih
         kKCDTk4//yUr3R9e3kfK51vqoCSbsTHb5zDIQEneZl+iwBiEqov8oee58gN5jbc7ENUn
         bYmFeTaYhNG1WFQ6H5iDhnCX7tezz7UHrj9lT5gY8WNs2FAmNd2UPNMX4NTYiDi9RBJ9
         kHAA==
X-Gm-Message-State: APjAAAWx+Iuzmy/qxsoXlzkG41A52psD6aKZsnFMg6xN7L94BYlFmcc3
        Hb6rM1iR4L89p4M/VKxi0jymSBU7xyQ=
X-Google-Smtp-Source: APXvYqxcoZyXI1YDx24c/6j/v6GrCpgt95qjxx1ZMbOd5tw2+rs5OCMmfVIg3PgOkSBgKwR5kkiTNg==
X-Received: by 2002:a0c:ba10:: with SMTP id w16mr21954196qvf.115.1554689927244;
        Sun, 07 Apr 2019 19:18:47 -0700 (PDT)
Received: from ovpn-120-238.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 204sm15771391qki.58.2019.04.07.19.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 19:18:46 -0700 (PDT)
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, tj@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190406225901.35465-1-cai@lca.pw>
 <20190408015917.GA633@eros.localdomain>
From:   Qian Cai <cai@lca.pw>
Message-ID: <57f7ef12-9330-a535-64c9-6bf17382d5fc@lca.pw>
Date:   Sun, 7 Apr 2019 22:18:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190408015917.GA633@eros.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/19 9:59 PM, Tobin C. Harding wrote:
> On Sat, Apr 06, 2019 at 06:59:01PM -0400, Qian Cai wrote:
>> The commit 510ded33e075 ("slab: implement slab_root_caches list")
>> changes the name of the list node within "struct kmem_cache" from
>> "list" to "root_caches_node"
> 
> Are you sure? It looks to me like it adds a member to the memcg_cache_array
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index a0cc7a77cda2..af1a5bef80f4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -556,6 +556,8 @@ struct memcg_cache_array {
>   *             used to index child cachces during allocation and cleared
>   *             early during shutdown.
>   * 
> + * @root_caches_node: List node for slab_root_caches list.
> + * 
>   * @children:  List of all child caches.  While the child caches are also
>   *             reachable through @memcg_caches, a child cache remains on
>   *             this list until it is actually destroyed.
> @@ -573,6 +575,7 @@ struct memcg_cache_params {
>         union { 
>                 struct {
>                         struct memcg_cache_array __rcu *memcg_caches;
> +                       struct list_head __root_caches_node;
>                         struct list_head children;
>                 };
> 
> And then defines 'root_caches_node' to be 'memcg_params.__root_caches_node'
> if we have CONFIG_MEMCG otherwise defines 'root_caches_node' to be 'list'
> 
> 
>> but leaks_show() still use the "list"
> 
> I believe it should since 'list' is used to add to slab_caches list.

See the offensive commit 510ded33e075 which changed those.

@@ -1136,12 +1146,12 @@ static void print_slabinfo_header(struct seq_file *m)
 void *slab_start(struct seq_file *m, loff_t *pos)
 {
        mutex_lock(&slab_mutex);
-       return seq_list_start(&slab_caches, *pos);
+       return seq_list_start(&slab_root_caches, *pos);
 }

 void *slab_next(struct seq_file *m, void *p, loff_t *pos)
 {
-       return seq_list_next(p, &slab_caches, pos);
+       return seq_list_next(p, &slab_root_caches, pos);
 }

and then memcg_link_cache() does,

if (is_root_cache(s)) {
	list_add(&s->root_caches_node, &slab_root_caches);

memcg_unlink_cache() does,

if (is_root_cache(s)) {
	list_del(&s->root_caches_node);

It also changed /proc/slabinfo but forgot to change /proc/slab_allocators.

@@ -1193,12 +1203,11 @@ static void cache_show(struct kmem_cache *s, struct
seq_file *m)

 static int slab_show(struct seq_file *m, void *p)
 {
-       struct kmem_cache *s = list_entry(p, struct kmem_cache, list);
+       struct kmem_cache *s = list_entry(p, struct kmem_cache, root_caches_node);

> 
>> which causes a crash when reading /proc/slab_allocators.
> 
> I was unable to reproduce this crash, I built with
> 
> # CONFIG_MEMCG is not set
> CONFIG_SLAB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SLAB_LEAK=y
> 
> I then booted in Qemu and successfully ran 
> $ cat slab_allocators
> 
> Perhaps you could post your config?

Yes, it won't be reproducible without CONFIG_MEMCG=y, because it has,

/* If !memcg, all caches are root. */
#define slab_root_caches       slab_caches
#define root_caches_node       list

Anyway,

https://git.sr.ht/~cai/linux-debug/blob/master/config

