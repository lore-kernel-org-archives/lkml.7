Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MK1r/kKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfFNNCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:02:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfFNNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:02:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ED1o1r1697688
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 06:01:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ED1o1r1697688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517311;
        bh=I3M3pctM9I89W//e6VBySqtO/xU76PUAl/e7mvfPUno=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MK1r/kKraLnq3rGiazLFnvqVXsqnD/g0xf2MXhwDcKacw6/oxau62Vpxa5XIgJRXx
         7CFX2fBld97tZSPNVDPDqJfunb6HBqYUgr16fcdPndg8mNaPlvp0tfApzLsWD9Wthi
         4X03o1lm2WRWKmxJScXltMgs9kqmKS0ZTgvo+tRqvQkbdCsONgpgv6tYw+hGWXntuG
         giznJK66NL41IFxv05a28MlAQQH2e1jSE5rd8cuPkbqYMc6OJoN9t0LtbU1Q8iygcu
         J42uCv0HkMv15FC0VDa/FpX4lz2rh1T7CStMEs2U4rF3tW+j1b/5dzEx90fIJgoFyR
         lhtNxjXfSOFqQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ED1okY1697680;
        Fri, 14 Jun 2019 06:01:50 -0700
Date:   Fri, 14 Jun 2019 06:01:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d5f34153e526903abe71869dbbc898bfc0f69373@git.kernel.org>
Cc:     joel@joelfernandes.org, mingo@kernel.org, zhongjiang@huawei.com,
        linux-kernel@vger.kernel.org, cai@gmx.us, hpa@zytor.com,
        tglx@linutronix.de, longman@redhat.com, yang.shi@linux.alibaba.com,
        akpm@linux-foundation.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, cai@gmx.us,
          longman@redhat.com, yang.shi@linux.alibaba.com,
          akpm@linux-foundation.org, joel@joelfernandes.org,
          zhongjiang@huawei.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520141450.7575-6-longman@redhat.com>
References: <20190520141450.7575-6-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Move printk out of db->lock
 critical sections
Git-Commit-ID: d5f34153e526903abe71869dbbc898bfc0f69373
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d5f34153e526903abe71869dbbc898bfc0f69373
Gitweb:     https://git.kernel.org/tip/d5f34153e526903abe71869dbbc898bfc0f69373
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 10:14:50 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:16 +0200

debugobjects: Move printk out of db->lock critical sections

The db->lock is a raw spinlock and so the lock hold time is supposed
to be short. This will not be the case when printk() is being involved
in some of the critical sections. In order to avoid the long hold time,
in case some messages need to be printed, the debug_object_is_on_stack()
and debug_print_object() calls are now moved out of those critical
sections.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-6-longman@redhat.com

---
 lib/debugobjects.c | 58 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index ede96c659552..61261195f5b6 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -528,6 +528,7 @@ static void
 __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
+	bool check_stack = false;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -547,7 +548,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 			debug_objects_oom();
 			return;
 		}
-		debug_object_is_on_stack(addr, onstack);
+		check_stack = true;
 	}
 
 	switch (obj->state) {
@@ -558,20 +559,23 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init");
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
+		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_print_object(obj, "init");
-		break;
+		return;
 	default:
 		break;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (check_stack)
+		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -629,6 +633,8 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 
 	obj = lookup_object(addr, db);
 	if (obj) {
+		bool print_object = false;
+
 		switch (obj->state) {
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
@@ -637,14 +643,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 
 		case ODEBUG_STATE_ACTIVE:
-			debug_print_object(obj, "activate");
 			state = obj->state;
 			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_print_object(obj, "activate");
 			ret = debug_object_fixup(descr->fixup_activate, addr, state);
 			return ret ? 0 : -EINVAL;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "activate");
+			print_object = true;
 			ret = -EINVAL;
 			break;
 		default:
@@ -652,10 +658,13 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		if (print_object)
+			debug_print_object(obj, "activate");
 		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	/*
 	 * We are here when a static object is activated. We
 	 * let the type specific code confirm whether this is
@@ -687,6 +696,7 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -704,24 +714,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 			if (!obj->astate)
 				obj->state = ODEBUG_STATE_INACTIVE;
 			else
-				debug_print_object(obj, "deactivate");
+				print_object = true;
 			break;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
+			print_object = true;
 			break;
 		default:
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "deactivate");
+	} else if (print_object) {
+		debug_print_object(obj, "deactivate");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -736,6 +749,7 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -755,20 +769,22 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "destroy");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "destroy");
 		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "destroy");
+		print_object = true;
 		break;
 	default:
 		break;
 	}
 out_unlock:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (print_object)
+		debug_print_object(obj, "destroy");
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -797,9 +813,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free");
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -872,6 +888,7 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -887,22 +904,25 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 			if (obj->astate == expect)
 				obj->astate = next;
 			else
-				debug_print_object(obj, "active_state");
+				print_object = true;
 			break;
 
 		default:
-			debug_print_object(obj, "active_state");
+			print_object = true;
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "active_state");
+	} else if (print_object) {
+		debug_print_object(obj, "active_state");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -937,10 +957,10 @@ repeat:
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				debug_print_object(obj, "free");
 				descr = obj->descr;
 				state = obj->state;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_print_object(obj, "free");
 				debug_object_fixup(descr->fixup_free,
 						   (void *) oaddr, state);
 				goto repeat;
