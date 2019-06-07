Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A37C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2C20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iVHpk3hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFGUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:24:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57631 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfFGUYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:24:30 -0400
Received: from [IPv6:2601:646:8600:3281:84b2:b0c:3049:ccfe] ([IPv6:2601:646:8600:3281:84b2:b0c:3049:ccfe])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x57KMeeV2644168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 7 Jun 2019 13:22:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x57KMeeV2644168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559938972;
        bh=ne0jc3kRZK29kv4U15wWU4x86yG5oGXYcHvoXYZq1Qs=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=iVHpk3hZET4fJNgfFIVgmGMF1UWexTvYsBix/DgxyFnREUMGcT2oXQjKaNIkTNT13
         De/ERe0Uzu/XEwyteklpHdL+pxJKozBJawSBkStPLkMwyHZMs3kKz+iBidgDUGN489
         9OQ1wSxnF7BktoeZ9jRa/DorFQGF5zvShAF8xJugKw9v9ENAKmEUUAGIqpPkFzRkvH
         +f0V8ICD1J1O11HJzVMgK/rB5tJBlrEwdCmElVarxTpIMllo+4lJyC86+YUFcTbvB+
         g/AMo8H1SS2T9+7XZKRYrUPMWlOZucbXao4YEyuW4fJizIFXdgDH23z9qNupDAdU6s
         S0dUFxTop/aYw==
Date:   Fri, 07 Jun 2019 13:22:31 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
References: <20190605130753.327195108@infradead.org> <20190605131945.005681046@infradead.org> <20190608004708.7646b287151cf613838ce05f@kernel.org> <20190607173427.GK3436@hirez.programming.kicks-ass.net> <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
From:   hpa@zytor.com
Message-ID: <E4AE85BE-FB3B-45BE-8E1E-DD27E2520A4C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 7, 2019 11:10:19 AM PDT, Andy Lutomirski <luto@amacapital=2Enet> wr=
ote:
>
>
>> On Jun 7, 2019, at 10:34 AM, Peter Zijlstra <peterz@infradead=2Eorg>
>wrote:
>>=20
>> On Sat, Jun 08, 2019 at 12:47:08AM +0900, Masami Hiramatsu wrote:
>>=20
>>>> This fits almost all text_poke_bp() users, except
>>>> arch_unoptimize_kprobe() which restores random text, and for that
>site
>>>> we have to build an explicit emulate instruction=2E
>>>=20
>>> Hm, actually it doesn't restores randome text, since the first byte
>>> must always be int3=2E As the function name means, it just unoptimizes
>>> (jump based optprobe -> int3 based kprobe)=2E
>>> Anyway, that is not an issue=2E With this patch, optprobe must still
>work=2E
>>=20
>> I thought it basically restored 5 bytes of original text (with no
>> guarantee it is a single instruction, or even a complete
>instruction),
>> with the first byte replaced with INT3=2E
>>=20
>
>I am surely missing some kprobe context, but is it really safe to use
>this mechanism to replace more than one instruction?

I don't see how it could be, except *perhaps* inside an NMI have, because =
you could have a preempted or interrupted now having an in-memory IP pointi=
ng inside the middle of the region you are intending to patch=2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
