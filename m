Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF97206F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573683029;
	bh=tpUrEsltff8WpmsbUvxUefhH+njQsK1DW06jfDDhLcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hn0MB0T+bkI8fbG5W06px/mIzqhufHNqWeMqhYomkBO3YhaJ/zO2Xsccs+Xs3CEvu
	 AeNCRmh7VKYfBlfj6AF7p87hSnhi1F77fLGXDxx2bt0Ay7rromK8g9xZmXNkLYnnC6
	 uKlJDRGVW0wHxC4yA5J/KTdCjlZ9ZP8e1Ws+zWFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKMWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:10:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39632 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:10:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id p18so4361308ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1zMQg9x2+quU7c6dj26l16dpASxnQWLZmydmUaC3KM=;
        b=GjdF9KRD29TPy51zlv+jHE6g1MGXU72w8Fz2FjC59HVEdkEXOFsEkYQxHadVwMFOR8
         ZdLXM30tUP6XNNIyPWNpPAn8oYNEE57ryb6Zfh+ymwEyNaxyN594mDcbgIJF0cqOJ/Aq
         Hw0QZWR7LcRPglxFbogYFzPP0c04ARjV0oNaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1zMQg9x2+quU7c6dj26l16dpASxnQWLZmydmUaC3KM=;
        b=n7X5B74zTRRuszNd2EkTiwPMEMhP6EBU2lpyYvN93jVc6gr+SXHPfrlPXzE9NkR/Jd
         ck5kznDf+h03CFFJWp+rJuNsUurTXIXYp5WUh1Rk/KAwsRxs368los+6/prmRpqv87X7
         Q6LvabEzAMVeYklG9oivhEtaY6n+k7nxku5FxzLBkTgdMABBwDWpwuMIGL6ZXdEed2ix
         dD6MWnVbb1p1mIkhonD/w2Y4hOCE9Y/TC0fCmoZ0aFSnBUNsWdAbvHn8BJa6201qm874
         6xHEnMXQQUwKacbPWrZ80fQpL0azU1t2/U6z9ltiFzLQq1ph8n4JSbanxie8je6AEVHA
         fzOQ==
X-Gm-Message-State: APjAAAUO3zzAy6xCoct/WYIHUGEHVc10eleJTlZIm+HmmnQkDl665DwH
        +09jVUpbbN4H5Xab7GPgmfRvqoGdidk=
X-Google-Smtp-Source: APXvYqw6iZHKqI7DBExVO1WYorN+kfCIvD1KZBN6qZwga+fX7GTH06+oJkV5tMaEdYIL3Ae0gPAGHw==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr4252191lji.54.1573683024070;
        Wed, 13 Nov 2019 14:10:24 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t8sm1539521lfl.51.2019.11.13.14.10.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:10:22 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n5so4339611ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:10:22 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr4163916ljh.82.1573683022288;
 Wed, 13 Nov 2019 14:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20191113204240.767922595@linutronix.de> <20191113210103.911310593@linutronix.de>
 <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com> <alpine.DEB.2.21.1911132237410.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911132237410.2507@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 14:10:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjnqBneDpDoYBOtGE-+hV_-nUEGC6O71DwyCy9zD6RKQ@mail.gmail.com>
Message-ID: <CAHk-=wgjnqBneDpDoYBOtGE-+hV_-nUEGC6O71DwyCy9zD6RKQ@mail.gmail.com>
Subject: Re: [patch V3 02/20] x86/process: Unify copy_thread_tls()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> See commit: 64604d54d311 ("sched/x86_64: Don't save flags on context switch")
>
> We need "only" make objtool support 32bit :)

Duh, I knew that.

Maybe just a comment in the structure and/or the __switch_to_asm() so
that next time I forget I won't look like such a tool.

The "Save callee-saved registers" comment we have now in the 32-bit
__switch_to_asm() really is misleading and incorrect wrt the pushfl.

            Linus
