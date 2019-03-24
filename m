Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8806C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ECC20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZa7Ov8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfCXWkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:40:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32818 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:40:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so5936046edg.0;
        Sun, 24 Mar 2019 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKWX9Rfs2ODFG3id7piLJrJ9395KBiXF20wqmflUrDQ=;
        b=vZa7Ov8WoPNxO+R2SR+uPA55vteOhqqoAyiDlhoEThNOy8tTX3ctx85+wAOB8cYvYt
         D3LtIj3wygVOfHvKTc8ihX5bC3VD6KERQmuAGom6shFRlYsqVTcEnlEhZL8TCUYIPstw
         oPzdGt633xDfAf8OhAuEDXRWbauKKCHKjNo2sP3BdVOnJvYxefXN1w8tl5FKy3Bpar/r
         ks7SRJ3L6FQ2bT04whVOjrZpyQDaMSoF/3/QCydgin7cH39pRKKy00ILIxrIV/1NWz1z
         TaPIrla83BoC8XGAKWsdVKQqge0ImnPXSzDnCuthTBqrHGiyjMNljeIonpa105cQvRiR
         KLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKWX9Rfs2ODFG3id7piLJrJ9395KBiXF20wqmflUrDQ=;
        b=W2xitMk7KfNPi/LAqkdLDW/rcjr1tJnhtFQJZbxKKFol7n7xkZiVlzlS01T32zEs4f
         rmzQmPdlSJfDaBhgPZ05DQVoZRniYEP2m9MqbiUTmXSgO6T+wYkk82ofnNfahQg369U6
         zB9ool9Bt7ta8ZihEeBxqxZCt+YCgyA1VKzTo0n6gBlIaHOMx4GvL7MsAP2C02K+856e
         y7SCUMTYum00UAUI89hpfRoJZMmmtNsL4n+n1FWVXSdtywYcZ2KIwIhAmA9kQ4CkqKrO
         nSWiKj0T0gpCYHAW9aDB9Xxzfyc+sPLWI+dSjIJSK4xniZks+mYtoLVCfNUfoRkl6+iy
         Opfg==
X-Gm-Message-State: APjAAAW9o2RXx4KoN9V1spH/8rWLVaDuZmUBC28CUfCSuUvDImvn6bCQ
        RfOeNvMvWcliy0BMO5k7GkTr8YsgIstEIn8LDU4=
X-Google-Smtp-Source: APXvYqy1BfXq2lKioEvs9yaib9N18Nj0agPeFZi3oZBnEXZIk9FK/6nPo9VYpJC9ajXbOSkJeaYY+ucon+1bZ3iYdpk=
X-Received: by 2002:a50:a5e5:: with SMTP id b34mr1777129edc.260.1553467202726;
 Sun, 24 Mar 2019 15:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190325092804.650ebdb0@canb.auug.org.au>
In-Reply-To: <20190325092804.650ebdb0@canb.auug.org.au>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 24 Mar 2019 18:39:26 -0400
Message-ID: <CAF=yD-JnqrLrnkF+iqQ6JGhVj-8Z5q=pDRb5aKiVeYoxUaOgAw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 6:30 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> net/core/filter.c: In function 'bpf_skb_adjust_room':
> net/core/filter.c:3022:31: warning: 'inner_trans' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    skb->inner_transport_header = inner_trans;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> net/core/filter.c:2979:26: note: 'inner_trans' was declared here
>   u16 mac_len, inner_net, inner_trans;
>                           ^~~~~~~~~~~
> net/core/filter.c:3021:29: warning: 'inner_net' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    skb->inner_network_header = inner_net;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> net/core/filter.c:2979:15: note: 'inner_net' was declared here
>   u16 mac_len, inner_net, inner_trans;
>                ^~~~~~~~~
> net/core/filter.c:3026:3: warning: 'mac_len' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    skb_set_network_header(skb, mac_len);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/core/filter.c:2979:6: note: 'mac_len' was declared here
>   u16 mac_len, inner_net, inner_trans;
>       ^~~~~~~
>
> Introduced by commit
>
>   868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
>
>
> This looks like a false positive, it seems that they are only set and
> used when encap is true.

Indeed. Sorry about that.

The fix for this is now in bpf-next, commit 62b31b42cff9 ("bpf:
silence uninitialized var warning in bpf_skb_net_grow").
