Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB48C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD820855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKRHmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:42:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfKRHmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:42:42 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iWbg8-0004wZ-Kx; Mon, 18 Nov 2019 07:42:32 +0000
Date:   Mon, 18 Nov 2019 08:42:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191118074231.fvczfgrbinzgajqg@wittgenstein>
References: <20191115123621.142252-1-areber@redhat.com>
 <20191115123621.142252-2-areber@redhat.com>
 <20191118014642.GC391304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118014642.GC391304@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 05:46:42PM -0800, Andrei Vagin wrote:
> On Fri, Nov 15, 2019 at 01:36:21PM +0100, Adrian Reber wrote:
> > +	if (!WIFEXITED(status))
> > +		ksft_test_result_fail("Child error\n");
> > +
> > +	if (WEXITSTATUS(status))
> > +		/*
> > +		 * Update the number of total tests with the tests from the
> > +		 * child processes.
> > +		 */
> > +		ksft_cnt.ksft_pass = WEXITSTATUS(status);
> 
> I just found that accounting of failed test cases in this test doesn't
> work properly. And if one of the test cases fails in a child process,
> the whole test will have the pass status.
> 
> 
> For example, if we add a fake fail:
> 
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index 3480e1c46..82c99c42f 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -301,7 +301,7 @@ int main(int argc, char *argv[])
>                  * namespaces. Again assuming this is running in the host's
>                  * PID namespace. Not yet nested.
>                  */
> -               test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
> +               test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EPERM, 0, 0);
>  
>                 /*
>                  * This should work and from the parent we should see
> 
> $ make run_tests 
> ....
> # ok 21 [21104] Result (0) matches expectation (0)
> # # unshare PID namespace
> # # [21104] Trying clone3() with CLONE_SET_TID to 21106 and 0x0
> # # Invalid argument - Failed to create new process
> # # [21104] clone3() with CLONE_SET_TID 21106 says :-22 - expected -22
> # ok 22 [21104] Result (-22) matches expectation (-22)
> # # [21104] Child is ready and waiting
> # ok 26 PIDs in all namespaces as expected (21106,42,1)
> # # Planned tests != run tests (27 != 26)
> # # Pass 26 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
> ok 3 selftests: clone3: clone3_set_tid

Thanks for reporting this.
With your patch series you just sent this problem should be addressed.

Thanks!
Christian
