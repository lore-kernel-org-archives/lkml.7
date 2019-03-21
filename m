Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E021900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553189020;
	bh=R02QTSkbXhNF39/NMhkWDhVYU6VJKb7LMOXsaMuY6gA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zz6OjgP6EqVrbDCN48WtLObz3zIO1dUo/jbuae/k5ov0AW68F9HLWVhHJExWWfCng
	 LGuKlQ/x30B5eBbfp1A5cSuEKdeCJTvOtXWLY7kas5IT0HZvcG08BGofOLOYGsgsQz
	 MTft3JszRDrhHblBwW8peISsrdCcv4CYcfqvArRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfCURXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:23:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44759 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCURXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:23:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id n18so5926989ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imTDpQqpJ9+XOpxXfYcZmQ5yPSDqpdK7Ha318oAPKGQ=;
        b=Z96ncrQ7CfLWI9TqEaS+3eiYJrfdzHArurR0VIGNebokzcEqQ65tle4l1os3jLIDHN
         cYiEynOaPxY0p580oMgXntn4WB0YeJ1R+RmE97WzcegJtkphmPxNJBWEPrFcEuc0IVWX
         r0xELSATrXlSoCfhN5C0CTwm4jz0RVV0MUgR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imTDpQqpJ9+XOpxXfYcZmQ5yPSDqpdK7Ha318oAPKGQ=;
        b=VHg7Zz82IUKo65EeiprGRIDbMPrMNrfZsMuJmYdyXmyHOhZW6Z5v7B5T+pogdViiKl
         vJhQq8ErrAegIrne6vVbrkC/axkRBCiVZBB1rd0AWpJcMaPDCMDBwZjwVpgq4b00o5n4
         /YJxrdkrRt6TNufVSPIi3nve0qfvH55Am3t80xpIrxHgwjS7T0AzmVWeKE/4xDDH2QmJ
         SVad1cVgDZ9Zj3EVN0VCf5frnK4e1WssOuV9E3ggSqzjx3sAealRbQQiQT/jJIM1rE63
         7q9g6gcOvPcPmHlbMj3gYk/lghL871LFBqkYmIGpe6ji95fRnvQPKKKvsYkey7dh8K9S
         z+vQ==
X-Gm-Message-State: APjAAAW288L04jR4VyufFoNKRfB1wbzyDRLEW8iqJwtprGBbMJKPTxLe
        SrAc6M6LsOp8rYsxleN5R0D3UhzrvN8=
X-Google-Smtp-Source: APXvYqyvxnpG9VYB5OEqOdFdQCZu5iZoq0ZCFdSxv/ycRr/ceNdarx6V97W59d8eV7JhLEtPDuVr7g==
X-Received: by 2002:a2e:b016:: with SMTP id y22mr2634235ljk.133.1553189015469;
        Thu, 21 Mar 2019 10:23:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u142sm1052469lff.14.2019.03.21.10.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:23:33 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a6so5181952lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:23:32 -0700 (PDT)
X-Received: by 2002:ac2:548f:: with SMTP id t15mr2763401lfk.166.1553189012448;
 Thu, 21 Mar 2019 10:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321095502.47b51356@gandalf.local.home>
In-Reply-To: <20190321095502.47b51356@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Mar 2019 10:23:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvxJjBBOmQSsrB-xHkc6xm8zGHsBRgpxh14UsEY_g+nw@mail.gmail.com>
Message-ID: <CAHk-=whvxJjBBOmQSsrB-xHkc6xm8zGHsBRgpxh14UsEY_g+nw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Looks to be an issue with the save_stack_trace_user() not checking if
> the address is canonical before reading it. I guess access_ok() doesn't
> check that.

access_ok() definitely does check for non-canonical.

But it only does so when USER_DS is in effect.

If you use KERNEL_DS, then you have to check the address yourself.

                    Linus
