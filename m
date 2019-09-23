Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA36F20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KJyIPSai";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xcxgKfYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404630AbfIWDun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 23:50:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59787 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404038AbfIWDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:50:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65F40860D1;
        Sun, 22 Sep 2019 23:50:41 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=MVUuUH7W9jCasBCGFD14PTolBvQ=; b=KJyIPS
        aiXmqCPl9caB9ItPEjbFbuxVVrpJblYxdVfziiu2vCJlESeebOvbunMZdjSmoQ3y
        Od8rW4j9y6dYqzs0FlYJ2BiRgRVaOIDJvrYqo776NAl2sMshWSVcXYdApgB1sUFD
        gP2U1hT/7eI16K4unQzu6aR9oCpF9SH7WVeL4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D276860CF;
        Sun, 22 Sep 2019 23:50:41 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=JVeZEyaxoXe27w9jPQ6cU6lzcXMTRNlh9K+ZFI/BpEo=; b=xcxgKfYimXqlilA6I6Eaz7u7Q5YXB46iRFdt+sJDvsZ0y1WkzehntdYausJ1x14/DQPWaxd9uRhV/5IT8PW8MXN05QRYc1HMYhgLSt+TQ3MIvEj8p6DPJERbBPl/Zjy929IQRiIi/G5JzIY0G4jLnuKlKXNMyVJzIrHajNeQgtY=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2831F860C7;
        Sun, 22 Sep 2019 23:50:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1A05E2DA0465;
        Sun, 22 Sep 2019 23:50:36 -0400 (EDT)
Date:   Sun, 22 Sep 2019 23:50:35 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Xiaoming Ni <nixiaoming@huawei.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, penberg@cs.helsinki.fi,
        jslaby@suse.com, textshell@uchuujin.de, sam@ravnborg.org,
        daniel.vetter@ffwll.ch, mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yuehaibing@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
In-Reply-To: <bee63793-e9f4-ecc4-7966-765207009c75@huawei.com>
Message-ID: <nycvar.YSQ.7.76.1909222347410.24536@knanqh.ubzr>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com> <20190919092933.GA2684163@kroah.com> <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr> <20190920060426.GA473496@kroah.com> <bee63793-e9f4-ecc4-7966-765207009c75@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 4E2BBE08-DDB5-11E9-8D9B-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019, Xiaoming Ni wrote:

> @ Nicolas Pitre
> Can I make a v2 patch based on your advice ?
> Or you will submit a patch for "GFP_WONTFAIL" yourself ?

Here's a patch implementing what I had in mind. This is compile tested 
only.

----- >8

Subject: [PATCH] mm: add __GFP_WONTFAIL and GFP_ONBOOT

Some memory allocations are very unlikely to fail during system boot.
Because of that, the code often doesn't bother to check for allocation
failure, but this gets reported anyway.

As an alternative to adding code to check for NULL that has almost no
chance of ever being exercised, let's use a GFP flag to identify those
cases and panic the kernel if allocation failure ever occurs.

Conversion of one such instance is also included.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d1ae..bd0a0e4807 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3356,7 +3356,7 @@ static int __init con_init(void)
 	}
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
-		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_ONBOOT);
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f33881688f..6f33575cd6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_WONTFAIL		0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x800000u
+#define ___GFP_NOLOCKDEP	0x1000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -187,6 +188,12 @@ struct vm_area_struct;
  * definitely preferable to use the flag rather than opencode endless
  * loop around allocator.
  * Using this flag for costly allocations is _highly_ discouraged.
+ *
+ * %__GFP_WONTFAIL: No allocation error is expected what so ever. The
+ * caller presumes allocation will always succeed (e.g. the system is still
+ * booting, the allocation size is relatively small and memory should be
+ * plentiful) so testing for failure is skipped. If allocation ever fails
+ * then the kernel will simply panic.
  */
 #define __GFP_IO	((__force gfp_t)___GFP_IO)
 #define __GFP_FS	((__force gfp_t)___GFP_FS)
@@ -196,6 +203,7 @@ struct vm_area_struct;
 #define __GFP_RETRY_MAYFAIL	((__force gfp_t)___GFP_RETRY_MAYFAIL)
 #define __GFP_NOFAIL	((__force gfp_t)___GFP_NOFAIL)
 #define __GFP_NORETRY	((__force gfp_t)___GFP_NORETRY)
+#define __GFP_WONTFAIL	((__force gfp_t)___GFP_WONTFAIL)
 
 /**
  * DOC: Action modifiers
@@ -217,7 +225,7 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
@@ -285,6 +293,9 @@ struct vm_area_struct;
  * available and will not wake kswapd/kcompactd on failure. The _LIGHT
  * version does not attempt reclaim/compaction at all and is by default used
  * in page fault path, while the non-light is used by khugepaged.
+ *
+ * %GFP_ONBOOT is for relatively small allocations that are not expected
+ * to fail while the system is booting.
  */
 #define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
@@ -300,6 +311,7 @@ struct vm_area_struct;
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
+#define GFP_ONBOOT	(GFP_NOWAIT | __GFP_WONTFAIL)
 
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff5484fdbd..36dee09f7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4625,6 +4625,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 fail:
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
+	if (gfp_mask & __GFP_WONTFAIL) {
+		/*
+		 * The assumption was wrong. This is never supposed to happen.
+		 * Caller most likely won't check for a returned NULL either.
+		 * So the only reasonable thing to do is to pannic.
+		 */
+		panic("Failed to allocate memory despite GFP_WONTFAIL\n");
+	}
 got_pg:
 	return page;
 }
