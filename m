Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1768C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C340C20869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="G8fRkvwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbfKGRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:48:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKGRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:48:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id h4so2494036pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQHzfatweJlvu9QRgWqn6mLupzORKF19rwgbns+H/Ko=;
        b=G8fRkvwVCgK+5AnZZD/V83YvXyFilTUx9GafaEg/RlOfkWwhafnHdqdNeGKXLF/H6K
         FDoIV9FDSYGiZwaMLLnBtT4HOWe9rvBSeoXdkoOt977x30UGwRbKIQD62Y3e0SHPGkJE
         zj18IxkktF05wkCUiif3Tune+pTbQR19EfTWV8nDz4Wk+HvNaFZ82cJrX2VmWcejNZCG
         /iA/y8UqcJOl8F5Lh91S8tMoq40Go993jzHkeaTYmeYHGrX9dqqW6SRh5BZnroMcF8Jn
         BD77+M4HBjqEt44AKkO6oPWfH6+/na5b+Omr1i/uNPazTemCNSqER5sX4i6vu+vqbhQq
         hrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQHzfatweJlvu9QRgWqn6mLupzORKF19rwgbns+H/Ko=;
        b=ggQfkLriC1a5fkLriF7lR2+QCl4LNGrAxikoqzXzXpp4Q7Yy3IKKglE3DLV/AkjLZJ
         Hd4J506cfknA7GcZSUal6Rs3DvXWgDrChIrA+GbUKcVDGFbpB0o250pXdiryPTkxjexN
         tIo3HL3diDF6GQt0wJG1gyvCNO2FUoM+THgvZ+NVaDHeGl0lfnlcGIcaOHDFWVSEw81W
         AeasgtVamPwZ6p+EJqUYLpzPbvyxPcgv7SdbGPaSZJpBQKux/cDjeUYAdHKdna22Cj1Z
         GAgl4mEvzcgbkeQcdr4vEUawCht0wkMGg0RjpA+7ezG2FK/RjwrIEbDwnLJsXbcghygh
         dxiw==
X-Gm-Message-State: APjAAAWdgmqqkUShYLcbYw73TA6yHGqDbviaiEQiPrKZ9PFf3TySPpRd
        16wj0Y8VsnPuVtuMrMb8+LJZNQ==
X-Google-Smtp-Source: APXvYqzAqvPs1jX+juk9qWnYhY1RhnF/vPkdqQeAI9VIRBxgjUBTjIXOsZmOImIrN/73qLNmV/iXGQ==
X-Received: by 2002:a63:6f47:: with SMTP id k68mr5759534pgc.92.1573148887304;
        Thu, 07 Nov 2019 09:48:07 -0800 (PST)
Received: from localhost ([199.201.64.133])
        by smtp.gmail.com with ESMTPSA id t12sm3323606pgv.45.2019.11.07.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:48:06 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:45:55 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 00/11] mm: fix page aging across multiple cgroups
Message-ID: <20191107174555.GA116752@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
 <CALvZod7821vuP_KcOKZkzKu-6b_kzDPrximi3E-Ld95fd=zbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7821vuP_KcOKZkzKu-6b_kzDPrximi3E-Ld95fd=zbMg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 06:50:25PM -0800, Shakeel Butt wrote:
> On Mon, Jun 3, 2019 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > When applications are put into unconfigured cgroups for memory
> > accounting purposes, the cgrouping itself should not change the
> > behavior of the page reclaim code. We expect the VM to reclaim the
> > coldest pages in the system. But right now the VM can reclaim hot
> > pages in one cgroup while there is eligible cold cache in others.
> >
> > This is because one part of the reclaim algorithm isn't truly cgroup
> > hierarchy aware: the inactive/active list balancing. That is the part
> > that is supposed to protect hot cache data from one-off streaming IO.
> >
> > The recursive cgroup reclaim scheme will scan and rotate the physical
> > LRU lists of each eligible cgroup at the same rate in a round-robin
> > fashion, thereby establishing a relative order among the pages of all
> > those cgroups. However, the inactive/active balancing decisions are
> > made locally within each cgroup, so when a cgroup is running low on
> > cold pages, its hot pages will get reclaimed - even when sibling
> > cgroups have plenty of cold cache eligible in the same reclaim run.
> >
> > For example:
> >
> >    [root@ham ~]# head -n1 /proc/meminfo
> >    MemTotal:        1016336 kB
> >
> >    [root@ham ~]# ./reclaimtest2.sh
> >    Establishing 50M active files in cgroup A...
> >    Hot pages cached: 12800/12800 workingset-a
> >    Linearly scanning through 18G of file data in cgroup B:
> >    real    0m4.269s
> >    user    0m0.051s
> >    sys     0m4.182s
> >    Hot pages cached: 134/12800 workingset-a
> >
> 
> Can you share reclaimtest2.sh as well? Maybe a selftest to
> monitor/test future changes.

I wish it were more portable, but it really only does what it says in
the log output, in a pretty hacky way, with all parameters hard-coded
to my test environment:

---

#!/bin/bash

# this should protect workingset-a from workingset-b

set -e
#set -x

echo Establishing 50M active files in cgroup A...
rmdir /cgroup/workingset-a 2>/dev/null || true
mkdir /cgroup/workingset-a
echo $$ > /cgroup/workingset-a/cgroup.procs
rm -f workingset-a
dd of=workingset-a bs=1M count=0 seek=50 2>/dev/null >/dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
echo -n "Hot pages cached: "
./mincore workingset-a

echo -n Linearly scanning through 2G of file data cgroup B:
rmdir /cgroup/workingset-b >/dev/null || true
mkdir /cgroup/workingset-b
echo $$ > /cgroup/workingset-b/cgroup.procs
rm -f workingset-b
dd of=workingset-b bs=1M count=0 seek=2048 2>/dev/null >/dev/null
time (
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null )
echo -n "Hot pages cached: "
./mincore workingset-a
