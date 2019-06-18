Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20374C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC54B2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xFUka6W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfFRRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:34:38 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59741 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbfFRRei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:34:38 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dc3a0052
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jun 2019 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=CRsWCAgoSojlFaaV/iJ0W+G6JQ0=; b=xFUka6
        W1ocvTxiqRgpv6WFRyfZDG4I269hBbjfN0UoQWRjR+Lkb86Wv/yrfwbfMSQDTb8P
        8urWGi++8gFY/fTm9G+2xSgIFMNAFzVtlUC33pFx1S8T0BI0OLCAEYj5dHVLxV/+
        i6GyCw25pzL6CEwhBu+1jc1QL+v+n/5R/aRCTB6CmcZoAvArUoTKslNQIqaFk1zR
        nNXcOtCZifVkjZEj738/dYy3XvB+AC2rO0daNATxYts7t5g8zYCteMu3rm/EAsTe
        dAfzKZjRguMD2byFrHhVwyXPquXkLTB/624p5CFk4e5jCl3QRgGU2jpWSl2dKgjB
        TBTGP+1CSjvqQgPg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e61c639a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jun 2019 17:01:34 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id r6so16098099oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:34:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUOEntq+MDMGNUTL/VQW+aP2FkF8N4Chn6dkzAJGBRsovLNGrk7
        g1PaNY3KGVv3C74lCAyY0WvdTQR9fvQCFCdB5VQ=
X-Google-Smtp-Source: APXvYqxi72+7BrxQDq+XhOhsqy6yiDIKS8cT9yCkQ7K6T49DqCwH+SLeB+cm7CZGpCIwkwvH2PfoQWqNVuAAch22eI8=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr9745045otn.243.1560879275230;
 Tue, 18 Jun 2019 10:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Jun 2019 19:34:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9pZpJj3zL3nEmz6CSouZs8pmt4D1VO26Zv8imVEPuJFeA@mail.gmail.com>
Message-ID: <CAHmME9pZpJj3zL3nEmz6CSouZs8pmt4D1VO26Zv8imVEPuJFeA@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jun 12, 2019 at 2:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > and the comment at the top mentions explicit sleep hooks. I wasn't
> > sure which function to use from here, though.
>
> Either local_clock() or cpu_clock(cpu). The sleep hooks are not
> something the consumer has to worry about.

I'm not sure whether this is another bug or just a misunderstanding on
what we meant about sleep, but I observed the following behavior,
below, with local_clock(). Notably, local_clock() isn't advanced
during sleep in the way that the other mechanisms are.

Regards,
Jason

[50865.699714] wireguard: local_clock: 1, jiffies: 1,
jiffies_monotoany: 1, ktime_boot: 1, ktime_boot_coarse: 1
[50866.723923] wireguard: local_clock: 2, jiffies: 2,
jiffies_monotoany: 2, ktime_boot: 2, ktime_boot_coarse: 2
[50867.747896] wireguard: local_clock: 3, jiffies: 3,
jiffies_monotoany: 3, ktime_boot: 3, ktime_boot_coarse: 3
[50868.772297] wireguard: local_clock: 4, jiffies: 4,
jiffies_monotoany: 4, ktime_boot: 4, ktime_boot_coarse: 4
[50869.796419] wireguard: local_clock: 5, jiffies: 5,
jiffies_monotoany: 5, ktime_boot: 5, ktime_boot_coarse: 5
[50870.820719] wireguard: local_clock: 6, jiffies: 6,
jiffies_monotoany: 6, ktime_boot: 6, ktime_boot_coarse: 6
[50871.834768] wireguard: local_clock: 7, jiffies: 7,
jiffies_monotoany: 10, ktime_boot: 10, ktime_boot_coarse: 10
[50869.918760] PM: suspend entry (deep)
[50872.846134] PM: suspend exit
[50872.874955] wireguard: local_clock: 8, jiffies: 8,
jiffies_monotoany: 11, ktime_boot: 11, ktime_boot_coarse: 11
[50873.899142] wireguard: local_clock: 9, jiffies: 9,
jiffies_monotoany: 12, ktime_boot: 12, ktime_boot_coarse: 12
[50874.923368] wireguard: local_clock: 10, jiffies: 10,
jiffies_monotoany: 13, ktime_boot: 13, ktime_boot_coarse: 13
[50875.947641] wireguard: local_clock: 11, jiffies: 11,
jiffies_monotoany: 14, ktime_boot: 14, ktime_boot_coarse: 14
[50876.971833] wireguard: local_clock: 12, jiffies: 12,
jiffies_monotoany: 15, ktime_boot: 15, ktime_boot_coarse: 15
[50877.995969] wireguard: local_clock: 13, jiffies: 13,
jiffies_monotoany: 16, ktime_boot: 16, ktime_boot_coarse: 16
[50879.020220] wireguard: local_clock: 14, jiffies: 14,
jiffies_monotoany: 17, ktime_boot: 17, ktime_boot_coarse: 17
[50880.044395] wireguard: local_clock: 15, jiffies: 15,
jiffies_monotoany: 18, ktime_boot: 18, ktime_boot_coarse: 18

static void ugh(struct work_struct *w)
{
  int i;
  u64 start_localclock = local_clock(), end_localclock;
  u64 start_jiffies = jiffies64_to_nsecs(get_jiffies_64()), end_jiffies;
  u64 start_jiffiesmonotoany =
ktime_to_ns(ktime_mono_to_any(ns_to_ktime(jiffies64_to_nsecs(get_jiffies_64())),
TK_OFFS_BOOT)), end_jiffiesmonotoany;
  u64 start_ktimeboot = ktime_get_boot_ns(), end_ktimeboot;
  u64 start_ktimebootcoarse =
ktime_to_ns(ktime_get_coarse_boottime()), end_ktimebootcoarse;

  for (i = 0; i < 15; ++i) {
    msleep(1000);
    end_localclock = local_clock();
    end_jiffies = jiffies64_to_nsecs(get_jiffies_64());
    end_jiffiesmonotoany =
ktime_to_ns(ktime_mono_to_any(ns_to_ktime(jiffies64_to_nsecs(get_jiffies_64())),
TK_OFFS_BOOT));
    end_ktimeboot = ktime_get_boot_ns();
    end_ktimebootcoarse = ktime_to_ns(ktime_get_coarse_boottime());
    pr_err("local_clock: %llu, jiffies: %llu, jiffies_monotoany: %llu,
ktime_boot: %llu, ktime_boot_coarse: %llu\n",
           (end_localclock - start_localclock) / NSEC_PER_SEC,
           (end_jiffies - start_jiffies) / NSEC_PER_SEC,
           (end_jiffiesmonotoany - start_jiffiesmonotoany) / NSEC_PER_SEC,
           (end_ktimeboot - start_ktimeboot) / NSEC_PER_SEC,
           (end_ktimebootcoarse - start_ktimebootcoarse) / NSEC_PER_SEC);
  }
}

static DECLARE_WORK(blah, ugh);

static int __init mod_init(void)
{
  schedule_work(&blah);
  return 0;
}
