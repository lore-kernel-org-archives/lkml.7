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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B1B2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNUuOmM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfKGQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:59:22 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38361 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfKGQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:59:21 -0500
Received: by mail-yw1-f65.google.com with SMTP id s6so826617ywe.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OY3mL3SJty7WONSqI9Sp3mmm9hhK0YCgUyTwKH16DyM=;
        b=NNUuOmM7CKWjGHRTbNqGdtPWTCVZ0EOBnHBVZa3Du0rkbJ7FuAdoM+5baW/0stuk3E
         gCiivLgsL72BauezxIjWfOW69541tetppjNLpG2D95N8+F/Wn/SGBAKFTqnLiB7KU6Lx
         CX3qq1gGt+ByA9Y561UNZy9VW7qUxNA/RFLeIB6YzUt5jxNcSAniQlhV5waLfLIYwRmI
         CNEAmi7iXeMVT9AdY2V3t1FWvhKfmU8ccDR4oOIJ+vrikdE91d1U2H6AutP4iBv4Leoj
         +HqRPkKjWHec2HWsuDwlAK0V8pdoaeVsGF3xzqc4YUKmwU5Ea5BiwNPzJA4399Kyj9sf
         hYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OY3mL3SJty7WONSqI9Sp3mmm9hhK0YCgUyTwKH16DyM=;
        b=QVfVmAbuQ/YJmQxLxgoxOr/NDOT6oEw2RwoCmkap9MBMjat26rG6ClDMnHm6dI1vRG
         3xrgmb7vMnB+lvkCLxl6WpFymN6RZT/QnPfQlPon6hmJD9F0ZlZcMGnrRiyW5ZNK5iIE
         KfiETcXP0KYxg5nJQ4BtZwrRSyfkymzzGT6NOrQEU1WsQwSRFlPnjA/5HUJUJNrM029K
         VI8kA51B0aWX4Qu8gq2Riyujm+FsLv2poOaqp55BJwgUiWtVZ7Q3MlaUAIRRlenVT+LN
         ljZo5B/E1WrfJ5t/BUPW2M60D3jyJQ5UA8dN8lqKEA/049Hd/he/6ZYWY0/6v7EoHXBy
         dONw==
X-Gm-Message-State: APjAAAVa7VLOAp+RueGqFYbHAAh4Iy8ztcG3okx0BX5z7FWCBktqBtvO
        ALnMqfUmwnW2xgjYtWKBiZ/AjpNB
X-Google-Smtp-Source: APXvYqwywasLn6m/7m+9ngq7VemwIJGQsnD+MP7zkTDSAGK5hEfJpgVTJTKBUslwtz2IbJ0bLXpe5g==
X-Received: by 2002:a81:a303:: with SMTP id a3mr3070741ywh.244.1573145959312;
        Thu, 07 Nov 2019 08:59:19 -0800 (PST)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id j136sm750614ywj.17.2019.11.07.08.59.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:59:18 -0800 (PST)
Received: by mail-yw1-f41.google.com with SMTP id y64so830031ywe.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:59:17 -0800 (PST)
X-Received: by 2002:a0d:fe06:: with SMTP id o6mr1541900ywf.424.1573145957443;
 Thu, 07 Nov 2019 08:59:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f68d660570dcddd8@google.com> <000000000000e51d450596c1d472@google.com>
In-Reply-To: <000000000000e51d450596c1d472@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 11:58:41 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdz-+Hj2itAiC5uiP0X7aHP4YPG1+1k_bbE+OCBK+P0Rg@mail.gmail.com>
Message-ID: <CA+FuTSdz-+Hj2itAiC5uiP0X7aHP4YPG1+1k_bbE+OCBK+P0Rg@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/ip_output.c:LINE!
To:     syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, johannes.berg@intel.com,
        Martin Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:42 AM syzbot
<syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Wed Jan 16 01:19:22 2019 +0000
>
>      bpf: in __bpf_redirect_no_mac pull mac only if present
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14175486600000
> start commit:   112cbae2 Merge branch 'linus' of git://git.kernel.org/pub/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
> dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ed6e2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539038c400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present
