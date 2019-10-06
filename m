Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52702087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383766;
	bh=I8B5kB4woAS8zeIX3RW9KSgJ4z9Xq/XpjsL8Ffdl0vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/tdgOOAVs0pQpWrh6bbP5ni4XkeekBRhxKH7r9azzDICCTHfdqUBFt+Sagsqrxzg
	 ynYxK4R9J3aMv1TDogGesQ6zeQVLzSu0wcgo0rRk31w0egLokz18tGD6rubdQUF3tL
	 hbk4I5q/s/GT9053x+RusLFKKQBlomPZMAgqsJTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfJFRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbfJFRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347AB2133F;
        Sun,  6 Oct 2019 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383762;
        bh=I8B5kB4woAS8zeIX3RW9KSgJ4z9Xq/XpjsL8Ffdl0vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhqYum3kTr/i5LqWzaAxBR4sWgSTPxAtMNjW1Bn2AkoVMxctqKJTbema5Age0GF3P
         dfEKqxtowqJc0qrLntNT5dKnNcRhvqttktboM4dYgrkGJ8r+V0yqDjuEASch93BM6r
         9RsPEgV9Ugqc3L+IY+GjjzdDfosyZyGn7jBNWHn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 042/166] powerpc/futex: Fix warning: oldval may be used uninitialized in this function
Date:   Sun,  6 Oct 2019 19:20:08 +0200
Message-Id: <20191006171216.487058904@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 38a0d0cdb46d3f91534e5b9839ec2d67be14c59d ]

We see warnings such as:
  kernel/futex.c: In function 'do_futex':
  kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return oldval == cmparg;
                   ^
  kernel/futex.c:1651:6: note: 'oldval' was declared here
    int oldval, ret;
        ^

This is because arch_futex_atomic_op_inuser() only sets *oval if ret
is 0 and GCC doesn't see that it will only use it when ret is 0.

Anyway, the non-zero ret path is an error path that won't suffer from
setting *oval, and as *oval is a local var in futex_atomic_op_inuser()
it will have no impact.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: reword change log slightly]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/86b72f0c134367b214910b27b9a6dd3321af93bb.1565774657.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/futex.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 3a6aa57b9d901..eea28ca679dbb 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -60,8 +60,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	pagefault_enable();
 
-	if (!ret)
-		*oval = oldval;
+	*oval = oldval;
 
 	prevent_write_to_user(uaddr, sizeof(*uaddr));
 	return ret;
-- 
2.20.1



