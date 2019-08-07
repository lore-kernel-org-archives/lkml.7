Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A42C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C4021E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfHGM4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:56:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:56:13 -0400
Received: from p200300ddd742df588d2c07822b9f4274.dip0.t-ipconnect.de ([2003:dd:d742:df58:8d2c:782:2b9f:4274])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvLU7-0000Iq-HK; Wed, 07 Aug 2019 14:56:07 +0200
Date:   Wed, 7 Aug 2019 14:56:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Austin Kim <austindh.kim@gmail.com>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org,
        mingo@kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: NULL ptr deref in wq_worker_sleeping on 4.19
In-Reply-To: <CADLLry6a9a0TKOEEPxOW_DS+XXwk5qUuaH+W9cmbLwvudXAV8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908071452350.24014@nanos.tec.linutronix.de>
References: <20190719135352.GF4240@sasha-vm> <20190807114649.fjfaj4oytcxaua7o@linutronix.de> <CADLLry6a9a0TKOEEPxOW_DS+XXwk5qUuaH+W9cmbLwvudXAV8A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Austin Kim wrote:

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?
  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?

  http://daringfireball.net/2007/07/on_top

> I wonder what kinds of workqueue is used in case of this panic.
> 
> If system workqueue(system_wq) is used for this case, it would be a
> help to replace it with high priority workqueue(system_highpri_wq). If
> panic disappers with high priority workqueue(system_highpri_wq), we
> would think about another scenario.

How would that help? As Sebastian explained, something overwrote memory or
it is a Use After Free. How would a high priority workqueue 'fix' that?

You need to find the root cause, which is either memory corruption or a use
after free.

Thanks,

	tglx
