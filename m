Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F0C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18942075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578311858;
	bh=s5Sa1xRbZFFMGRaFBBUyOdwEz6ghW8w9muI3pbuLQac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lH1V1LChPWs4fkFVcJW5zXn9m7AXiQ5nr00sl3ql/lJ5YXv+oj8dHoYq5J9K2c44s
	 q3SHWbSOQ7KCIYKs7SkFZ4avxBH7gCgGY3f4fNX0DwuVuHHnuT7AU2oIpP2pZoUTkp
	 Jh6yEbRI8Q2EO+dNMusSMj8gwK++ooZM48V/cfpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgAFL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:57:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:57:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so14963456wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 03:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wq5ckQk7LFGLcvmKNi6yRQD928FRQYB9nCju3+NM16s=;
        b=YqfmXAmAm86ENG9pp3gPOnICI/V/f3Y51o47AXNHGcq+aBDjpDatokZ+BAaKJqa0o1
         ypwIHeEfXFtbtjRDcDb/watTGdPTNuWxwfcBI0emDJ7JOKVx3CpEVSAzJlhbsfyQEubW
         TmYQrhPdWmiGJMnutBtkMRn9M3U1ObFgEUbKhK+ubNMQxoXm4vOrYJtLssYTwGhMYVT2
         3pmRD7H5lSboo8aliiFgecfwkH2GPn0PlXsaA6HRIVyN4GXPQTI9DrnsQn8OY6t2/Nqv
         X2s/WcenFu6uW9mjmoGimb15wsQvo65h2xIUo9w26hyzV82AjwfOoGFziOqxLNXSV3b7
         1x5w==
X-Gm-Message-State: APjAAAVfOFNnvB2untFCMNuIPmTUHY95S/prJSV2btp4dk6315Zo8tOh
        nRI8sCWRaGaL2JXPzq6Vy0mjNA9Z
X-Google-Smtp-Source: APXvYqz+K5ThOJvt/fr4HLv1TX9A/QH8tzGeDdL9+NBitXIU6Wt0jJh/hTjo2ms6UIQKX9U5J7xDGA==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr35470768wmj.122.1578311855456;
        Mon, 06 Jan 2020 03:57:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f127sm22452306wma.4.2020.01.06.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 03:57:34 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:57:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200106115733.GH12699@dhcp22.suse.cz>
References: <20191126165420.GL20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271535560.16935@www.lameter.com>
 <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
 <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204173224.GN25242@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-12-19 18:32:24, Michal Hocko wrote:
> [Cc akpm - the email thread starts
> http://lkml.kernel.org/r/20191126121901.GE20912@dhcp22.suse.cz]

ping.

> On Wed 04-12-19 16:53:47, Cristopher Lameter wrote:
> > On Wed, 4 Dec 2019, Michal Hocko wrote:
> > 
> > > As I've said I believe it is quite risky. But if you as a maintainer
> > > believe this is the right thing to do I will not object. Care to send a
> > > patch?
> > 
> > From: Christoph Lameter <cl@linux.com>
> > Subject: slub: Remove userspace notifier for cache add/remove
> > 
> > Kmem caches are internal kernel structures so it is strange that
> > userspace notifiers would be needed. And I am not aware of any use
> > of these notifiers. These notifiers may just exist because in the
> > initial slub release the sysfs code was copied from another
> > subsystem.
> > 
> > Signed-off-by: Christoph Lameter <cl@linux.com>
> > 
> > Index: linux/mm/slub.c
> > ===================================================================
> > --- linux.orig/mm/slub.c	2019-12-02 15:13:23.948312925 +0000
> > +++ linux/mm/slub.c	2019-12-04 16:32:34.648550310 +0000
> > @@ -5632,19 +5632,6 @@ static struct kobj_type slab_ktype = {
> >  	.release = kmem_cache_release,
> >  };
> > 
> > -static int uevent_filter(struct kset *kset, struct kobject *kobj)
> > -{
> > -	struct kobj_type *ktype = get_ktype(kobj);
> > -
> > -	if (ktype == &slab_ktype)
> > -		return 1;
> > -	return 0;
> > -}
> > -
> > -static const struct kset_uevent_ops slab_uevent_ops = {
> > -	.filter = uevent_filter,
> > -};
> > -
> >  static struct kset *slab_kset;
> > 
> >  static inline struct kset *cache_kset(struct kmem_cache *s)
> > @@ -5712,7 +5699,6 @@ static void sysfs_slab_remove_workfn(str
> >  #ifdef CONFIG_MEMCG
> >  	kset_unregister(s->memcg_kset);
> >  #endif
> > -	kobject_uevent(&s->kobj, KOBJ_REMOVE);
> >  out:
> >  	kobject_put(&s->kobj);
> >  }
> > @@ -5770,7 +5756,6 @@ static int sysfs_slab_add(struct kmem_ca
> >  	}
> >  #endif
> > 
> > -	kobject_uevent(&s->kobj, KOBJ_ADD);
> >  	if (!unmergeable) {
> >  		/* Setup first alias */
> >  		sysfs_slab_alias(s, s->name);
> > @@ -5851,7 +5836,7 @@ static int __init slab_sysfs_init(void)
> > 
> >  	mutex_lock(&slab_mutex);
> > 
> > -	slab_kset = kset_create_and_add("slab", &slab_uevent_ops, kernel_kobj);
> > +	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
> >  	if (!slab_kset) {
> >  		mutex_unlock(&slab_mutex);
> >  		pr_err("Cannot register slab subsystem.\n");
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
