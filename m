Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673032085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCYOC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:02:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39135 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCYOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:02:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so10353878qte.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QO9hCHcYPIvg66x+248nyFXgmiRj/VUkTksDhxQ54hI=;
        b=rn+qLyh/0odjKlT9fTH/K8Z4s+Sx/jAjRNOSlEfBgCisE/tcrZZ2fa7NFzRdi6GQAp
         9HYn438i+HdkNGNWl8TuT/khxskBxnoTy5ywjEiCImFVi/G+GaTYuKdu1PCcfohAX9rq
         o2ve3ypKF3HCfRFSaIHxyj+afuHM1lQNgwHQSZVyHsHRVVVfGZO6AaQDAhTH1bvEzV6P
         HSjlyRyt3cXbKZOsWSeh8gCn8U3t++OZJfniSpfhQSL2XDiiGsOJ9rCGtHEW56HMM6BF
         YWIaMUn93JGTNeaJpgV6UwKXicl/3VDYr7iKtS59m9gDEoFGxAaLDcI1uxIafhXCuuyM
         IXfg==
X-Gm-Message-State: APjAAAVcQEYKvOKDYrbXswHhBCxlb6CpqbpQpZcNFYfnawY6jUdXKB9J
        i1jZs9dOfUvwOnq3NdrWHSNXxQ==
X-Google-Smtp-Source: APXvYqznCr5gfnJVEKTi8gX+vCcnf+yvDkiZ+WWZCj/Fs5neRxLZbwPSn7OEwZNdQclvYWgzliandg==
X-Received: by 2002:ac8:2eb8:: with SMTP id h53mr19923098qta.188.1553522571537;
        Mon, 25 Mar 2019 07:02:51 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 204sm5268191qki.58.2019.03.25.07.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 07:02:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:02:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, weiyj.lk@gmail.com
Subject: Re: INFO: task hung in vhost_net_stop_vq
Message-ID: <20190325100223-mutt-send-email-mst@kernel.org>
References: <0000000000004f8499057be95e1d@google.com>
 <0000000000008ee87005847fc985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008ee87005847fc985@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like more iotlb locking mess?

On Tue, Mar 19, 2019 at 10:21:00PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 6b1e6cc7855b09a0a9bfa1d9f30172ba366f161c
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Thu Jun 23 06:04:32 2016 +0000
> 
>     vhost: new device IOTLB API
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1486ad27200000
> start commit:   6b1e6cc7 vhost: new device IOTLB API
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1686ad27200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1286ad27200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d21e6e297322a900c128
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141db34d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ef293400000
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
