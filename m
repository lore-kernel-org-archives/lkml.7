Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DDDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640A120865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482329;
	bh=QLRIQ6w2SD3IKDPtQP3oJZdEEthwGbIiI78k4VHxfbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CD2iE/c6QmEkDHRUo4t7nNIOM3vn6/S1605WcYqM8973maMbe4rkkBljbVxxdUMI6
	 PdI7b08fng6c9/tumqhvsU2mxojMEPDu7uszdH2QJ5YobXCtVClk/zCUumNlGl/9eu
	 LyqtP73CNVq03A0fa7KKF0JUgDMmlyxAodNOaILw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfLDR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfLDR6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:44 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB2B20865;
        Wed,  4 Dec 2019 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482324;
        bh=QLRIQ6w2SD3IKDPtQP3oJZdEEthwGbIiI78k4VHxfbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgkblvC1bcvC2jzrpXfuZbHmSXieiv88LRH5iaaLo6RTZ7PVxrn5zclO77gIKwv5B
         XOu74uAnFQXGZPx83d7bI3cs8pzvcneykmu7jhgG9w8HhYvdg00ohSeCSxC8gvXPoL
         l4fG4iiziAoI70zBFJ878sqcEnkGEPMIdihrYwEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/92] scripts/gdb: fix debugging modules compiled with hot/cold partitioning
Date:   Wed,  4 Dec 2019 18:49:07 +0100
Message-Id: <20191204174329.362456823@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 8731acc5068eb3f422a45c760d32198175c756f8 ]

gcc's -freorder-blocks-and-partition option makes it group frequently
and infrequently used code in .text.hot and .text.unlikely sections
respectively.  At least when building modules on s390, this option is
used by default.

gdb assumes that all code is located in .text section, and that .text
section is located at module load address.  With such modules this is no
longer the case: there is code in .text.hot and .text.unlikely, and
either of them might precede .text.

Fix by explicitly telling gdb the addresses of code sections.

It might be tempting to do this for all sections, not only the ones in
the white list.  Unfortunately, gdb appears to have an issue, when
telling it about e.g. loadable .note.gnu.build-id section causes it to
think that non-loadable .note.Linux section is loaded at address 0,
which in turn causes NULL pointers to be resolved to bogus symbols.  So
keep using the white list approach for the time being.

Link: http://lkml.kernel.org/r/20191028152734.13065-1-iii@linux.ibm.com
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 627750cb420d0..9b71c65504a38 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -99,7 +99,8 @@ lx-symbols command."""
             attrs[n]['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
         args = []
-        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss"]:
+        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
+                             ".text", ".text.hot", ".text.unlikely"]:
             address = section_name_to_address.get(section_name)
             if address:
                 args.append(" -s {name} {addr}".format(
-- 
2.20.1



