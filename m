Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F73C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C04B21852
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BN1j3Fmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKIJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:09:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfDKIJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:09:44 -0400
Received: from zn.tnic (p200300EC2F0ABD00803D8A3D4BEC4F6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bd00:803d:8a3d:4bec:4f6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78AB41EC04B9;
        Thu, 11 Apr 2019 10:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554970183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z8304YD94RCjlMSAF19W30BX/NBhw56qlzcYzCUrbBQ=;
        b=BN1j3FmfQ0/khzILjomCxEeke76qPL2Rz35iiAr+2BdYmUkH3xhs9smafXLHuyCqTPNQTf
        Ab379qO0FrLaPmvhaiWRmaInNOJIfsK92kM6pvquKNTffFrS3RKvyeY7cmhnr6yWR8cugu
        Cmaezy1q31jvGHtzLx3CH+iCrjJJOpI=
Date:   Thu, 11 Apr 2019 10:09:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190411080927.GA30080@zn.tnic>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:34:51PM +0000, Junichi Nomura wrote:
> But efi_get_rsdp_addr() needs to check whether the kernel was
> kexec booted to avoid accessing invalid EFI table address.
> efi_get_kexec_setup_data_addr() is the only method I know
> to check if it was kexec-booted.

Your v3 had the right approach - you first check if you can get the
address as a kexec-ed kernel. If you do, you use that one and continue
the normal path.

If you don't, you fall back to efi_get_rsdp_addr() and get it directly
from EFI.

And then carve out the functionality you need to call multiple times in
helper functions like __efi_get_rsdp_addr().

Why doesn't that work anymore?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
