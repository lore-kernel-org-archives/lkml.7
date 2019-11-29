Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCAEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C42F217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK2O4H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:56:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:32456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2O4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:56:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 06:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="212303680"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2019 06:56:04 -0800
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.252]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.76]) with mapi id 14.03.0439.000;
 Fri, 29 Nov 2019 14:56:03 +0000
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Pedro Alves" <palves@redhat.com>, Simon Marchi <simark@simark.ca>,
        Andi Kleen <ak@linux.intel.com>
Subject: RE: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Topic: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Index: AQHVm+iTbaIQs/3oqE+UcwYHBKDTgKeiRc1Q
Date:   Fri, 29 Nov 2019 14:56:03 +0000
Message-ID: <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
In-Reply-To: <20191115191200.GD22747@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 15, 2019 at 07:29:17PM +0100, Thomas Gleixner wrote:
> > On Fri, 4 Oct 2019, Chang S. Bae wrote:
> > >
> > > Updates from v8 [10]:
> > > * Internalized the interrupt check in the helper functions (Andy L.)
> > > * Simplified GS base helper functions (Tony L.)
> > > * Changed the patch order to put the paranoid path changes before the
> > >   context switch changes (Tony L.)
> > > * Fixed typos (Randy D.) and massaged a few sentences in the documentation
> > > * Massaged the FSGSBASE enablement message
> >
> > That still lacks what Andy requested quite some time ago in the V8 thread:
> >
> >      https://lore.kernel.org/lkml/034aaf3a-a93d-ec03-0bbd-
> 068e1905b774@kernel.org/
> >
> >   "I also think that, before this series can have my ack, it needs an
> >    actual gdb maintainer to chime in, publicly, and state that they have
> >    thought about and tested the ABI changes and that gdb still works on
> >    patched kernels with and without FSGSBASE enabled.  I realize that there
> >    were all kinds of discussions, but they were all quite theoretical, and
> >    I think that the actual patches need to be considered by people who
> >    understand the concerns.  Specific test cases would be nice, too."
> >
> > What's the state of this?

On branch users/mmetzger/fsgs in sourceware.org/git/binutils-gdb.git,
there's a GDB test covering the behavior discussed theoretically back then.

It covers modifying the selector as well as the base from GDB and using
the modified values for inferior calls as well as for resuming the inferior.

Current kernels allow changing the selector and provide the resulting
base back to the ptracer.  They also allow changing the base as long as
the selector is zero.  That's the behavior we wanted to preserve IIRC.

The patch series on branch fsgs_tip_5.4-rc1_100319 at
github.com/changbae/Linux-kernel.git breaks tests that modify the
selector and expect that to change the base.

That kernel allows changing the base via ptrace but ignores changes
to the selector.

Regards,
Markus.
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

