Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1721C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F7A205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567094759;
	bh=FG8d4a3h71LpL87UYvSzdLwAtQxizOpK0AdUZANpR3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uvpm1iHdWtEdVuy+5PF52Ff8McDBYBTXrprHinmreBWqf8LqxsT+mhvHICiTUCfLn
	 B5rpuW5Gz1I/aD+vO2AS9TT70eEPyM+aC+cVd/AEOthCQMu+/wZgtN/leaCPSi3mUt
	 l9a6kw7HWvtZ1wg1T4YUtxuCNwJj/ytwxyY/XAns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfH2QF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:05:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36909 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2QF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:05:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id t14so3601242lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Osc1mf7K5cBOA23NneEW30SjiiTDj6GNMsWDl0iOhg=;
        b=RlmSVgpnb7UJ4wkvYHqk1Ep2+AI8vdz1gI6MoFUtgeFFWNRmVSSLZ8kRIVrm5WqpB0
         4tWwJ8w/tVUNjabdqyuGVnc2HGJ8wmHIfk0V8RMUQYWavpgi4E5/gY3aYZnfhZ4PY7dB
         3RDs8UGUbPykFjCkj5U9hXqWMTbHuKl6EyS84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Osc1mf7K5cBOA23NneEW30SjiiTDj6GNMsWDl0iOhg=;
        b=P9DFbAdHB/xLAQlM6uJZexnoyNy4mgVigxE+O1KOnMDCsUU0Yad7vjZzWBpsBDLzhV
         nGMx02WpF7hnAsuRa0YaXrI/uISB3ddv5aoYNI8gV/4j2a4RPGnobjsFhrrawoOklSSL
         VT9lZexIbXJ0MIJYMnpCTKC1XkM0mPdMPoyXp/Fd/AiARecI14ZRwEHGJ1Bb7eEBavMW
         p2Jgc1IXUFzjPUfCF3Bv+ijbxNnHE+Dop8bWvP4K/Tfaj7T3SzS4XYbnLvIznYdoTDWx
         NcShsql7gcB8FSGV2kt3GqY3YbivF2fyIGsDejTmauOAnr7l3d8NupZccYLkDW9TQE+c
         7SYg==
X-Gm-Message-State: APjAAAUxzOKT4mbs9cxj1OAZY8YP71a3zC2a7K3l1Heg/QmpGUl9NPHV
        pQtB9ad+MABdMQ87c3ocOIqmFUTGg64=
X-Google-Smtp-Source: APXvYqwp/57F4pZfRpc0ncu5Z9MzvUfL0U1NMxh/X9vRBKzO46WDV4KOfz8lkwosVyRPCgtxxs5rUQ==
X-Received: by 2002:a2e:894d:: with SMTP id b13mr6002518ljk.38.1567094755863;
        Thu, 29 Aug 2019 09:05:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o8sm407342ljc.49.2019.08.29.09.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 09:05:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f9so3523780ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:05:53 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr5907101lji.52.1567094752690;
 Thu, 29 Aug 2019 09:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 09:05:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihp7KZ_WjA16odsU7eGb-rUfg7J0rhqwhRoD0zjyGHpw@mail.gmail.com>
Message-ID: <CAHk-=wihp7KZ_WjA16odsU7eGb-rUfg7J0rhqwhRoD0zjyGHpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:32 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> But since we #define the identifier inline to attach some attributes,
> we have to use the alternate spelling __inline__ of that
> keyword. Unfortunately, we also currently #define that one (to
> inline), so we first have to get rid of all (mis)uses of
> __inline__. Hence the huge diffstat.

Ugh. Not pretty, but I guess we're stuck with it.

However, it worries me a bit that you excluide the UAPI headers where
we still use "__inline__", and now the semantics of that will change
for the kernel (for some odd gcc versions).

I suspect we should just bite the bullet and you should do it to the
uapi headers too. We already use "inline" in a lot of them, so it's
not the case that we're using __inline__ because of some namespace
issue, as far as I can tell.

One option might be to just use "__inline" for the asm_inline thing.
We have way fewer of those. That would make the noise much less for
this patch series.

               Linus
