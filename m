Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB028C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80606212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ouhlv+Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfFGSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:10:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37727 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbfFGSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:10:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so791411pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RdV7PbyVkSYhNsrYGZ8E6Uu22GQTdcJL5heT1Y0FTF4=;
        b=ouhlv+SddShDf250mCEoGIo+nD3wsUaOV8r6iUvcyecJcT9BKaJsjGfcoib34GTjau
         JT5IqYoZJKDp2aMvAewcsfHqE4lEpdXwGIHjhGdrKrf0uwHZZKeEEigdG3cDgaaAnFAY
         Dt4tvCwXwQVTsAAwmNAey4AC4Wkam2ift6+jrAqcVRj3A2yqKNbXd4qU6pJGq+rbtUDf
         grmNyW+aaCuftmbdxMy23ItA3gtc+ssc26qODc9ED7fBm8jugx5GV203valW3JNmy2Sa
         1IDqY79wev5+F+rHZhr9eVmJKKN0bc3xldGbeyc6vrZyuzzGdh56q4HtSump1b8J1lNc
         YJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RdV7PbyVkSYhNsrYGZ8E6Uu22GQTdcJL5heT1Y0FTF4=;
        b=rd545R3l5f5G0iqdWoBZnLnhDGJxbiN6yjshC0oKFVok/nDEtkDDRwuHdb+ZT2NYcE
         jBrKLIQsMtV7DteDDtYLJxahbbGfhY1ojXK5/Av8hETNipBXN55jk3pLhc2uNAjK42Z6
         KhbRcYJKdzG+aFyqLFbIHIHXhMP2+ceGKr/ZuUWYd/iBZ9gOQZUoEUMUrZp1N5xXeSE/
         uIAY6pf96gmwutWuPqXp8DIuwxSWC2BBbCREPTfDKcKKyFvfmBx+SQIJLhJOo+zE9XCM
         ZxmrKl4/laNo6UINn7SiOSzGoSUt/lgq0ItqRVRgX/InouMmAilhAtkCCwag2Iok7RJE
         xuMw==
X-Gm-Message-State: APjAAAXVSNF9WwZ49sK6AHtFsLPE0e5utzN8GclJK9oEaoopRrJ+Ff0J
        nQbgd//IIGYxOhVYZAYJ1P2ewg==
X-Google-Smtp-Source: APXvYqwkUcL6yKwRhj7ZSLiEepZIDDJGiNTbd1sAki2fQ8TvQr1QVnYevXUeeY4S+Y9oFzS8hvri8g==
X-Received: by 2002:aa7:9f1c:: with SMTP id g28mr37489871pfr.81.1559931021677;
        Fri, 07 Jun 2019 11:10:21 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id j14sm2905412pfe.10.2019.06.07.11.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:10:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190607173427.GK3436@hirez.programming.kicks-ass.net>
Date:   Fri, 7 Jun 2019 11:10:19 -0700
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
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
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
References: <20190605130753.327195108@infradead.org> <20190605131945.005681046@infradead.org> <20190608004708.7646b287151cf613838ce05f@kernel.org> <20190607173427.GK3436@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 7, 2019, at 10:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Sat, Jun 08, 2019 at 12:47:08AM +0900, Masami Hiramatsu wrote:
>=20
>>> This fits almost all text_poke_bp() users, except
>>> arch_unoptimize_kprobe() which restores random text, and for that site
>>> we have to build an explicit emulate instruction.
>>=20
>> Hm, actually it doesn't restores randome text, since the first byte
>> must always be int3. As the function name means, it just unoptimizes
>> (jump based optprobe -> int3 based kprobe).
>> Anyway, that is not an issue. With this patch, optprobe must still work.
>=20
> I thought it basically restored 5 bytes of original text (with no
> guarantee it is a single instruction, or even a complete instruction),
> with the first byte replaced with INT3.
>=20

I am surely missing some kprobe context, but is it really safe to use this m=
echanism to replace more than one instruction?=
