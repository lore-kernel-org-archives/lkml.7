Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D83C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7EC218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfGZSBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:01:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:39633 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfGZSBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:01:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 11:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="178472981"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2019 11:01:03 -0700
Date:   Fri, 26 Jul 2019 11:01:03 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <20190726180103.GE3188@linux.intel.com>
References: <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook>
 <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
 <201907231636.AD3ED717D@keescook>
 <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Paul

On Wed, Jul 24, 2019 at 01:56:34AM +0200, Thomas Gleixner wrote:
> On Tue, 23 Jul 2019, Kees Cook wrote:
> 
> > On Wed, Jul 24, 2019 at 12:59:03AM +0200, Thomas Gleixner wrote:
> > > And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
> > > deal with that in seccomp independently of the VDSO. It does not make sense
> > > to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
> > > both expose the same information, but the latter is y2038 safe.
> > 
> > Okay, so combining Andy's ideas on aliasing and "more seccomp flags",
> > we could declare that clock_gettime64() is not filterable on 32-bit at
> > all without the magic SECCOMP_IGNORE_ALIASES flag or something. Then we
> > would alias clock_gettime64 to clock_gettime _before_ the first evaluation
> > (unless SECCOMP_IGNORE_ALIASES is set)?
> > 
> > (When was clock_gettime64() introduced? Is it too long ago to do this
> > "you can't filter it without a special flag" change?)
> 
> clock_gettime64() and the other sys_*time64() syscalls which address the
> y2038 issue were added in 5.1

Paul Bolle pointed out that this regression showed up in v5.3-rc1, not
v5.2.  In Paul's case, systemd-journal is failing.
