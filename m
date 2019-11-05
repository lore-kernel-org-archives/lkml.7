Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D257C5DF66
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE7521929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AdEtYm7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbfKEO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:58:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388842AbfKEO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:58:28 -0500
Received: from zn.tnic (p200300EC2F0EF00014F02C62D0694FB9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:14f0:2c62:d069:4fb9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C79DC1EC0C82;
        Tue,  5 Nov 2019 15:58:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572965906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ukquyBILKVfbO4SjqBe2FVU0Y8O1nG4L04w2gtXFP9U=;
        b=AdEtYm7TCtDhkmWzPhuAHMxWych/WpMnM3d4v8Un2zgsiA7PfYmottof0RpjhGu3xx4cUA
        4uD2crjiFFLtcFu6rj6lJiZiK6I1jRPt2oCrav789mERt/4bKD2VxOTlBrbEdStnA/15k/
        wGR4dg7miVBMm1bkEqGX9WfrBrL2OMo=
Date:   Tue, 5 Nov 2019 15:58:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Message-ID: <20191105145821.GD28418@zn.tnic>
References: <20191025211226.2444-1-rrichter@marvell.com>
 <20191105110511.GA28418@zn.tnic>
 <20191105141734.ubw5qegth3hdahls@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191105141734.ubw5qegth3hdahls@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to hold down what we discussed on IRC.

On Tue, Nov 05, 2019 at 02:17:42PM +0000, Robert Richter wrote:
> Here the bypass:
> 
> 1) Entering ghes_edac_register(), instance #1

That was a misunderstanding, I know what Robert means now.

> Right, there will be a parent device created for each instance. But an
> array is not required as this also can be part of the private data.
> Only some sort of list head is needed to collect them all.

Ok.

> I would rather avoid an own implementation of reference counting and
> also better switch from atomic_* to refcount_* which also provides
> range checks. There is no benefit doing this our own.
> 
> Any objections here for the renaming and using the refcount API?

None.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
