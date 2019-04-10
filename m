Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD69C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA63320818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwUS5wTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfDJPgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:36:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42748 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfDJPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:36:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id l124so975697ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5s7u3TCPcCJ6I81wAOQezikgSrwQIZY29LzswhKGks=;
        b=pwUS5wTt5RR+gsfmHHbHE3pXndA84XuH+QAhmu5sIES0NJ2BIeMOm2hcUdi16dQdTP
         /fB3qUfpEeCDI1BL1fsT/ZiMLQ3kfr4hPpBvQGhduwvqNaaqi9UeLR6eMW9bNmDz7tcy
         82NHCrt4YoWfjuCEm9cS8bx2fP2tEPNLcm+WruvnDhXUUyKALnYAvkGQ8xzkyaOpKsgi
         A+qhi0iyUWpKiS7tGVMDAcsvuf5vAUlzWKVY6Sw7+Le3MGf6gWVLQA/nh+VKvOASd0Qg
         lc/lE5zIRIRQZ7dkmNdaJTSRgUHDgD1OIBmYtG2PZJ1DKZL5X7AdclMCItzedQjYccPJ
         KecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5s7u3TCPcCJ6I81wAOQezikgSrwQIZY29LzswhKGks=;
        b=EKOHc5SNC+DsjSvyTyZBBwm3ejL2ZEdtbiB79SaRTBVroJ9RVUbACe+QgYhalsTZxf
         hNkOxpDL7m0gCok9PBGsq3I5V1XI8QGqHlFr0NXZkhahPvMnSyktlx8nyvk+56O231lo
         7ssXccOS+P+mYLk6LfTXmro5p5phN4xrtvVgOSvNArw2avcZdI5rpQyDKnUa4fDW1glT
         4bgNUCQ08GbxP5s/kOtVKeVTA5VZPEdkchJiCW3Eu7eqLC2xRp2KDNK9aUd5oNXz3ozi
         hcN8bAw1qF907dQkN9KYBJfIMpsTGFio4rHOzkWZQNMsiVxuVkvLh6pgTDvmzUOkGZOJ
         Hjyw==
X-Gm-Message-State: APjAAAVqD0xMo0u2dF8ItwEuNntQE6cCrzsGz7cwx/oX7AP5/A8+PKBr
        JFvmhtkaYhkIC+blufqoI9WQb1bpVc4Hsv2SQKexDijP91M=
X-Google-Smtp-Source: APXvYqzepj2ap1LB3Q5S526zBXnik5RXImA3tKUUazee0hR07MaF82XMyZItnxShyxkO/zlxAN5DqP6y3yVbqypMafI=
X-Received: by 2002:a25:81c9:: with SMTP id n9mr17154830ybm.246.1554910579082;
 Wed, 10 Apr 2019 08:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
 <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com> <CAA1_w3_4ZeOA-viD4W0QH1rUYPczcwS2KpnsvRhCX2hQniV-kQ@mail.gmail.com>
In-Reply-To: <CAA1_w3_4ZeOA-viD4W0QH1rUYPczcwS2KpnsvRhCX2hQniV-kQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Apr 2019 08:36:06 -0700
Message-ID: <CANn89iLmzADQF5=htGsjNwXrUZxMUYaYZB+6WOM_vo6zG+JB9A@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     Juha-Matti Tilli <juha-matti.tilli@foreca.com>
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

On Wed, Apr 10, 2019 at 8:01 AM Juha-Matti Tilli
<juha-matti.tilli@foreca.com> wrote:
>
> On Wed, Apr 10, 2019 at 5:16 PM Eric Dumazet <edumazet@google.com> wrote:
> > If NFS sessions hang, then there is a bug to eventually root cause and fix.
> >
> > Just telling the user : Increase the limit is the same thing than admitting :
> >
> > Our limit system or TCP or NFS stacks are broken and unable to
> > recover, so lets disable the limit system and work around a more
> > serious bug.
> >
> > Maybe the bug is in a NIC driver, please share more details before
> > adding yet another noisy signal in syslog
> >
> > SNMP counters are per netns, and more useful in the modern computing
> > era,  where a host is shared by many different containers.
>
> Any idea where the bug might be?
>

Before diving into the details, can we first double check which exact
kernel version you are using ?

In the past some pfmemalloc bugs have been solved, I do not want spend
time finding them a second time.



> It can't be in NFS, because I have observed the issue to be a TCP
> level issue. NFS would be working just fine if TCP worked, but the
> underlying TCP connection is not working fine, unless we bump up
> vm.min_free_kbytes.
>
> It could be in ixgbe, because the incoming SKB gets pfmemalloc pages
> for some reason, and that happens repeatedly for a duration of 5-10
> minutes for every single retransmit, until the condition clears. Ping
> is working just fine at the time the NFS connection is stuck. I think
> these 63-queue NICs use different queue for ping than they use for the
> TCP NFS connection. I think there is some code in ixgbe for not
> reusing pfmemalloc pages, but it seems every packet nevertheless gets
> a pfmemalloc page in the queue that is used for TCP NFS. Might the
> cause be that if ixgbe gets the pages in large bunches, it gets
> multiple pfmemalloc pages at a time and then every packet is dropped
> until all the pfmemalloc pages run out (not being reused)?
>
> It could also be in the default value of vm.min_free_kbytes, but I'm
> not experienced enough in Linux kernel internals to adjust the complex
> calculations. Just saying that 90 MB sounds ridiculously low on a 256
> GB NUMA machine.
>
> Are you of the opinion that Intel as the developer of ixgbe should be informed?
>
> Anyway, I posted more details to the mailing lists about a week ago,
> search for "NFS hang, sk_drops increasing, segs_in not, pfmemalloc
> suspected" in the mailing lists, or click this direct link:
> https://lkml.org/lkml/2019/4/3/682
>
> The current situation is that we've been running the production system
> for 2 weeks with a bumped-up vm.min_free_kbytes, no NFS hangs, whereas
> before the bump, we had approximately one hang per day, so without the
> bump, the period of 2 weeks would have approximately 14 NFS hangs.
>
> To me, this OOM condition seems to be global, so having it per-netns
> offers no clear benefit in my opinion. Or is vm.min_free_kbytes per
> container tunable?
>
> BR, Juha-Matti
