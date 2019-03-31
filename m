Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F005C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5164F20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fkf01x+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfCaPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:12:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34516 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731211AbfCaPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:12:55 -0400
Received: from zn.tnic (p200300EC2F148A00A1B251568878E03A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:a1b2:5156:8878:e03a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D44351EC05C4;
        Sun, 31 Mar 2019 17:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554045174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=svyDCcgq3wXfxeVOLwOH7ifKj0fK/+lF/VXXIcI/l8Y=;
        b=fkf01x+dO1z/ZXsnjlKrrfSvwNzolzy1kieaSr6sfqEjEejlg3kZNlbMCA87/M2EjDkF+t
        03krVnV/HEv0FeFMAWc34FHcSzm/AIJpLMU+53sn8xnsEvDHRD1MFCsz7MFKP/Tjiq0Zau
        BO5Nvz+YoLWU+S5/U2WPQIj/aqPt7C0=
Date:   Sun, 31 Mar 2019 17:12:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 3/5] x86/kvm: Convert some slow-path static_cpu_has()
 callers to boot_cpu_has()
Message-ID: <20190331151248.GB15073@zn.tnic>
References: <20190330112022.28888-1-bp@alien8.de>
 <20190330112022.28888-4-bp@alien8.de>
 <2f71cb35-46b2-9ed5-28b3-c6eb5e647b46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f71cb35-46b2-9ed5-28b3-c6eb5e647b46@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 04:20:11PM +0200, Paolo Bonzini wrote:
> These are not slow path.

Those functions do a *lot* of stuff like a bunch of MSR reads which are
tens of cycles each at least.

I don't think a RIP-relative MOV and a BT:

        movq    boot_cpu_data+20(%rip), %rax    # MEM[(const long unsigned int *)&boot_cpu_data + 20B], _45
        btq     $59, %rax       #, _45

are at all noticeable.

On latest AMD and Intel uarch those are 2-4 cycles, according to

https://agner.org/optimize/instruction_tables.ods

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
