Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D6AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18D20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IvjdXu9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfCYMYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:24:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47838 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbfCYMYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:24:21 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 716861EC0B86;
        Mon, 25 Mar 2019 13:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553516659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WqHyS+JkhvmQFE4Ip6LsuG7NWbvJD3Q1zgGfTQj1r+c=;
        b=IvjdXu9IQZWl58MfreMfXs4uJY1NmLBCHYeFwr0++Tt6nHySzCkbyRaMLRp94y0YtN2Xvv
        2SxM2b3YyC0OncGDppMT4u8zom/V036xE56z5XHdXIqZzp+bOZa9qVv92aN8xjH9nRKT42
        naV8x/di9/j9FDoJD8u5PP6xsh6qOpI=
Date:   Mon, 25 Mar 2019 13:24:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20190325122426.GK12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com>
 <20190322192800.GM12472@zn.tnic>
 <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:53:02PM +0800, lijiang wrote:
> In this function, i printed its values, and only got the value of reserved
> type, so i changed the IORES_DESC_NONE to the IORES_DESC_RESERVED.
> 
> In addition, after the new descriptor 'IORES_DESC_RESERVED' is introduced,
> the IORES_DESC_NONE does not include the IORES_DESC_RESERVED any more, it
> could miss to handle the value of the reserved type.

Yes, IORES_DESC_RESERVED is supposed to denote the e820 reserved type.
Why should IORES_DESC_NONE include it ?!?!

IORES_DESC_NONE is, well, an invalid, i.e., "none" type:

/*
 * I/O Resource Descriptors
 *
 * Descriptors are used by walk_iomem_res_desc() and region_intersects()
 * for searching a specific resource range in the iomem table.  Assign
 * a new descriptor when a resource range supports the search interfaces.
 * Otherwise, resource.desc must be set to IORES_DESC_NONE (0).
 */

> Do you mean i should never touch the three chunks? If i made a mistake, i
> will remove this changes next post.

I'm looking at the hunks below and you're changing ->desc assignments in
some random function which doesn't look like you know what you're doing.
Maybe it gets you what you want but it sure as hell doesn't look right
to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
