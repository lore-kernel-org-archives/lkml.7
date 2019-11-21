Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685D620718
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="muVq5zaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKUWHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:07:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKUWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:07:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so2328500pgd.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Wso9M2AptCOQ/FSB/cF//hdr5Wmb6Utbp6FwVtSvgFg=;
        b=muVq5zaKkBQRopIc2gUyZS+KHD4OCOG0Y0Lj9B2+WEvWxaf2p7IF3xq6IVyLVHF/hi
         hhFNsLIeUddkEjHpGStAkfUtqdyDYWvzQGPuti6Tjxn9uGaT+ChklsBz2+FboMQNqJ8c
         madsv1PEL3adKYmbw+yn9sZeSGJ2Zev5fqTvM7OhNGf+lhJqyvxhQ8zwzH6fCPCt1iVE
         CnVaWt1iXAR9zQyLbNHKvxP1GhyFxccyMLU9SEqCXYi+8L7y2he1JApd92rh5MDKW8F2
         NMu/Y9Fi0QydQSpgXIMFhgMcWvYOZGi/Xkx+t/wahNlb0K+ILJiYZ/MDe1tBdh9d0I2L
         nIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Wso9M2AptCOQ/FSB/cF//hdr5Wmb6Utbp6FwVtSvgFg=;
        b=gVVhtG2GycRJ1gj9MQIM0SkAGsuMeoa6dkUQcLlumiow5pt7QDarwieX9gGMOqUV/i
         VsOn+oyDmK4MsMp3iAXt4s9uXQaralpLV7YP+Y9H+/zoWzZ20rirPeefubVFXRz/R4zI
         HYc0JCyff9fCTPzbeCaAqEZJXJErcrjMP/I5GVrRC2acJvuOWOahAQhp/ldNa5/ZzE1C
         ie7iq5mFp5xPPgzjXwzNDifrXJPLRgBXqRay1oS5qpgTJgEQ8nUYldoM6PNt7LnaB0Ao
         Umk27+NYx1HoSYiT5OSC1fYcY1f2QkQ+opXuy3X+A2lgCPWe1f6G9MPY83qG7N/Mlmm4
         8QUQ==
X-Gm-Message-State: APjAAAX4YKCqsyDTHQbH+zMBWyZumOE2hdytqiIFgq61cejGC1iNKR9j
        C452J1k23C2vS3qroFyd0KEYHA==
X-Google-Smtp-Source: APXvYqwDorQg7vv5808xuL8+fLkJF5Lnbg5y3BdQ92DW3UKMbp5u4/p2LgdvLTGB+TEFVKbNK0K2Jw==
X-Received: by 2002:a63:25c7:: with SMTP id l190mr12263520pgl.429.1574374060188;
        Thu, 21 Nov 2019 14:07:40 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1956:3100:f5cd:d9bc? ([2601:646:c200:1ef2:1956:3100:f5cd:d9bc])
        by smtp.gmail.com with ESMTPSA id y24sm4833234pfr.116.2019.11.21.14.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:07:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 4/6] x86/split_lock: Enumerate split lock detection if the IA32_CORE_CAPABILITIES MSR is not supported
Date:   Thu, 21 Nov 2019 14:07:38 -0800
Message-Id: <D4D6F51D-D791-4B78-8FCA-5D419B1D079C@amacapital.net>
References: <1574297603-198156-5-git-send-email-fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <1574297603-198156-5-git-send-email-fenghua.yu@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFArchitecturally the split lock detection feature is enumerated by=

> IA32_CORE_CAPABILITIES MSR and future CPU models will indicate presence
> of the feature by setting bit 5. But the feature is present in a few
> older models where split lock detection is enumerated by the CPU models.
>=20
> Use a "x86_cpu_id" table to list the older CPU models with the feature.
>=20

This may need to be disabled if the HYPERVISOR bit is set.=
