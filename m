Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23399C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0E21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfGXPty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:49:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfGXPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:49:54 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqJWU-0004Jn-9L; Wed, 24 Jul 2019 17:49:46 +0200
Date:   Wed, 24 Jul 2019 17:49:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to
 be reserved
In-Reply-To: <20190724153416.GA27117@kroah.com>
Message-ID: <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de> <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com> <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de> <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de> <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com> <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de> <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, Greg KH wrote:
> On Tue, Jul 23, 2019 at 03:44:54PM +0200, Greg KH wrote:
> > Sorry, I saw that after writing that.  You are right, if the others
> > don't object, that's fine with me.  I'll go poke the various build
> > systems that are failing right now on 5.3-rc1 and try to get them fixed
> > for this reason.
> 
> Ok, I dug around and the gold linker is not being used here, only clang
> to build the source and GNU ld to link, and I am still seeing this
> error.

Odd combo.
 
> Hm, clang 8 does not cause this error, but clang 9 does.  Let me go poke
> the people who are providing this version of clang to see if there's
> something they can figure out.

Let me try that with my clang variant. Which version of GNU ld are you
using?

Thanks,

	tglx
