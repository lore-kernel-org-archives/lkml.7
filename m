Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A042171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfG2Owf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:52:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:64348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfG2Owf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:52:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="255261173"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2019 07:52:34 -0700
Date:   Mon, 29 Jul 2019 07:52:34 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch 1/5] lib/vdso/32: Remove inconsistent NULL pointer checks
Message-ID: <20190729145234.GC21120@linux.intel.com>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.587523358@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728131648.587523358@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:12:52PM +0200, Thomas Gleixner wrote:
> The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
> check for the timespec pointer. That's inconsistent vs. 64bit.
> 
> But the vdso implementation will never be consistent versus the syscall
> because the only case which it can handle is NULL. Any other invalid
> pointer will cause a segfault. So special casing NULL is not really useful.
> 
> Remove it along with the superflouos syscall fallback invocation as that

s/superflouos/superfluous

> will return -EFAULT anyway. That also gets rid of the dubious typecast
> which only works because the pointer is NULL.
> 
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
