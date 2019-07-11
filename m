Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C9DC73C66
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C8121537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfGKRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfGKRpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 647DE5D5E6;
        Thu, 11 Jul 2019 17:45:13 +0000 (UTC)
Received: from treble (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C82600CD;
        Thu, 11 Jul 2019 17:45:10 +0000 (UTC)
Date:   Thu, 11 Jul 2019 12:45:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Pu Wen <puwen@hygon.cn>, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Remove X86_FEATURE_MFENCE_RDTSC
Message-ID: <20190711174507.wrwfxohzutfsgbgl@treble>
References: <d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com>
 <45f247d2-80f5-6c8c-d11e-965a3da8a88f@amd.com>
 <4a13c6a3-a13e-d3e5-0008-41a6d47a6eff@redhat.com>
 <alpine.DEB.2.21.1907101333250.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907101333250.1758@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Jul 2019 17:45:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:33:48PM +0200, Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Paolo Bonzini wrote:
> > On 08/07/19 21:32, Lendacky, Thomas wrote:
> > >> AMD and Intel both have serializing lfence (X86_FEATURE_LFENCE_RDTSC).
> > >> They've both had it for a long time, and AMD has had it enabled in Linux
> > >> since Spectre v1 was announced.
> > >>
> > >> Back then, there was a proposal to remove the serializing mfence feature
> > >> bit (X86_FEATURE_MFENCE_RDTSC), since both AMD and Intel have
> > >> serializing lfence.  At the time, it was (ahem) speculated that some
> > >> hypervisors might not yet support its removal, so it remained for the
> > >> time being.
> > >>
> > >> Now a year-and-a-half later, it should be safe to remove.
> > >
> > > I vaguely remember a concern from a migration point of view, maybe? Adding
> > > Paolo to see if he has any concerns.
> > 
> > It would be a problem to remove the conditional "if
> > (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))" from svm_get_msr_feature.  But
> > removing support for X86_FEATURE_MFENCE_RDTSC essentially amounts to
> > removing support for hypervisors that haven't been updated pre-Spectre.
> >  That's fair enough, I think.
> 
> Yes, they have other more interesting problems :)

Great.  Anyone care to give an ACK? :-)

-- 
Josh
