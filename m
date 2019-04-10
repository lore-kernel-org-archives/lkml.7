Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28012082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foreca.com header.i=@foreca.com header.b="TysosJxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfDJPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:01:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36008 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfDJPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:01:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id e76so938062ybc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foreca.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfcXxyY2pf1Us+EzMt10j1R0H3C85nVMzYP20CgJNes=;
        b=TysosJxl3EO86pltnIejs2Dor1YwYMZqoOUkJFP1OYHtQT02PGZZPCiOTzQ7XOA1vv
         qawyHTH5ZXw68ccdxpwQRI5ILg6Pt/kqUnV2DybfDZDT/oyhap9QiyytjX7k4cQAOC3h
         /6oCknc67YufXvWPSyPKtWXw0YyOFxc36z9rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfcXxyY2pf1Us+EzMt10j1R0H3C85nVMzYP20CgJNes=;
        b=dxWwIegKLgO4vUNkQc4/6+gE8KqtY2k5tXjsOwJ6RQQT8RtRaIynTvw9C7VXN8T9Rt
         CPJtf1Xtcah4AXuT6fOAOd2qzg6O+HFcqnTsaqnGgb099VnhRlRnqz+2dDyIgEpiJjeu
         KyIOUWRaIculFaNTkiwZi8ADj5WNSjOgHia1Jma+AbiwsKsa+hOJBRW7XAeBF8SMzD6U
         M8EhyU/oUonZHYfZ4ELfOCFkA5QJyK+jJm9fu5uyRnCE4XQQWSuQ8bJPNQXOwUXCwYaR
         1k72zvCDxWAkkqoSMXefqQ8J0dMGoYs8lDb9vVknu5tHBuvd8Dg/kblMuLdWUbj5OuTq
         me6Q==
X-Gm-Message-State: APjAAAVz0KgLONk6jH0r7PZEGsRuEgrTY9IHG/PxdKND/2+NzSny45kO
        UDubX/nBKds1M9jbu8CTabjjnbndQe/c4BwE7JeEsw==
X-Google-Smtp-Source: APXvYqwE+3a8a1eBMlZqFH8D9IZdCK8vl3VGBQncZ0SazD8CspGzJ269s1ZxRq003oRkumlshbS5cTxOtKD8WDtri4k=
X-Received: by 2002:a25:aaaf:: with SMTP id t44mr1766665ybi.299.1554908488903;
 Wed, 10 Apr 2019 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com> <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
In-Reply-To: <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
From:   Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Date:   Wed, 10 Apr 2019 18:01:17 +0300
Message-ID: <CAA1_w3_4ZeOA-viD4W0QH1rUYPczcwS2KpnsvRhCX2hQniV-kQ@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 5:16 PM Eric Dumazet <edumazet@google.com> wrote:
> If NFS sessions hang, then there is a bug to eventually root cause and fix.
>
> Just telling the user : Increase the limit is the same thing than admitting :
>
> Our limit system or TCP or NFS stacks are broken and unable to
> recover, so lets disable the limit system and work around a more
> serious bug.
>
> Maybe the bug is in a NIC driver, please share more details before
> adding yet another noisy signal in syslog
>
> SNMP counters are per netns, and more useful in the modern computing
> era,  where a host is shared by many different containers.

Any idea where the bug might be?

It can't be in NFS, because I have observed the issue to be a TCP
level issue. NFS would be working just fine if TCP worked, but the
underlying TCP connection is not working fine, unless we bump up
vm.min_free_kbytes.

It could be in ixgbe, because the incoming SKB gets pfmemalloc pages
for some reason, and that happens repeatedly for a duration of 5-10
minutes for every single retransmit, until the condition clears. Ping
is working just fine at the time the NFS connection is stuck. I think
these 63-queue NICs use different queue for ping than they use for the
TCP NFS connection. I think there is some code in ixgbe for not
reusing pfmemalloc pages, but it seems every packet nevertheless gets
a pfmemalloc page in the queue that is used for TCP NFS. Might the
cause be that if ixgbe gets the pages in large bunches, it gets
multiple pfmemalloc pages at a time and then every packet is dropped
until all the pfmemalloc pages run out (not being reused)?

It could also be in the default value of vm.min_free_kbytes, but I'm
not experienced enough in Linux kernel internals to adjust the complex
calculations. Just saying that 90 MB sounds ridiculously low on a 256
GB NUMA machine.

Are you of the opinion that Intel as the developer of ixgbe should be informed?

Anyway, I posted more details to the mailing lists about a week ago,
search for "NFS hang, sk_drops increasing, segs_in not, pfmemalloc
suspected" in the mailing lists, or click this direct link:
https://lkml.org/lkml/2019/4/3/682

The current situation is that we've been running the production system
for 2 weeks with a bumped-up vm.min_free_kbytes, no NFS hangs, whereas
before the bump, we had approximately one hang per day, so without the
bump, the period of 2 weeks would have approximately 14 NFS hangs.

To me, this OOM condition seems to be global, so having it per-netns
offers no clear benefit in my opinion. Or is vm.min_free_kbytes per
container tunable?

BR, Juha-Matti
