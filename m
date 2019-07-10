Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D3C74A22
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E482064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mengyan1223.wang header.i=@mengyan1223.wang header.b="xZgPkVoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGJNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:25:26 -0400
Received: from mengyan1223.wang ([89.208.246.23]:38616 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfGJNZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:25:26 -0400
Received: from xry111-laptop.lan (unknown [124.115.222.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id A989465B48;
        Wed, 10 Jul 2019 09:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1562765123;
        bh=F7jfGWTtAY0jJd0ZKJkp5Z7M3XVcQTbZJ3SkCYLC5Mo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xZgPkVoGvbOZq1gB+Hn8iJcqZrRP8AKy5IyvEjbORtJLD4u/aEeun61EidPSuenF2
         75aZNQt0XFcIAeAEHf7s5tnMkAqFxxGuDeVCt/taNnKl0ehKMOpU/oK2Rj2MBbXgZ8
         EDTwUFVqh70jmqhR1CT7ZyFrev0nl4mHQeStxYvdG/jQjn+G8sCkO4KrNLfcOK2sZR
         cRsrmWFfX8lk8GGLNlUxY8UtTlDb6ncKDWCH54HBSKbN42wgtdDuO9h8dIQGlAXeSX
         LGcrOJ7c9Cb8c+qm/VvJX58ds7bZab4lpFX7Nh5pvssXiBd9UqsvfO2lWsfyg9hueT
         Icgtora5jHzkA==
Message-ID: <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nadav Amit <namit@vmware.com>
Date:   Wed, 10 Jul 2019 21:25:16 +0800
In-Reply-To: <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
References: <20190708162756.GA69120@gmail.com>
          <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
          <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
          <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
         <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
          <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
          <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
          <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
         <201907091727.91CC6C72D8@keescook>
          <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
         <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
         <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
         <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-10 14:31 +0200, Jiri Kosina wrote:
> Adding Daniel to check whether this couldn't be some fallout of jumplabel 
> batching.

I don't think so.  I tried to revert Daniel's jumplabel batching commits and the
issue wasn't solved.  But reverting Kees' CR0 and CR4 commits can "fix" it
(apprently).
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

