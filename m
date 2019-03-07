Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91767C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6920851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="oeWffzbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCGSF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:05:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGSF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:05:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id o10so7288053wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2cUVK3inPrvRVB8kdEpi8hS70rK4dnI8SLL7DHrSvA=;
        b=oeWffzbDBkf7/O1cg7YjKOrZ+Q8JarUb0fE0P/xxCaSA1EEehlF5OIg2fooAiN9DN+
         SbM7F62YjK/ai0N8mpy/UHrQAHCD6hHRmX2tEybWkB/rxPHXHACVXnU4CSLYVR8psccV
         2B4Lh3bhp4hnL4XeEA+2vgveV+u5Nrhh4EBY8xRWv+Y7icJwbw0E5S4kn2v+BmP3v7/c
         cjUF4vXqNQsv/JHManj05FV2AHlVi+3CF5N02Jsnibi72Wbp/NULTpqQAWykfCtge/D0
         L/Lf80zA+HYnxNeO3dZJT6h7Bk1+SPrejZM2Tg3b2ALBATSN5HAg6JU5JOs49hs11pZU
         SJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2cUVK3inPrvRVB8kdEpi8hS70rK4dnI8SLL7DHrSvA=;
        b=VTk6nPE+Jt8OeNpGN+PufOpohsEHJ1OqLs39y2nV2LusG4QHbTtloD0b2kEqG4hzUz
         x3FqyiErkiYxdCCPD0mXXdiKU40+SVy+Rk18naxVydLHxeYkraZUydUu8+FgqOiKRAzs
         646B18xOQoa0y5tBvixjUlAlZr0BrBCoC+n08N05QIUqQA/iRZYHY8gdl89vF3RFWRTW
         CY29uDuJGHWDfrltG5FImRpkLcbQ8D3xvhVaayzW4CqSifDJJakWE1PeVXAlgqQoUyZ9
         6aGDBWcxB4Z0t7WDQhScnczfXwFBtZkLlv1lrsRMm/zVpjvDI8EAfQawv41yaqT1D87o
         TI5w==
X-Gm-Message-State: APjAAAXBCmjM7pOPvu+ABJ4Uzq1OvJgbj+auO1Q/uk5GsFMVxjNjNPez
        INuy+DI5/6i3VMJFYBhAcFseq2zaLCZ46cy6tmRZ9A==
X-Google-Smtp-Source: APXvYqyDAO5Yz6sUWH4t6YO+iLMkb1emAtyb/uEEUjbMd/18jLzo8773nSe0oFOsMgiS3R4QdqlNldfNxd55FD/RZ4A=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr6352585wme.83.1551981954362;
 Thu, 07 Mar 2019 10:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307115159.708180729@infradead.org>
In-Reply-To: <20190307115159.708180729@infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 7 Mar 2019 10:05:43 -0800
Message-ID: <CALCETrX8ZAQpqxA+aRA7gdT3or33wj2Lmj40khmHp59JO=AVVg@mail.gmail.com>
Subject: Re: [PATCH 07/20] x86/uaccess: Always inline force_valid_ss()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x3cc: call to force_valid_ss.isra.5() with UACCESS enabled
>
> XXX: move the callsite out of te AC=1 region instead?

Let's move it instead.  I looked at the code and it should be fine.

--Andy
