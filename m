Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF9120652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="baorS2Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfD2Hgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:36:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfD2Hgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:36:33 -0400
Received: from zn.tnic (p200300EC2F073600CC908F6B12A96C5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3600:cc90:8f6b:12a9:6c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FF101EC0A99;
        Mon, 29 Apr 2019 09:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556523391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ecj0aE6gq10rKox5w0C12D0qKcWWyug+xBLPklihyDQ=;
        b=baorS2QbQlfP18vTtOK0cVWrLq5HKuwlJ3nSCscAr8t9TBRZYApffFMdbzA7Htog2Qfk//
        xz9T4xLDXMcavQcOCdS9skoBKgNx7Huc/ylacMxvQU5GyJAxdakpWPmnASMO82vOk4Wcyt
        Et4112kvddtMy0zadeuSMWAOZH3usrk=
Date:   Mon, 29 Apr 2019 09:36:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Message-ID: <20190429073625.GA2324@zn.tnic>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
 <20190427085816.GB12360@zn.tnic>
 <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
 <20190428100309.GA2334@zn.tnic>
 <4c5ca6d7-ffb1-a5a5-9e46-9057802318e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c5ca6d7-ffb1-a5a5-9e46-9057802318e0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 09:24:12AM +0800, Zhao, Yakui wrote:
> Yes. "movq" only indicates explicitly that it is 64-bit mov as ACRN guest
> only works under 64-bit mode.
> I also check the usage of "mov" and "movq" in this scenario. There is no
> difference except that the movq is an explicit 64-op.

Damn, I'm tired of explaining this: it is explicit only to the code
reader. gcc generates the *same* instruction no matter whether it has a
"q" suffix or not as long as the destination register is a 64-bit one.

If you prefer to have it explicit, sure, use "movq".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
