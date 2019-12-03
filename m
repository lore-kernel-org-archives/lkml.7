Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE55AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3232073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412945;
	bh=BDl6YZmSUM/C4B00ELQHtINL4MQScqoiNf6XwU2P6C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oT7G9mqCXxaYZPj35qxsu9+QDDGAJayOTthFS2mThLRNyhgi0ew1hj6rX9fmZM3ol
	 zkK+1s60EMaMEwAJDNnCK7HHCjkxHjOxvzQKvDpyBVNEpjk/SSX8bnFfMhi5YLtLky
	 H6KeNklwqfzWU8eGrg7s4BhZClFnoZzbCxsIlfF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfLCWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfLCWmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020142073C;
        Tue,  3 Dec 2019 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412941;
        bh=BDl6YZmSUM/C4B00ELQHtINL4MQScqoiNf6XwU2P6C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwuGd97ys1VwGqVr3lTOBGW565GlAc3QuBFjoyu5Q+ujWY5/b6REt8b+t8+echvjR
         +rIZ3hYo75e6Rq0rcBSGn0/vD9VK2CKaslLndQt5TTqEc7X2C3Lawhnq0IeNB0tNfd
         5yxA1mMkpqCldjCjtyJP/eelXh9nEtWz0J7+fX94=
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
Subject: [PATCH 5.3 074/135] scripts/gdb: fix debugging modules compiled with hot/cold partitioning
Date:   Tue,  3 Dec 2019 23:35:14 +0100
Message-Id: <20191203213027.555358164@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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
index 2f5b95f09fa03..3c29504302896 100644
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



