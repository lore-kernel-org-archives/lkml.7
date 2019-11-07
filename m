Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E14C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08126207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V31+97gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfKGOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:32:05 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37210 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfKGOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:32:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id v84so647053ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRYqa1o2NdhEBRGJeqYIB6zt6VJ6WLQd957CNIrLVtU=;
        b=V31+97gEuKcwS9OaNqcWuLxaf6Dk9IUdRwjbv1EpOWaTkrPxYHB2EW3c7/ri43Q6k7
         bwFNF/T9wGxfriCODN4BuqYv6VwhvwZPWBTV4Pn0+HUEPmow694LOsl9dm08jzg4mhod
         Lu5WoqEIQ7TCMvBtSirFujYbjNVn9mXg+n7ZwkwkNz2gJVMUk7E5ofu+1hUzGuG8liRX
         cTx09BiykjRuupe9Q5PDg6qJXwNkBE1dU1vBm8WzSLfnmHE/Bij8LTKZTUJJAYRdDGd2
         rbHLjCvp9ZGLmy3aZAkHGBw48R5p5w24mgg3G/2oeRwyxZGzAvUAI9fJkGYLmrWNlsea
         E+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRYqa1o2NdhEBRGJeqYIB6zt6VJ6WLQd957CNIrLVtU=;
        b=nLFXto8K8le5H1Tds4XLZgMK7sLHvHyTO2ODIgdLrPWcwcfns/Wvigj0WN/ZZUfdsz
         Mz/oA2vFX2dcp2TrF6Pg3sy2dcy3o8t9f+zcWa7LtYvbDKbD/S1csHpkfcurbcpWHXhc
         7u2mJ/E8ch/z6ROreEm8gSj2+uvb4xvWi0iq+KfwWYDsLerq05nb02TFuNnNOsNq98Q6
         7W7o3lYoDEQ3GfZMBNWP54bihZ/+kIFEF26F1r9oBJeWexZFXVk60/AdY8ubV3N6t5E8
         t03nX/8Pkua5VZm9weQT8RE8PAmnWUrqnV8kK9q3EQuyMClDfgxscUY1Q8PLtuAVqUEp
         8S+w==
X-Gm-Message-State: APjAAAVD7i1tPP3UAhIFMe3yz3M6pRUg4NuLD8NWXwbEpSATJIdtVzco
        VgPBVd4EXrfaXRL/aFHG0B8EGwTm
X-Google-Smtp-Source: APXvYqzwj902Tyd57AaG3em2GTwZ2M3cPNOVwCrB5xRjJO9YSPN56fPqFIVZ3t+1la8W6v+/h7rVzA==
X-Received: by 2002:a81:dd1:: with SMTP id 200mr2561355ywn.410.1573137122446;
        Thu, 07 Nov 2019 06:32:02 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id f194sm1343150ywb.53.2019.11.07.06.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 06:32:01 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id i15so1008734ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:32:00 -0800 (PST)
X-Received: by 2002:a25:cf55:: with SMTP id f82mr3672759ybg.203.1573137120264;
 Thu, 07 Nov 2019 06:32:00 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008d5a360575368e31@google.com> <000000000000cd76fb0596c1d41c@google.com>
In-Reply-To: <000000000000cd76fb0596c1d41c@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 09:31:24 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfVgPM4DZcvaRjDinoyg7cA+Pj4oCO-13+7PsFGrhuC+w@mail.gmail.com>
Message-ID: <CA+FuTSfVgPM4DZcvaRjDinoyg7cA+Pj4oCO-13+7PsFGrhuC+w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in _decode_session6
To:     syzbot <syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        johannes.berg@intel.com, Martin Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>, songliubraving@fb.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:42 AM syzbot
<syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Wed Jan 16 01:19:22 2019 +0000
>
>      bpf: in __bpf_redirect_no_mac pull mac only if present
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736f974600000
> start commit:   b36fdc68 Merge tag 'gpio-v4.19-2' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> dashboard link: https://syzkaller.appspot.com/bug?extid=e8c1d30881266e47eb33
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d42021400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d09f1e400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

indeed manually reproduced at e7c87bd6cc4e~1, failed to reproduce at
e7c87bd6cc4e. Also seems plausible given the stack trace.
