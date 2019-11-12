Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD0C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52CE2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573573045;
	bh=Gnaoe1THZvmm795ITxUa5d/3fC1nuVpSaUfMd8JIAIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G860aqWIVUQv3Ch+FYCbgPi5giUJgLvGr1mlAF7DEquDRuYRunLlUy7QrTlCTSiGV
	 hSxAhF9nncynz6aMvPTukDZ+CHpJ5nZaPoLE4bml0H6CFtFVDOsUoRbZx+0FAImi62
	 BbtM50fdPD28EOroseBjfpPD1ZoSdBAv+6f/eODw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKLPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKLPhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:37:24 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839A0222BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573573043;
        bh=Gnaoe1THZvmm795ITxUa5d/3fC1nuVpSaUfMd8JIAIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKQei/YXkLq4caWtZiOJ2rCpcHJPoCLYWCa/Np6ir1XFfVvF3NUOR5fxcS70Oa0QX
         yAcKKzpZ9Z9bjhjO1p43bYzKCUmzGc2OtOrdPOwJioHut/I7Zk+m1Ns58i8cDrCi5E
         e0xjQ8qtkKEviq2ZTT+YdOkP787QFBF9sOWSllTM=
Received: by mail-wm1-f54.google.com with SMTP id q70so3717724wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:37:23 -0800 (PST)
X-Gm-Message-State: APjAAAX7EV91Gc8umop06UbXCryjUMHF6LH9cjRBxIKgOKVYTD1ezFya
        Wc1yFo16Cy67f9WGcPY8T/Cgg7QQdp+ht/DMNM9ulg==
X-Google-Smtp-Source: APXvYqxGs/phv8Jvko+xj3aaFTP2LW5mH5dKn92+hLAZ0DKGL9mXzZLBXuaNxjQGkhkkVe8ZDrPpWid4hgRuyn7ffJw=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr4891245wmj.161.1573573042024;
 Tue, 12 Nov 2019 07:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223051.865129706@linutronix.de>
In-Reply-To: <20191111223051.865129706@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 07:37:11 -0800
X-Gmail-Original-Message-ID: <CALCETrWFyBbuxqQnnQhg0h_TkBZ666iDHiCVb6-X_yXFm-v7pQ@mail.gmail.com>
Message-ID: <CALCETrWFyBbuxqQnnQhg0h_TkBZ666iDHiCVb6-X_yXFm-v7pQ@mail.gmail.com>
Subject: Re: [patch V2 04/16] x86/tss: Fix and move VMX BUILD_BUG_ON()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 == 0x67) in the VMX code is bogus in
> two aspects:
>
> 1) This wants to be in generic x86 code simply to catch issues even when
>    VMX is disabled in Kconfig.
>
> 2) The IO_BITMAP_OFFSET is not the right thing to check because it makes
>    asssumptions about the layout of tss_struct. Nothing requires that the
>    I/O bitmap is placed right after x86_tss, which is the hardware mandated
>    tss structure. It pointlessly makes restrictions on the struct
>    tss_struct layout.
>
> The proper thing to check is:
>
>     - Offset of x86_tss in tss_struct is 0
>     - Size of x86_tss == 0x68
>
> Move it to the other build time TSS checks and make it do the right thing.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Andy Lutomirski <luto@kernel.org>
