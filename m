Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6518C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE6C21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125958;
	bh=285a+tERQb5YRXqzYZvzP/tCeJxzfWWh1r5SL2aWDQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UClbrWEZlxIttQuV7+4fcTN8xykLhq12//2sYvudwuop3a3YBaQYW1pEpfclZeHCd
	 HLGy8yPR12ElqpL8hFk81kARqFuKJfoMeLS6Iy6NoeKSHY+Y8alt9+vgj8WjUtthgG
	 ep8PZJiRfytnM3cpZNl1xq6FRuortlU/UdN8l4uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfDXRMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387664AbfDXRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:34 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B0B218FE;
        Wed, 24 Apr 2019 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125953;
        bh=285a+tERQb5YRXqzYZvzP/tCeJxzfWWh1r5SL2aWDQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdRWa2gsDnK/a1HEG0wowMxlBmTnUWALZCBCrnxftJ8N5SzwGUqCIUskjc5XQxdjb
         YHfVrnDrjk0YYAY8cckepP1PeeK45Sc7eTitbS7keN1qnKlKVWIlgzZway9kc/J9Lu
         KIxTZ7DcYNO7S3k/Pn6+BAvZqFdeUDYW5zLyD9H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Federico Manuel Bento <up201407890@fc.up.pt>
Subject: [PATCH 3.18 042/104] binfmt_elf: switch to new creds when switching to new mm
Date:   Wed, 24 Apr 2019 19:08:59 +0200
Message-Id: <20190424170859.734250816@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Federico Manuel Bento <up201407890@fc.up.pt>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -734,6 +734,7 @@ static int load_elf_binary(struct linux_
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
@@ -935,7 +936,6 @@ static int load_elf_binary(struct linux_
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	install_exec_creds(bprm);
 	retval = create_elf_tables(bprm, &loc->elf_ex,
 			  load_addr, interp_load_addr);
 	if (retval < 0)


