Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C973C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC7120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555700056;
	bh=b7ZyTOYZ8TntYKxdXZu0R3vC1HO1dQ6wVFQ/nhmFhYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VqTaWLE0yGkj/RDdp+UaTTbtLpBgwjAPlujSY369yPUM0O21zGvexFPsaFObpccNO
	 fgNCum7PyjumvLdNbcltDWKeKh3L6NWio6G638/lpN/x8oTijul+/TuS0ikJmy/CHq
	 uf0+QyjHojq5NZvxBAOgNPGg+Ws2Vcg9ams/PR9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfDSSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:54:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45864 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfDSSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:54:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so5329769ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKqzywgc1cp3koFgwyvN+bbYf8wKvWjrwVL97dRWch0=;
        b=BRP1MH8ZJP6lsutxZOLFNG4GYFhBIsbdK2ed6gbSxK7mzDPVeQq3HzdBSq8rehNBHO
         tyuVP6s9ypBDG/P3EqZLc/zpUwIcymc2seXeWZgwwohBeDRVIK5iKPyyp7wqc3rmAeKs
         tLDezz6iqMfU/4ZWvt/YGYxAVwsI8kf3OEVUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKqzywgc1cp3koFgwyvN+bbYf8wKvWjrwVL97dRWch0=;
        b=imceIAlzJLFIctkQni9hadRAwDGsVfbMT6p2JTGGc6jIQGaW5ypVUm4fHJY7d5s8Tb
         V//hGpap5l+0quL3CAGuTVNOZ9y+75T/I3HWrT3IsaKOwW5tcmSsXqrB26DYpUN7gfsq
         03xTpAgC4g3E7SfchS2tLf5/e+E20mxxOj1C8gJgGpmAwsfOdp+pe83SljV4IUVNKu+H
         JAVOxAX3hVDjadsX2C+lGoyGlg+Kys/XPjOmT9Lmyxk1loHWOvW8XjfKrCUDagPCOcQK
         7XO5h0KisJYsUz/fE+MhJikrnpkkwrWuwrG6zc39gsdEjJ3Db3I3gsZDiH4BpbdhIm+U
         nUJQ==
X-Gm-Message-State: APjAAAVmPH8vqWCuJqmcJ5k6CNVXF/p6Tmf+88gvngS4w1vXjYmXXoAE
        3KhNCGwzHsEbMwFyDGELAnr+iKjL0sQ=
X-Google-Smtp-Source: APXvYqxKiqHqpPN/Si3z5zV3mRRYa2dGjojIGJZeg9Fp6JhUiEYnQYDJR8zRepgU/Af5SoHV04ApAw==
X-Received: by 2002:a2e:9348:: with SMTP id m8mr3173067ljh.23.1555700050165;
        Fri, 19 Apr 2019 11:54:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t23sm1216190ljc.13.2019.04.19.11.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:54:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d12so4635546lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:54:08 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr3062928lfn.148.1555700048046;
 Fri, 19 Apr 2019 11:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190419145327.12736-1-mathieu.desnoyers@efficios.com> <tip-3c0f67279fb57568b436dece3aa20651aa6c5a05@git.kernel.org>
In-Reply-To: <tip-3c0f67279fb57568b436dece3aa20651aa6c5a05@git.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Apr 2019 11:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieuxm+B-Bmhcy+Sszqs6h=iTNMEP=TeSBFKxtnEsKHUg@mail.gmail.com>
Message-ID: <CAHk-=wieuxm+B-Bmhcy+Sszqs6h=iTNMEP=TeSBFKxtnEsKHUg@mail.gmail.com>
Subject: Re: [tip:core/rseq] rseq/selftests/x86: Work around bogus gcc-8 optimisation
To:     Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christoph Lameter <cl@linux.com>,
        Shuah Khan <shuah@kernel.org>, josh@joshtriplett.org,
        Dave Watson <davejwatson@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux@arm.linux.org.uk,
        Paul Turner <pjt@google.com>, bmaurer@fb.com,
        Joel Fernandes <joelaf@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:46 AM tip-bot for Mathieu Desnoyers
<tipbot@zytor.com> wrote:
>
> rseq/selftests/x86: Work around bogus gcc-8 optimisation
>
> At least the following versions of gcc-8:
>
>  - gcc version 8.0.1 20180414 (experimental) [trunk revision 259383] (Ubuntu 8-20180414-1ubuntu2)
>  - gcc 8.2.0-7ubuntu1 (Ubuntu 18.10 (Cosmic)),
>
> generate broken assembler with asm goto that have a thread-local storage
> "m" input operand on both x86-32 and x86-64. For instance:

Is there a gcc bugzilla for this? Shouldn't that be mentioned here?

Also, we use "asm goto" together with "m" all the time in the kernel.
In fact, it's the most common case, with the RMWcc ops being generated
with that. I realize that we don't use the gcc thread-local storage
for them (we often do use our *own* thread-local storage), but it
would be good to have that gcc bugzilla to see why it can only affect
those user level "__thread" cases..

                    Linus
