Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A3AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1B20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDJWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:30:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39592 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfDJWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:30:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id z9so3035001lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgFRy3xnUP6NIgxErvxJfk2xMZ8wlFlp/Oi4ioPIets=;
        b=RAXXm4oQzgVWP/9aV8L+QOhQm8n4NrdC+tBbEQFpl0J+2Ko1clMd8zbsJXVCpHdcDb
         7YngCtdp18M7cc4aXYQVFHEg5LGRQ3gUvoYngSkTDiKnVf2vD4o6JKDN7sR1eC8YfuwA
         8EaaNNyPZy/yZdMfuanXLi5xEmEQfWXOjB2OEk9n2bwHO4Q8iHSgSqhaCq/lMbsHXej+
         3jI2tKFZjkMA+5hnONXwCH/F+exg8k7A8Z53lBQADWPUP9zxjSB+TewaHr9XvRcPq18S
         ksoHbqTCKnC6f3SNCI4Hy3APV+V5alPQpLKhEk7qhZ4ggdfHRl4Uj60IgAc2M+azGh/K
         KV5Q==
X-Gm-Message-State: APjAAAX3Ml4XwnPe5RQy6aPeaUfVNiL0neeXSAlc2pmhXCbOm96j8oif
        tpfCkSj7bYwhcRH4LaZeGWkBF+AB5X6G8JUdPWpVkA==
X-Google-Smtp-Source: APXvYqx6/CJ/NTPyyMHaRFYubdEk8/EbrcDQ7QZfFKYOJ+2bNS0PkdENZCM8QhfNcTykmnEfUoKLbB/+Hy5c2QAnayk=
X-Received: by 2002:ac2:4551:: with SMTP id j17mr13958827lfm.141.1554935441257;
 Wed, 10 Apr 2019 15:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
 <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com> <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
In-Reply-To: <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 11 Apr 2019 00:30:05 +0200
Message-ID: <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 12:24 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > On Wed, Apr 10, 2019 at 8:46 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Apr 8, 2019 at 3:09 PM Matteo Croce <mcroce@redhat.com> wrote:
> > > >
> > > > Use the shared variables for range check, instead of declaring a local one
> > > > in every source file.
> > >
> > > I was expecting this to be a tree-wide change for all the cases found
> > > by patch 1's "git grep".
> > >
> >
> > Hi Kees,
> >
> > I have already the whole patch ready, but I was frightened by the
> > output of get_maintainer.pl, so I decided to split the patch into
> > small pieces and send the first one.
>
> Heh, sounds fine. Normally the big tree-wide changes go via Linus just
> before cutting rc1 (or rc2). This is "only" 31 source files, though,
> so maybe akpm wants to take these instead? Andrew, how do you feel
> about that?
>

FYI, this are the stats from my local repo, just to let you the size
of a series with all the changes in it:

$ git --no-pager log --stat --oneline linus/master
acebb1f752e9 x86: use sysctl shared variables for range check
 arch/x86/entry/vdso/vdso32-setup.c | 7 ++-----
 arch/x86/kernel/itmt.c             | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)
6731f419f46d s390: use sysctl shared variables for range check
 arch/s390/appldata/appldata_base.c | 15 +++++----------
 arch/s390/kernel/topology.c        |  6 ++----
 2 files changed, 7 insertions(+), 14 deletions(-)
1189495100c6 drivers: use sysctl shared variables for range check
 drivers/base/firmware_loader/fallback_table.c | 11 ++++-------
 drivers/gpu/drm/i915/i915_perf.c              |  8 +++-----
 drivers/hv/vmbus_drv.c                        |  6 ++----
 drivers/s390/char/sclp_async.c                |  7 ++-----
 drivers/tty/tty_ldisc.c                       |  6 ++----
 drivers/xen/balloon.c                         |  7 ++-----
 6 files changed, 15 insertions(+), 30 deletions(-)
bada6ce1f240 ipc: use sysctl shared variables for range check
 ipc/ipc_sysctl.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)
1faa590d64c5 inotify: use sysctl shared variables for range check
 fs/notify/inotify/inotify_user.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)
ad4254677a52 security: use sysctl shared variables for range check
 security/keys/sysctl.c     | 26 ++++++++++++--------------
 security/loadpin/loadpin.c |  6 ++----
 security/yama/yama_lsm.c   |  3 +--
 3 files changed, 15 insertions(+), 20 deletions(-)
3d2211ab8c7c net: use sysctl shared variables for range check
 net/core/neighbour.c            | 20 ++++++-------
 net/core/sysctl_net_core.c      | 34 ++++++++++------------
 net/dccp/sysctl.c               | 16 +++++-----
 net/ipv4/sysctl_net_ipv4.c      | 58 ++++++++++++++++++-------------------
 net/ipv6/addrconf.c             |  6 ++--
 net/ipv6/route.c                |  7 ++---
 net/ipv6/sysctl_net_ipv6.c      |  8 ++---
 net/mpls/af_mpls.c              | 10 +++----
 net/netfilter/ipvs/ip_vs_ctl.c  |  3 +-
 net/rxrpc/sysctl.c              |  9 +++---
 net/sctp/sysctl.c               | 35 ++++++++++------------
 net/sunrpc/xprtrdma/transport.c |  3 +-
 12 files changed, 93 insertions(+), 116 deletions(-)
f20fd0e406ec kernel: use sysctl shared variables for range check
 kernel/pid_namespace.c |   3 +-
 kernel/sysctl.c        | 193 ++++++++++++++++++++++-----------------------
 kernel/ucount.c        |   6 +-
 3 files changed, 98 insertions(+), 104 deletions(-)
05fc54289d17 proc/sysctl: add shared variables for range check
 fs/proc/proc_sysctl.c  | 5 +++++
 include/linux/sysctl.h | 4 ++++
 2 files changed, 9 insertions(+)


--
Matteo Croce
per aspera ad upstream
