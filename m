Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C771C20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551985265;
	bh=jLsy14xrHiu+BFv96cMYF60EPBitx2fdM5bOBfEHQoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Np+RnuU1S/fYXayFCNHTmSp4q6gZyTgWBTmPq938G8lVuGgXVVnHuiUpRxLBVZtHK
	 WBp/+CqMAraDmIkWICYRwmDVOBcgmckKC2n/6UzPKFDH/CJKBYpkkByp+EP/de/U42
	 TsuWImBpF4Ch/NtySqcS2yiTYoAZe3SgZLsFpWRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCGTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:01:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:01:04 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29654C646;
        Thu,  7 Mar 2019 19:01:03 +0000 (UTC)
Date:   Thu, 7 Mar 2019 11:01:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rong.a.chen@intel.com
Subject: Re: [PATCH] proc: test with vsyscall in mind
Message-Id: <20190307110102.914eaf61d17339c6ae9ca3ef@linux-foundation.org>
In-Reply-To: <20190307183204.GA11405@avx2>
References: <20190307183204.GA11405@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 21:32:04 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Read from vsyscall page to tell if vsyscall is being used.
> 
> Reported-by: kernel test robot
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

There's a lot of information missing from this changelog :(


I rewrote it to this:

: selftests: proc: proc-pid-vm
: ========================================
: proc-pid-vm: proc-pid-vm.c:277: main: Assertion `rv == strlen(buf0)' failed.
: Aborted

Because the vsyscall mapping is enabled.  Read from vsyscall page to tell
if vsyscall is being used.

Link: http://lkml.kernel.org/r/20190307183204.GA11405@avx2
Link: http://lkml.kernel.org/r/20190219094722.GB28258@shao2-debian
Fixes: 34aab6bec23e7e9 ("proc: test /proc/*/maps, smaps, smaps_rollup, statm")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


