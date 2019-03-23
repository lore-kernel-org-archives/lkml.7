Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BABF21841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfCWVKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:10:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:57707 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfCWVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:10:01 -0400
Received: by mail-it1-f197.google.com with SMTP id h82so5581999ita.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H0YimcghHT0/gJPwSA1rkrR5qRnoKmjRqNBRjiJyio4=;
        b=P/myhkbPoHQNGoJe4QTCpd60CX/woMxg4BZetCyKrimO1do6JkYK99/bOf9TFqhyxc
         3XqSKFAa5pz1uFIDhp4uXNzK5r4pfDUt4Kw/6Y9fhu0T7KmDcopnP54H3bRLE88GP0v6
         CDU+I1A8NiKS2yOdfNjiA8K2ZzAfSsoM+VnPiyFcgfFsabIBID0Zq7KN0fSSpMvc6ehb
         C7i5U5YCAzW54nWRr0qOmo85IH4fYIp7RTh2YMpRfK30sUIIw2Uq9yYppkYPHh6a70GL
         nF6QLcgcJjIxwuoPSr50R88ePw7nFLi3bcvYsLtPZX5mv2EMLAjAYTOZKRjND1pkA+Id
         WC8A==
X-Gm-Message-State: APjAAAVX4WFBxfHiiIKT76KdwYCHe3tzSgsXkoMn0fe0rgakRsbelkPI
        fHwQ3cTZ+RJ4dByUtmShRrSGCQN+eDXY0AKLOpkbymEK1Ccz
X-Google-Smtp-Source: APXvYqxy9GWCuMJhBKCK8ItNo5FsHlX2a7uRQ6tyfzhbCWhqbcLrzs3BiSl2CUL32rcErPUcGhf+lJViDCJ/wdIZYP6oC1dEQcB6
MIME-Version: 1.0
X-Received: by 2002:a24:e50b:: with SMTP id g11mr6475073iti.14.1553375400876;
 Sat, 23 Mar 2019 14:10:00 -0700 (PDT)
Date:   Sat, 23 Mar 2019 14:10:00 -0700
In-Reply-To: <00000000000066aa5f0581b6effe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8e14f0584c96446@google.com>
Subject: Re: KASAN: use-after-free Read in rt_cache_valid
From:   syzbot <syzbot+c4c4b2bb358bb936ad7e@syzkaller.appspotmail.com>
To:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, broonie@kernel.org,
        colin.king@canonical.com, davem@davemloft.net, dsahern@gmail.com,
        ktkhai@virtuozzo.com, kuznet@ms2.inr.ac.ru, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        olivier.moysan@st.com, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        tyhicks@canonical.com, willy@infradead.org, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6b27e27729270a2478fdebea2db9c4f57bb4e8e6
Author: Colin Ian King <colin.king@canonical.com>
Date:   Wed Oct 31 19:31:43 2018 +0000

     ASoC: stm32: sai: fix less than zero comparison on unsigned int

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c0298b200000
start commit:   aa0c38cf Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12c0298b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0298b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c4b2bb358bb936ad7e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1197cb88c00000

Reported-by: syzbot+c4c4b2bb358bb936ad7e@syzkaller.appspotmail.com
Fixes: 6b27e2772927 ("ASoC: stm32: sai: fix less than zero comparison on  
unsigned int")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
