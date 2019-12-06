Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152BC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B2824679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575619028;
	bh=Vo/Nyoj6NYsP3WDzflA7vAE83GEcxJjOqXtGgl4Mqnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N60nR0F2+P9+rfGgnbPGslt0roGLtEoQ3L/poFnXnJjpNz2BUXK557MJuvpBIxKYs
	 97ONXn4rqW5eP61CMK3+KTPVfYHjGufshiW2FhlbYikFo0g54N7Xm3EG/9byzUQ1F3
	 SDr9OlnSQBc3xUOc1ggPNM6ZP7qMhD+j9kR1I3/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLFH5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:57:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLFH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:57:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so6725903wrq.0;
        Thu, 05 Dec 2019 23:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mobGWCFRoNiMon+fqSNJqSuTbmxm/A3xC/X3cT3Seb0=;
        b=LWUlNxSbHCzFXZLB8agEx6kq0Lr+L7BO6q5U8JrQt8DGMW1GheHVeyiciK3Oo5mfew
         cE6mQsirmIsKrXEjM1LhrF78ExZM3SpFMCg0cdHzysMvtrymKfElUG62ZYDyTfWAE4IW
         EcSVpaMIU+refwdI7zDE9XPEAObqdNo0+riBPyR+Qtq/SCKiygeu0YNOGamyWFYsbwaN
         Mej8h6CoiGOtDTk4BlExMjAeL9mm3+fRjEr9zr1zM0WOmgvVM/MblyrEU041HJzZKUDb
         8TOzX+PgrIKZW7eVnGJq6bCp6xeekwX1D9z40LhWlDCFWIxoseLBhKwo6TzAWfYtXjZL
         1rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mobGWCFRoNiMon+fqSNJqSuTbmxm/A3xC/X3cT3Seb0=;
        b=NBiNlh9v/Si3hKi5FqlP8topsdN3j/El4liBO71bF0Gg3Hc45L0iDgWq6zbHesSk9Z
         eMNeQ+8oRAMw5NpS832MV/VoDOJycy+wOGKpILy+RhPmBAMFgZIRxgxETOgzlu04hEcL
         2tIj37UnddueIrufbHXO6PVOrLcUlbrgtHSBoOJtO9m5sW+RBO4xw4cHLbgBV1eKeC39
         GxuY8nWHWB4qJQyZ5kH3wAYK+g4O87oz8DTetANYmhLqUk9CT5svKZi0U3e9AF4Wor8G
         dSkHP/K2AdMtF39ioMoYClnHSzbHRs7pfvBmAT+y4F3dG7osraC6QN4Bp3ZrBHAh2d46
         thpQ==
X-Gm-Message-State: APjAAAVmGvYnHebwhknmxv8QxD+DvW05rgbivKjzo/m37DiCH22IwDsk
        1NXPI08SrgXgHal6jZaTOF4=
X-Google-Smtp-Source: APXvYqx6b0WeQZToKrHXjPkM2js0Cqt7opPY63PI72cwR+1CgkgVYeQD5s8RRWLAFRS138zztkcnGg==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr13856031wrv.197.1575619024663;
        Thu, 05 Dec 2019 23:57:04 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e18sm14893868wrr.95.2019.12.05.23.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:57:03 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:57:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Message-ID: <20191206075701.GA25384@gmail.com>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9f58c93efdffc2cba91fdcee010b3e5e8860334d:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191203' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-12-04 08:49:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191205
> 
> for you to fetch changes up to fd9bee5e24141d00e23b66d1b51bc759efa7e3fe:
> 
>   tools headers UAPI: Update tools's copy of drm.h headers (2019-12-04 16:22:38 -0300)
> 
> ----------------------------------------------------------------
> perf inject:
> 
>   Adrian Hunter:
> 
>   - Fix processing of ID index for injected instruction tracing
> 
> perf report:
> 
>   Ravi Bangoria:
> 
>   - Replace pr_err() with ui__error(), so that we can see the output
>     in the TUI mode instead of showing and immediately restoring the
>     screen to the state before perf was started.
> 
>   - Don't start --mem-mode/--branch-mode mode if required samples are not
>     available.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync drm/i915_drm.h with the kernel sources
> 
>   - Update tools's copy of drm.h headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf inject: Fix processing of ID index for injected instruction tracing
> 
> Arnaldo Carvalho de Melo (2):
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers UAPI: Update tools's copy of drm.h headers
> 
> Ravi Bangoria (3):
>       perf report/top TUI: Replace pr_err() with ui__error()
>       perf report: Make -F more strict like -s
>       perf report: Bail out --mem-mode if mem info is not available
> 
>  tools/include/uapi/drm/drm.h      |   3 +-
>  tools/include/uapi/drm/i915_drm.h | 128 +++++++++++++++++++++++++++++++++++++-
>  tools/perf/builtin-inject.c       |  13 +---
>  tools/perf/builtin-report.c       |   8 +++
>  tools/perf/util/sort.c            |  16 +++--
>  5 files changed, 147 insertions(+), 21 deletions(-)

Pulled, thanks a lot Arnaldo!

JFYI, on my system the default perf/urgent build still has this noise 
generated by util/parse-events.y and util/expr.y:

  util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
      1 | %pure-parser
      | ^~~~~~~~~~~~
  util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
  util/expr.y:15.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
     15 | %pure-parser
      | ^~~~~~~~~~~~
  util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]


Thanks,

	Ingo
