Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B642C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F2B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eSmgO6DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHLMiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:38:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58618 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfHLMiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:38:03 -0400
Received: from zn.tnic (p200300EC2F06270038B9220C3BC92516.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:2700:38b9:220c:3bc9:2516])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6522C1EC067D;
        Mon, 12 Aug 2019 14:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565613482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SaArodZx+5q7Iuxt2E8Pyvzs8NOQXSzRyvMaHdT3syI=;
        b=eSmgO6DXKEyca86l5+4J4tIVGCZ/wU4V9IB66NTCZ71OAAM2iR8Wb1scWcC33SOpXpN7MB
        To8Tyy7l39W585Yf4gFkhLT/H5R4fBkf3FGThVe9LoUmumsD8FmviH4Gpuk7IMaZukXl67
        0DBk5dI7EgOvPkrtT8od+y5oD2qAYq4=
Date:   Mon, 12 Aug 2019 14:38:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Message-ID: <20190812123847.GC23772@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-3-rrichter@marvell.com>
 <20190809131559.GF2152@zn.tnic>
 <20190812064147.5czmkj7e6hxgvje3@rric.localdomain>
 <20190812073221.GA23772@zn.tnic>
 <20190812120517.2kktugib244ujgvb@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812120517.2kktugib244ujgvb@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:05:25PM +0000, Robert Richter wrote:
> So for masks in the range from 0xffffffffff000000 to
> 0xffffffffff7fffff we have grain_bits set to 24, which corresponds to
> a grain of 0x1000000.

I don't think you're reading what I'm trying to say so let me go into
more detail:

I'm very suspicious about any and all information we get from firmware.
I think that is clear why by now.

If we get an address mask, we better sanity-check that mask. For
example, whether it is contiguous or whether the set bits in it are even
making any sense and so on.

What you're doing is assuming the firmware will give you a sensible mask
and you start working with it without checking it.

For example, if you get a mask of 0xffffffffff00ff00, how do you know
that the grain bits are really 24? Says who? There's a hole in the damn
mask so it could just as well be *anything* *but* an address mask. Hell,
it can be some random garbage.

Do you catch my drift now?

But, since we don't use the grain all too much and don't depend on it
yet, we keep it simple and lazy for now:

> > "I guess we can leave it like that for now until some "inventive"
> > firmware actually does it."

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
