Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E6C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B5207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575480750;
	bh=HDQU89ZCAHZxnDRcwzXKTPiqcgV7uHJv6X/vHk+qi9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/2ABPh5H/3ksIxsAJovYNHtuKeaXopKAUCa0445zkKP0sdcdXX646e/kgbO9CQz1
	 pd1Hkum0I1HNJ08InWLiP+Ohxotv/2kqrTHl2fjGM0/8XNaEdP8wkErzdajHdpIrz1
	 u7RIXd2Pfg94tZ78+11+1rqwGEbw66QJxmnjrqkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfLDRc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:32:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:32:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id u8so655939wmu.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Da4Y4n3NMFC/79t5RanRXSUf1h1wEAGbNHxtuyP+xmM=;
        b=Z94DkfufL6HVtq5BV+uU20SpiNvgoUy4yY7ngu6G+RM2sQ61nJWU0ONGFvbdr3OHma
         1b2mX5hK51qYdj2ZJoQOaVqYP/s3a3LWaCAcXBfcarUlEgBlLeR1ca1g05W+pqZLpqQX
         lWi5zlONVDlMnk4ggJvH9UWRudA3BA80Zg6mupRiQF/DEJFAdUfClAPcKJnV3nVFu4SZ
         NAfasXzjoMYKW+qu6iRGTRSnR1RRkwv2q8qEApfbaoOd6/m7hLTApOmGpU4q9KS7AkPY
         ApgF91e03Pog4Fj7AQrsNtW45l4Hudi/0bq+ptZgPsFb9eTnK+NZF8zdQDAOFtPKDbn9
         ZPYA==
X-Gm-Message-State: APjAAAUz+FIOhU3zE38p6iL47nPNqRSQ/cxD0F+LvetWWgC/72txAOpy
        y1oyhWsX5aqF5luDi46Okes=
X-Google-Smtp-Source: APXvYqz2+J1w4/+Mka97KTYvxkWaEPcEfNDGA9xqF4/DUTq+CSCHZZfIrpdSQSf8NDotGd4eWrU1Kw==
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr677882wmd.130.1575480747146;
        Wed, 04 Dec 2019 09:32:27 -0800 (PST)
Received: from localhost (ip-37-188-170-11.eurotel.cz. [37.188.170.11])
        by smtp.gmail.com with ESMTPSA id c9sm6995939wmc.47.2019.12.04.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 09:32:26 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:32:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191204173224.GN25242@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
 <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
 <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
 <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc akpm - the email thread starts
http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]

On Wed 04-12-19 16:53:47, Cristopher Lameter wrote:
> On Wed, 4 Dec 2019, Michal Hocko wrote:
> 
> > As I've said I believe it is quite risky. But if you as a maintainer
> > believe this is the right thing to do I will not object. Care to send a
> > patch?
> 
> From: Christoph Lameter <cl@linux.com>
> Subject: slub: Remove userspace notifier for cache add/remove
> 
> Kmem caches are internal kernel structures so it is strange that
> userspace notifiers would be needed. And I am not aware of any use
> of these notifiers. These notifiers may just exist because in the
> initial slub release the sysfs code was copied from another
> subsystem.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c	2019-12-02 15:13:23.948312925 +0000
> +++ linux/mm/slub.c	2019-12-04 16:32:34.648550310 +0000
> @@ -5632,19 +5632,6 @@ static struct kobj_type slab_ktype = {
>  	.release = kmem_cache_release,
>  };
> 
> -static int uevent_filter(struct kset *kset, struct kobject *kobj)
> -{
> -	struct kobj_type *ktype = get_ktype(kobj);
> -
> -	if (ktype == &slab_ktype)
> -		return 1;
> -	return 0;
> -}
> -
> -static const struct kset_uevent_ops slab_uevent_ops = {
> -	.filter = uevent_filter,
> -};
> -
>  static struct kset *slab_kset;
> 
>  static inline struct kset *cache_kset(struct kmem_cache *s)
> @@ -5712,7 +5699,6 @@ static void sysfs_slab_remove_workfn(str
>  #ifdef CONFIG_MEMCG
>  	kset_unregister(s->memcg_kset);
>  #endif
> -	kobject_uevent(&s->kobj, KOBJ_REMOVE);
>  out:
>  	kobject_put(&s->kobj);
>  }
> @@ -5770,7 +5756,6 @@ static int sysfs_slab_add(struct kmem_ca
>  	}
>  #endif
> 
> -	kobject_uevent(&s->kobj, KOBJ_ADD);
>  	if (!unmergeable) {
>  		/* Setup first alias */
>  		sysfs_slab_alias(s, s->name);
> @@ -5851,7 +5836,7 @@ static int __init slab_sysfs_init(void)
> 
>  	mutex_lock(&slab_mutex);
> 
> -	slab_kset = kset_create_and_add("slab", &slab_uevent_ops, kernel_kobj);
> +	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
>  	if (!slab_kset) {
>  		mutex_unlock(&slab_mutex);
>  		pr_err("Cannot register slab subsystem.\n");

-- 
Michal Hocko
SUSE Labs
