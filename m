Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D9C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0820872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TO/Bj+VS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfFFTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:20:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfFFTUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:20:12 -0400
Received: from zn.tnic (p200300EC2F1EFA00985DCAE74D76316F.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:fa00:985d:cae7:4d76:316f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAC1C1EC01AD;
        Thu,  6 Jun 2019 21:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559848810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yCNTMXZUE49/fLG5ZTMFnNHLY3mz38m+7qEFZfj0H2E=;
        b=TO/Bj+VSjGd7aN55WYzQsAVoI0w1RWmtV/Y3Oca5Ee5Bo5CYMyuw1/RTjCbvmPTiS5C/+m
        50n9PcQVLNmtYaN0vA+TogvG2TGeUoSl74biq77mKb+44bm2BU5PaQ0KLQNrtY3MKL9e3h
        KR/O+rKKNvNaZp3BemDaMJmU3y+WjIQ=
Date:   Thu, 6 Jun 2019 21:20:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Baoquan He <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190606192010.GJ26146@zn.tnic>
References: <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
 <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
 <20190521180855.GA7793@cz.tnic>
 <CACPcB9fg5RGXcBbESNnn9rV0DSoh4jYkVWZrdcRWay5KKAjLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9fg5RGXcBbESNnn9rV0DSoh4jYkVWZrdcRWay5KKAjLww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:49:54AM +0800, Kairui Song wrote:
> Hi, by now, I still didn't see any tip branch pick up this patch yet,
> any update?

Ok, stuff is queued in tip:x86/boot now. Please test it as much as you
can and send all fixes ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
