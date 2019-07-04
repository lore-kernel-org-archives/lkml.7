Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD9C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65B32184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562276983;
	bh=4Oop+fgc9SI+uFqoJJS6azVnvjBl/fumFqcQnaCZgdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oAnf80FcCDa0Ce5zgMGMp5dMEjl5XW8krnRckb5IP2iFGz1pIB2EgtSMUBnQnT4Ml
	 MgNomSpC4ia6wlvYW/tU1Xou0y4xpv3QFwnwxCpMzCevjWyoyU78CIr7Ryn2zM6AAB
	 vqDLqmFj18TbI1UlsySswUIMSRVNv3NiDyR2yE6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfGDVtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfGDVtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:49:41 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05022218AD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2019 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562276980;
        bh=4Oop+fgc9SI+uFqoJJS6azVnvjBl/fumFqcQnaCZgdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S9iWw85uWtA+Coopms+3t7MAKZ1pfhxYWeplOkbF+lw5LdNIEoOeN34krsOZ1zIal
         o810hvzq0xoVj0YVZYRpa5wJyKoCcBgA8Vmrt1lp4SwO/GNjJOSQH9WQJKlQMkKP5y
         BR9ssPXg7LQbsmdaZZjVbGCQT6beuK1cK2V0XHKA=
Received: by mail-wm1-f43.google.com with SMTP id z23so7388418wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:49:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWyXMXeyaal+KEzIjF8M2IvOvN+lQDPo/T3LZ6hUXlwMp6bOtwC
        xjY7CDmjiaH8aUlLlcz7AalqD/cHjO/KpcL2YQRJ1g==
X-Google-Smtp-Source: APXvYqzYD/o8dowUtje83OnTt+L7DWaFV73zsiWhAhkLoxgyL0zUpr+cuxsp6Q1WSllrZaRCehcYqsj4MQ++LCeP+WU=
X-Received: by 2002:a7b:c149:: with SMTP id z9mr139902wmi.0.1562276978597;
 Thu, 04 Jul 2019 14:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.306303504@infradead.org>
In-Reply-To: <20190704200050.306303504@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Jul 2019 14:49:27 -0700
X-Gmail-Original-Message-ID: <CALCETrUJeOPvujnx--ZLQXJAaj0x8YEjftdt-rR=UiVijCrvcg@mail.gmail.com>
Message-ID: <CALCETrUJeOPvujnx--ZLQXJAaj0x8YEjftdt-rR=UiVijCrvcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] x86/paravirt: Make read_cr2() CALLEE_SAVE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The one paravirt read_cr2() implementation (Xen) is actually quite
> trivial and doesn't need to clobber anything other than the return
> register. By making read_cr2() CALLEE_SAVE we avoid all the PUSH/POP
> nonsense and allow more convenient use from assembly.

Wow, this is incomprehensible! :)  I'll trust Juergen's review.

--Andy
