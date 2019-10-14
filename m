Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0848DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14912133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSoVeTWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfJNQ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:28:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53532 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfJNQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:28:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so17932108wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rR4HHt9sUcCAtG9vjl4zLc6ifKuatlbyyZBo1ocXxP8=;
        b=GSoVeTWOXMaWnHP1MS2tl1J4MneC+RHaKf1ZXRIFJFBAu/PSKG6LKdD4T46Iuerd9s
         qfAG9Fp7et6D7dU+Web0FQJam1ass/TdkYGu44TJ7GgF08BL5BIgrdoW/0nKy2pGobkE
         a9xSKETW18UFUoG/Pzl7DWF+WD1VS+K75LnUSnnlR1ybDlO5ZGSKiyqwSRa8uROAXUfV
         XPumTgp0sjcocgmB/dISROI52ps6sMYj9iT6OTWJUGtDOrGTyVGKvjIWKOu8weQTwNre
         4hGFwLjxSrKTOYWD0JEzIElPaLJxLdt7nGHRPeJR0DiiS0KN5G7qnGFIif1lywQbHc/y
         dBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rR4HHt9sUcCAtG9vjl4zLc6ifKuatlbyyZBo1ocXxP8=;
        b=iV2Z/gACzQHLKQLhWSHluwvny4sHIcTvbl1hWLjnmoOzWlvLebNPA3P+IZbivAiVlE
         fCVVVMwoseZeFRXMLG5jivDJcGM5ciuxFJuHz8OzMW0aZFtbfpOm/7azy/SDIOPEjEJ0
         NgGl7ju/VTmBDVMXVF9j7pqsc4V9cmHgvNu4JGdG8DoRbn1jmwagvmGd/WZnILFRvdx3
         qIeU39b+OB6agpUfH9k1GlIb+mEZ6K9/mpxJ2EGg11M6lMb6U5652C1FoK1HgrEkWicr
         0AmQvCMlMHvXhHBvV38gQd2hooAOUSW0/gusWx2eT0pevK2Eu5YYLgXqroAVAGSFadz0
         5Uqg==
X-Gm-Message-State: APjAAAW2+0tcu7dZxtYYMeAMZLW0068NJdmm9wkJ9TnLBsq10IQ13pcy
        7bMRVW9WLaZNg1Q7EQAjsuOTnKOiCyqIlg==
X-Google-Smtp-Source: APXvYqwyqujMWffkPiPAQfBJGd2YLo5bKm8byYy+9RVKQ7jWMRFKN/SVhY6dr7Zj0uk2exqQPnaY7g==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr15077392wmh.56.1571070530048;
        Mon, 14 Oct 2019 09:28:50 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h18sm7073619wrr.78.2019.10.14.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:28:49 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:28:47 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [danielt-linux:kgdb/for-next 4/4]
 kernel/debug/debug_core.c:452:17: warning: array subscript is outside array
 bounds
Message-ID: <20191014162847.kshvdwcahyjbtweo@holly.lan>
References: <201910110030.gUpQOCmR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910110030.gUpQOCmR%lkp@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug

On Fri, Oct 11, 2019 at 12:41:31AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git kgdb/for-next
> head:   2277b492582d5525244519f60da6f9daea5ef41a
> commit: 2277b492582d5525244519f60da6f9daea5ef41a [4/4] kdb: Fix stack crawling on 'running' CPUs that aren't the master
> config: sh-allyesconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2277b492582d5525244519f60da6f9daea5ef41a
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/debug/debug_core.c: In function 'kdb_dump_stack_on_cpu':
> >> kernel/debug/debug_core.c:452:17: warning: array subscript is outside array bounds [-Warray-bounds]
>      if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
>            ~~~~~~~~~^~~~~
>    kernel/debug/debug_core.c:469:33: warning: array subscript is outside array bounds [-Warray-bounds]
>      kgdb_info[cpu].exception_state |= DCPU_WANT_BT;
>    kernel/debug/debug_core.c:470:18: warning: array subscript is outside array bounds [-Warray-bounds]
>      while (kgdb_info[cpu].exception_state & DCPU_WANT_BT)
>             ~~~~~~~~~^~~~~

Thoughts on the following?

From 9e0114bc9ae504c3a7e837c977d64f84b2010d8e Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 11 Oct 2019 08:49:29 +0100
Subject: [PATCH] kdb: Avoid array subscript warnings on non-SMP builds

Recent versions of gcc (reported on gcc-7.4) issue array subscript
warnings for builds where SMP is not enabled.

There is no bug here but there is scope to improve the code
generation for non-SMP systems (whilst also silencing the warning).

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs that aren't the master")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 70e86b4b4932..eccb7298a0b5 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -449,7 +449,8 @@ void kdb_dump_stack_on_cpu(int cpu)
 		return;
 	}
 
-	if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    !(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
 		kdb_printf("ERROR: Task on cpu %d didn't stop in the debugger\n",
 			   cpu);
 		return;
-- 
2.21.0

