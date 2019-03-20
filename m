Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699622183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKUo4cy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCTQPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:15:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52602 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCTQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DXuig+AJEWqv1vBbJJPr3sxyDmxliaIOlkmxMvCRbfg=; b=MKUo4cy6OS5c9EMPTbuRdIed/
        deF1gVfrvSlY58y+eMwGoATmemMKawYTaoY/oUJ94cY1Cs6Jm3V7QH4+DNQZoXGCwOLWgH02yX03U
        OUetI8OYMwdR5/FD+LxpAHrtSwRGmPL26If1VD35q3hNj6cpJqn8gM+KZ+EBQzAO22AyVeIbVanWw
        THPB8b+xqeGWcflhPps3e6ygnlFrtzqz2jdSE/1IyPWIZsGesHIo1XaV9eC/Qs/Uvsd/vzaQG9BrK
        hs2U+ELLkpjvvdhAaKxDm3D3uvjJ0y9Ec5tGBi486mphN5bgv/nDa7HMoZnPx1OT4NRb5wWxzHw6C
        r1C+ORdOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6drh-0004bN-0H; Wed, 20 Mar 2019 16:14:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AB90201A1C72; Wed, 20 Mar 2019 17:14:51 +0100 (CET)
Date:   Wed, 20 Mar 2019 17:14:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     pbonzini@redhat.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH] locking/static_key: Fix false positive warnings on
 concurrent dec/inc
Message-ID: <20190320161451.GJ6058@hirez.programming.kicks-ass.net>
References: <20190318215814.3724-1-jakub.kicinski@netronome.com>
 <20190319121856.GE5996@hirez.programming.kicks-ass.net>
 <20190319104657.6fa99d82@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319104657.6fa99d82@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:46:57AM -0700, Jakub Kicinski wrote:

> That indeed looks far cleanest, thanks!
> 
> Tested-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks, I've made it into the below patch.

---

Subject: locking/static_key: Fix false positive warnings on concurrent dec/inc
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 19 Mar 2019 13:18:56 +0100

Even though the atomic_dec_and_mutex_lock() in
__static_key_slow_dec_cpuslocked() can never see a negative value in
key->enabled the subsequent sanity check is re-reading key->enabled, which may
have been set to -1 in the meantime by static_key_slow_inc_cpuslocked().


                CPU  A                               CPU B

 __static_key_slow_dec_cpuslocked():          static_key_slow_inc_cpuslocked():
                               # enabled = 1
   atomic_dec_and_mutex_lock()
                               # enabled = 0
                                              atomic_read() == 0
                                              atomic_set(-1)
                               # enabled = -1
   val = atomic_read()
   # Oops - val == -1!


The test case is TCP's clean_acked_data_enable() / clean_acked_data_disable()
as tickled by ktls (net/ktls).

Cc: mingo@kernel.org
Cc: oss-drivers@netronome.com
Cc: ard.biesheuvel@linaro.org
Cc: tglx@linutronix.de
Cc: pbonzini@redhat.com
Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Tested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/jump_label.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -206,6 +206,8 @@ static void __static_key_slow_dec_cpuslo
 					   unsigned long rate_limit,
 					   struct delayed_work *work)
 {
+	int val;
+
 	lockdep_assert_cpus_held();
 
 	/*
@@ -215,17 +217,20 @@ static void __static_key_slow_dec_cpuslo
 	 * returns is unbalanced, because all other static_key_slow_inc()
 	 * instances block while the update is in progress.
 	 */
-	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
-		WARN(atomic_read(&key->enabled) < 0,
-		     "jump label: negative count!\n");
+	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
+	if (val != 1) {
+		WARN(val < 0, "jump label: negative count!\n");
 		return;
 	}
 
-	if (rate_limit) {
-		atomic_inc(&key->enabled);
-		schedule_delayed_work(work, rate_limit);
-	} else {
-		jump_label_update(key);
+	jump_label_lock();
+	if (atomic_dec_and_test(&key->enabled)) {
+		if (rate_limit) {
+			atomic_inc(&key->enabled);
+			schedule_delayed_work(work, rate_limit);
+		} else {
+			jump_label_update(key);
+		}
 	}
 	jump_label_unlock();
 }
