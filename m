Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC020748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmjb9doZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfL3Sre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:47:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39176 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfL3Sre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:47:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so47232044oty.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSzF2ZZ1Ch1a/dTTcoXOq4WOPRbLFthto/gMc1GFPCU=;
        b=bmjb9doZNeXlm4t9AGopbZrAC/v5Xr2Q8eEKnQIScDqVcduViyq4sq3B4iP9eHMGo+
         31zj9DJA0b/JLQrqoNkELpWXjDjSJImwCl2gVpLxJTrBv1Gzq6Dkm9ROz2m8KZun9wMk
         zGE+ROjlqXx95b1GqO869/+7buvARhRqu7gjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSzF2ZZ1Ch1a/dTTcoXOq4WOPRbLFthto/gMc1GFPCU=;
        b=HaDbj643xTFSYE+ks7JquPTAq/ojyvuQs1zruyAQShhx2xZn+Y/s51wM1WqjINOOcn
         9QJ0fwLl+IM8kyumGnHt37QRfbNUgQYyW34xW+KRMNEvWBooGv6BfO89XuhvlKxJNrYC
         h1LnXSuNLmQOWZNpOsLAiCN5XqIhTTOk3uRoB8tGv7LbKCKoHQVr/jvY0zFpJtzVQyiu
         SaT1CTzcb+kCYgQoJmPGiN6NtHksiqLtL81GzSVDzNbsxZ/9zoexywkrDjK1/fWNtMsW
         +Ih1NH/OKWWWC+a6lpCaiW6KDn6qyNRQkBOzgV7W2LLtrUsoRYHvmn/PsC343mDWb8Rr
         5SSA==
X-Gm-Message-State: APjAAAV2n/Z66EYASLTtIbqKfydy2Qu+X/OCLzW/rYxwnn158No8Eq6q
        gccvy7CvMlXM/oDrL+hUOwnwWA==
X-Google-Smtp-Source: APXvYqyOHJDwbUTNf0rlAN73tcGw41GW0ESRktnB6i9wHUFbcBmdhzSifggkHFh57jUt/jAjdI84Ug==
X-Received: by 2002:a05:6830:1487:: with SMTP id s7mr52998368otq.269.1577731652506;
        Mon, 30 Dec 2019 10:47:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm16039105oti.22.2019.12.30.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:47:31 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:47:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     openrisc@lists.librecores.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: lib/test_user_copy.c:244: Error: unrecognized keyword/register
 name `l.lwz ?ap,4(r18)'
Message-ID: <201912301046.0C58C5E@keescook>
References: <201912271737.FW6uJ1Qa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912271737.FW6uJ1Qa%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 05:09:08PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   46cf053efec6a3a5f343fead837777efe8252a46
> commit: 6d13de1489b6bf539695f96d945de3860e6d5e17 uaccess: disallow > INT_MAX copy sizes
> date:   3 weeks ago
> config: openrisc-randconfig-a001-20191225 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6d13de1489b6bf539695f96d945de3860e6d5e17
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    lib/test_user_copy.c: Assembler messages:
> >> lib/test_user_copy.c:244: Error: unrecognized keyword/register name `l.lwz ?ap,4(r18)'
> >> lib/test_user_copy.c:249: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

Hi!

This looks like something deep in the usercopy code on openrisc?
Something likely around 64-bit copies, I'd guess. Can someone with
openrisc knowledge take a look at this?

Thanks!

-Kees

> 
> vim +244 lib/test_user_copy.c
> 
> 3e2a4c183ace87 Kees Cook    2014-01-23  193  
> 3e2a4c183ace87 Kees Cook    2014-01-23  194  	kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
> 3e2a4c183ace87 Kees Cook    2014-01-23  195  	if (!kmem)
> 3e2a4c183ace87 Kees Cook    2014-01-23  196  		return -ENOMEM;
> 3e2a4c183ace87 Kees Cook    2014-01-23  197  
> 3e2a4c183ace87 Kees Cook    2014-01-23  198  	user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
> 3e2a4c183ace87 Kees Cook    2014-01-23  199  			    PROT_READ | PROT_WRITE | PROT_EXEC,
> 3e2a4c183ace87 Kees Cook    2014-01-23  200  			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
> 3e2a4c183ace87 Kees Cook    2014-01-23  201  	if (user_addr >= (unsigned long)(TASK_SIZE)) {
> 3e2a4c183ace87 Kees Cook    2014-01-23  202  		pr_warn("Failed to allocate user memory\n");
> 3e2a4c183ace87 Kees Cook    2014-01-23  203  		kfree(kmem);
> 3e2a4c183ace87 Kees Cook    2014-01-23  204  		return -ENOMEM;
> 3e2a4c183ace87 Kees Cook    2014-01-23  205  	}
> 3e2a4c183ace87 Kees Cook    2014-01-23  206  
> 3e2a4c183ace87 Kees Cook    2014-01-23  207  	usermem = (char __user *)user_addr;
> 3e2a4c183ace87 Kees Cook    2014-01-23  208  	bad_usermem = (char *)user_addr;
> 3e2a4c183ace87 Kees Cook    2014-01-23  209  
> f5f893c57e37ca Kees Cook    2017-02-13  210  	/*
> f5f893c57e37ca Kees Cook    2017-02-13  211  	 * Legitimate usage: none of these copies should fail.
> f5f893c57e37ca Kees Cook    2017-02-13  212  	 */
> 4c5d7bc63775b4 Kees Cook    2017-02-14  213  	memset(kmem, 0x3a, PAGE_SIZE * 2);
> 3e2a4c183ace87 Kees Cook    2014-01-23  214  	ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
> 3e2a4c183ace87 Kees Cook    2014-01-23  215  		    "legitimate copy_to_user failed");
> 4c5d7bc63775b4 Kees Cook    2017-02-14  216  	memset(kmem, 0x0, PAGE_SIZE);
> 4c5d7bc63775b4 Kees Cook    2017-02-14  217  	ret |= test(copy_from_user(kmem, usermem, PAGE_SIZE),
> 4c5d7bc63775b4 Kees Cook    2017-02-14  218  		    "legitimate copy_from_user failed");
> 4c5d7bc63775b4 Kees Cook    2017-02-14  219  	ret |= test(memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
> 4c5d7bc63775b4 Kees Cook    2017-02-14  220  		    "legitimate usercopy failed to copy data");
> 4c5d7bc63775b4 Kees Cook    2017-02-14  221  
> 4c5d7bc63775b4 Kees Cook    2017-02-14  222  #define test_legit(size, check)						  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  223  	do {								  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  224  		val_##size = check;					  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  225  		ret |= test(put_user(val_##size, (size __user *)usermem), \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  226  		    "legitimate put_user (" #size ") failed");		  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  227  		val_##size = 0;						  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  228  		ret |= test(get_user(val_##size, (size __user *)usermem), \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  229  		    "legitimate get_user (" #size ") failed");		  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  230  		ret |= test(val_##size != check,			  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  231  		    "legitimate get_user (" #size ") failed to do copy"); \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  232  		if (val_##size != check) {				  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  233  			pr_info("0x%llx != 0x%llx\n",			  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  234  				(unsigned long long)val_##size,		  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  235  				(unsigned long long)check);		  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  236  		}							  \
> 4c5d7bc63775b4 Kees Cook    2017-02-14  237  	} while (0)
> 4c5d7bc63775b4 Kees Cook    2017-02-14  238  
> 4c5d7bc63775b4 Kees Cook    2017-02-14  239  	test_legit(u8,  0x5a);
> 4c5d7bc63775b4 Kees Cook    2017-02-14  240  	test_legit(u16, 0x5a5b);
> 4c5d7bc63775b4 Kees Cook    2017-02-14  241  	test_legit(u32, 0x5a5b5c5d);
> 4c5d7bc63775b4 Kees Cook    2017-02-14  242  #ifdef TEST_U64
> 4c5d7bc63775b4 Kees Cook    2017-02-14  243  	test_legit(u64, 0x5a5b5c5d6a6b6c6d);
> 4c5d7bc63775b4 Kees Cook    2017-02-14 @244  #endif
> 4c5d7bc63775b4 Kees Cook    2017-02-14  245  #undef test_legit
> 3e2a4c183ace87 Kees Cook    2014-01-23  246  
> f5a1a536fa1489 Aleksa Sarai 2019-10-01  247  	/* Test usage of check_nonzero_user(). */
> f5a1a536fa1489 Aleksa Sarai 2019-10-01  248  	ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> f5a1a536fa1489 Aleksa Sarai 2019-10-01 @249  	/* Test usage of copy_struct_from_user(). */
> f5a1a536fa1489 Aleksa Sarai 2019-10-01  250  	ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> f5a1a536fa1489 Aleksa Sarai 2019-10-01  251  
> f5f893c57e37ca Kees Cook    2017-02-13  252  	/*
> f5f893c57e37ca Kees Cook    2017-02-13  253  	 * Invalid usage: none of these copies should succeed.
> f5f893c57e37ca Kees Cook    2017-02-13  254  	 */
> f5f893c57e37ca Kees Cook    2017-02-13  255  
> f5f893c57e37ca Kees Cook    2017-02-13  256  	/* Prepare kernel memory with check values. */
> 4fbfeb8bd684d5 Hoeun Ryu    2017-02-12  257  	memset(kmem, 0x5a, PAGE_SIZE);
> 4fbfeb8bd684d5 Hoeun Ryu    2017-02-12  258  	memset(kmem + PAGE_SIZE, 0, PAGE_SIZE);
> f5f893c57e37ca Kees Cook    2017-02-13  259  
> f5f893c57e37ca Kees Cook    2017-02-13  260  	/* Reject kernel-to-kernel copies through copy_from_user(). */
> 3e2a4c183ace87 Kees Cook    2014-01-23  261  	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
> 3e2a4c183ace87 Kees Cook    2014-01-23  262  				    PAGE_SIZE),
> 3e2a4c183ace87 Kees Cook    2014-01-23  263  		    "illegal all-kernel copy_from_user passed");
> f5f893c57e37ca Kees Cook    2017-02-13  264  
> f5f893c57e37ca Kees Cook    2017-02-13  265  	/* Destination half of buffer should have been zeroed. */
> 4fbfeb8bd684d5 Hoeun Ryu    2017-02-12  266  	ret |= test(memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE),
> 4fbfeb8bd684d5 Hoeun Ryu    2017-02-12  267  		    "zeroing failure for illegal all-kernel copy_from_user");
> f5f893c57e37ca Kees Cook    2017-02-13  268  
> 
> :::::: The code at line 244 was first introduced by commit
> :::::: 4c5d7bc63775b40631b75f6c59a3a3005455262d usercopy: Add tests for all get_user() sizes
> 
> :::::: TO: Kees Cook <keescook@chromium.org>
> :::::: CC: Kees Cook <keescook@chromium.org>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation



-- 
Kees Cook
