Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D55214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKSJrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:47:52 -0500
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:47:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED2A1FB;
        Tue, 19 Nov 2019 01:47:51 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0833F52E;
        Tue, 19 Nov 2019 01:47:50 -0800 (PST)
Date:   Tue, 19 Nov 2019 09:47:47 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enrico Weigelt <info@metux.net>, Ram Pai <linuxram@us.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] powerpc: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191119094747.4asxwnmyrjy5d5io@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-4-qais.yousef@arm.com>
 <87h830d5n8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h830d5n8.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 12:19, Michael Ellerman wrote:
> Qais Yousef <qais.yousef@arm.com> writes:
> > The core device API performs extra housekeeping bits that are missing
> > from directly calling cpu_up/down.
> >
> > See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> > serialization during LPM") for an example description of what might go
> > wrong.
> >
> > This also prepares to make cpu_up/down a private interface for anything
> > but the cpu subsystem.
> >
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Paul Mackerras <paulus@samba.org>
> > CC: Michael Ellerman <mpe@ellerman.id.au>
> > CC: Enrico Weigelt <info@metux.net>
> > CC: Ram Pai <linuxram@us.ibm.com>
> > CC: Nicholas Piggin <npiggin@gmail.com>
> > CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > CC: Christophe Leroy <christophe.leroy@c-s.fr>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/powerpc/kernel/machine_kexec_64.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> My initial though is "what about kdump", but that function is not called
> during kdump, so there should be no issue with the extra locking leading
> to deadlocks in a crash.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

> 
> I assume you haven't actually tested it?

Only compile tested it I'm afraid. Would appreciate if you can give it a spin.
Otherwise I'd be happy to try it out on qemu.

Cheers

--
Qais Yousef
