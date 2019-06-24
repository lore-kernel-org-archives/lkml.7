Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4534C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914B1208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370326;
	bh=wZqc0efwhTt7a7sN79w0xtLc1GDzGFBGZY5PRH6sqH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFJMXWIhEwkNy3mSii4ukOJ4Fc8JNJf0XanPSApO+lgG6LATIXMz7nWQHCs+utbHP
	 LU7vwizNdVJlBu1UTF7GH9S9fObpvFuwZANNMeJFwlki+gzdvNFnSSSHW0XtTpfisu
	 EA0IxwW4HUqoONTUVx5zNOlz0CEFuZSbA3kxCz6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfFXJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbfFXJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:58:43 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4FC214C6;
        Mon, 24 Jun 2019 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370323;
        bh=wZqc0efwhTt7a7sN79w0xtLc1GDzGFBGZY5PRH6sqH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/UB31RoM8prKAvW47m7DZuiuTKeEMyh/Ju9COhaDVH5ewWdCAbgIKsiDESY9Tksg
         mGjHMAlUCSElJBW4UDe2B0WkzSb8k0EO8HRXmrJCK72lqSASxc7JQy3F3JGe/f2uGL
         mo2IwcztTT2yiLMkeWhjBgNVVzcrv/PXWkVbfOGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 03/51] gcc-9: silence address-of-packed-member warning
Date:   Mon, 24 Jun 2019 17:56:21 +0800
Message-Id: <20190624092306.319099559@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
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
@@ -650,6 +650,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warni
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
@@ -716,7 +717,6 @@ ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the


