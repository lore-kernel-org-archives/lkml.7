Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92521C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD821744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557431066;
	bh=keqavFL8lhG4U0wtXuTx0jZyaWppSu4S6UmhqaneCVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YTU3IGrY84teYyglhrY1msHH7oI3m9629Iw9m6FiIPOCShcwYSoQw1ixJkmenaL/p
	 wOeRLA0U44r8SCUGDZgudp/8SqsHtudk9FROwvBbc2xyEKGK7Hz7Qs9NQqmG3lR8Gt
	 lS2nRWSUsXR/xhMNGZY8u5/b8JO1JD01m3Pft/JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEIToZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:44:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42660 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEIToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:44:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so3059947ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0/ym1mmNmKB3V1YI5EOYjWhKsAecqndDM3XjAmY7xo=;
        b=bZOYGPzrvaOvN0slWBOMz90ZRF+SlLVqUiZDaFCChf2fQxq0PUKb221LAKja6LTxBJ
         vjQTcLvfZgoMAmKrepLsCaUYETSKrfdHlf3EBymOyJAIA9F85DquAviSdeynNSEk8GxA
         PBFWijkYARHhptPYXGFYMCrqYPdMiEqlDwV3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0/ym1mmNmKB3V1YI5EOYjWhKsAecqndDM3XjAmY7xo=;
        b=XOe0YiB8mKYA2ioJ66oiEiNObNx+NOUMbGkqBnHIlCQ9B037vdeHmn+LYPi6C6czwc
         ZgXqzL8K8rI3hHEGsBevBTdUHPpbW8Z9zEYkkbjS0mEiqD26w3Ly/JMO2fQ8HJKfc2dt
         lPjJ7UyrESp0ugxRJnql5OaN72yRQL0IGShDEW9u4N9O1QPHRjWOV1wgbZejAS3y6+j/
         fivKpdA6+uZM2ne4xkdDd1px+/f+PEqgQNlvgcaoX8d1Vm6QaINp7wn6kIJG4JbU4dkm
         QrjaR2e2qjhi9Io+Ooex8wIihi1z1dbunF+Ymx305Xg4U+ECoM/Ge8E7WhSo9IULvp9C
         /V+A==
X-Gm-Message-State: APjAAAXf4lH3707ZTPoyoAO6KpEvYiQFJf1qr1WYskyvXOVauOvokihj
        v846aqTpEByZzi9lmQDq5nC4Arfd27g=
X-Google-Smtp-Source: APXvYqyz+3gYhECyraXZ6i4W6joVvTfOFp9viDTarjNZrL+7Mytx0NLWYpvg7ZZ5LwOONLTZkYjpiQ==
X-Received: by 2002:a2e:9747:: with SMTP id f7mr590919ljj.34.1557431061740;
        Thu, 09 May 2019 12:44:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v26sm552125lja.60.2019.05.09.12.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:44:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id n4so3070199ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:44:19 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1752057ljh.22.1557431059453;
 Thu, 09 May 2019 12:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com> <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home> <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
 <20190509142902.08a32f20@gandalf.local.home> <20190509184531.jhinxi2x2pdfaefb@treble>
 <20190509150644.13d4a046@gandalf.local.home> <20190509152840.7fd261a4@gandalf.local.home>
In-Reply-To: <20190509152840.7fd261a4@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 12:44:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=widET5dA_4xNQ=7cc7VbW9HMpXK6r06VmDEfX3=D6fXRQ@mail.gmail.com>
Message-ID: <CAHk-=widET5dA_4xNQ=7cc7VbW9HMpXK6r06VmDEfX3=D6fXRQ@mail.gmail.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 12:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But it probably would probably still be good to know why this fixes the
> issues you see.

Looks like a compiler bug, plain and simple.

The simplified case really simplifies a lot for the internal IR, and
has a single conditional that then increments a constant location and
returns a constant value. That means that any branch following code in
the compiler has a much simpler setup, and doesn't need to try to
follow any chain of condirional branches with the same conditional to
generate sane code.

But the code generation problem is clearly a compiler bug, although
I'd not be surprised if it's also triggered by whatever horrid things
ASAN does internally to gcc state.

                 Linus
