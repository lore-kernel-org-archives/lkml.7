Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D61C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBF12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gKRtWWGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfEUSJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:09:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfEUSJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:09:02 -0400
Received: from cz.tnic (unknown [165.204.77.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 819B11EC0A6C;
        Tue, 21 May 2019 20:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558462141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gXUfsJPPjyhWdbSDhgOu4fBLlmMRmcDQJ/8G4/xdGUM=;
        b=gKRtWWGpaa58ggMpqsx5YcdaQvz0P4gZMiGSObW5QbNvINkYGtmQAemYfBd6UZBnHuH8FT
        fTguA8ATQMpTXVhjwRcaHKxeCOiwUalaibPW0Qrd7TkSDnbh2+hxYi4HtfHULW4UWnqYgk
        +Lb9Z8bvf1/35CDVZZciZKCtmF2P2BI=
Date:   Tue, 21 May 2019 20:09:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
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
Message-ID: <20190521180855.GA7793@cz.tnic>
References: <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
 <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:02:59PM +0800, Kairui Song wrote:
> Hi Boris, would you prefer to just fold Junichi update patch into the
> previous one or I should send an updated patch?

Please send a patch ontop after Ingo queues your old one, which should
happen soon. This way it would also document the fact that there are
machines with NVS regions only.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
