Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6310EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F80B20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOaTd4Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfERSTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:19:47 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33464 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfERSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:19:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id v81so1830548ywe.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXf6eTW/D9KxZmWzXNhg+M6jwam9QsxO2o7O+sjwG9E=;
        b=KOaTd4IlfWUxNaXLskFHyVq7H0i8lpdWSIVPFopEIKFaXwrey0kvlfn85PJsPO8OF3
         PtxSVFPse9lrU6IEvprl54kO+RTm/Cn0o1tuLJQ+tiB+tq/KWnMPZ9adFTDixWYlJBKi
         Bg4NB8E7bfZRGvhsKQA9XRAV4ejI9EElokasQB9HCMVDJypzbD0AhQvLu0Z5aunRKrkL
         xFXWZoyCrFlDNXfW0Q5kMqWc9HAwkGpYK0dKeSda18nvSExfMtjVXOYcTmobNsi63WXt
         OxNqQyQ4HOqR61dxIDq5QJfm14YybWGQYxJCWP51+ux3mnTEvvQsnqwisox+qkM3KS+U
         iqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXf6eTW/D9KxZmWzXNhg+M6jwam9QsxO2o7O+sjwG9E=;
        b=ODRP3P9tAlD00EMUrorQIRYMC1xyJJJOs6nnR8Js6JRfPEnZpAZs4zLTz+3UgVnWrh
         7HGwU79XgGM8s9ol93d3NPhEhX0Vh+XkWctBm+7kyoU/CiNPJVh//9TpSN/w437opxId
         JkNZMHBiUX6AFvLnX+GkUYwIvr6KbWu8UfEOmdeIfbi7509bEPo3rQ09za3lJIkHlps7
         3KLAy/mNuQzNLsHwcvty/1ve230bRiSwpJzif7PMj4nE5llHy8ydO+KD1BoyKh+ujMSH
         p2S0Q0lqXopMQIEEOfYonrxhJQ7+0lv+1gSzcTSV+A6n6UPS9D7YWftz7Xixzz4lOI6a
         LI+A==
X-Gm-Message-State: APjAAAUbUEGc8XgWMd626LJDxuJdD3u224SpbZ6gFOoi/Q8pGezkDvk7
        pcVL+WVRlejzsxRbbGyj3tYeCC3X
X-Google-Smtp-Source: APXvYqzH9QEoQ2EbXlAjz0QS0tLdRLvxVlwFaUWQCIzl6ZHThacssVmfyRoeNizUsJ9evfonwe7x1g==
X-Received: by 2002:a81:3217:: with SMTP id y23mr29527670ywy.386.1558203585654;
        Sat, 18 May 2019 11:19:45 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id y62sm3740078ywf.110.2019.05.18.11.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 11:19:44 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id k202so3997436ybk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 11:19:44 -0700 (PDT)
X-Received: by 2002:a25:f509:: with SMTP id a9mr31918634ybe.391.1558203584001;
 Sat, 18 May 2019 11:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014e65905892486ab@google.com> <CA+FuTSeM5qzyf_D+70Xe5k=3d+dYp2WyVZC-YM=K4=9kCCst6A@mail.gmail.com>
In-Reply-To: <CA+FuTSeM5qzyf_D+70Xe5k=3d+dYp2WyVZC-YM=K4=9kCCst6A@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 18 May 2019 14:19:07 -0400
X-Gmail-Original-Message-ID: <CA+FuTSct1p1tYAWdsWOgQT7AHoFbdgoT=gA1tQ3nii_85k9bFA@mail.gmail.com>
Message-ID: <CA+FuTSct1p1tYAWdsWOgQT7AHoFbdgoT=gA1tQ3nii_85k9bFA@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in rhashtable_walk_enter
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     syzbot <syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, jon.maloy@ericsson.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>, hujunwei4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 2:09 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, May 18, 2019 at 3:34 AM syzbot
> <syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    510e2ced ipv6: fix src addr routing with the exception table
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b7e608a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1e8114b61079bfe9cbc5
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com
> >
> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
>
> All these five rhashtable_walk_enter probably have the same root cause.
>
> Bisected to commit 7e27e8d6130c (" tipc: switch order of device
> registration to fix a crash"). Reverting that fixes it.
>
> Before the commit, tipc_init succeeds. After the commit it fails at
> register_pernet_subsys(&tipc_net_ops) due to error in
>
>   tipc_init_net
>     tipc_topsrv_start
>       tipc_topsrv_create_listener
>         sock_create_kern
>
> On a related note, in tipc_topsrv_start srv is also not freed on later
> error paths.

and tipc_topsrv_stop is not called in tipc_init_net on later error paths.
