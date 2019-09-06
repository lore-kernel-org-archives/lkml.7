Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A2CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C66E20640
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j0z+LE85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfIFHrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:47:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732133AbfIFHrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:47:03 -0400
Received: from zn.tnic (p200300EC2F0B9E00D81CE8CF22720A06.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:d81c:e8cf:2272:a06])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 795EF1EC09A0;
        Fri,  6 Sep 2019 09:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567756021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kXsLjA6zXd8DcBcKRp3q4a5MOpKDcX1Fi7lO4aq/nhE=;
        b=j0z+LE85Kw78wgdn2dfqwfaa54eNdfaZx+dGoRSPLw2tZr8it+39Pvu3zM1x5BS6kz6lri
        E5PUQ/NycDIIgtbycLF3j6e4qKew4SoF98dWP9smHpFFvG2tkNzSV/8KRjhwnRuaIl6PQM
        i/4182e8DcEJ50NwtLYvxd6725+iPYE=
Date:   Fri, 6 Sep 2019 09:46:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906074655.GA19008@zn.tnic>
References: <20190829060942.GA1312@zn.tnic>
 <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905222706.GA4422@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:27:06PM -0700, Raj, Ashok wrote:
> Several customers have asked this to check the safety of late loads.
> They want to validate in production setup prior to rolling late-load
> to all production systems.

First of all, they should use *early* loading. I don't know how many
times I need to say that, maybe I should print it on T-shirts.

And then they can reboot. If you're thinking of the
"we-can't-reboot-because-we're-cloud" argument don't even bother to
bring it - I've had it more than enough and no, just because cloud
people don't want to reboot, it doesn't mean we will support some insane
use case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
