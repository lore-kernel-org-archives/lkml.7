Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91610C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E2020872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP7uv2G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfERSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:09:56 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37664 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfERSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:09:56 -0400
Received: by mail-yb1-f193.google.com with SMTP id p134so3989360ybc.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKwzC7+9dFa3APPTisEwxUdLiJEcokybHIkZLdfOQgU=;
        b=HP7uv2G7guSKmSVG8Z2PpC8Q+y2qv/S3jM8lQOSq9E99UtkRMLaGCEbmDtZmmoTKcM
         QsW3HaNs5Tk7fgkVGcrd9zXcUelxRpyODQASlHI5iOlWQgWWLe2MRIWPFjN29t3xBQ2q
         RL3ZJZ2LCdn5+vlWgchQhwy6oIZBPpu74IygxLQZmRjHIFNdljrHw6D8I3io0p/TBdH6
         nxVTHk8LTLglio3bcxaIXANCsFPUCU+C6NRxvHlDh+GMOWfK84aD07IiJbv3x/xCt7cg
         0AChUF9PLPlwcR6AORccDuXoMAsLg9GgjF/D2RHJu7T6sLUIwM/uHv453rPenfwkfNEz
         wyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKwzC7+9dFa3APPTisEwxUdLiJEcokybHIkZLdfOQgU=;
        b=Or0rspP7hDaPhGF0o+unpgmgFlKOkZGNp5+/p2KbYokpArunwrPfkPegSAPMpbLs1/
         NZAy5Rz/29vCN6Mb73nmRi8Yvl3nE5PynmTxI2Zj1lXjNGn6wheAjH+F4D3FbZvRUEC/
         DZbUan5LRc3LUnOUuXu06d8fsqpMWn+4Kv18Ex3PTAPsJG9zTWc0D+iI9LalyvhhMOU3
         9Qlz6Yyx1aG3MvwjLptb+BlISF7g29LRMOAWkmBMExWktXOzo9Kl2IQmOU/vV1JZK7h4
         mhJP52DtzPlkelwQaZmcX+F6eJldDlujkooe1/hmD5JR3H7mSmib1k8GQ6768SQ5S6aR
         QWkA==
X-Gm-Message-State: APjAAAVHWp8gLys5gLqWIi4k5TDUD+2oaLm+4Fj4y1O3x2dwPP5Wc+RR
        nVmdmw31slyQfA+K4uCPSFF0SPDi
X-Google-Smtp-Source: APXvYqyr2pdqtKkNDAWg6BQdJuLYTZvgWCoMD8bmH3DyWEVQ5EHuxZtcOXXlkB3LVTQyEWTZBxhelw==
X-Received: by 2002:a25:6d54:: with SMTP id i81mr29891075ybc.444.1558202994229;
        Sat, 18 May 2019 11:09:54 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id j189sm4701724ywa.42.2019.05.18.11.09.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 11:09:52 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id t62so3966800ybi.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 11:09:52 -0700 (PDT)
X-Received: by 2002:a25:6ec1:: with SMTP id j184mr7425869ybc.441.1558202991919;
 Sat, 18 May 2019 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014e65905892486ab@google.com>
In-Reply-To: <00000000000014e65905892486ab@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 18 May 2019 14:09:15 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeM5qzyf_D+70Xe5k=3d+dYp2WyVZC-YM=K4=9kCCst6A@mail.gmail.com>
Message-ID: <CA+FuTSeM5qzyf_D+70Xe5k=3d+dYp2WyVZC-YM=K4=9kCCst6A@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in rhashtable_walk_enter
To:     syzbot <syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, jon.maloy@ericsson.com,
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

On Sat, May 18, 2019 at 3:34 AM syzbot
<syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    510e2ced ipv6: fix src addr routing with the exception table
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b7e608a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
> dashboard link: https://syzkaller.appspot.com/bug?extid=1e8114b61079bfe9cbc5
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1e8114b61079bfe9cbc5@syzkaller.appspotmail.com
>
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.

All these five rhashtable_walk_enter probably have the same root cause.

Bisected to commit 7e27e8d6130c (" tipc: switch order of device
registration to fix a crash"). Reverting that fixes it.

Before the commit, tipc_init succeeds. After the commit it fails at
register_pernet_subsys(&tipc_net_ops) due to error in

  tipc_init_net
    tipc_topsrv_start
      tipc_topsrv_create_listener
        sock_create_kern

On a related note, in tipc_topsrv_start srv is also not freed on later
error paths.
