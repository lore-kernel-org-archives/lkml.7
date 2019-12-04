Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A52081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfLDQxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:53:48 -0500
Received: from gentwo.org ([3.19.106.255]:46986 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfLDQxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:53:48 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 75E533EED9; Wed,  4 Dec 2019 16:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 736693E93B;
        Wed,  4 Dec 2019 16:53:47 +0000 (UTC)
Date:   Wed, 4 Dec 2019 16:53:47 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20191204153225.GM25242@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
References: <20191126121901.GE20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911261632030.9857@www.lameter.com> <20191126165420.GL20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911271535560.16935@www.lameter.com> <20191127162400.GT20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911271625110.17727@www.lameter.com> <20191127174317.GD26807@dhcp22.suse.cz> <20191204132812.GF25242@dhcp22.suse.cz> <alpine.DEB.2.21.1912041524290.18825@www.lameter.com> <20191204153225.GM25242@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Michal Hocko wrote:

> As I've said I believe it is quite risky. But if you as a maintainer
> believe this is the right thing to do I will not object. Care to send a
> patch?

From: Christoph Lameter <cl@linux.com>
Subject: slub: Remove userspace notifier for cache add/remove

Kmem caches are internal kernel structures so it is strange that
userspace notifiers would be needed. And I am not aware of any use
of these notifiers. These notifiers may just exist because in the
initial slub release the sysfs code was copied from another
subsystem.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c	2019-12-02 15:13:23.948312925 +0000
+++ linux/mm/slub.c	2019-12-04 16:32:34.648550310 +0000
@@ -5632,19 +5632,6 @@ static struct kobj_type slab_ktype = {
 	.release = kmem_cache_release,
 };

-static int uevent_filter(struct kset *kset, struct kobject *kobj)
-{
-	struct kobj_type *ktype = get_ktype(kobj);
-
-	if (ktype == &slab_ktype)
-		return 1;
-	return 0;
-}
-
-static const struct kset_uevent_ops slab_uevent_ops = {
-	.filter = uevent_filter,
-};
-
 static struct kset *slab_kset;

 static inline struct kset *cache_kset(struct kmem_cache *s)
@@ -5712,7 +5699,6 @@ static void sysfs_slab_remove_workfn(str
 #ifdef CONFIG_MEMCG
 	kset_unregister(s->memcg_kset);
 #endif
-	kobject_uevent(&s->kobj, KOBJ_REMOVE);
 out:
 	kobject_put(&s->kobj);
 }
@@ -5770,7 +5756,6 @@ static int sysfs_slab_add(struct kmem_ca
 	}
 #endif

-	kobject_uevent(&s->kobj, KOBJ_ADD);
 	if (!unmergeable) {
 		/* Setup first alias */
 		sysfs_slab_alias(s, s->name);
@@ -5851,7 +5836,7 @@ static int __init slab_sysfs_init(void)

 	mutex_lock(&slab_mutex);

-	slab_kset = kset_create_and_add("slab", &slab_uevent_ops, kernel_kobj);
+	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
 	if (!slab_kset) {
 		mutex_unlock(&slab_mutex);
 		pr_err("Cannot register slab subsystem.\n");
