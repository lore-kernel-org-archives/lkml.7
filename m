Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF2C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DBD208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zwTEHm5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfGQXKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:10:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:10:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HNA6Yr1726938
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:10:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HNA6Yr1726938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563405007;
        bh=LdxDXB6uOFDcle6akxx0Feexmge1pyrkIlkwXAuXREQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zwTEHm5cRum26o13ulEghihSpzK/oD8wZ3XGIYDLZB7syL2xM/4hK1jD0g2MHMsNc
         B+b989sS8f2fBie5UQnE1DlbPlQF//T0Wy5L/cvvUOfchCaUDe9LwKK3uXT8CqatPy
         Nvm9BHQPDArK2XlElkD8a+zLtXEKJwmu36xEmu9299qzdvHI2aBzmDsIRtg0iGd+hI
         0hdJHO0vodeisZ2q2GqtAl53Tk3FBphuMhWT83bwIo9/ZzuNhGD+dj1oJ3h/AtDxPB
         zPRG+fOIhepGdS13fXVghL0huoc3dzAofBPVKUqiYjANzr1SsRgacEgqLXnl3dEr7G
         PpkjSohY2XBqg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HNA6BO1726934;
        Wed, 17 Jul 2019 16:10:06 -0700
Date:   Wed, 17 Jul 2019 16:10:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Forney <tipbot@zytor.com>
Message-ID: <tip-3c3ea5031761fdd144b461d23a077c3a0cf427fa@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, mforney@mforney.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: jpoimboe@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mforney@mforney.org, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <d270e1be2835fc2a10acf67535ff2ebd2145bf43.1562793448.git.jpoimboe@redhat.com>
References: <d270e1be2835fc2a10acf67535ff2ebd2145bf43.1562793448.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Use Elf_Scn typedef instead of assuming
 struct name
Git-Commit-ID: 3c3ea5031761fdd144b461d23a077c3a0cf427fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3c3ea5031761fdd144b461d23a077c3a0cf427fa
Gitweb:     https://git.kernel.org/tip/3c3ea5031761fdd144b461d23a077c3a0cf427fa
Author:     Michael Forney <mforney@mforney.org>
AuthorDate: Wed, 10 Jul 2019 16:17:35 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 00:50:14 +0200

objtool: Use Elf_Scn typedef instead of assuming struct name

The libelf implementation might use a different struct name, and the
Elf_Scn typedef is already used throughout the rest of objtool.

Signed-off-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/d270e1be2835fc2a10acf67535ff2ebd2145bf43.1562793448.git.jpoimboe@redhat.com

---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..76e4f7ceab82 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -463,7 +463,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
-	struct Elf_Scn *s;
+	Elf_Scn *s;
 	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
