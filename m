Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B55121743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BQ+JycJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfEUOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:43:39 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:38116 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfEUOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1558449818;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ugj1TnF91z5+PBr8jQIJ7x5EpDifHr/zSRpWbpp1ovs=;
        b=BQ+JycJdcpCjIkVBFXG/uI/HVL5jFnPpTJt1wuepkBL/uNGFdX/hN68BkswpWFGW
        mg/FuCt9SExcgAO0Eslvkkk3XzdUBUdiRTWU+zp5YFpHW7RGAhGngcQtn5shOZF0VN/
        nOqFCUJNNa5hHtr4UGwVSyLKP9qAjIfWUg7eWWug=
Date:   Tue, 21 May 2019 14:43:38 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add non_block_start/end()
In-Reply-To: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
Message-ID: <0100016adad909d8-e6c9c310-36e0-4bdd-80fd-5df1a1660041-000000@email.amazonses.com>
References: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.21-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Daniel Vetter wrote:

> In some special cases we must not block, but there's not a
> spinlock, preempt-off, irqs-off or similar critical section already
> that arms the might_sleep() debug checks. Add a non_block_start/end()
> pair to annotate these.

Just putting preempt on/off around these is not sufficient?

If not and you need to add another type of critical section then would
this not need to be added to the preempt counters? See
include/linux/preempt.h? Looks like there are sufficient bits left to put
the counter in there.


