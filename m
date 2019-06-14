Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C688C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A321473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNgRqR9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfFNM1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:27:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42392 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfFNM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:27:47 -0400
Received: by mail-yw1-f65.google.com with SMTP id s5so1003606ywd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YnMPbwL4s/jQR8V1f8H97ZkPj3o349XbfXjq85CLy4=;
        b=mNgRqR9R4DILLyqKfkVzOgJZ558rQ3fTtTduD85c7js1UgGft5GNAd816Q6FK8mo27
         4B5TKaIrjEDF8XWyOy4XS4zeSiXcXTPc4LsLS7qQNXBnnLLs4eHrXi8qofhzr733h90K
         kJetXj7RLB6agorrJqqdWTnURyuv31SiSs17c+vxXJJbM7nquA2MaagNH1bNA6BWY8V6
         t+OM0CwA0oDdHkzN0rh4N+8F1rpwN9/V2f8wYNR8s3jBECXCdW1wW3SOggULdCeTf/GI
         mcbTRYp4BUNf/lQtelsV8+OsjLZCv8MHK8QdXavpr38I/YCzXMBBCTmkexjv5YO5ij7X
         0Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YnMPbwL4s/jQR8V1f8H97ZkPj3o349XbfXjq85CLy4=;
        b=LBdWo9wFgLCVwCMmCLLEWXE8p4/J7We7PfKPtgMM7y2/CqgSTmNG7MA3oV9EWLWtMj
         WfytDjUTzrL+2w6R4rUw9RnxAuBJ6Jq4JisySUwRauGOoZx7IxzT3Ks/gaQnFra7V4LV
         i4fPmcsEWXEH/Oba39B+1q3QWBLK7N1sYhratD7ipXWbvTQ/DpXp0ApYzbBBsrKRpdZn
         eDaOv5EsKJEeDX4Gq7gMo1llkPv8Z74x1+h4FHtfoxpZKGB8S5e8esGO3+DCsCU1BRG6
         alzM7v282A+Q7Z58LF+G/uMOnrKB3ohN+b+0sQ/4seZcGCHXGArXjqn4knzcVUZrSwS8
         r5lg==
X-Gm-Message-State: APjAAAWPwxz6dHDnAyQg4Pfm52kSx2PPbOwA0XdElvQb1qVXISmhleBt
        71W06oC58b7SemUZuu70Ui5L/b/FXTM4T5HzSAiSKNCYypQ=
X-Google-Smtp-Source: APXvYqyaUH2A4/LGefxVpSgiMOcMVHjURn1dYJyki1qLcSp+iqtGsQVj9ZEIxQ0HUmfYVUg5AKcclc7nUtGqeyh3B9E=
X-Received: by 2002:a0d:dfc4:: with SMTP id i187mr8597935ywe.146.1560515266154;
 Fri, 14 Jun 2019 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190612035715.166676-1-maowenan@huawei.com> <CANn89iJH6ZBH774SNrd2sUd_A5OBniiUVX=HBq6H4PXEW4cjwQ@mail.gmail.com>
 <6de5d6d8-e481-8235-193e-b12e7f511030@huawei.com> <a674e90e-d06f-cb67-604f-30cb736d7c72@huawei.com>
 <6aa69ab5-ed81-6a7f-2b2b-214e44ff0ada@gmail.com> <52025f94-04d3-2a44-11cd-7aa66ebc7e27@huawei.com>
In-Reply-To: <52025f94-04d3-2a44-11cd-7aa66ebc7e27@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Jun 2019 05:27:34 -0700
Message-ID: <CANn89iKzfvZqZRo1pEwqW11DQk1YOPkoAR4tLbjRG9qbKOYEMw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: avoid creating multiple req socks with the
 same tuples
To:     maowenan <maowenan@huawei.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:35 AM maowenan <maowenan@huawei.com> wrote:
>
>
>
> On 2019/6/14 12:28, Eric Dumazet wrote:
> >
> >
> > On 6/13/19 9:19 PM, maowenan wrote:
> >>
> >>
> >> @Eric, for this issue I only want to check TCP_NEW_SYN_RECV sk, is it OK like below?
> >>  +       if (!osk && sk->sk_state == TCP_NEW_SYN_RECV)
> >>  +               reqsk = __inet_lookup_established(sock_net(sk), &tcp_hashinfo,
> >>  +                                                       sk->sk_daddr, sk->sk_dport,
> >>  +                                                       sk->sk_rcv_saddr, sk->sk_num,
> >>  +                                                       sk->sk_bound_dev_if, sk->sk_bound_dev_if);
> >>  +       if (unlikely(reqsk)) {
> >>
> >
> > Not enough.
> >
> > If we have many cpus here, there is a chance another cpu has inserted a request socket, then
> > replaced it by an ESTABLISH socket for the same 4-tuple.
>
> I try to get more clear about the scene you mentioned. And I have do some testing about this, it can work well
> when I use multiple cpus.
>
> The ESTABLISH socket would be from tcp_check_req->tcp_v4_syn_recv_sock->tcp_create_openreq_child,
> and for this path, inet_ehash_nolisten pass osk(NOT NULL), my patch won't call __inet_lookup_established in inet_ehash_insert().
>
> When TCP_NEW_SYN_RECV socket try to inset to hash table, it will pass osk with NULL, my patch will check whether reqsk existed
> in hash table or not. If reqsk is existed, it just removes this reqsk and dose not insert to hash table. Then the synack for this
> reqsk can't be sent to client, and there is no chance to receive the ack from client, so ESTABLISH socket can't be replaced in hash table.
>
> So I don't see the race when there are many cpus. Can you show me some clue?

This is a bit silly.
You focus on some crash you got on a given system, but do not see the real bug.


CPU A

SYN packet
 lookup finds nothing.
 Create a NEW_SYN_RECV
 <long delay, like hardware interrupts calling some buggy driver or something>

             CPU B
             SYN packet
               -> inserts a NEW_SYN_RECV  sends a SYNACK
             ACK packet
             -> replaces the NEW_SYN_RECV by ESTABLISH socket

CPU A resumes.
    Basically a lookup (after taking the bucket spinlock) could either find :
   - Nothing (typical case where there was no race)
   -  A NEW_SYN_RECV
   -  A ESTABLISHED socket
  - A TIME_WAIT socket.

You can not simply fix the "NEW_SYN_RECV" state case, and possibly add
hard crashes (instead of current situation leading to RST packets)
