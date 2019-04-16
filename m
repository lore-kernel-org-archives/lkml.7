Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A166EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bjNw7WrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfDPJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:40:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfDPJk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:40:27 -0400
Received: from zn.tnic (p200300EC2F0D6900D0FA583685BBD9D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:d0fa:5836:85bb:d9d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D30C1EC030F;
        Tue, 16 Apr 2019 11:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555407625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f8up/2b93O/sh2BiKrHbGXEHljq83o9oPq4lXtZEX5c=;
        b=bjNw7WrLN/qbMbOQ8bmAtnmQFu6+cn8qLYv7REb7nI6lVT9LlnDXM4voa3tS5Y0edWsHdd
        J2SiEs8NEsJztAWL8HdbAin0eztRe3GR6I1bf6zgLguFMF25ukKxutUgH9+uoVvDNdBCC/
        sz2fbCjr04iG8jn5UHWhZo4FwSCTbls=
Date:   Tue, 16 Apr 2019 11:40:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190416094024.GE27892@zn.tnic>
References: <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:00:25PM +0000, Junichi Nomura wrote:
> I thought we should hang here instead of return so that we
> don't run into efi_get_rsdp_addr() in case of kexec.

Hanging that early without debug output is not very friendly to
debuggers, methinks.

> > +	ei = &boot_params->efi_info;
> > +	sig = (char *)&ei->efi_loader_signature;
> > +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> > +		debug_putstr("Wrong kexec EFI loader signature.\n");
> > +		return 0;
> > +	}
> 
> Same here.

Ditto.

You get the idea.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
