Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F22C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2A2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfH2Qog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfH2Qog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16DE118B3D83;
        Thu, 29 Aug 2019 16:44:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9659F5D9D3;
        Thu, 29 Aug 2019 16:44:34 +0000 (UTC)
Date:   Thu, 29 Aug 2019 18:44:32 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 1/4] KVM: selftests: Move vm type into _vm_create()
 internally
Message-ID: <20190829164432.e5kxt4e2f5ncxwlc@kamzik.brq.redhat.com>
References: <20190829022117.10191-1-peterx@redhat.com>
 <20190829022117.10191-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829022117.10191-2-peterx@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 29 Aug 2019 16:44:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:21:14AM +0800, Peter Xu wrote:
> Rather than passing the vm type from the top level to the end of vm
> creation, let's simply keep that as an internal of kvm_vm struct and
> decide the type in _vm_create().  Several reasons for doing this:
> 
> - The vm type is only decided by physical address width and currently
>   only used in aarch64, so we've got enough information as long as
>   we're passing vm_guest_mode into _vm_create(),
> 
> - This removes a loop dependency between the vm->type and creation of
>   vms.  That's why now we need to parse vm_guest_mode twice sometimes,
>   once in run_test() and then again in _vm_create().  The follow up
>   patches will move on to clean up that as well so we can have a
>   single place to decide guest machine types and so.
> 
> Note that this patch will slightly change the behavior of aarch64
> tests in that previously most vm_create() callers will directly pass
> in type==0 into _vm_create() but now the type will depend on
> vm_guest_mode, however it shouldn't affect any user because all
> vm_create() users of aarch64 will be using VM_MODE_DEFAULT guest
> mode (which is VM_MODE_P40V48_4K) so at last type will still be zero.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c  | 13 +++---------
>  .../testing/selftests/kvm/include/kvm_util.h  |  3 +--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++++++-------
>  3 files changed, 17 insertions(+), 20 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
