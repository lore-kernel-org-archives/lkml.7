Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71A220863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZvvGPOUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfCYSjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:39:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48944 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfCYSjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:39:08 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FEAC1EC0AB1;
        Mon, 25 Mar 2019 19:39:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553539146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gg2u1ds3XRqFyuFOielquJtFw5GjYPmcMuZcr6XBCVw=;
        b=ZvvGPOUKdRkm62/l4Dw6xflmCxEoVtPqJU+XBL2fXBjT0iLY9P338P5wBTF29jZm1gp0Lb
        7Hpdi/7Z1Ge9wDcfNTxBAqLP5yizQ23FYanlFvYUezrZxyB18BFLvDRf0oCdE0VdO0Zw7B
        G2iS5zVY/PjcaqR+6avdn6qt+FdRNvs=
Date:   Mon, 25 Mar 2019 19:39:09 +0100
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
Message-ID: <20190325183909.GQ12016@zn.tnic>
References: <20190325171649.7311-1-bp@alien8.de>
 <20190325171649.7311-2-bp@alien8.de>
 <20190325182133.GG31069@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325182133.GG31069@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:21:33AM -0700, Sean Christopherson wrote:
> Won't this prevent emulating an AMD guest on Intel hardware, e.g. due to
> injecting #GPs during boot?

I guess, but...

> Keeping support in kvm_{get,set}_msr_common
> doesn't preclude svm_{get,set}_msr() from having SVM-specific handling for
> the MSR.

... is kvm_{get,set}_msr_common() supposed to cover for all those
overlapping MSRs between AMD and Intel? svm_{get,set}_msr() have a lot
more AMD-specific MSRs just like vmx_{get,set}_msr() respectively for
Intel.

Which would mean that if you really want to support those cross-vendor
emulations, you don't need the svm* and vmx* MSR accessors... or am I
missing something?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
