Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E500620732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnklFHyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKOWUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:20:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKOWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:20:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so6611651pgt.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVyJpir/VLUEMttgrpMJ1qWScwdPhvyUGo9A2jE2/Wc=;
        b=TnklFHyJy57V8i737k8NzApU3WrqLAzuuyE/BBO1+iLl6KxeQJxRlh8bdXfZOAuFWj
         DoFbUH5nqWpRYj2/qbxGZH6gEd0SSaANDwjGcTDdhHs2OuZH4pTDVjT5cFtYVIWecA36
         A05bGbZEE1cS9CVojaweW0HVIO3T5RmzdaKk82fhB94NV0rHI8DzBfXfgJcxWUyeUFaZ
         aMSBCqyMcb+wcIzgYRHgN+7Upsd9XdKs7CaY2lKttrgsAQJ2C2Nx+i8sfdpoAc3AScgw
         ERZQo41dg3HFXbDlGTfdW3WSGIUQ2Y9HVEIiVouBAzOWvE4fvhkSPVinARcuYkRCrNEm
         +LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVyJpir/VLUEMttgrpMJ1qWScwdPhvyUGo9A2jE2/Wc=;
        b=lMS3NcLkBFg+qT2wpE6zsTCsKnzXSQWqdOlyWq4VJrjeIUpLw60ZDqpRLLBw0iiniQ
         x0StG9YoCFzFxZwA+oT++xhRmojO7z3uKwbAFBk2Ai3bzSuhLJfi1BafqZFAjOKsdTiG
         vY8L9CJHR7ts2I62WBXdu2CoWEBm/3t9U/CxY0XpnwLHI5gw1v7reSegu03Owmi1oUNC
         S3p2djfn5kEWkFBc5dFciex7tEKjq2pe0P7jDBpLj5mDHo7tiksiy3aK670oND/I2si+
         h1f9eYIrF5GkGCCg3vxBjdgZTfpIMl3ITK1yL955SglrOu2XXxsv22ANhpeojs7nTTCh
         YKmw==
X-Gm-Message-State: APjAAAV/ipCX+zHnLbKzS7rzxxvuhdYI4DEMC8TeAHwMW/oRP5pbhHdT
        Coo4mMJtpdvm3M3kKJCZoY4=
X-Google-Smtp-Source: APXvYqxVt4yLpVtaJ5pbNfQu1NgR4qweZy35wJOhlufYbmdeiM2bd32R4l9pk0KjpMbyCwf/YFlz3g==
X-Received: by 2002:a63:535c:: with SMTP id t28mr6117263pgl.173.1573856421040;
        Fri, 15 Nov 2019 14:20:21 -0800 (PST)
Received: from gmail.com ([2620:0:1009:fd00:e14f:8808:551a:63ec])
        by smtp.gmail.com with ESMTPSA id r203sm9582595pfr.184.2019.11.15.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:20:20 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:20:18 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191115222018.GB353836@gmail.com>
References: <20191115123621.142252-1-areber@redhat.com>
 <20191115123621.142252-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20191115123621.142252-2-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Fri, Nov 15, 2019 at 01:36:21PM +0100, Adrian Reber wrote:
> This tests clone3() with *set_tid to see if all desired PIDs are working
> as expected. The tests are trying multiple invalid input parameters as
> well as creating processes while specifying a certain PID in multiple
> PID namespaces at the same time.
> 
> Additionally this moves common clone3() test code into clone3_selftests.h.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
> v9:
>  - applied all changes from Christian's review (except using the
>    NSpid: parsing code from selftests/pidfd/pidfd_fdinfo_test.c)
> 
> v10:
>  - added even more '\n' and include file fixes (Christian)
> 
> v11:
>  - added more return code checking at multiple places (Andrei)
>  - also add set_tid/set_tid_size to internal struct (Andrei)

I think we can add a test case to trigger the issue what I found in the
previous version of the kernel patch. You can find my version of this
test case in the attached patch.

nit: we need to flush stdout and stderr buffers before calling the raw
clone3 syscall and _exit(). Otherwise, some log messages can be lost and
some of them can be printed twice.

To trigger this issue, you can run the test and redirect its output to
file or pipe:

$ ./clone3_set_tid | cat

I have attached the patch to address both these problems. It is a draft
version and may require some work.

Adrian and Christian, it is up to you to decide whether we want to
update the current patch or to fix this on top by a separate patch.

Thanks,
Andrei


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=patch

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index cf976c732906..a7c7d8d15e1c 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -Wall -g -I../../../../usr/include/
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 3480e1c46983..ab1df5ce201f 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -30,6 +30,12 @@
 static int pipe_1[2];
 static int pipe_2[2];
 
+static void flush()
+{
+	fflush(stdout);
+	fflush(stderr);
+}
+
 static int call_clone3_set_tid(pid_t *set_tid,
 			       size_t set_tid_size,
 			       int flags,
@@ -46,6 +52,7 @@ static int call_clone3_set_tid(pid_t *set_tid,
 		.set_tid_size = set_tid_size,
 	};
 
+	flush();
 	pid = sys_clone3(&args, sizeof(struct clone_args));
 	if (pid < 0) {
 		ksft_print_msg("%s - Failed to create new process\n",
@@ -83,6 +90,7 @@ static int call_clone3_set_tid(pid_t *set_tid,
 			close(pipe_2[0]);
 		}
 
+		flush();
 		if (set_tid[0] != getpid())
 			_exit(EXIT_FAILURE);
 		_exit(exit_code);
@@ -153,7 +161,7 @@ int main(int argc, char *argv[])
 		ksft_exit_fail_msg("pipe() failed\n");
 
 	ksft_print_header();
-	ksft_set_plan(27);
+	ksft_set_plan(29);
 
 	f = fopen("/proc/sys/kernel/pid_max", "r");
 	if (f == NULL)
@@ -249,6 +257,7 @@ int main(int argc, char *argv[])
 	pid = fork();
 	if (pid == 0) {
 		ksft_print_msg("Child has PID %d\n", getpid());
+		flush();
 		_exit(EXIT_SUCCESS);
 	}
 	if (waitpid(pid, &status, 0) < 0)
@@ -283,6 +292,19 @@ int main(int argc, char *argv[])
 	/* Let's create a PID 1 */
 	ns_pid = fork();
 	if (ns_pid == 0) {
+		set_tid[0] = 43;
+		set_tid[1] = -1;
+		/*
+		 * This should fail as there are not enough active PID
+		 * namespaces. Again assuming this is running in the host's
+		 * PID namespace. Not yet nested.
+		 */
+		test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+
+		set_tid[0] = 43;
+		set_tid[1] = pid;
+		test_clone3_set_tid(set_tid, 2, 0, 0, 43, 0);
+
 		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
 		set_tid[0] = 2;
 		test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
@@ -309,6 +331,8 @@ int main(int argc, char *argv[])
 		 */
 		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
 
+
+		flush();
 		_exit(ksft_cnt.ksft_pass);
 	}
 

--17pEHd4RhPHOinZp--
