Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B26C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FC24672
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1xKDPk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLPVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726646AbfLPVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576531891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wA2v5bd7y9zj1BvwWA29iyklcyeaUYmEU8VPY6Cu/no=;
        b=Y1xKDPk3/L6vvRt5VIGPJvpDob9zpE5aGdETXOmc3XzfYwBwatYR/O6ZTiJtgEeoFLeh+W
        0e9PA/5auA51Lqn0sKDotgikptWZec9zH5evmRI9Z/WBwNDzLLDZDQuGXIovihvZpgeunp
        mJNOmbReutfjgx+ME3TZZuSm/rgg5CY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-sglaArxnN8Kz2JA3dEZdIw-1; Mon, 16 Dec 2019 16:31:29 -0500
X-MC-Unique: sglaArxnN8Kz2JA3dEZdIw-1
Received: by mail-qk1-f199.google.com with SMTP id u30so5560791qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA2v5bd7y9zj1BvwWA29iyklcyeaUYmEU8VPY6Cu/no=;
        b=PvRPxCIOBCc0iHu0LEjuelQQSxoHfa5gabtORv3Z9e7la09D9X1Adeh7eIKKoECC1d
         FD7XHHp+U0eAWky1Q5laih3e5AmnhAmKvhUGOIpM9Sra1jyq66DugWi9QUKxbScAQFjZ
         uIojwYc7Wu6GlhkXnvrr0+rBcF30HqpsjPzzDnCzNHck5Hb3dK2wmwpShz94JHWbhjTr
         kfHmUAEBjdFkPPa/bPoq8c1z9ra47kGUY8f92vkXIUBSMxfTw5ULCpydJuioYa1tjQTq
         Ozkm/pSiDJUgQhR4b8qKPffM7UDkesE3ZJFr/2+MKp+DisF8r1KuodkVWl3z3wxF82hG
         Fpow==
X-Gm-Message-State: APjAAAW9Z8n2gb53bWCoxextfFMrw67lxfLPa55U5aYWBwG40MSpfv9S
        16AVHx9OD78SWw7MB7MEw0hSRMrN+eURfSpDdv3kC4YIW1MGL4evVvJYZJ5PvY7YMpSwYCxaOro
        Vjpy2aGgmbMzAoPsxp3K65eFX
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr1656702qku.414.1576531889002;
        Mon, 16 Dec 2019 13:31:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0XqeB/TuNLAQr0FBxOvF5dzgyHAEK6FuNubrHUTDjBDQndcnXlkovgOPZUNEQ5Ia7DSUbRw==
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr1656672qku.414.1576531888754;
        Mon, 16 Dec 2019 13:31:28 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y184sm6321943qkd.128.2019.12.16.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:31:27 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, peterx@redhat.com,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/3] smp: Allow smp_call_function_single_async() to insert locked csd
Date:   Mon, 16 Dec 2019 16:31:23 -0500
Message-Id: <20191216213125.9536-2-peterx@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216213125.9536-1-peterx@redhat.com>
References: <20191216213125.9536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we will raise an warning if we want to insert a csd object
which is with the LOCK flag set, and if it happens we'll also wait for
the lock to be released.  However, this operation does not match
perfectly with how the function is named - the name with "_async"
suffix hints that this function should not block, while we will.

This patch changed this behavior by simply return -EBUSY instead of
waiting, at the meantime we allow this operation to happen without
warning the user to change this into a feature when the caller wants
to "insert a csd object, if it's there, just wait for that one".

This is pretty safe because in flush_smp_call_function_queue() for
async csd objects (where csd->flags&SYNC is zero) we'll first do the
unlock then we call the csd->func().  So if we see the csd->flags&LOCK
is true in smp_call_function_single_async(), then it's guaranteed that
csd->func() will be called after this smp_call_function_single_async()
returns -EBUSY.

Update the comment of the function too to refect this.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/smp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..dd31e8228218 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -329,6 +329,11 @@ EXPORT_SYMBOL(smp_call_function_single);
  * (ie: embedded in an object) and is responsible for synchronizing it
  * such that the IPIs performed on the @csd are strictly serialized.
  *
+ * If the function is called with one csd which has not yet been
+ * processed by previous call to smp_call_function_single_async(), the
+ * function will return immediately with -EBUSY showing that the csd
+ * object is still in progress.
+ *
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
  */
@@ -338,14 +343,17 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 
 	preempt_disable();
 
-	/* We could deadlock if we have to wait here with interrupts disabled! */
-	if (WARN_ON_ONCE(csd->flags & CSD_FLAG_LOCK))
-		csd_lock_wait(csd);
+	if (csd->flags & CSD_FLAG_LOCK) {
+		err = -EBUSY;
+		goto out;
+	}
 
 	csd->flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
 	err = generic_exec_single(cpu, csd, csd->func, csd->info);
+
+out:
 	preempt_enable();
 
 	return err;
-- 
2.23.0

