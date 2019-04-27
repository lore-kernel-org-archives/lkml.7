Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F0F208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfD0P2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:28:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33078 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfD0PPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:21 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2s-00014H-DM; Sat, 27 Apr 2019 16:15:18 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004fH-Am; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Willy Tarreau" <w@1wt.eu>, "Oleg Nesterov" <oleg@redhat.com>,
        "Robert =?UTF-8?Q?=C5=9Awi=C4=99cki?=" <robert@swiecki.net>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Kees Cook" <keescook@chromium.org>,
        "David Howells" <dhowells@redhat.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.761854587@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 200/202] binfmt_elf: switch to new creds when
 switching to new mm
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 9f834ec18defc369d73ccf9e87a2790bfa05bf46 upstream.

We used to delay switching to the new credentials until after we had
mapped the executable (and possible elf interpreter).  That was kind of
odd to begin with, since the new executable will actually then _run_
with the new creds, but whatever.

The bigger problem was that we also want to make sure that we turn off
prof events and tracing before we start mapping the new executable
state.  So while this is a cleanup, it's also a fix for a possible
information leak.

Reported-by: Robert Święcki <robert@swiecki.net>
Tested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: David Howells <dhowells@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andy Lutomirski <luto@amacapital.net>
Acked-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -736,6 +736,7 @@ static int load_elf_binary(struct linux_
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
@@ -951,7 +952,6 @@ static int load_elf_binary(struct linux_
 	}
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	install_exec_creds(bprm);
 	retval = create_elf_tables(bprm, &loc->elf_ex,
 			  load_addr, interp_load_addr);
 	if (retval < 0) {

