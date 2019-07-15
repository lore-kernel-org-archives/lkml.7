Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDACC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FEC2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="gnHK+c2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfGOPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:46:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34637 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbfGOPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:45:07 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so34900846iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScxfIM+hKDT1VQaIZy4BKqol+JPqVs71rTa7fK4KN1M=;
        b=gnHK+c2cwZGKOdspduqrUgKCh6lVrsKIInyhuuavEpiiOcbGli77C58lcIXgh934gd
         X+tLt3k+Ik4aenfsxG9NFO2TPCD832u+KzaI36GcEuU2FPeWtzF+N76i6iSHvlttqWsR
         k+frcRdRsmUd5oRFAvWQ9JfUk8UTM29DlkBao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScxfIM+hKDT1VQaIZy4BKqol+JPqVs71rTa7fK4KN1M=;
        b=VUmBSbLEu/p7F579gatqTQX1G1uA6tCaBR03ugbwoX40I0NDnGutvjRjBFGlGPS6aL
         qszHbwyv9b4rQYU2s1SBx0jxEaXaTsWL1llXtH/e8+QyMuHF7/atP4MIF9i5LOfhL8fr
         88rOpU0R7n/MOpc8AP/31pTyrQ20UrSwUCIxf/j8yMime5QNBbKLpTNgMgeqQZSJnmjy
         Bh/q+wsjllBy6k/SOqAUYPk8/6SB8XCCjeGLrvJf6nEji0w3HhQv5397zeal5if5mU5l
         H6I2dBbhfjtygV3zvlHXpkz8lGIMNQs/e9UzVOE6FpdV24aLcJg1E/7zXI3tWy+R5Jsq
         0uzQ==
X-Gm-Message-State: APjAAAXb48COBUTxYlQRgE2hsa8RFmIvdZbQiNt9qxF/lDvaeweHEk15
        DkLQ3XJ6t5HeOyk4qCYzfxwDqOFCkwPGuJ436xMLlw==
X-Google-Smtp-Source: APXvYqzbMN6ZWpAf5P2ZPcRYCxnKHbAAGVINWdGhBwNhv+b97qeWrnWhIxrRo/FNE6Q1bMyE5Gf6q1fus5Od5lXuuKQ=
X-Received: by 2002:a6b:790a:: with SMTP id i10mr24067436iop.150.1563205505726;
 Mon, 15 Jul 2019 08:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
 <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com> <20190711095102.GX3402@hirez.programming.kicks-ass.net>
 <xm26v9w8jwgl.fsf@bsegall-linux.svl.corp.google.com> <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
 <xm26muhikiq2.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26muhikiq2.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Mon, 15 Jul 2019 10:44:39 -0500
Message-ID: <CAC=E7cVSVqg8raXgVC8f7wB+BJO8TAjSU=0UN-M+Oxuo2raXAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 5:10 PM <bsegall@google.com> wrote:
> Ugh. Maybe we /do/ just give up and say that most people don't seem to
> be using cfs_b in a way that expiration of the leftover 1ms matters.

That was my conclusion as well.  Does this mean you want to proceed
with my patch set?  Do you have any changes you want made to the
proposed documentation changes, or any other changes for that matter?
