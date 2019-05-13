Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557771449;
	bh=lPPXPrlCXnec9ArL5Smn4WZ7XgjTRPHq0b2cg72c7do=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QDvMBJ8UpBcIownyXHFsqDdx0zPSzTH8m0o3+61ZLSYUoPGMr7Qj2hR7EWgJ25Hyg
	 u3/InpKCCYm1wasCwWkb3e7UpWMrl033bgU5Km11PhkIJUz18z/Iz4EpzD45J5P10K
	 6VYDvHXeYTnVZ/1WFhfNHf9U0Ji8ituBfj/OSio8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEMSR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfEMSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:17:27 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FB42168B
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557771447;
        bh=lPPXPrlCXnec9ArL5Smn4WZ7XgjTRPHq0b2cg72c7do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M73groKWN7tiM88HUylA0BevMADMrkXxMAX5GrLV+GI8cDdt8upEqFbWjtmTbBtWf
         B1fbMLLC4Ig6Ha6q/7u8EsjeSgkgTLTRZg/th8dDdkCQSgF5F8U6hLZj14iprJmgc3
         c3GN5DwMXPdaJcryEnpckEV58wfnaOyIRu/KMP3g=
Received: by mail-wm1-f47.google.com with SMTP id x64so291169wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:17:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVN6Twft0DwaB/tm4RowrYa/wz11i6F2QtRFbTo2YY585CHlvgy
        Ntk/Ydm7Ugxy65kKVaXIJNNP9CXH5pqAR4I7rj+ERg==
X-Google-Smtp-Source: APXvYqx+EkWMgZAYXf7WLt7psTjiviAgkkYF4bdVHgGcH1wH1s9Zk+LiM9gHe43vF05EDuJif4nyuITlc2cZxxSsBDE=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr17403247wmh.32.1557771445393;
 Mon, 13 May 2019 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com>
In-Reply-To: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 11:17:14 -0700
X-Gmail-Original-Message-ID: <CALCETrVhRt0vPgcun19VBqAU_sWUkRg1RDVYk4osY6vK0SKzgg@mail.gmail.com>
Message-ID: <CALCETrVhRt0vPgcun19VBqAU_sWUkRg1RDVYk4osY6vK0SKzgg@mail.gmail.com>
Subject: Re: [RFC KVM 00/27] KVM Address Space Isolation
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I expect that the KVM address space can eventually be expanded to include
> the ioctl syscall entries. By doing so, and also adding the KVM page table
> to the process userland page table (which should be safe to do because the
> KVM address space doesn't have any secret), we could potentially handle the
> KVM ioctl without having to switch to the kernel pagetable (thus effectively
> eliminating KPTI for KVM). Then the only overhead would be if a VM-Exit has
> to be handled using the full kernel address space.
>

In the hopefully common case where a VM exits and then gets re-entered
without needing to load full page tables, what code actually runs?
I'm trying to understand when the optimization of not switching is
actually useful.

Allowing ioctl() without switching to kernel tables sounds...
extremely complicated.  It also makes the dubious assumption that user
memory contains no secrets.
