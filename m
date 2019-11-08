Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888821848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232497;
	bh=8576erlpBEecdBZLwaAf1hANQyRlAVg5w9VzhgYn1N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKM4F0EisNLyPvQ+dsWev+CjXMN1fPZ8k1j2r9pgLMgnUZ0B1DlWA7IK+oNJ5aAh1
	 CTIqJ5+nvf93/hfVme57/OjBztPdQi6HkR9fjdO1xdfzdmF4IsYpLBkD7Ag9Q9FR5c
	 tyCK5kcycsK+aPEoNfnblUIhCvaQkvw0XznpWxkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfKHRBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfKHRBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:35 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15698218AE;
        Fri,  8 Nov 2019 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232495;
        bh=8576erlpBEecdBZLwaAf1hANQyRlAVg5w9VzhgYn1N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQPLKMFTmKtUZrfE3t7fIwnKcTB8Q4GrSwDBG6Plp2pjYB/4SEURJMylIYjxap80C
         9jQhqVE8V7fknpdFh1PU4i5Wri22OGwEnaDY7uqEqHlzbj3LH2qi1A5wN473to2iaS
         xhDH1bVxYwWCkKi2t5TgPxVPltHPTMheMiRG/sTQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 02/13] READ_ONCE: Undefine internal __READ_ONCE_SIZE macro after use
Date:   Fri,  8 Nov 2019 17:01:09 +0000
Message-Id: <20191108170120.22331-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '__READ_ONCE_SIZE()' macro is only used as part of building
'READ_ONCE()', so undefine it once we don't need it anymore.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index d189455ae038..abf326634ecd 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -59,6 +59,8 @@ void __read_once_size_nocheck(const volatile void *p, void *res, int size)
 	__READ_ONCE_SIZE;
 }
 
+#undef __READ_ONCE_SIZE
+
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
 {
 	switch (size) {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

