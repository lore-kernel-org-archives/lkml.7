Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B00C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E218420828
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4wImzzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCQNSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:18:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43072 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 09:18:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so14098757wre.10;
        Sun, 17 Mar 2019 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YZo2GQ1fjWxKYcSnm1Eu0tAzJ9UpV1rZvqpWk/X6Mk=;
        b=Q4wImzzZkyoax+AI1ffto0ie86b+qKjQo8v8i2jS5vUKCwSKkqMuu3DJuz0e7ly4Ch
         XsfgNb9dIU6X4veCpMwRXX95/g0qAPbRHw89AW+hg3I7kOrerRvRY8TQ4gbQHJ5xHYtH
         68aYbL+jKSRHXSCNPssSm7uwcmCBVbXkBuezhRHvvJrf4AIm3/onYkf2CQ2K+sYLeILh
         0McXrIpNFBT8eLzIpU0AlqiIX54LPDot/jnTrS1FC3GmAqPZGOIvToksGBAVqT7ZlE0v
         ccNGxOjIE07jFP5XOsYkb6UbhsWUyVQF0fTAas7WsPauItW3IEFknM6Yiu/LqPwjcsxK
         vBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YZo2GQ1fjWxKYcSnm1Eu0tAzJ9UpV1rZvqpWk/X6Mk=;
        b=Qzp04TKmuu9s0UyOtX0huSd3aQhBnwSaaiAdoOwscrRNzt+wSdIpjgXl1ntlvlRBb/
         LTUrnAsgIU0Wb2JkuaxAWZZbrLaABIwp6+napn+bgUW8lTmi0N5urgskyFcd9WFOOpCB
         EtUQXLWPzZtT9fM4nEvc9iUwPhw+QwX4ejS76xcb3c00rORnow1dM3lj6aUBSY77dmfx
         T06OVM3HfXtUqRTDbekofQpFvk2tWhiqUE9pave3nIIyhcxhJJz/16+/A1WurzS6nUTW
         Hz8qU1c3EEhgHsOmM81CBZn5HnbCK8YLyvKx4urPE0cFYmNZU7D3+iZfXG4klMbMexDP
         V1Tw==
X-Gm-Message-State: APjAAAUQ70RFnwXEuLluDgtiaFuyIKfRfK5ZEkV9kj3eE9+YxmWHflIC
        ISe6Ni8lfg+RwRluydJS9Q0kXixJEO/6Pm+8AlY=
X-Google-Smtp-Source: APXvYqwH6PScGltPkeXs4LZ61L1XXhCqLV7vT+B6wvMs7crGH+gdcri0OBRUf1vu8S7RtUTseBV4Ec/8h0EuLJIVl44=
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr7169512wrn.242.1552828687947;
 Sun, 17 Mar 2019 06:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000089bb100583e5fe7a@google.com> <000000000000757009058436b23f@google.com>
In-Reply-To: <000000000000757009058436b23f@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sun, 17 Mar 2019 21:17:56 +0800
Message-ID: <CADvbK_fjUBj1PYRshztyUxmiN2b27AFGJHHOgGDpggaQqtVBUA@mail.gmail.com>
Subject: Re: general protection fault in sctp_assoc_rwnd_increase
To:     syzbot <syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com>
Cc:     davem <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 10:09 PM syzbot
<syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 89664c623617b1d34447a927ac7871ddf3db29d3
> Author: Xin Long <lucien.xin@gmail.com>
> Date:   Sun Mar 3 09:54:53 2019 +0000
>
>      sctp: sctp_sock_migrate() returns error if sctp_bind_addr_dup() fails
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b17777200000
> start commit:   89664c62 sctp: sctp_sock_migrate() returns error if sctp_b..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=14717777200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10717777200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b613f0327d980b6b
> dashboard link: https://syzkaller.appspot.com/bug?extid=85e0b422ff140b03672a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12613b13200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f1884d200000
>
> Reported-by: syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com
> Fixes: 89664c62 ("sctp: sctp_sock_migrate() returns error if
> sctp_bind_addr_dup() fails")

sctp_copy_descendant() coplied sctp_sock->pd_lobby. we should fix it with:
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 06c6f4a..e0857dd 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9175,7 +9175,7 @@ static inline void sctp_copy_descendant(struct
sock *sk_to,
 {
  int ancestor_size = sizeof(struct inet_sock) +
      sizeof(struct sctp_sock) -
-     offsetof(struct sctp_sock, auto_asconf_list);
+     offsetof(struct sctp_sock, pd_lobby);

  if (sk_from->sk_family == PF_INET6)
  ancestor_size += sizeof(struct ipv6_pinfo);
