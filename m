Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1925218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562186052;
	bh=6aeRlj1oFPSEX7b2IsaZkvOUVgMLM3YAevxp4V0rfOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whPkszr6CodgREClddm8FiMRKhuzk9BsSOKnWWht+/VxR5LlJZt19pOq+VYoqUQhn
	 Qrn5QeAB4b2ECQ5nA1QDjIBlH+bPgrFclYLJl4XKJG3/Z8lGUIPnxof1Hs/D2jzlk2
	 7BGMXlnns8kXvarH4LEph6b4OqcH5Bos80FAgJYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGCUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfGCUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:09 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52ED5218A6;
        Wed,  3 Jul 2019 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562186049;
        bh=6aeRlj1oFPSEX7b2IsaZkvOUVgMLM3YAevxp4V0rfOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKuYyxID6M2GpdVi5gTj0LE6yJleeIL0rny7qy1c2FtC1SNAQ8FmGOqCbiqnAt8sR
         DwLUdDeAk79nORd4KCKHL2S5SxCZccBYsAH9js13n6aCCeNQBX267JpN1DOokjt4FD
         b0ARXzj7YiYmh83dRzwTn1pK4AmIHYBtiWrxsg+g=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/4] x86/syscalls: Disallow compat entries for all types of 64-bit syscalls
Date:   Wed,  3 Jul 2019 13:34:03 -0700
Message-Id: <4b7565954c5a06530ac01d98cb1592538fd8ae51.1562185330.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185330.git.luto@kernel.org>
References: <cover.1562185330.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "compat" entry in the syscall tables means to use a different
entry on 32-bit and 64-bit builds.  This only makes sense for
syscalls that exist in the first place in 32-bit builds, so disallow
it for anything other than i386.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/syscalls/syscalltbl.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 94fcd1951aca..53c8c1a9adf9 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -27,8 +27,8 @@ emit() {
     compat="$4"
     umlentry=""
 
-    if [ "$abi" = "64" -a -n "$compat" ]; then
-	echo "a compat entry for a 64-bit syscall makes no sense" >&2
+    if [ "$abi" != "I386" -a -n "$compat" ]; then
+	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 
-- 
2.21.0

