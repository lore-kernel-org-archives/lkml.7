Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F7CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AEC21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572632662;
	bh=SzUM5NeWAG+E0eqSpj3zuD6ltC8wZE1F+AwKRX2zRSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f8k3fOrR72FMkdpB8rUB4mP2yEJurSZftq5car7PgdWOSLkmnFvK5CZAZrPAb6+kC
	 xjyDd2fGJ8QYyV0eYeoLdx6adVj9C5yM8AWCbypVJyXFU9GvrqkpeeJSSL9cEd0B1q
	 MzUMlrJVlZp5N+N7w3ajwxMsZ1jfWmEyGTMHIheQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKASYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfKASYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:24:20 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D8421D7D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2019 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572632660;
        bh=SzUM5NeWAG+E0eqSpj3zuD6ltC8wZE1F+AwKRX2zRSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lduYS8WKNuwzfVJBAy2651MpqHBfuuZuVEV3pkKPx+Z3COSomJDwQoMx9IpRfWLpL
         g7J/hLZM0Il1y8JklXz4kSO9tu6x0ut8M0Ls0MB7NODYprJFREQ/pZzoFBwah/g5qL
         E2A7OkyIKz8YL4u2Zr/4AuM7hNmPuzKDUNdTzbik=
Received: by mail-wr1-f44.google.com with SMTP id v9so10499869wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:24:19 -0700 (PDT)
X-Gm-Message-State: APjAAAVQip09itpghLRrG0lKbfZWpYzeUXDhN+2te+OjvJMIC59IQiwW
        +Sf5DsW7YGnZFDz+yrZsesqNpSzlnKGopWiEwTQz6w==
X-Google-Smtp-Source: APXvYqw0rnlRfwdriPZ576aBq0O+9yfzKHeFxM6ELtsX3pHZailT8JBumH5jVuvvbajKbkN8+GHbNieTjD6qZT7bzCU=
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr12220218wrm.106.1572632658034;
 Fri, 01 Nov 2019 11:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <157262960837.2838.17520432516398899751.stgit@naples-babu.amd.com> <157262962352.2838.15656190309312238595.stgit@naples-babu.amd.com>
In-Reply-To: <157262962352.2838.15656190309312238595.stgit@naples-babu.amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Nov 2019 11:24:05 -0700
X-Gmail-Original-Message-ID: <CALCETrUSjbjt=U6OpTFXEZsEJQ6zjcqCeqi6nSFOi=rN91zWmg@mail.gmail.com>
Message-ID: <CALCETrUSjbjt=U6OpTFXEZsEJQ6zjcqCeqi6nSFOi=rN91zWmg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kvm: svm: Enable UMIP feature on AMD
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:33 AM Moger, Babu <Babu.Moger@amd.com> wrote:
>
> AMD 2nd generation EPYC processors support UMIP (User-Mode Instruction
> Prevention) feature. The UMIP feature prevents the execution of certain
> instructions if the Current Privilege Level (CPL) is greater than 0.
> If any of these instructions are executed with CPL > 0 and UMIP
> is enabled, then kernel reports a #GP exception.
>
> The idea is taken from articles:
> https://lwn.net/Articles/738209/
> https://lwn.net/Articles/694385/
>
> Enable the feature if supported on bare metal and emulate instructions
> to return dummy values for certain cases.

What are these cases?
