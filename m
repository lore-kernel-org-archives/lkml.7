Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F8020862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557850725;
	bh=ep1Sn4wytJYdkhKNE/+DKp2Dox3E1xF5zHKkoiEtkwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NJjSK73bb3T84MJk+3qfyIfDeefils4y8gws0zLmYNOFgdJaue/+jLlwSIyEFigZG
	 DiXwTZaA61dPYb40D1S2UKp1S1zC1mt5Bon2V/V9mqhpBZ9jvy9dPf4zA9axXdOJtO
	 DbaQGg92HkYMty3UajCPa6ZfnU29u53gvDzXlVgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfENQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:18:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:18:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id z1so14899018ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HO0cnBM0dn7BVUw2B8mMBOcjVqtIjYAhv4NF4GvQNTw=;
        b=cpfwfbRyqVxPcSivVQTYAkFsUt14IzV28F82+YoNcSVOGlqkabWnL8g5roVVkGBNgU
         I2rI0AkpuG5BkBqvH6buk0MtJV7fiWLwUL6hzZd31x+OPykwOsxjwMPpYRC1BHGh4H3X
         KX+PXRNVyYJRn/+ZyvzNhaBBOXjItKQ5yJLnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HO0cnBM0dn7BVUw2B8mMBOcjVqtIjYAhv4NF4GvQNTw=;
        b=GjSPq/O50v7ZQkZy0BmpsXGkiYjvu6dsGy6TocopuJaWbi0drw/rfz5ecdOGD4Qr8x
         5JiMl6z4nlLExwJZz0e+Sa7zOU11i0j2eA+N/Kbnkuf8Cto7BiQPlpX4ymOIHyxFMBmK
         +3p9ySLxSKHvQqUshrh5IxNu9RlLnIUUgapv6cCEzjF9XJSn5Y32xylKDc96G1kem8Fq
         Sf/ozok2ADS38PRAU24fTMyIQ2iKGMweanJu9jtmnf9+/ZWXEsNxO+16mQPiEQMOkPQe
         c+Xm8manyiTf1abXbKRlYr3u+NBIDnZ2DUKPwudGzV0JtJy2WUEehgchgGOIyVzSiVQp
         RTdQ==
X-Gm-Message-State: APjAAAUr3MBvhXTCAPNDGrwFN4Q7wcN0TWdfCSfhjzuITQi9oUQNnroV
        fQBkCLkhDPrrYJcdh2lsbTKYGklIApk=
X-Google-Smtp-Source: APXvYqydod4xkmVQEoid3JXReMb6jvlpYcOgxuWhcI88mqigh4c/nsyKn6uHu8b4GW43vRWF5n9YMw==
X-Received: by 2002:a2e:964a:: with SMTP id z10mr8267781ljh.22.1557850721902;
        Tue, 14 May 2019 09:18:41 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b23sm3879828lfg.41.2019.05.14.09.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 09:18:41 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y19so12355608lfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:18:41 -0700 (PDT)
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr17174747lfn.148.1557850250052;
 Tue, 14 May 2019 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424123656.484227701@infradead.org> <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop> <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net> <20190425091258.GC14281@hirez.programming.kicks-ass.net>
 <20190514155813.GG2677@hirez.programming.kicks-ass.net>
In-Reply-To: <20190514155813.GG2677@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 May 2019 09:10:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
Message-ID: <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     huangpei@loongson.cn, Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 8:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So if two variables share a line, and one is local while the other is
> shared atomic, can contention on the line, but not the variable, cause
> issues for the local variable?
>
> If not; why not? Because so far the issue is line granular due to the
> coherence aspect.

If I understood the issue correctly, it's not that cache coherence
doesn't work, it's literally that the sc succeeds when it shouldn't.

In other words, it's not going to affect anything else, but it means
that "ll/sc" isn't actually truly atomic, because the cacheline could
have bounced around to another CPU in the meantime.

So we *think* we got an atomic update, but didn't, and the "ll/sc"
pair ends up incorrectly working as a regular "load -> store" pair,
because the "sc' incorrectly thought it still had exclusive access to
the line from the "ll".

The added memory barrier isn't because it's a memory barrier, it's
just keeping the subsequent speculative instructions from getting the
cacheline back and causing that "sc" confusion.

But note how from a cache coherency standpoint, it's not about the
cache coherency being wrong, it's literally just about the ll/sc not
giving the atomicity guarantees that the sequence is *supposed* to
give. So an "atomic_inc()" can basically (under just the wrong
circumstances) essentially turn into just a non-atomic "*p++".

NOTE! I have no actual inside knowledge of what is going on. The above
is purely my reading of this thread, and maybe I have mis-understood.

                  Linus
