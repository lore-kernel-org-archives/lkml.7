Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D98C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A542075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553552042;
	bh=gptljuDKYtd4mBF7inngaQOoThcVckkYVNKZFHbmhYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o8Rfjyl9bWpF7F84bofXkuSemkVeVPzolVf0R+nDuD72rXDZeakwpYwf2hODdzpOK
	 G2+fFkq7qpR9nH/N4fhywpIwXjQoHt5v2KgbMlSQQPyxMkIU0xfwK/ltyz6TRVKYMD
	 41taCpcJhXlJ+X5RgsIKL5kkaTuh5RNfLGb7URWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfCYWOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:14:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45154 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfCYWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:14:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so9285437ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYHpnIVDKxmo6/3WilvIDPLEyb4Tfp7ExayQzfs9ItU=;
        b=X5pQijd2sCBbiFaZv9aOINBZAkjXG50xrGdu6/8gh9h2CggXiUhpetTONeM04KsBBF
         UhG2ENlH6PaHLFDngidjIDF5HFlqZR5/6PocyyQf84qd0bjbNFrf//+kG/3Dol9vOKKC
         w7wwVMsD00c286MEpwLfY6n8U8ebGLVKdQnLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYHpnIVDKxmo6/3WilvIDPLEyb4Tfp7ExayQzfs9ItU=;
        b=eYkJgkAhVhfrhItn5sjBLScLvqsbLauio5rTKRdkjqM/Y0A+lHBy4tPwraKKjelGH5
         VqBJA5roU5MFbw99TKvdjUNGzDgTLenuyM/BLKAImW9dotyBzFgK3Jdu90giRuvvh9Ts
         y8UJRUO8YduWOcH3MHq3KV4MkGZ7Fj06e80NxjWybaWoRDWZCx9GoVWd7jaGnQZoMBBU
         O0B+QoBOBMHkNYIhjarJJyIQgO4dFZlQQRnlvX4Y+zyxYwvJvAczjAcNazrge8f1T01t
         bJL95kRrlAusTav25qrUA/lPDR6D/yJZp1lh7fXKC6XDd0Bng6nRNSPokW19FBOn0ANX
         4CJQ==
X-Gm-Message-State: APjAAAXvcoqJaxY35jk/FhjkfxaHx72cUJpp4klMvRbiNaMJ7LqStZ2w
        82e3iA6v8eFdAXSHE/r2knc+aoRDhvw=
X-Google-Smtp-Source: APXvYqxLGdCHtrAx7CzRNrncM8K+Pq5a7kQT+AXHZkr+3d034r06QLW7N+dsDr/fCjpXlr6pBIdhMA==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr15301932ljj.166.1553552037735;
        Mon, 25 Mar 2019 15:13:57 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i24sm3689767ljb.31.2019.03.25.15.13.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:13:56 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a6so7179586lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:13:56 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr13455337lfl.148.1553552036163;
 Mon, 25 Mar 2019 15:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk> <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <f4eccb87-1ea2-c0d5-19db-d638f2c5aa57@iogearbox.net>
In-Reply-To: <f4eccb87-1ea2-c0d5-19db-d638f2c5aa57@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 15:13:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD-A_VsYC_OKcn30_ZsrLEE1CN7mnwZ803cvaFTdTTfA@mail.gmail.com>
Message-ID: <CAHk-=wjD-A_VsYC_OKcn30_ZsrLEE1CN7mnwZ803cvaFTdTTfA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> I'm fine either way, I think the rcu_destroy_inode would indeed simplify
> it nicely. In any case fwiw, here's what I'd have ready for standby on bpf
> side and tested as well. Decided to get rid of bpf_evict_inode() entirely
> since the only callback we'd really need is on final inode destruction:

Yes, this looks correct to me.

I think this is worth doing regardless. Even if we then make the vfs
layer add that rcu_destroy_inode(), that will fit very well with this
patch, and getting rid of the special bpf_evict_inode() logic and just
letting the normal vfs inode cleanup happen looks like the right
thing.

So ack from me on your

> Subject: [PATCH bpf] bpf: fix use after free in bpf_evict_inode

patch regardless of what else we might end up doing in this area to
clean things up.

                 Linus
