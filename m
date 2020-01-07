Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C920C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6BD2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgAGXmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgAGXmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:42:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805142075A;
        Tue,  7 Jan 2020 23:42:54 +0000 (UTC)
Date:   Tue, 7 Jan 2020 18:42:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/ftrace: fix glob selftest
Message-ID: <20200107184253.2f97cf3f@gandalf.local.home>
In-Reply-To: <20200107094047.87758-1-svens@linux.ibm.com>
References: <20200107094047.87758-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 10:40:47 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> test.d/ftrace/func-filter-glob.tc is failing on s390 because it has
> ARCH_INLINE_SPIN_LOCK and friends set to 'y'. So the usual
> __raw_spin_lock symbol isn't in the ftrace function list. Change
> '*aw*lock' to '*spin*lock' which would hopefully match some of the
> locking functions on all platforms.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  .../testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> index 27a54a17da65..cf296a3dd723 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> @@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
>  ftrace_filter_check 'schedule*' '^schedule.*$'
>  
>  # filter by *mid*end
> -ftrace_filter_check '*aw*lock' '.*aw.*lock$'
> +ftrace_filter_check '*spin*lock' '.*spin.*lock$'

Just to make it not check the beginning, can you remove the 's':

  '*pin*lock' '.*pin.*lock$'

Thanks!

-- Steve

>  
>  # filter by start*mid*
>  ftrace_filter_check 'mutex*try*' '^mutex.*try.*'

