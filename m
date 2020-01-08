Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF20C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3E20643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAHOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgAHOL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:11:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A625B20643;
        Wed,  8 Jan 2020 14:11:56 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:11:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] selftests/ftrace: fix glob selftest
Message-ID: <20200108091155.4af8a2c5@gandalf.local.home>
In-Reply-To: <20200108074043.21580-1-svens@linux.ibm.com>
References: <20200108074043.21580-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shuah,

Want to take this through your tree?

 https://lore.kernel.org/r/20200108074043.21580-1-svens@linux.ibm.com

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

-- Steve


On Wed,  8 Jan 2020 08:40:43 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> test.d/ftrace/func-filter-glob.tc is failing on s390 because it has
> ARCH_INLINE_SPIN_LOCK and friends set to 'y'. So the usual
> __raw_spin_lock symbol isn't in the ftrace function list. Change
> '*aw*lock' to '*spin*lock' which would hopefully match some of the
> locking functions on all platforms.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
> 
> Changes in v3:
>   change '*spin*lock' to '*pin*lock' to not match the beginning
> 
> Changes in v2:
>   use '*spin*lock' instead of '*ktime*ns'
> 
>  .../testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> index 27a54a17da65..f4e92afab14b 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> @@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
>  ftrace_filter_check 'schedule*' '^schedule.*$'
>  
>  # filter by *mid*end
> -ftrace_filter_check '*aw*lock' '.*aw.*lock$'
> +ftrace_filter_check '*pin*lock' '.*pin.*lock$'
>  
>  # filter by start*mid*
>  ftrace_filter_check 'mutex*try*' '^mutex.*try.*'

