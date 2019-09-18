Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF95921927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787803;
	bh=MWUV2b6QxsbPsvTZ3TNr/yspJoRscZir+Gd6EwbVJdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pn7O0JtnhtGpl3mfBw9GVDqhD64MD/J+s2fOaJxx3DF4r9nWKnaU9SQP3VWhnntlg
	 MYt7OWm5mbgPQB7avVdjxM7HWd6ZHWgvPu2QxuOhGfldCph2TSdtwa7tK8BYAzB7Xd
	 wkH41aTJqU6iEK7l802GIWNe6VNaqufm9GAfNnyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfIRGXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfIRGXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:23:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404F621920;
        Wed, 18 Sep 2019 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787786;
        bh=MWUV2b6QxsbPsvTZ3TNr/yspJoRscZir+Gd6EwbVJdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/tRwCxBgYfbqnZMCwEw7td0jzjaBMAR+oICaNtUYuzHanpGeEcQyVSkRVgk+vtcx
         p0UpGDX1yKG7W6aSEROitgMZ94XUcNOLLiiAiU2wnnXh93K1CSzoEcgGeFIsnZyjU3
         rvJZ2wFHv5xjnwHrwp36b8+Vyprm+EVVeeUwQZeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 26/50] powerpc: Add barrier_nospec to raw_copy_in_user()
Date:   Wed, 18 Sep 2019 08:19:09 +0200
Message-Id: <20190918061225.846518448@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

commit 6fbcdd59094ade30db63f32316e9502425d7b256 upstream.

Commit ddf35cf3764b ("powerpc: Use barrier_nospec in copy_from_user()")
Added barrier_nospec before loading from user-controlled pointers. The
intention was to order the load from the potentially user-controlled
pointer vs a previous branch based on an access_ok() check or similar.

In order to achieve the same result, add a barrier_nospec to the
raw_copy_in_user() function before loading from such a user-controlled
pointer.

Fixes: ddf35cf3764b ("powerpc: Use barrier_nospec in copy_from_user()")
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/uaccess.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -306,6 +306,7 @@ extern unsigned long __copy_tofrom_user(
 static inline unsigned long
 raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
+	barrier_nospec();
 	return __copy_tofrom_user(to, from, n);
 }
 #endif /* __powerpc64__ */


