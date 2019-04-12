Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39695C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21320850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNfanZT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDLUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:50:15 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34084 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:50:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id x129so3875946ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7qwsRw5IVivpTyLBIatOTcD/RB+ixEMBFLpFto3jKc=;
        b=FNfanZT+pHyXePPyxtbvwcA0HSyUlLfO69/0C0yMTEEwkqZGMDKqTnsD34jUcSJwSW
         H+rD2xu0SDTdcw2PMP5wOdnzg2MxqLtDyXmgf+SrP+4HztAQxIIZxBF+bICluUkir/pY
         c8cRuA0THxpAqVC/043WDsTwSO7azcuGV8s3Vue48TZYoJ5syonT16R4SA6/Mj9qtuXt
         5KndgfyXwhPPDpn/a2Z3w1WxKVQRod5rlcVAAlA/Um8fPjD//D1ASejBz38ApivCap2q
         aXtwz0gMjra9X61DONZSTYp0024btZjJXF98c64BfCEZ2hl5rI6OgykrOJAXItWBazR8
         8n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7qwsRw5IVivpTyLBIatOTcD/RB+ixEMBFLpFto3jKc=;
        b=dl87WGrQDBfg3HZfifeOV86BNfcQjzNkfjgwbxtszUUmZyr8/tIrvVUeYk3Rxkqvf8
         qqg3Vg8kk414GEnZrfTq0Q6fy7sDIW8VT2XwhyR4I0O4PXNJGD8WK3FvbfVtsIe1vPcf
         PmTzfwrADzCUBArVHJSQv1243tp8kSKZGIRi0+9csj+M/QF+/asAnwpj5rK7MbhSOMo/
         qKkUguh9EwxR7NVMVL1BdEvLs7dGsmEXhRWxu/XgxWFzjXuJTGkMENaJUgedcDBlpU5N
         WTUZOkl0ghk4e13C0CV9ukV3Mu8VLpFrSitO+MY9R+PJdUAIPBBJIIPF0ZCRZPwL0LZv
         Tw8Q==
X-Gm-Message-State: APjAAAVR2J23fCwJu5qYnqiZzX2wrxrjRsosds9B8BrTdqPgH2WhI6sI
        W1yX9AIBTGShq2MgNSMKbhi3ASWFYgjq5eGBke3g2A==
X-Google-Smtp-Source: APXvYqyayhbtQZ1S8kD8Qek+eW5XNvWOoa8xBKC1ooATGN/pyfvB4oZsltCbWCl2h3eCaoJoYHi6iBozkNsniEk8QkQ=
X-Received: by 2002:a81:9ad0:: with SMTP id r199mr47081086ywg.310.1555102213675;
 Fri, 12 Apr 2019 13:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190412151507.2769-1-hannes@cmpxchg.org> <20190412151507.2769-4-hannes@cmpxchg.org>
 <CALvZod4xu10+E41YyaamigysZAnDcdA09f5m-hGd72LeJ9VmEg@mail.gmail.com> <20190412201534.GB24377@tower.DHCP.thefacebook.com>
In-Reply-To: <20190412201534.GB24377@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Apr 2019 13:50:02 -0700
Message-ID: <CALvZod6jPxRb=ZEtErvZ4nJnObhQN05ECO9d_=HF0UWsCZExNw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: memcontrol: fix recursive statistics correctness
 & scalabilty
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 1:16 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Apr 12, 2019 at 12:55:10PM -0700, Shakeel Butt wrote:
> > On Fri, Apr 12, 2019 at 8:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Right now, when somebody needs to know the recursive memory statistics
> > > and events of a cgroup subtree, they need to walk the entire subtree
> > > and sum up the counters manually.
> > >
> > > There are two issues with this:
> > >
> > > 1. When a cgroup gets deleted, its stats are lost. The state counters
> > > should all be 0 at that point, of course, but the events are not. When
> > > this happens, the event counters, which are supposed to be monotonic,
> > > can go backwards in the parent cgroups.
> > >
> >
> > We also faced this exact same issue as well and had the similar solution.
> >
> > > 2. During regular operation, we always have a certain number of lazily
> > > freed cgroups sitting around that have been deleted, have no tasks,
> > > but have a few cache pages remaining. These groups' statistics do not
> > > change until we eventually hit memory pressure, but somebody watching,
> > > say, memory.stat on an ancestor has to iterate those every time.
> > >
> > > This patch addresses both issues by introducing recursive counters at
> > > each level that are propagated from the write side when stats change.
> > >
> > > Upward propagation happens when the per-cpu caches spill over into the
> > > local atomic counter. This is the same thing we do during charge and
> > > uncharge, except that the latter uses atomic RMWs, which are more
> > > expensive; stat changes happen at around the same rate. In a sparse
> > > file test (page faults and reclaim at maximum CPU speed) with 5 cgroup
> > > nesting levels, perf shows __mod_memcg_page state at ~1%.
> > >
> >
> > (Unrelated to this patchset) I think there should also a way to get
> > the exact memcg stats. As the machines are getting bigger (more cpus
> > and larger basic page size) the accuracy of stats are getting worse.
> > Internally we have an additional interface memory.stat_exact for that.
> > However I am not sure in the upstream kernel will an additional
> > interface is better or something like /proc/sys/vm/stat_refresh which
> > sync all per-cpu stats.
>
> I was thinking about eventually consistent counters: sync them periodically
> from a worker thread. It should keep the cost of reading small, but
> should increase the accuracy. Will it work for you?

Worker thread based solution seems fine to me but Johannes said it
would be best to not traverse the whole tree every few seconds.
