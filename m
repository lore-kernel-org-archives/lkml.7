Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7D020B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153227;
	bh=f11jp5pnuLRKWRjULmAaNIRfddqjIyIyxGbk8hTPxWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uGFGXXnIGHpwf951fuEi9nfQ/0wJeNddNWOJoOWmoFEa4ZmCAlHqDCaWd7cgGj+DV
	 9AVR/O3H7nDLVKljWwx9imL/dtJXOlNipIpIp2PBALwd/U3hsBkHoi/VUUyOgsV0fB
	 6zakq5sjck3BAe/C+O0JzHfYqyWEBFuSV1uqhTN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEFOdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEFOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:33:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A61204EC;
        Mon,  6 May 2019 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153224;
        bh=f11jp5pnuLRKWRjULmAaNIRfddqjIyIyxGbk8hTPxWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJ4MlraK8Sl2EQn7N+Yb0q7nM80cBVJETE5BP/lJVSqXoWdNrdRPQRyCJL8XcRMCU
         2jcZIwjJTmWY4h/+0bB0qn9yTx650GWNvqHuN3IqreSW3rU/iHpojeubsYzkfJBF8p
         bzsjyPS8p30Ur9NQ3Q077MPDixvYvxE7lkezj7t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        James Morris <jamorris@linux.microsoft.com>
Subject: [PATCH 5.0 001/122] selftests/seccomp: Prepare for exclusive seccomp flags
Date:   Mon,  6 May 2019 16:30:59 +0200
Message-Id: <20190506143054.814812713@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 4ee0776760af03f181e6b80baf5fb1cc1a980f50 upstream.

Some seccomp flags will become exclusive, so the selftest needs to
be adjusted to mask those out and test them individually for the "all
flags" tests.

Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |   34 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2166,11 +2166,14 @@ TEST(detect_seccomp_filter_flags)
 				 SECCOMP_FILTER_FLAG_LOG,
 				 SECCOMP_FILTER_FLAG_SPEC_ALLOW,
 				 SECCOMP_FILTER_FLAG_NEW_LISTENER };
-	unsigned int flag, all_flags;
+	unsigned int exclusive[] = {
+				SECCOMP_FILTER_FLAG_TSYNC,
+				SECCOMP_FILTER_FLAG_NEW_LISTENER };
+	unsigned int flag, all_flags, exclusive_mask;
 	int i;
 	long ret;
 
-	/* Test detection of known-good filter flags */
+	/* Test detection of individual known-good filter flags */
 	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
 		int bits = 0;
 
@@ -2197,16 +2200,29 @@ TEST(detect_seccomp_filter_flags)
 		all_flags |= flag;
 	}
 
-	/* Test detection of all known-good filter flags */
-	ret = seccomp(SECCOMP_SET_MODE_FILTER, all_flags, NULL);
-	EXPECT_EQ(-1, ret);
-	EXPECT_EQ(EFAULT, errno) {
-		TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
-		       all_flags);
+	/*
+	 * Test detection of all known-good filter flags combined. But
+	 * for the exclusive flags we need to mask them out and try them
+	 * individually for the "all flags" testing.
+	 */
+	exclusive_mask = 0;
+	for (i = 0; i < ARRAY_SIZE(exclusive); i++)
+		exclusive_mask |= exclusive[i];
+	for (i = 0; i < ARRAY_SIZE(exclusive); i++) {
+		flag = all_flags & ~exclusive_mask;
+		flag |= exclusive[i];
+
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EFAULT, errno) {
+			TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
+			       flag);
+		}
 	}
 
-	/* Test detection of an unknown filter flag */
+	/* Test detection of an unknown filter flags, without exclusives. */
 	flag = -1;
+	flag &= ~exclusive_mask;
 	ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
 	EXPECT_EQ(-1, ret);
 	EXPECT_EQ(EINVAL, errno) {


