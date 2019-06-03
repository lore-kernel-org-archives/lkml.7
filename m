Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD68C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCE623C13
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559578071;
	bh=N24q+OA0cUS1PYG+PlwtAct6Qw8U0Wj3kZ8ZqWnnch8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fixEVwAcg9g+NQQcnxEB8/zga+aivCeRkOs8IN6ZCRWT71jOzkiZqPwkLp7Jtt7im
	 A2J3sqDz3+R9wCblNqgoDhmhSTLVENJX4mFMhfLK0QwdlNw1VCpe72v6sP/pHj805P
	 ZNvj5TdavfLz0ecOYnmn7ARhbp7MwvcAcjWJjLMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFCQHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:07:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34990 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfFCQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:07:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so16799487ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxJWbikYyn86QHCb0MwofCFDPmQed9mzRIadXSeX7vU=;
        b=Z2rW7Y52J1jlD/vdLzyZA3EE5ZKf8u+7QkfyHu0DdN3BFL0k8qRy5xZypKkCU/4QVp
         +V9e3HJeIoju1wARoAembK05/AsHz0rFh3AYCJO3uYP54sEvCqed8Mb5dRqEOMI34gWw
         O6AIkk+mUiIV/IIPKYXRJlzU0eZx96PLgqUzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxJWbikYyn86QHCb0MwofCFDPmQed9mzRIadXSeX7vU=;
        b=Ax974xg7+aMV3dobL47FPLtZukl0xXAaW2S1ej/rz17VnjJmSq8vWPoRaUH4AqJE0P
         3af5cIj/bp7eNY5SjhKJovWoRaEME4U3cwNhAQ8V2fYxPi3Ntf5OrQnaMHNxv8B/bBb/
         xpfk47664m0T2bAdcDgWE/5JAQrM19iqyPTVUFvAFiGbVAvK4R9uaacU0gYQKvfrI3tz
         U0imr0zNLkTC+R2I8irHrj3BrideDLe3FbWhmrRpF7ohn/pQAUxP74Fo9wexF5EfoD+f
         RZq87ed9CDbrdfPDogI4g0HnrU8TQ5toejsgQKohlJeVFidOBAby1jsz6qWoL3OfkJrM
         9dtA==
X-Gm-Message-State: APjAAAUBVjJ+Jtmxr1rafcv+3vvD90wI9de10EL+4Xeie2K1RQythEZo
        s72D7iA/hQ5KEavI8HfM8Auua0Az1eA=
X-Google-Smtp-Source: APXvYqxLnTbtvlIaXbigFB9WyyOcD+b07P3xTbeN5v0nOXpCz4q+GDWpoi7Os1FmwPqX4/+QeIX+PA==
X-Received: by 2002:a2e:2b11:: with SMTP id q17mr14351395lje.23.1559578067323;
        Mon, 03 Jun 2019 09:07:47 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z24sm3641805lfh.63.2019.06.03.09.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:07:46 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v29so5473673ljv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:07:46 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr14182608ljj.1.1559578065814;
 Mon, 03 Jun 2019 09:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20150910005708.GA23369@wfg-t540p.sh.intel.com>
 <20150910102513.GA1677@fixme-laptop.cn.ibm.com> <20150910171649.GE4029@linux.vnet.ibm.com>
 <20150911021933.GA1521@fixme-laptop.cn.ibm.com> <20150921193045.GA13674@lerouge>
 <20150921204327.GH4029@linux.vnet.ibm.com> <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au>
 <20190603000617.GD28207@linux.ibm.com> <20190603030324.kl3bckqmebzis2vw@gondor.apana.org.au>
 <CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 09:07:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZcrb_vQi5rwpv+=wwG+68SRDY16HcqcMtgPFL_kdfyQ@mail.gmail.com>
Message-ID: <CAHk-=wgZcrb_vQi5rwpv+=wwG+68SRDY16HcqcMtgPFL_kdfyQ@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 8:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't believe that it would necessarily help to turn a
> rcu_read_lock() into a compiler barrier, because for the non-preempt
> case rcu_read_lock() doesn't need to actually _do_ anything, and
> anything that matters for the RCU read lock will already be a compiler
> barrier for other reasons (ie a function call that can schedule).

Actually, thinking a bit more about this, and trying to come up with
special cases, I'm not at all convinced.

Even if we don't have preemption enabled, it turns out that we *do*
have things that can cause scheduling without being compiler barriers.

In particular, user accesses are not necessarily full compiler
barriers. One common pattern (x86) is

        asm volatile("call __get_user_%P4"

which explicitly has a "asm volaile" so that it doesn't re-order wrt
other asms (and thus other user accesses), but it does *not* have a
"memory" clobber, because the user access doesn't actually change
kernel memory. Not even if it's a "put_user()".

So we've made those fairly relaxed on purpose. And they might be
relaxed enough that they'd allow re-ordering wrt something that does a
rcu read lock, unless the rcu read lock has some compiler barrier in
it.

IOW, imagine completely made up code like

     get_user(val, ptr)
     rcu_read_lock();
     WRITE_ONCE(state, 1);

and unless the rcu lock has a barrier in it, I actually think that
write to 'state' could migrate to *before* the get_user().

I'm not convinced we have anything that remotely looks like the above,
but I'm actually starting to think that yes, all RCU barriers had
better be compiler barriers.

Because this is very much an example of something where you don't
necessarily need a memory barrier, but there's a code generation
barrier needed because of local ordering requirements. The possible
faulting behavior of "get_user()" must not migrate into the RCU
critical region.

Paul?

So I think the rule really should be: every single form of locking
that has any semantic meaning at all, absolutely needs to be at least
a compiler barrier.

(That "any semantic meaning" weaselwording is because I suspect that
we have locking that truly and intentionally becomes no-ops because
it's based on things that aren't relevant in some configurations. But
generally compiler barriers are really pretty damn cheap, even from a
code generation standpoint, and can help make the resulting code more
legible, so I think we should not try to aggressively remove them
without _very_ good reasons)

                      Linus
