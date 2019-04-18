Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C46C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F43217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XEy5puxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfDRN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:26:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53372 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbfDRN0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:26:50 -0400
Received: from zn.tnic (p200300EC2F112E003868EF36058F9C84.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:3868:ef36:58f:9c84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22C5D1EC0380;
        Thu, 18 Apr 2019 15:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555594008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fVMDvZEZiCuGOnAjMQl6ngtpe23dJ0SmPq90J6AH18o=;
        b=XEy5puxF3DaO4zTv5yir99OePccTPj+rhmJXehwr9d4d9njPMEh6SVgmMJEWe8PbdcuYIw
        D2c/oyjM3LTkOZHLqtsCriCMKxDb+j4ATCz3pW3Q/xUmrZLmSiuuYrpaf2UQyxaXLVPhXI
        38RSi8h6WWFKlsh1b40XdtBwJhukkMU=
Date:   Thu, 18 Apr 2019 15:26:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190418132641.GJ27160@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
 <20190415154155.GH29317@zn.tnic>
 <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
 <20190418100138.GD27160@zn.tnic>
 <b04098df-5c4e-b8c8-3d8d-bab68a5e197a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b04098df-5c4e-b8c8-3d8d-bab68a5e197a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:17:03PM +0000, Lendacky, Thomas wrote:
> You could probably make this unsigned int for now since you're creating
> the new enum used to assign to this variable and it only uses two bits
> currently.

Right.

> > +	if (res->desc & (IORES_DESC_NONE | IORES_DESC_RESERVED))
> > +		return 0;
> 
> The IORES_DESC_xxxx enums are not bits, just sequential numbers, so you
> won't be able to test them this way.  You can probably get away with a
> switch statement here.

Ah, good catch. I thought they're BITs too. Oh well.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
