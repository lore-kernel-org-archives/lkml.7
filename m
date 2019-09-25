Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA776C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C07217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405456AbfIYMNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405148AbfIYMNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9B3F10CC208;
        Wed, 25 Sep 2019 12:13:33 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FCCF60603;
        Wed, 25 Sep 2019 12:13:31 +0000 (UTC)
Date:   Wed, 25 Sep 2019 08:13:30 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] KVM: monolithic: x86: adjust the section prefixes
Message-ID: <20190925121330.GA13637@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-8-aarcange@redhat.com>
 <2171e409-487f-6408-e037-3abc0b9aa312@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2171e409-487f-6408-e037-3abc0b9aa312@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 25 Sep 2019 12:13:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 23, 2019 at 12:15:23PM +0200, Paolo Bonzini wrote:
> On 20/09/19 23:24, Andrea Arcangeli wrote:
> > Adjusts the section prefixes of some KVM common code function because
> > with the monolithic methods the section checker can now do a more
> > accurate analysis at build time and this allows to build without
> > CONFIG_SECTION_MISMATCH_WARN_ONLY=n.
> > 
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> 
> I think it's the opposite---the checker is detecting *missing* section
> prefixes, for example vmx_exit, kvm_exit, kvm_arch_hardware_unsetup etc.
> could be marked __exit.

I added the two missing __init.

The __exit removed from unsetup is because kvm_arch_hardware_unsetup
is called by kvm_init, so unless somehow kvm_init can go in the exit
section and be dropped too during the final kernel link (which would
prevent KVM to initialize in the first place at kernel boot), it's not
feasible to call a function located in the exit section and dropped
during the kernel link from there.

As far as I can tell with upstream KVM if you hit the
kvm_arch_hardware_unsetup function during kvm_init error path it'll
crash the kernel at boot because of it.

Removing __exit fixes that potential upstream crash and upstream bug.

The comment header was short, I'll add more commentary to the commit
header to reduce the confusion about why removing __exit is needed.

Thanks,
Andrea
