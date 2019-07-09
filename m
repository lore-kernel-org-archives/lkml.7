Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D6C606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922F2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfGIEIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:08:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50543 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGIEIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:08:01 -0400
Received: by mail-io1-f69.google.com with SMTP id m26so21562221ioh.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Tojd49K4TWJ2ahCpfLjRNApjFre4XIEC+uxSBIyo+38=;
        b=Qt74ZqGmijBYnRmZWqnpN3Mo4q3YjXU2+ImxXM5lEXH7UlBeT61yjELpXwJTHBiLlE
         HQ8YQk9bhNWJTqgNF0+6LhiSenb4ImgWybLzx8VIl2fRTH9IFAnznQmcqXj6gNyHBBxY
         hkwObkZpi7sOeU8i0zR1IaWw2mMdpmjKnvD6T59x0nGOZBcJIxbD6rdxDjnZafXgfTcK
         cKJ9r91FdkAg3RoURV0L0vgsPbzOWdApgrQMuUY/z2KSyozyz1zSdRJn69F9wCY2vjaK
         p0M2S5kz0NyGMFSognIB6suGjEUJ4Q1PcsdMLTww6w7j47PVYysq9PPNWV0is+2hvlIh
         zBBw==
X-Gm-Message-State: APjAAAXUW1DwvAcJvBuMdq7NKFr+Crgu0g8ovAe5b1rWInPHprkiG6rU
        sphwoj0YlI3tZN1TgXyd22nVotsR0wGSBiB8eVsojAfLtC95
X-Google-Smtp-Source: APXvYqxm/mXCoJ5Hk6y8vR6v2IS4oj/n6X0W9JquEY5V/Gz6bIh3qzQKuPRQYew4ljT/GIOxZ10ZAdEqTPIVIKbtLtZFlys15uqe
MIME-Version: 1.0
X-Received: by 2002:a6b:cf17:: with SMTP id o23mr791127ioa.176.1562645280222;
 Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
Date:   Mon, 08 Jul 2019 21:08:00 -0700
In-Reply-To: <CAEf4BzZfqnFZRbDVo1-=Vph=NpOm1g=wGuV_O5Cniuxj9f9CsQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d676f2058d37b4a9@google.com>
Subject: Re: WARNING in __mark_chain_precision
From:   syzbot <syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, ast@kernel.org, bcrl@kvack.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com

Tested on:

commit:         b9321614 bpf: fix precision bit propagation for BPF_ST ins..
git tree:       https://github.com/anakryiko/linux bpf-fix-precise-bpf_st
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb3e6e7997c14f9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
