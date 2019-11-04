Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA3920B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cWzsrd68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfKDRhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:37:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfKDRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:37:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id q13so18103716wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q42A9GE6rbKyvGuSxAml40ibzM2Hb1uuhq9f3IXuc4Y=;
        b=cWzsrd68SdlOV0Q302wyR11tF2fkJQituuofoLZ+F7zHH+FsGdI5n7j9ewIP4i68t1
         gXlwqq2sifm3AD7OAy94JW+f9rDRDD+4V6dymz3aeo86ZQANScxbAns0LeqfbDoHpwA7
         ceGpUMSuTsUpfDA7pjN3SCRZORqyFTw2D4K3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q42A9GE6rbKyvGuSxAml40ibzM2Hb1uuhq9f3IXuc4Y=;
        b=mwcVI/Ytcqe5i4uiGrIHyYcj5AMxr13P3xVRIQHz8c3/e8SoT5uw+cQshbr3D7rxPA
         eLSukETRQZTTGKScvRChX8bqycjWUaBvWgUfnl5XpX5AVe/dW1WsbVkBr8T1t63m8l98
         bd9JDfgk8bc74tXc5Zs5kbgPe2wp3zVNBHdZIlp3DWLQNSfaBb+nfDHzcZ6xt2ATaztp
         7cZ9zbiD1FZyt8LNHkll9n5jIz/ZhgTne+i5OxdVZrJhf//sHNZiKHZ3EN3bb5b4SUd+
         tLf3ussVAbhxw3gPkDNAaOVNc3/QkzdHuEeDZvOGxHf3p1HuYsuA1EMkF9dzHRs69O7p
         kVbw==
X-Gm-Message-State: APjAAAXRoqQ+cuDwiY4v7c242uxByjzS4X+ZtJcU+1ogxFW+p7wJ1rx0
        hlU56C3TQiS0RvgCq3bw+D7X3Q==
X-Google-Smtp-Source: APXvYqyZGwOKtaoeBaHT91cDJ8JsAllkAP5LrJWjODhvvXVM7htvxjcm6lrzfjLAuEk+9Ke+1UEPnA==
X-Received: by 2002:adf:d18b:: with SMTP id v11mr25588251wrc.308.1572889051786;
        Mon, 04 Nov 2019 09:37:31 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l22sm32408863wrb.45.2019.11.04.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:37:30 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lockdep: add might_lock_nested()
Date:   Mon,  4 Nov 2019 18:37:19 +0100
Message-Id: <20191104173720.2696-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191104173720.2696-1-daniel.vetter@ffwll.ch>
References: <20191104173720.2696-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Necessary to annotate functions where we might acquire a
mutex_lock_nested() or similar. Needed by i915.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/lockdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index e0eca94e58c8..c4155436e6fc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -628,6 +628,13 @@ do {									\
 	lock_acquire(&(lock)->dep_map, 0, 0, 1, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, 0, _THIS_IP_);			\
 } while (0)
+# define might_lock_nested(lock, subclass) 				\
+do {									\
+	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
+	lock_acquire(&(lock)->dep_map, subclass, 0, 1, 1, NULL,		\
+		     _THIS_IP_);					\
+	lock_release(&(lock)->dep_map, 0, _THIS_IP_);		\
+} while (0)
 
 #define lockdep_assert_irqs_enabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
@@ -650,6 +657,7 @@ do {									\
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
+# define might_lock_nested(lock, subclass) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
-- 
2.24.0.rc2

