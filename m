Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B393C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BBA20838
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562449304;
	bh=KLyuPOeHEk7KeAkWB300YDHuZ8VNSXjajONMAP+HdCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D5PgRQ34fSrdMh7jK8E55UWK1daYmp6HOAfvd5l3j3OySyB7DO8SnFFEWXTCn2HZC
	 CIQiqC8qwXmYnmzVpSoPHu9tG5iaugx74dNbPZj9Zzvs2eQi9PW9C5bFYRhOfiKhVz
	 THcShPjbJPBBM1nhWJzympSdLaCXfS1FGobn2TJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGFVln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:41:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39977 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfGFVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:41:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so2850093lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tEtD0lRCpf+jxYQ00teH9l4O5uQL9hDGsIbaVh4o1g=;
        b=FLWmBuqCo0tNZ4Q4mKPdaEUKusTehmF6WMwpxDDFujTGjtlZq925m25RCOdabL3BE/
         M5CZbYH5MIHH+Uy1BP+PfExtwoW+oNbE+UN9n6sAFkFpoKVa7p/ZIXUUK9Hvh4ETNSUt
         6P3eM0hsIsHWuyyY/x9jKiN/55dscxgOJXaZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tEtD0lRCpf+jxYQ00teH9l4O5uQL9hDGsIbaVh4o1g=;
        b=UTSxn+e6rJKZuMTiKTytE41udtMNDCDSr4ULOz7Sc+zYl5PE0ndyvxun1smMPQaVQZ
         VhBbk8yu1qz8TnHBLaruCW9iptKj7bzhfoZ1x4Aa3e/GCwy70ECXyA0WXAeUqYGDHwve
         dv4Q+Q50VcpnA6cD5KrSOwYuxP/oIK9AOAXrI1eZrFySsDo8Phfo1yl8Uk3p7/KhWOKB
         +EjiH5o/25O3Pz0m8nXUZqptgPVmnzI33FnH4smfMhN76uEpa5t/TVKoXfmEIFsGggZ3
         jszh0xQzNOcNHjwgNl83WWaF5upiToIyuyDZvJagFzTw5L/NMm3hudeYWlpmdh1TC2t2
         ecCQ==
X-Gm-Message-State: APjAAAVvuudqAftB6Js25/bYxMxEV7sFJfogsd2PO8q66JVrrRY2mbiD
        S2qiWdG7C2iidSD/BZkbgKhBmk8qtP4=
X-Google-Smtp-Source: APXvYqz4r1hZd+qWkRwMhPWDRsH8pSMO2UPwklp/7KhOhM1VT2zyCVy9rpAEuBnicQ2+VkVeAD1CEw==
X-Received: by 2002:a2e:5548:: with SMTP id j69mr5784352ljb.48.1562449300115;
        Sat, 06 Jul 2019 14:41:40 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u9sm2011191lfb.38.2019.07.06.14.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 14:41:39 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id p17so12376863ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 14:41:38 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr5981899ljk.72.1562449298743;
 Sat, 06 Jul 2019 14:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com> <20190705134916.GU3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190705134916.GU3402@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jul 2019 14:41:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
Message-ID: <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 6:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Also; all previous attempts at fixing this have been about pushing the
> read_cr2() earlier; notably:
>
>   0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
>   d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")

I think both of those are because people - again - felt like tracing
can validly corrupt CPU state, and then they fix up the symptoms
rather than the cause.

Which I disagree with.

> And I'm thinking that with exception of this patch, the rest are
> worthwhile cleanups regardless.

I don't have any issues with the patches themselves, I agree that they
are probably good on their own.

I *do* have issues with the "tracing can change CPU state so we need
to deal with it" model, though. I think that mode of thinking is
wrong. I don't believe tracing should ever change core CPU state and
that be considered ok.

> Also; while looking at this, if we do continue with the C wrappers from
> the very last patch, we can do horrible things like this on top and move
> the read_cr2() back into C code.

Again, I don't think that is the problem. I think it's a much more
fundamental problem in thinking that core code should be changed
because tracing is broken garbage and didn't do things right.

I see Eiichi's patch, and it makes me go "that looks better" - simply
because it fixes the fundamental issue, rather than working around the
symptoms.

               Linus
