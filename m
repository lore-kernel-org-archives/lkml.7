Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4299205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GNkr5TMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfCZJ6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:58:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCZJ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:58:36 -0400
Received: from [10.189.135.50] (x59cc8b32.dyn.telefonica.de [89.204.139.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC4B61EC06CA;
        Tue, 26 Mar 2019 10:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553594314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDWKO6eH/zlgiGaOLfvIsRy9vA6UEubRgnGstJSi9T8=;
        b=GNkr5TMmCz7Gm6yKAzacPjEnQL5QXO9w0j2lVzgm7nqLie2RlsRy6oO7r8U8qDvyuMYs7C
        nnXcF+abZQbGZE/URZxnTdm2CWJTBXn4nMTypB6CpeZNr7mJ1D1yW9iii+k+iUvk5nFFRC
        IcvQj2poiVHXIzp1xQ0vQbiEb0Yd9is=
Date:   Tue, 26 Mar 2019 10:58:31 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <b1556461-fe83-2ba0-00a3-e8ecf3e286fe@amd.com>
References: <20181129080956.20776-1-lijiang@redhat.com> <20181129080956.20776-2-lijiang@redhat.com> <20181130033703.GA23624@dhcp-128-65.nay.redhat.com> <b8936194-01ef-8b8f-254e-039fc951855d@amd.com> <95661569-d9c9-af13-11c4-c0d752710a1f@redhat.com> <b1556461-fe83-2ba0-00a3-e8ecf3e286fe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor 'IORES_DESC_RESERVED'
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        lijiang <lijiang@redhat.com>
CC:     Dave Young <dyoung@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bhe@redhat.com" <bhe@redhat.com>, Toshi Kani <toshi.kani@hp.com>,
        Dan Williams <dan.j.williams@intel.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <5B077919-37B4-4434-86BC-6F29DD73C195@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 25, 2019 8:34:25 PM GMT+01:00, "Lendacky, Thomas" <Thomas=2ELendac=
ky@amd=2Ecom> wrote:
>On 3/16/19 2:31 AM, lijiang=20
>Adding a nice comment here about how IORES_DESC_NONE originally was to
>identify MMIO and reserved areas=2E Now IORES_DESC_RESERVED has been
>created
>for the reserved areas so the check needs to be expanded

Expanded and made explicit *which* areas should not be mapped encrypted an=
d then the function name corrected=2E=20

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
