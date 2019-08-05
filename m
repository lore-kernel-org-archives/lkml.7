Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B4C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5221743
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010965;
	bh=njhFZQxy19PcglwTow94+N5gzFX0PX+0iAdPg690j6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=crH1CU9BxetGk/vFBykuBbTOJpd8NpszzyYPZpUjb04DdYrq9kvHWrGptSxWmSWr/
	 scrLzIDKRmbl8YVnepSMKa9e2O8oBEjNuREYII7oZR8ykmkkn3Oz+JFGmvTmzsR6VJ
	 gCV5euNAKkQ2fVjL26gKFGDB48SgI6x/gY4X0sd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfHENQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbfHENG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49A3206C1;
        Mon,  5 Aug 2019 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010389;
        bh=njhFZQxy19PcglwTow94+N5gzFX0PX+0iAdPg690j6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPatOKDxLgcjXhmSmYN6RUjQpZ7ZNkEMFzSR8wH8vI4Bxc0bjdObV03KbGyHfAZ30
         M0BZzjyC3kC+Q632Je2ionI6vqFgNbxQ2gb98NNVQI6c+UPrie5S9myubb/foJ+AJs
         aNpYZo2505AVNhsJkz7h71uB2D0LdsZaN94DbsFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Protsenko <semen.protsenko@linaro.org>,
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
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/42] coda: fix build using bare-metal toolchain
Date:   Mon,  5 Aug 2019 15:02:46 +0200
Message-Id: <20190805124927.323238471@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d30209b9cef81..0ca0c83fdb1c4 100644
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



