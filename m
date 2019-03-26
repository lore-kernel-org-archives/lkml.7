Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62799C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264F02075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rgIMkKTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfCZKGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:06:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZKGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:06:18 -0400
Received: from [10.189.135.50] (x59cc8b32.dyn.telefonica.de [89.204.139.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF9D91EC082D;
        Tue, 26 Mar 2019 11:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553594777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6kxqdFfs/VvAWkFucYDxHQbKc7utkP+G1OcERASYhQ=;
        b=rgIMkKTI0H2CZdpFTaDwtciENyk97F8j2gYHd48dPWEASvwrILtlnC4SRg1OhVTFlLMYf4
        mZL+AFBab98wAkvyjkaBGD0DPgxUvXnNY8YKBqlex6uozCJdYBSYz6J2n9ZJm6E6CIsvXi
        yFJT0T+lkT2gECQy23Rmi9E93j7KRig=
Date:   Tue, 26 Mar 2019 11:06:13 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <be457f42-40b0-6d21-0f0c-2a5e3860d4d5@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com> <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic> <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com> <20190325063742.GA12016@zn.tnic> <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com> <20190325173239.GO12016@zn.tnic> <11013ad2-2eab-5a7a-d4e2-a9da4920cfab@amd.com> <be457f42-40b0-6d21-0f0c-2a5e3860d4d5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is active
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
CC:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <24AEA0F0-8BDA-4C96-9AC2-F12A7A06C76D@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 25, 2019 8:59:28 PM GMT+01:00, "Lendacky, Thomas" <Thomas=2ELendac=
ky@amd=2Ecom> wrote:
>Maybe what would help is to describe why there is a difference between
>SME
>and SEV in regards to kexec=2E During a traditional boot under SME, SME
>will
>encrypt the kernel, so the SME kexec kernel also needs to be
>un-encrypted
>in order to replicate a normal SME boot=2E During a traditional boot
>under
>SEV, the kernel has already been loaded encrypted, so the SEV kexec
>kernel
>needs to be encrypted in order to replicate a normal SEV boot=2E


Yah, that should be in a comment above that function=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
