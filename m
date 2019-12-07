Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8EC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA142173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQQvBIpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLGHRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:17:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfLGHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:17:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so9567549wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oa74tX0rrToiDTjsb0l5w1iPUstS1fPMTJqaqMvhiuQ=;
        b=SQQvBIpX68h8tU+m7gVvNlf1h/MEoIiZEC4Vghaj1EOyHJKD7K6VWydfZ6qqdfs190
         4VAAOB/X+9PQDfa1TMS48/zG9Dvus5dy86jdOCRzLeRHT2IeLV6Zgcj+aJf1lwKjT43d
         J3UwcgD0TND2dOnV3h3gzPUPtZmZ2rGm0NQXLFnJZQMSszPzl31tg5f/YohnUzwLBgk3
         vNF3moOGD7Funui40j6eRu7HG16Rgr4Ro5B+luatZzpb0hAO+2ylEbV+DeDXUKCX4BOc
         jg0cAKoA/f3QbbLUzqH1/wCObFKidPQsRDMt+DP83GB34oftgass2jykNKf2jLSRGtr8
         gKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oa74tX0rrToiDTjsb0l5w1iPUstS1fPMTJqaqMvhiuQ=;
        b=cmW6iHqSK9EkDUruK8EmmW2iBbW3sC9TYfhHRu7LO5ueC7VkQRMNQ3EMzAblGftmMK
         zxGLVab6fekNKcL6errQ9H0tyF0j8h6mE2ClYaOAmZjeVkdbXaVhM4un4f/Tyz6WWPok
         8bYFvBN7qWBgx/HPNsZC0Cao5aZXfmumsF70Oh6PKkdBgH/YgQABb7fwKNyVsd0c4Lu4
         oZ7MnFp+S3e2TLI4Z4EQnf/bYuX2HiIDnSsZ1m4MhYfVtlAD/O0WYlvoGalnyWXnLShB
         PedeamQoV9AVNQqvou1oQYRHVERzLYTFJvdtbu8dHOwE18UUFyxSvc0WYz+uD/3cdwdB
         X60Q==
X-Gm-Message-State: APjAAAWJ5C/QAerxLsMgh2urAHfNuUHLE/6WP4Nnik6iHuYicrDfnhK6
        ob7kk/9wklhyuah6zztRwK4=
X-Google-Smtp-Source: APXvYqyQvteTIQ3cPD+8RNWe/5PdLo4Q/p8Mmqfp/1+YN8Fhy26mEqQfeHbsnedoqE1nJCNCzIrdZw==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr14417227wma.143.1575703071843;
        Fri, 06 Dec 2019 23:17:51 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f1sm19114557wrp.93.2019.12.06.23.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 23:17:51 -0800 (PST)
Date:   Sat, 7 Dec 2019 07:17:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, kbuild-all@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de
Subject: Re: [Patch v2 5/6] x86/mm: Use address directly in split_mem_range()
Message-ID: <20191207071750.5wxy2o5ozqxwpbix@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191205021403.25606-6-richardw.yang@linux.intel.com>
 <201912071155.JJoAya4K%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912071155.JJoAya4K%lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 11:36:10AM +0800, kbuild test robot wrote:
>Hi Wei,
>
>Thank you for the patch! Yet something to improve:
>
>[auto build test ERROR on tip/x86/mm]
>[also build test ERROR on tip/auto-latest linus/master v5.4 next-20191206]
>[if your patch is applied to the wrong git tree, please drop us a note to help
>improve the system. BTW, we also suggest to use '--base' option to specify the
>base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
>url:    https://github.com/0day-ci/linux/commits/Wei-Yang/x86-mm-Remove-second-argument-of-split_mem_range/20191207-061345
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 7f264dab5b60343358e788d4c939c166c22ea4a2
>config: i386-tinyconfig (attached as .config)
>compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
>reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=i386 
>
>If you fix the issue, kindly add following tag
>Reported-by: kbuild test robot <lkp@intel.com>
>
>Note: the linux-review/Wei-Yang/x86-mm-Remove-second-argument-of-split_mem_range/20191207-061345 HEAD 7f535395f79354bfa29cca182dd203525bcb4237 builds fine.
>      It only hurts bisectibility.
>
>All errors (new ones prefixed by >>):
>
>   arch/x86/mm/init.c: In function 'save_mr':
>>> arch/x86/mm/init.c:265:6: error: 'start_pfn' undeclared (first use in this function); did you mean 'start'?
>     if (start_pfn < end_pfn) {
>         ^~~~~~~~~
>         start
>   arch/x86/mm/init.c:265:6: note: each undeclared identifier is reported only once for each function it appears in
>>> arch/x86/mm/init.c:265:18: error: 'end_pfn' undeclared (first use in this function); did you mean 'pgd_pfn'?
>     if (start_pfn < end_pfn) {
>                     ^~~~~~~
>                     pgd_pfn
>

Oops, introduced an error after resolving a conflict. Should be start and end.

Will correct it in next version.


-- 
Wei Yang
Help you, Help me
