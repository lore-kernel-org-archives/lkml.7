Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233CE212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370541;
	bh=NpWdLlvlgVzlOmBWQMyBRockYxupEsdFueLaXSNjT6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yPQ2R7ZwHoMmuk7EpcG3jzGKYj9YxRtvrK02B1IyDScBvjCNqJVMODsa7sDmxAlIH
	 bRuI4dUukGr0bbjvlxQIk26Rid9ifVmtVZoNwLU7XUvZwWmaXxFPTeVbqVdwO9lDMC
	 t3HHXFucVue3ie0qcZSRw+bd54FWn26UM+LhlMO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfFXKCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbfFXKCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:02:17 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F7F205ED;
        Mon, 24 Jun 2019 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370536;
        bh=NpWdLlvlgVzlOmBWQMyBRockYxupEsdFueLaXSNjT6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhfeiEvGuiGis177lwXasAER1WYu1V6AyM3spdrKfBcB6W23IfQ+j+lpKYHElfm0d
         237WiJ+uMaPqr12qk36glnkT7Q6+VTgybEewmQyteJR2uKbzqOhPcjpfDU4hwrN8Fs
         SP1sDO/SHmJhGKa0gt8CrPfZe14YxkO9kU502Cm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 03/90] gcc-9: silence address-of-packed-member warning
Date:   Mon, 24 Jun 2019 17:55:53 +0800
Message-Id: <20190624092314.097362613@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
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
@@ -652,6 +652,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warni
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
@@ -696,7 +697,6 @@ ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the


