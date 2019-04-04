Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFFFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114AA2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="i04Bd3zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfDDOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:41:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfDDOlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:41:18 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64F601EC05DE;
        Thu,  4 Apr 2019 16:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554388877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/YZzw1RW81PhsLKH+mISk/ZZsfEZsoZCLh+7jR7MDYc=;
        b=i04Bd3zzYZswNXui3NDkomjcYFFvXM5Xo8SWfF8CMb7/vrWOb1mnl5OpLz0wMyzNlCFVb1
        sMJnKJ2HVQQ/OifjVdXbHRz/NJtllwiAOKH3aJyR8YjIimnAlEaqvszjKZX4ThbtFOsf6O
        eUgigJDeVdIJALWdzDoHSOtvtc9HZZw=
Date:   Thu, 4 Apr 2019 16:41:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404144115.GE22539@zn.tnic>
References: <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
 <20190404122425.GC22539@zn.tnic>
 <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:12:41PM +0800, Dave Young wrote:
> The early code hang can make people confused, it is hard to
> say what happens and not easy to debug.   But if we return 0 then kernel
> just continue to boot, and fail later because of no acpi root pointer, at
> least we can have some kernel boot log.

Is it clear from that boot log where we failed?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
