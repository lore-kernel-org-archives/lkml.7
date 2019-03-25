Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7391420854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aWxqp556"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfCYTir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:38:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYTir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:38:47 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA41B1EC058B;
        Mon, 25 Mar 2019 20:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553542726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=94EUk/iFm63hrEEwsiCrF2fkINeVQIA4lACwZXxMYzM=;
        b=aWxqp556RIETfEqbrIcBXPXYMfMisV+2NZY64f2JOX9K0LUX+zvoVBWeqCZ3qsqKFqRLHP
        xFd2dr1N0GtDtLCNEsrSuhPIw/qJj4OVqKM7zYD++1Wsx/A1B6+t67xRXyIsuRVouPk/Fr
        q41mIvqxFrNzEQz6OxbeF+84Ac1AtDE=
Date:   Mon, 25 Mar 2019 20:38:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Message-ID: <20190325193821.GS12016@zn.tnic>
References: <20190325171649.7311-1-bp@alien8.de>
 <20190325171649.7311-2-bp@alien8.de>
 <20190325182133.GG31069@linux.intel.com>
 <20190325183909.GQ12016@zn.tnic>
 <20190325192111.GH31069@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325192111.GH31069@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:21:11PM -0700, Sean Christopherson wrote:
> Generally speaking, the goal is to support cross-vendor VMs without having
> to modify the guest kernel, i.e. exact emulation is out of scope.  This
> means "emulating" cross-vendor MSRs that the guest expects to exist to the
> point where the guest won't explode, e.g. in the case of MSR_K7_HWCR, Linux
> expects the MSR to exist on all AMD platforms and AFAICT will die during
> boot if it doesn't.
> 
> The rule of thumb for "what MSRs can a guest reasonably expect to exist"
> is fluid.

Ok, I'll keep it in the common MSR accessors in the next version.

Thx for confirming what I was suspecting.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
