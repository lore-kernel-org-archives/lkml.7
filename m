Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE6C4CEC6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 00:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42EC206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 00:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+UuXrdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfIMAQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 20:16:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46676 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfIMAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 20:16:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so14278241pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 17:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q1y6Q9U/s3PJgAkSELZgsVOZ8hKGLhFOIm9jLTNjE5o=;
        b=P+UuXrdhuRkWR9w0Dl+sK53lcUBFUxWUDMnRtf/f6Ma9ugroBWYn6OEh8qthg3gSLs
         v1DYkLt7JHaDUb3uBL4isX/OVKIe7pjgHp8O3aLIfw+TIiNwcD9SvQ5QevmjoLCdoypl
         727ufk7gG9+DfwV94n9NmIl/8WclBRb5S8fXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q1y6Q9U/s3PJgAkSELZgsVOZ8hKGLhFOIm9jLTNjE5o=;
        b=mvV6kge4KeLzgPo8K3jqDFcYS4P1aJRxPu+aC3DooxmQW9wTJ8EatUCVK0roAhdrsP
         jXkLu+syEc5a0cNsYczVL6jPm3pvBJkR5WD52Rh9+BWHA9RCHRcaGAm4eSd9ySdtL3fi
         gGTA5/3LEAhYBIbreFPkMuFbwFbKx8nNTxieCI+ryYeDl8eA20E2KU/2z5DIjaTMhFRt
         IM7tUrtfhfr8K2/XYUQmaLFsTj6aHzOF1rRChOhL56dBpBMJUbLS/5PYh50hv+tt+Wji
         aqnAA8Ab9vvR7+geZyEEZhYiRwekHZkyLCDdRlBf16uqCy+aJCeIcJobjE4bmxehBh6D
         sMgw==
X-Gm-Message-State: APjAAAVmGei1+13gHqqvv82ilW17fIV4DpIJj8cY7avQ7XrkOTG/fh+r
        +YtreYgy40wsy/SgONXtW71odQ==
X-Google-Smtp-Source: APXvYqyRDAckYNuKy0WOu/temLOTvgcmwYuqT1KVGgqDFpUC9V+2My8WkDpsUge7a5+jKj125BbE1g==
X-Received: by 2002:a17:90a:bf82:: with SMTP id d2mr1611132pjs.121.1568333764417;
        Thu, 12 Sep 2019 17:16:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s97sm413148pjc.4.2019.09.12.17.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 17:16:03 -0700 (PDT)
Date:   Thu, 12 Sep 2019 17:16:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: problem starting /sbin/init (32-bit 5.3-rc8)
Message-ID: <201909121637.B9C39DF@keescook>
References: <a6010953-16f3-efb9-b507-e46973fc9275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6010953-16f3-efb9-b507-e46973fc9275@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 02:40:19PM -0700, Randy Dunlap wrote:
> This is 32-bit kernel, just happens to be running on a 64-bit laptop.
> I added the debug printk in __phys_addr() just before "[cut here]".
> 
> CONFIG_HARDENED_USERCOPY=y

I can reproduce this under CONFIG_DEBUG_VIRTUAL=y, and it goes back
to at least to v5.2. Booting with "hardened_usercopy=off" or without
CONFIG_DEBUG_VIRTUAL makes this go away (since __phys_addr() doesn't
get called):

__check_object_size+0xff/0x1b0:
pfn_to_section_nr at include/linux/mmzone.h:1153
(inlined by) __pfn_to_section at include/linux/mmzone.h:1291
(inlined by) virt_to_head_page at include/linux/mm.h:729
(inlined by) check_heap_object at mm/usercopy.c:230
(inlined by) __check_object_size at mm/usercopy.c:280

Is virt_to_head_page() illegal to use under some recently new conditions?

> The BUG is this line in arch/x86/mm/physaddr.c:
> 		VIRTUAL_BUG_ON((phys_addr >> PAGE_SHIFT) > max_low_pfn);
> It's line 83 in my source file only due to adding <linux/printk.h> and
> a conditional pr_crit() call.
> 
> 
> [   19.730409][    T1] debug: unmapping init [mem 0xdc7bc000-0xdca30fff]
> [   19.734289][    T1] Write protecting kernel text and read-only data: 13888k
> [   19.737675][    T1] rodata_test: all tests were successful
> [   19.740757][    T1] Run /sbin/init as init process
> [   19.792877][    T1] __phys_addr: max_low_pfn=0x36ffe, x=0xff001ff1, phys_addr=0x3f001ff1
> [   19.796561][    T1] ------------[ cut here ]------------
> [   19.797501][    T1] kernel BUG at ../arch/x86/mm/physaddr.c:83!
> [   19.802799][    T1] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [   19.803782][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc8 #6
> [   19.803782][    T1] Hardware name: Dell Inc. Inspiron 1318                   /0C236D, BIOS A04 01/15/2009
> [   19.803782][    T1] EIP: __phys_addr+0xaf/0x100
> [   19.803782][    T1] Code: 85 c0 74 67 89 f7 c1 ef 0c 39 f8 73 2e 56 53 50 68 90 9f 1f dc 68 00 eb 45 dc e8 ec b3 09 00 83 c4 14 3b 3d 30 55 cf dc 76 11 <0f> 0b b8 7c 3b 5c dc e8 45 53 4c 00 90 8d 74 26 00 89 d8 e8 39 cd
> [   19.803782][    T1] EAX: 00000044 EBX: ff001ff1 ECX: 00000000 EDX: db90a471
> [   19.803782][    T1] ESI: 3f001ff1 EDI: 0003f001 EBP: f41ddea0 ESP: f41dde90
> [   19.803782][    T1] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010216
> [   19.803782][    T1] CR0: 80050033 CR2: dc218544 CR3: 1ca39000 CR4: 000406d0
> [   19.803782][    T1] Call Trace:
> [   19.803782][    T1]  __check_object_size+0xaf/0x3c0
> [   19.803782][    T1]  ? __might_sleep+0x80/0xa0
> [   19.803782][    T1]  copy_strings+0x1c2/0x370
> [   19.803782][    T1]  copy_strings_kernel+0x2b/0x40
> 
> Full boot log or kernel .config file are available if wanted.

I'll see if I can bisect, but I'm getting on a plane soon...

-- 
Kees Cook
