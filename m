Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4542F218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCULpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:45:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCULpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:45:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id k130so16077753qke.3;
        Thu, 21 Mar 2019 04:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOa2Qq+enOx59Wyoou7QV6md7ZdaJ5A6Yx+Mn9ROcnc=;
        b=mQLNgNyr5/KSDV7J6s3LBXTtEQypgtXfCGYZfClWOQFZWGNbvY9vZu9/+9ns0I61ew
         HyYR1wQU4YUGzrOmHuG+MHlQHfQ8dc4zlHK/2z/+Q1+22E4R4R+0eOUDSlQJdCnW+Piv
         Sn4WFs4w5eaMarQIGIDv55xo9Tm91muI/4R0SncR8TG4Sd/DLDBRzo6/kZMA100bo82V
         Iy8k+FX3Y4ISdNWfnbNFnYntCEmfbn1EFfz9pZhgn1dZ4blh+EQ9JK80pOrstOC19wXx
         Bxie1R++/UMpHyzvzZMie5iKXA2xY8O6aWuoWtP9ZJDgqc3+ZwBMrWpiE8l9ov4yzarg
         g/nQ==
X-Gm-Message-State: APjAAAXRVxkW/PgbGtXqCTY5jkCbbfPllsqacIhV4ERlVKPYFBFtE/pS
        pyZ7dpPBHgPwtP8YLeSJLqm5/Ce56oVwv2V2PMc=
X-Google-Smtp-Source: APXvYqyGc9zV1hAFFRJATFFJOCwoMk6epoMmYlnrJ9/tTYn2tAA20Z0pVUNbrGWiDtC9Gn+Jo16Kuk0aCPrgQ4BA2eY=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr2159398qkf.107.1553168719423;
 Thu, 21 Mar 2019 04:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190308001723.GA11197@archlinux-ryzen> <20190320190752.GA28744@archlinux-ryzen>
 <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
In-Reply-To: <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 12:45:02 +0100
Message-ID: <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        tipc-discussion@lists.sourceforge.net,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:51 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Wed, Mar 20, 2019 at 12:07 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>
> The use in tipc_bearer_xmit() isn't even guaranteed to set the in/out
> parameter, so even if the if is taken doesn't guarantee that maddr is
> always initialized before calling tipc_bearer_xmit().

Right, it is only initialized in certain states. It was always
initialized until commit 598411d70f85 ("tipc: make resetting of
links non-atomic"), afterwards only if the link was not reset,
and as of commit 73f646cec354 ("tipc: delay ESTABLISH
state event when link is established") only if it's not
'establishing' or 'reset'.

> At the minimum, we should initialize maddr to NULL.  I think we'd
> prefer to risk the possibility of a null pointer dereference to the
> possibility of working with uninitialized memory.  To be clear, both
> are bad, but one is easier to spot/debug later than the other.

I disagree with setting it to NULL, given that it is still an obviously
incorrect value. We could add a if(maddr) check before calling
tipc_bearer_xmit(), but I think it would be clearer to check
skb_queue_empty(xmitq)) if that avoids the warning:

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 2dc4919ab23c..147786795e48 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -844,7 +844,8 @@ static void tipc_node_link_down(struct tipc_node
*n, int bearer_id, bool delete)
        tipc_node_write_unlock(n);
        if (delete)
                tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
-       tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
+       if (skb_queue_empty(xmitq))
+               tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
        tipc_sk_rcv(n->net, &le->inputq);
 }

This duplicates the check inside of skb_queue_empty(),
but I don't know if the compiler can see through the
logic behind the inlined function calls.

      Arnd
