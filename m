Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576176206;
	bh=PJyKfMalY0gpBEpyEjCuKvuwLGOUy0Zl0QRKgM0JWu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VaRefb8IIPmn1MRdiZxFqr5FLpdFxzDxL2HXoo0Ci+xK7cVAQVMDE+WXpjbOmCQNb
	 Dz04GkTCYUvpm9hPbfVz9Ll5SVtw7W1okfk/BW38isOmj2zWbdvS14L9xIN0cz38gL
	 MaHZ1PEeMTTa4FZ+CJFvuw4RYlwQ5JLgG1tSMLtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfLLSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:43:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33033 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfLLSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:43:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so3448697ljr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daP2x4GLzegqYAtGzoN/GqQWx/OgbUZpFEmzsIb9AuY=;
        b=ESVNK1Mwi4VakiBbtSIOLOxnFTfo9yicVGMiebqVDAAObXDl8gUPGjFP3V6AoTVKJc
         HXbX49wJTIP8gVq4DIOHImreynSyKqrAyaVA413Sj66yFki8qzqdppnMRHspROxc1wIy
         o3RYW91grmKJW3WGA8r4+DqCoBMnHPzXSZzsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daP2x4GLzegqYAtGzoN/GqQWx/OgbUZpFEmzsIb9AuY=;
        b=HBjX54aDP/54LJaMRDiuHzPczX2jFPeihUUZ5+nDnaUROOg7yeHjZ6RdwTPKW4AJK8
         Wbkv8AGbnnzF+4PPW57M4VLJgNvbHGVgC+Dcgch5B4XOwsAaeJCcV2wLCbxmTn2DoD/G
         6RDw+q4CsK3h7n9dQWn1docIms47+u9CoMSLvphVksoYv3PY3qDr6BCqqgyCvicNxExS
         GaO2BdsRf7oYjEaGioCks8IuKq6/EaJbIKqUSrDsM5lcJWLppSW9nct+uhHSFRXq5SvC
         F7qYO+SX5ZxGMzuAVXiw7LGiqXDfdcsg9KzbwUF31z4cplUj7Utt3772HtXuAa3UPDtk
         6FtQ==
X-Gm-Message-State: APjAAAUWqB5Y7Ij2XlDk3g/Ch3vFy0oSIGKtVLh2jBpX7RNj1bLCZ3s+
        6y1u4ZloqVd4azMLbIV9FMr2goV3Rbs=
X-Google-Smtp-Source: APXvYqw2ngl46VL0ZEy5KVACHVCvxKJiCiDVYcWsHA9wxgZuzngszZ9MGfRj2ktu7xhSdGPiWrliiw==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr6125805ljo.180.1576176202617;
        Thu, 12 Dec 2019 10:43:22 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w2sm3463385ljo.61.2019.12.12.10.43.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:43:21 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id n12so38211lfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:43:21 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr6694407lfi.170.1576176201157;
 Thu, 12 Dec 2019 10:43:21 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com> <20191212180634.GA19020@willie-the-truck>
In-Reply-To: <20191212180634.GA19020@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 10:43:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
Message-ID: <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:06 AM Will Deacon <will@kernel.org> wrote:
>
> I'm currently trying to solve the issue by removing volatile from the bitop
> function signatures

I really think that's the wrong thing to do.

The bitop signature really should be "volatile" (and it should be
"const volatile" for test_bit, but I'm not sure anybody cares).

Exactly because it's simply valid to say "hey, my data is volatile,
but do an atomic test of this bit". So it might be volatile in the
caller.

Now, I generally frown on actual volatile data structures - because
the data structure volatility often depends on _context_. The same
data might be volatile in one context (when you do some optimistic
test on it without locking), but 100% stable in another (when you do
have a lock).

So I don't want to see "volatile" on data definitions ("jiffies" being
the one traditional exception), but marking things volatile in code
(because you know you're working with unlocked data) and then passing
them down to various helper functions - including the bitops ones - is
quite traditional and accepted.

In other words, 'volatile" should be treated the same way "const" is
largely treated in C.

A pointer to "const" data doesn't mean that the data is read-only, or
that it cannot be modified _elsewhere_, it means that within this
particular context and this copy of the pointer we promise not to
write to it.

Similarly, a pointer to "volatile" data doesn't mean that the data
might not be stable once you take a lock, for example. So it's ok to
have volatile pointers even if the data declaration itself isn't
volatile - you're stating something about the context, not something
fundamental about the data.

And in the context of the bit operations, "volatile" is the correct thing to do.

                     Linus
