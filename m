Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D88C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBE620675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jNca5HYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfDROT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:19:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388806AbfDROT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:19:56 -0400
Received: from zn.tnic (p200300EC2F112E003868EF36058F9C84.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:3868:ef36:58f:9c84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBB231EC04CD;
        Thu, 18 Apr 2019 16:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555597194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zla6IUZC5NUqumdwsALqVVzlHUaEhOjQZzDTdtmrxF0=;
        b=jNca5HYd+fieHVv0NIgBhgXk149ujkFqt46WKOfcexddkadC2ML1O4hevawxr/JdkoMNsG
        fX+tMf1V3j+7m9SPRNK0+oIVrY/s5UsEVD0KO1ksE0z6MQM4V5DuncJYHaGB0HSU4DBpZ8
        XuBQMlnhob1sLJy3c4AfEFjMO3BiSB8=
Date:   Thu, 18 Apr 2019 16:19:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     KVM <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH -v5.1] x86/kvm: Implement HWCR support
Message-ID: <20190418141949.GK27160@zn.tnic>
References: <20190408090946.GA2315@zn.tnic>
 <20190408144115.GA25880@linux.intel.com>
 <20190408145716.GG15689@zn.tnic>
 <20190418122842.GF27160@zn.tnic>
 <20190418135606.GA17218@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418135606.GA17218@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 06:56:06AM -0700, Sean Christopherson wrote:
> This doesn't allow writing '0' regardless of msr_hwcr.BIT(18), which was
> previously supported.

Restored the old conditional:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 10f6acc6494c..f74f1280745b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2318,7 +2318,8 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 				return -1;
 
 			/* MCi_STATUS */
-			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
+			if (!msr_info->host_initiated &&
+			    (offset & 0x3) == 1 && data != 0) {
 				if (!can_set_mci_status(vcpu))
 					return -1;
 			}

> And there's no need for multiple if statements.

It is a bit more readable this way.

Actually, I'd break that if above into smaller if-statements with
flipped logic to make it even more readable:

	if (msr_info->host_initiated)
		goto set_msr;

	if (!(offset & 0x3))
		goto set_msr;

	if (!data)
		goto set_msr;

	if (!can_set_mci_status(vcpu))
		return -1;

set_msr:
	...


Anything else? Can I send v5.2 now?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
