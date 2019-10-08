Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12351C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D9D205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZUOidlyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJHOvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:51:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfJHOvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:51:01 -0400
Received: from zn.tnic (p200300EC2F0B5100B1AE7F6CCC5C3495.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:b1ae:7f6c:cc5c:3495])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E03F1EC067D;
        Tue,  8 Oct 2019 16:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570546260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wtHryWZ8ayWLPjxGe3WnCrTRtLCRPBthFbWCMzbnUWY=;
        b=ZUOidlyf1yjWPz34QRHj1un7GbBqDHDfL2MMb7Lch1EIoV71wHq65o6pc5c8TyAGE2kqfB
        1qHymHmIxsSjKz19hFLDLVgGMhY0b31vCj+2u7OcwUTXZl1eaVT807BQRQufqRm4v+Md+B
        CfMXsdsCdeBXhFWRoC96DooOgJUS/eQ=
Date:   Tue, 8 Oct 2019 16:50:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191008145053.GF14765@zn.tnic>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.88332264.2@infradead.org>
 <20191008142924.GE14765@zn.tnic>
 <20191008104010.181c4927@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008104010.181c4927@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:40:10AM -0400, Steven Rostedt wrote:
> Seeing OPCODE_JMP32 and INSN_SIZE_JMP32 doesn't look like they are
> related to me.

But if it starts with OPCODE_ you know what it is - an opcode.
JMP32_INSN_OPCODE can first be shortened to JMP32_OPCODE and then having
instruction mnemonic start the macro name doesn't show they belong to
the same type of things. Ditto for the insn size.

But I'm way too busy to bikeshed so whatever...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
