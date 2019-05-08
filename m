Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4564EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59D21726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557349144;
	bh=wnn8mr3hv6F28DUzH65RauF5H5CR3zatNGNGIAcFYlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X+ZZ0hpI8f02TKKOp7M5kjQDJ7LpN64Jl6jTuxrFmin+mLuqw0xB/aoUkPiyQYAvg
	 Nus+k39XAAnYPWN8b45mdmGgkXjBMDorYaLZNfWvTsX/p1VSNNigoIACw4PIVnQsP+
	 i7LxWPk2IdABkq1g6CdNWGAa4GzvuRrPKzC0xJSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfEHU7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:59:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36710 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:59:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so8888903lfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVp1WyottRqZ9+kDNkl5m+DUf/QkhjWuWQymJTyFosU=;
        b=HMKAum8oc7qqjOyz0KKGmVDLRtliLfjtSEJJELkhU2c+Zo+4XmOMuN68bbshRQ1HMZ
         CTiGiT3IGyJE2PdccKqKy+R3mbogPJHH+OL3GhsJo4e+KC4bDf/32UUzvKPYPNzu0BBf
         01jmZJPdQ69jkOGMtHMEBwdbuYUIGz1skqkkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVp1WyottRqZ9+kDNkl5m+DUf/QkhjWuWQymJTyFosU=;
        b=JK2u4EnQSy8A+TLKzMrVzyBtIUM3peawwv2LNsSTl2GGMP6OGQ2K0Ge/ecOUB1ywrg
         mEZcmqLnUNVOpf04b2t3IGzNCosAoo4l9tPsTjq0EjXCCOEM57pk+qKCknTRqBHQ/pep
         adToUydWANSRiDeTl9cTUOHzo5/ai1Jy2RPaGb/mvu/bpBAMILQGYny+SLSpK9onnh/L
         RuCe5DpWFMtGfWR2S2aGufhPRSX6cGsBkf7bl5t6iTX8NkxEsvBnw5jSOYLi70JM9TqA
         8v/tiYXBq50YDhNqSGrLU0bfKW3Wi2Iu8A/fhBTpeql6GZfB3noclOvKZkAX0laBcsJX
         xX9Q==
X-Gm-Message-State: APjAAAXaV68XNDXPUcj0ZaAZb9AGrgdvj4tgihZjglDmrCZ2gjDhq/60
        qXi0FVn1YcqelNP70MhDuXtACs/Pi0s=
X-Google-Smtp-Source: APXvYqzH/i7oV7pGXHDgqK/64OpsfnTAHl/YIxBoVqFBDTJaWdlifHHPBtqzVZTGMEy6mSFOUucQ2w==
X-Received: by 2002:a19:f703:: with SMTP id z3mr108952lfe.1.1557349139975;
        Wed, 08 May 2019 13:58:59 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x76sm4160241ljb.17.2019.05.08.13.58.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:58:58 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s7so147554ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:58:58 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr6921501ljh.22.1557349138137;
 Wed, 08 May 2019 13:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190508074901.982470324@infradead.org> <20190508080612.832694080@infradead.org>
In-Reply-To: <20190508080612.832694080@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 13:58:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5EMx2vmLsFqLKmVtjFa6VnTs_MWfxX2N++CDd_UiOqw@mail.gmail.com>
Message-ID: <CAHk-=wh5EMx2vmLsFqLKmVtjFa6VnTs_MWfxX2N++CDd_UiOqw@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] x86_32: Provide consistent pt_regs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 1:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hated-by: Linus Torvalds <torvalds@linux-foundation.org>

I can live with this cleaned-up version. I'm still not loving it, but
at least it now tries very hard to simplify other code. You can remote
the hated-by.

                  Linus
