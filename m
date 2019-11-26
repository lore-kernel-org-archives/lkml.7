Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1763C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B5E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfKZR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfKZR6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:58:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82C32073F;
        Tue, 26 Nov 2019 17:49:02 +0000 (UTC)
Date:   Tue, 26 Nov 2019 12:49:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v4 2/4] selftests/ftrace: Fix ftrace test cases
 to check unsupported
Message-ID: <20191126124901.22ae2f9f@gandalf.local.home>
In-Reply-To: <157475726452.3389.3778488615487716476.stgit@devnote2>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
        <157475726452.3389.3778488615487716476.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 17:34:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> @@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
>    exit_unresolved
>  fi
>  
> +if ! grep -q function available_tracers ; then
> +  echo "Function trace is not enabled"
> +  exit_unsupported
> +fi
> +
>  ORIG_CPUMASK=`cat tracing_cpumask`

Strange, but the bashism test failed:

++ checkbashisms /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
possible bashism in /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc line 18 ('function' is useless):
if ! grep -q function available_tracers ; then

Not sure why it did not like that line. Maybe my bashism check got
confused by the key word "function"?

Yep!

By adding quotes around "function" it doesn't complain:

	if ! grep -q "function" available_tracers ; then

May need to add that.

-- Steve
