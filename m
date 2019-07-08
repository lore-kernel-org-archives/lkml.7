Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF1C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECAC2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfGHNtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:49:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:49:24 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkU12-0000w0-Qv; Mon, 08 Jul 2019 15:49:12 +0200
Date:   Mon, 8 Jul 2019 15:49:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Liam Shepherd <liam@dancer.es>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@chromium.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Cannot build 5.2.0 with gold linker
In-Reply-To: <CAB8B+d3QEJ4kqzXnT7xaE26F8qqREeNm2M2=DKv+2vUsTSu4sQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907081548160.4709@nanos.tec.linutronix.de>
References: <CAB8B+d3QEJ4kqzXnT7xaE26F8qqREeNm2M2=DKv+2vUsTSu4sQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Liam Shepherd wrote:

> Hi,
> 
> It results in this error:
> 
> Invalid absolute R_X86_64_32S relocation: _etext
> make[2]: *** [arch/x86/boot/compressed/Makefile:130:
> arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[2]: *** Waiting for unfinished jobs....
>   CC      arch/x86/boot/compressed/cpuflags.o
> make[1]: *** [arch/x86/boot/Makefile:112:
> arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:283: bzImage] Error 2
> 
> This was introduced under this commit:
> 
> 392bef709659abea614abfe53cf228e7a59876a4: x86/build: Move _etext to
> actual end of .text
> 
> The commit was reverted on 5.18 by Greg...

Know issue and the fix is queued for mainline, but did not make it to 5.2
for an unrelated reason. Will show up soon and be backported.

Thanks,

	tglx
