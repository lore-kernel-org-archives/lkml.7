Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF40C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B08B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129292;
	bh=LnsFNpBJfXYxyAUMjNXpdCuzjQApJdVUskscUBhvFzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YzgZShvqcMBlbwQ3CZHGbIpYP+n5H/ldosA8ngdEZOC5wghO0JWtEwBvBvWidfIfL
	 HJ/4TN4F649i7Vsr1dFSZgJSJ8hVEFzUX0J+uG6vq5WiOerBLQns+ClLprhXB/uvDc
	 g+8R1JnjQByotVXqrNaTzytkO/mogb8IMlgj4fKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfDXSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbfDXRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A606218B0;
        Wed, 24 Apr 2019 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126181;
        bh=LnsFNpBJfXYxyAUMjNXpdCuzjQApJdVUskscUBhvFzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8ZWsX6Ti6ymQXzKQtbs9PKXtjUttEQyYe53vmqElhyTB57a0gAbK0YWx315eKR4w
         gEvw0OtzDkX3e+XSgHZAjNSr+GSUaXuz8/vhCJl+Gkom4ATotGfLPKM5WMyKb+hUiB
         BmNWzyRPik8ZoRlubjW73P3VGtPB/hInXcNUE4oA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.4 002/168] arm64: debug: Ensure debug handlers check triggering exception level
Date:   Wed, 24 Apr 2019 19:07:26 +0200
Message-Id: <20190424170923.593936482@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 6bd288569b50bc89fa5513031086746968f585cb upstream.

Debug exception handlers may be called for exceptions generated both by
user and kernel code. In many cases, this is checked explicitly, but
in other cases things either happen to work by happy accident or they
go slightly wrong. For example, executing 'brk #4' from userspace will
enter the kprobes code and be ignored, but the instruction will be
retried forever in userspace instead of delivering a SIGTRAP.

Fix this issue in the most stable-friendly fashion by simply adding
explicit checks of the triggering exception level to all of our debug
exception handlers.

Cc: <stable@vger.kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/kgdb.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -215,22 +215,31 @@ int kgdb_arch_handle_exception(int excep
 
 static int kgdb_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 
 static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	compiled_break = 1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 
 static struct break_hook kgdb_brkpt_hook = {


