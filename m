Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7728C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A7C216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562601002;
	bh=P4zCUfw3PBJ37v5L33h79iJqNctbwXqXcDvvCEH9UCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eXVIsYF3nzFJBJqgtuiuhdgshZPdY70ew6ySbH6ItU1NS8M1PlkJvYaBTxv6VkQ0u
	 6hPmN33/ACH8NoH7cnrj/F5z7xEbf+lOk58K0whncENCqBxggeQEhk90wYeTeWn+3m
	 QTFz3p3mtiJNjpl+ze2Vw9KQ7deWe1GT9foU/GC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391474AbfGHPuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbfGHPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:15:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D91216FD;
        Mon,  8 Jul 2019 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598953;
        bh=P4zCUfw3PBJ37v5L33h79iJqNctbwXqXcDvvCEH9UCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLl/IX7I3H79Kf+blpzC2Jl7k3XWwJldv5xrQOWCU4mBCNJuXBTUICjVbgESk+Cr2
         emYpeLv8GJqAmFqzqrYOKpidDmybEzBujIp5JhMV+5HIByEIX46fwpStQA534/Bs0O
         l4IPhdPAmTxyJ5TQLq9uGlmUKVY14wfBpD5pV7oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 05/73] gcc-9: silence address-of-packed-member warning
Date:   Mon,  8 Jul 2019 17:12:15 +0200
Message-Id: <20190708150518.071139435@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 6f303d60534c46aa1a239f29c321f95c83dda748 upstream.

We already did this for clang, but now gcc has that warning too.  Yes,
yes, the address may be unaligned.  And that's kind of the point.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Makefile
+++ b/Makefile
@@ -636,6 +636,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warni
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
@@ -712,7 +713,6 @@ ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the


