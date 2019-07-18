Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1ADC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8EC20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfGROMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGROMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BC5830860BC;
        Thu, 18 Jul 2019 14:12:19 +0000 (UTC)
Received: from treble (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB5755ED3C;
        Thu, 18 Jul 2019 14:12:17 +0000 (UTC)
Date:   Thu, 18 Jul 2019 09:12:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
Message-ID: <20190718141210.us7giumvgbgifvtv@treble>
References: <cover.1563413318.git.jpoimboe@redhat.com>
 <64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com>
 <65bbf58d-f88b-c7d6-523b-6e35f4972bf2@redhat.com>
 <20190718131654.GE28096@linux.intel.com>
 <1b891612-18e6-48ed-cfb5-05e8aca79dcb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b891612-18e6-48ed-cfb5-05e8aca79dcb@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Jul 2019 14:12:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:18:50PM +0200, Paolo Bonzini wrote:
> On 18/07/19 15:16, Sean Christopherson wrote:
> >> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >> This has a side effect of adding a jump in a generally hot path, but
> >> let's hope that the speculation gods for once help us.
> > Any reason not to take the same approach as vmx_vmenter() and ud2 directly
> > from fixup?  I've never found kvm_spurious_fault() to be all that helpful,
> > IMO it's a win win. :-)
> 
> Honestly I've never seen a backtrace from here but I would rather not
> regret this when a customer encounters it...

In theory, changing the "call kvm_spurious_fault" to ud2 should be fine.
It should be tested, of course.

I would defer to Sean to make the patch on top of mine :-)

-- 
Josh
