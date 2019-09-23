Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80DC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB9C20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407675AbfIWRmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407617AbfIWRmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CADE010CC1F4;
        Mon, 23 Sep 2019 17:42:48 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 868F360BFB;
        Mon, 23 Sep 2019 17:42:45 +0000 (UTC)
Date:   Mon, 23 Sep 2019 13:42:44 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
Message-ID: <20190923174244.GA19996@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <20190923163746.GE18195@linux.intel.com>
 <24dc5c23-eed8-22db-fd15-5a165a67e747@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24dc5c23-eed8-22db-fd15-5a165a67e747@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 23 Sep 2019 17:42:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:53:10PM +0200, Paolo Bonzini wrote:
> On 23/09/19 18:37, Sean Christopherson wrote:
> >> Would it be too much if we get rid of
> >> kvm_vmx_exit_handlers completely replacing this code with one switch()?
> > Hmm, that'd require redirects for nVMX functions since they are set at
> > runtime.  That isn't necessarily a bad thing.  The approach could also be
> > used if Paolo's idea of making kvm_vmx_max_exit_handlers const allows the
> > compiler to avoid retpoline.
> 
> But aren't switch statements also retpolin-ized if they use a jump table?

See commit a9d57ef15cbe327fe54416dd194ee0ea66ae53a4.

We disabled that feature or the kernel would potentially suffer the
downsides of the exit handlers through pointer to functions for every
switch statement in the kernel.

In turn you can't make it run any faster by converting my "if" to a
"switch" at least the "if" can deterministic control the order of what
is more likely that we should also re-review, but the order of secondary
effect, the important thing is to reduce the retpolines to zero during
normal hrtimer guest runtime.
