Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D50C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D69322CD7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148768;
	bh=2HAjsazSUtJXt2TTMq9ufkoer4YWsLVnedNBQy4W8XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qv/oZ4BWi/l+TsPveMaPLwbtDYmCedH+M3ac5sj4xDyvuzxWB9Kk07zL2h+n2ENqv
	 7nPD54clxnDvDWK0hEo+tvmmHTOtP6d55hBvN2He1joKxZrL6OTyG0edrFIom3uZtK
	 /xtmCJdXg9vQ3qQ8YFET7usQWVTMLDYeJlEqqpbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfGZNqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbfGZNp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3E022CF4;
        Fri, 26 Jul 2019 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148759;
        bh=2HAjsazSUtJXt2TTMq9ufkoer4YWsLVnedNBQy4W8XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Z/jlhgRf1ZLGU5+g696EUq6puttgM0F9OtE3MelBRFtLOir4lRs6fCDAEOcPoLfY
         NU/bOKyUlygzYcWswpiSU4iSlobBjENbdmq2CGrFVAYLxULNfUkS6lA+0/5lfOt2qi
         MQWTqvyG88KzCghYAlmhDQk0NCYQrBbpWfdoze68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Fabian Frederick <fabf@skynet.be>,
        Mikko Rapeli <mikko.rapeli@iki.fi>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, codalist@coda.cs.cmu.edu
Subject: [PATCH AUTOSEL 4.4 17/23] coda: fix build using bare-metal toolchain
Date:   Fri, 26 Jul 2019 09:45:16 -0400
Message-Id: <20190726134522.13308-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134522.13308-1-sashal@kernel.org>
References: <20190726134522.13308-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Protsenko <semen.protsenko@linaro.org>

[ Upstream commit b2a57e334086602be56b74958d9f29b955cd157f ]

The kernel is self-contained project and can be built with bare-metal
toolchain.  But bare-metal toolchain doesn't define __linux__.  Because
of this u_quad_t type is not defined when using bare-metal toolchain and
codafs build fails.  This patch fixes it by defining u_quad_t type
unconditionally.

Link: http://lkml.kernel.org/r/3cbb40b0a57b6f9923a9d67b53473c0b691a3eaa.1558117389.git.jaharkes@cs.cmu.edu
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Yann Droneaud <ydroneaud@opteya.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/coda.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/coda.h b/include/linux/coda.h
index d30209b9cef8..0ca0c83fdb1c 100644
--- a/include/linux/coda.h
+++ b/include/linux/coda.h
@@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
 #ifndef _CODA_HEADER_
 #define _CODA_HEADER_
 
-#if defined(__linux__)
 typedef unsigned long long u_quad_t;
-#endif
+
 #include <uapi/linux/coda.h>
 #endif 
-- 
2.20.1

