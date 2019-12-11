Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF394C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48A124656
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076969;
	bh=rVwHSdF1S7JYEeKe0HR7QEXKgXHVfwcBcfN5qKNNnMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hF9toqHkjW1q7ASzXN4hvLqd9tqDK1lqtiGkj8Ozl6oXn1poySKt9xbD+r49M30/K
	 tcwYEL/NnJgn6xminb0q8HBL+ij1JgEzNH+4Eg1to9ibhGGjfVeEJFyGHE06yDFbG/
	 CkW5IX4/7cEv7kIPQNgApI8j6cLSX6AdxNjx1mz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfLKPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729481AbfLKPJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:09:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3BC222C4;
        Wed, 11 Dec 2019 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076960;
        bh=rVwHSdF1S7JYEeKe0HR7QEXKgXHVfwcBcfN5qKNNnMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFHH4tGXt5Bhnmtn+9gPk8OmmF+a9WRnjHqNNy6CSFEgnRZlGE22ok4oiAk46l9QC
         WGHSd40gptVlaPjh8yGuJprdjV491FoS0V5Dtix+xzgLWBi3oGXJ7rk1q2fGvA/27Z
         wfuItKbdFv93kpOIO5VMd9Q1dp9Se03leHFKeXIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.4 57/92] arm64: Validate tagged addresses in access_ok() called from kernel threads
Date:   Wed, 11 Dec 2019 16:05:48 +0100
Message-Id: <20191211150247.321136840@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

commit df325e05a682e9c624f471835c35bd3f870d5e8c upstream.

__range_ok(), invoked from access_ok(), clears the tag of the user
address only if CONFIG_ARM64_TAGGED_ADDR_ABI is enabled and the thread
opted in to the relaxed ABI. The latter sets the TIF_TAGGED_ADDR thread
flag. In the case of asynchronous I/O (e.g. io_submit()), the
access_ok() may be called from a kernel thread. Since kernel threads
don't have TIF_TAGGED_ADDR set, access_ok() will fail for valid tagged
user addresses. Example from the ffs_user_copy_worker() thread:

	use_mm(io_data->mm);
	ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
	unuse_mm(io_data->mm);

Relax the __range_ok() check to always untag the user address if called
in the context of a kernel thread. The user pointers would have already
been checked via aio_setup_rw() -> import_{single_range,iovec}() at the
time of the asynchronous I/O request.

Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
Cc: <stable@vger.kernel.org> # 5.4.x-
Cc: Will Deacon <will@kernel.org>
Reported-by: Evgenii Stepanov <eugenis@google.com>
Tested-by: Evgenii Stepanov <eugenis@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/uaccess.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -62,8 +62,13 @@ static inline unsigned long __range_ok(c
 {
 	unsigned long ret, limit = current_thread_info()->addr_limit;
 
+	/*
+	 * Asynchronous I/O running in a kernel thread does not have the
+	 * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
+	 * the user address before checking.
+	 */
 	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
-	    test_thread_flag(TIF_TAGGED_ADDR))
+	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
 		addr = untagged_addr(addr);
 
 	__chk_user_ptr(addr);


