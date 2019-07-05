Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5FC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E08C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562359067;
	bh=R/NZzyRB8n045WyDB+KpdTaWasPlNT5Oy3/V7eWIzqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dhzr5f2/f6CGn8Urirv6mKhIM54XInkVIWrvk7+M3lzrBGQ+QELxiKAwkltAiaUsD
	 OvBPVLHkP9cQ3vMbRe9fwDvEVF7jXhF7NtIyuTmgsMCcCPnKGD0LjYw8jDzIeM4ST1
	 3Ed3d+HyNo5g+OYyS4TSxygrOYHSg9KY1Gvu16IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGEUhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGEUhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:37:45 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6F821852
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562359064;
        bh=R/NZzyRB8n045WyDB+KpdTaWasPlNT5Oy3/V7eWIzqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vgxt420OxsPZ7jUL6hr4u5hltEsus7q8RHArHiTsTO87dnjmEiTXBKka0QiwCS69P
         jH8Qff/o0KfZJ8eVeJhMhB5MXNHE4XGJ+i8YXJE8pIIHBPaTDfJL0LSTar4FdpNIQF
         1WteLkIA/74U/B23jVgkxCGjuJh7w+e6Xid2Z/M8=
Received: by mail-wm1-f46.google.com with SMTP id z23so10829928wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:37:44 -0700 (PDT)
X-Gm-Message-State: APjAAAV9r79atmvSYYsXGNbqacJO62ecF4c3GHSI02uRMk7h/gRK5IL2
        JLXh2GUzFJRy0g1CViZ3Z4wClh6e4GWMILaqYJP/xA==
X-Google-Smtp-Source: APXvYqx39v6GFd5J7B93Up85PZEU+4O/70IAN8E8Eu4hDnNLTFCQ0okxdbCQ3exNN7CQ1j4Oo3ucbBGdx4/8pUZ9Lm4=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr4590144wme.76.1562359062690;
 Fri, 05 Jul 2019 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Jul 2019 13:37:31 -0700
X-Gmail-Original-Message-ID: <CALCETrWjTpGzJ7bS3p1hU0RPBs9eDg0ixpU2_rYXs6+nBQ1=fA@mail.gmail.com>
Message-ID: <CALCETrWjTpGzJ7bS3p1hU0RPBs9eDg0ixpU2_rYXs6+nBQ1=fA@mail.gmail.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more robust
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 1:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andrew,
>
> >
> > These can be addressed by setting TPR to 0x10, which will inhibit
>
> Right, that's easy and obvious.
>

This boots:

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 177aa8ef2afa..5257c40bde6c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1531,11 +1531,14 @@ static void setup_local_APIC(void)
 #endif

        /*
-        * Set Task Priority to 'accept all'. We never change this
-        * later on.
+        * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
+        * vector in the 16-31 range can be delivered otherwise, but we'll
+        * think it's an exception and terrible things will happen.
+        * We never change this later on.
         */
        value = apic_read(APIC_TASKPRI);
        value &= ~APIC_TPRI_MASK;
+       value |= 0x10;
        apic_write(APIC_TASKPRI, value);

        apic_pending_intr_clear();
