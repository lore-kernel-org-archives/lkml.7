Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC421C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E229206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfD0PPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33010 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbfD0PPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:20 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2s-00014C-3I; Sat, 27 Apr 2019 16:15:18 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004fN-C3; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "John Johansen" <john.johansen@canonical.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.763289498@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 201/202] apparmor: provide userspace flag indicating
 binfmt_elf_mmap change
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 34c426acb75cc21bdf84685e106db0c1a3565057 upstream.

Commit 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
changed when the creds are installed by the binfmt_elf handler. This
affects which creds are used to mmap the executable into the address
space. Which can have an affect on apparmor policy.

Add a flag to apparmor at
/sys/kernel/security/apparmor/features/domain/fix_binfmt_elf_mmap

to make it possible to detect this semantic change so that the userspace
tools and the regression test suite can correctly deal with the change.

BugLink: http://bugs.launchpad.net/bugs/1630069
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/apparmor/apparmorfs.c | 1 +
 1 file changed, 1 insertion(+)

--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -794,6 +794,7 @@ static struct aa_fs_entry aa_fs_entry_do
 	AA_FS_FILE_BOOLEAN("change_hatv",	1),
 	AA_FS_FILE_BOOLEAN("change_onexec",	1),
 	AA_FS_FILE_BOOLEAN("change_profile",	1),
+	AA_FS_FILE_BOOLEAN("fix_binfmt_elf_mmap",	1),
 	{ }
 };
 

