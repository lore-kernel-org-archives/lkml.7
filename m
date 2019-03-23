Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E35218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553336872;
	bh=dw66iRYdx/1o/GQmWdl8qu3PmTegurNTy9BUzh5ugQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vW9RJSF6wrlH2rRu3dRKdwTFD5k8zX4Pk2Dj/0m/CXFB9flEWOxHRjtL9SQVnQlrG
	 MDkorWVt0LqxnT8Vy1XRsvZFcbNkyf10AlV2mPa1lsVIcP17gu7ziokKt1f3LlIiue
	 VPnRSZdPjFYEdOCKYlf4WN7ErjEmNzcyJZ3rYoq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCWK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfCWK1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:27:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BEB20883;
        Sat, 23 Mar 2019 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553336870;
        bh=dw66iRYdx/1o/GQmWdl8qu3PmTegurNTy9BUzh5ugQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L5TW4LQfOQV920GMeVJnJHlkJh0TEUxvXr/hJKL36rApUUDN2Pn+Vdx4cKaSa2irM
         SwnqFdz3G7dVKh/gekon2m4XGNNoPa2/uJwVPvzVulr3c1sWQ5CaPrJn88tyutn4t9
         1Qhk29+UKC0ND9+IMAl/beq4CRcKGcduimHk/zqU=
Date:   Sat, 23 Mar 2019 19:27:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH selftests 0/2] Add checkbashisms meta-testcase
Message-Id: <20190323192746.59739e5e9ea0445791ac14ed@kernel.org>
In-Reply-To: <155079878723.5157.12433171255092403676.stgit@devbox>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Could you pick this to your tree? I think this can prevent further
simillar errors before release...

Thank you,

On Fri, 22 Feb 2019 10:26:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are patches for making sure the ftracetest testcases
> are checkbashisms clean.
> 
> This actually needs a patch from Juerg, "selftests/ftrace:
> Make the coloring POSIX compliant" to complete the work.
> 
> http://lkml.kernel.org/r/20190220161333.28109-1-juergh@canonical.com
> (Note that this is still under development)
> 
> So as Juerg pointed, recently ftracetest becomes not POSIX
> compliant, and such kind of issues happened repeatedly.
> To avoid those anymore, I decided to introduce a testcase
> which runs checkbasisms on ftracetest and its testcases.
> I think this can help us to find out whether it was
> written in a way out of POSIX.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       selftests/ftrace: Make a script checkbashisms clean
>       selftests/ftrace: Add checkbashisms meta-testcase
> 
> 
>  tools/testing/selftests/ftrace/ftracetest          |    1 +
>  .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    2 +-
>  .../selftests/ftrace/test.d/selftest/bashisms.tc   |   21 ++++++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
