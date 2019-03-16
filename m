Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D3FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F6D218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCVMHWqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCPSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:10:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44787 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:10:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so7072710edh.11;
        Sat, 16 Mar 2019 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znzyF0XYlGQOaoqfzgdLDLzxgBCOwtEUBvUvaGLYBRc=;
        b=pCVMHWqgNO1/SXbwRvnuPXGgd5p6u1rH3kuRd+/zCz6Yo+/FBtqayK3paMSQ0MogL2
         xeoV4/75aqeklCAdotloOSythA9DATe2VflAvdjgZ0WQwUPZueJ/5z7jP9xEP4Ziheif
         2O/WM9f7+Xq/Pez81ik379WbYuJw8wNgIv/++pKGkzN4Q7/WX6tuitauySGsD5GgGkTa
         +DI+P9E7k6zGILeBYCPATuOcgJQaKO16N+qHiPnbUys56r6VvcQuF0d1++DsZ6ul5yw6
         CFKzcX/y25N2mJCPKAqT33/pbehpnRBMN3t+0ENjsFfLgulOzRVDaqAo8vx8RUQerIn+
         HICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znzyF0XYlGQOaoqfzgdLDLzxgBCOwtEUBvUvaGLYBRc=;
        b=AQcnzk+mBovTPlWBKhNN2CgQkAQ5WCPTeBUCafxZR+A12mpn6JVfO/hM6T+kyHMQao
         x2hVbV/MLVkBfAwwRJozCzHCfzbST2hfl3XpKaeGU7yXAPUyEVknHoJ/JIzakR2BoB8q
         Cpt6EXlxsMaDY/f1dO6HdlDAKRe39XvdHR9mUPlCxCWzrcavhrC7Sm1yqp0QDHKxRCJ0
         HSWRN/rOleiMax8irSrXjSCif9C5Mthn+2XQ6ITkZqwMhhpp/XL0n/a/PMxAqo7hJwn7
         aIV6DIJFNnRD4aQAFHfQertFgtYMRAS4rZVO5c9aLL/6BlDRHxwdvG9OYCXbdisE303P
         tm+A==
X-Gm-Message-State: APjAAAWGo83rAENq0qlGUAXkiuO0Qd+fLpFXW/+p35xcH7xdgOYqljRC
        eWUPqY3w6cUxicM/v5hgMK1hhjxDtcKqItOGuhU=
X-Google-Smtp-Source: APXvYqwjH95dg/5UJPTwyl062TaTmAtg6rjNEJkR7lmX5NTn+329lQZCnSb5D7vskERBP5xmFuwmEtrG9ta/y+8vMrE=
X-Received: by 2002:a17:906:4688:: with SMTP id a8mr5918566ejr.246.1552759809906;
 Sat, 16 Mar 2019 11:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190316134130.28065-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20190316134130.28065-1-maxime.chevallier@bootlin.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 16 Mar 2019 14:09:33 -0400
Message-ID: <CAF=yD-K1imzDHm2K8bvrtYu5j-MNrN_4xH2h2je6ornuqmi_QA@mail.gmail.com>
Subject: Re: [PATCH net] packets: Always register packet sk in the same order
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 9:43 AM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> When using fanouts with AF_PACKET, the demux functions such as
> fanout_demux_cpu will return an index in the fanout socket array, which
> corresponds to the selected socket.
>
> The ordering of this array depends on the order the sockets were added
> to a given fanout group, so for FANOUT_CPU this means sockets are bound
> to cpus in the order they are configured, which is OK.
>
> However, when stopping then restarting the interface these sockets are
> bound to, the sockets are reassigned to the fanout group in the reverse
> order, due to the fact that they were inserted at the head of the
> interface's AF_PACKET socket list.
>
> This means that traffic that was directed to the first socket in the
> fanout group is now directed to the last one after an interface restart.
>
> In the case of FANOUT_CPU, traffic from CPU0 will be directed to the
> socket that used to receive traffic from the last CPU after an interface
> restart.
>
> This commit introduces a helper to add a socket at the tail of a list,
> then uses it to register AF_PACKET sockets.
>
> Note that this changes the order in which sockets are listed in /proc and
> with sock_diag.
>
> Fixes: dc99f600698d ("packet: Add fanout support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Note that another consequence of this patch is that insertion on
packet create is now O(N) with the number of active packet sockets,
due to sklist being an hlist.
