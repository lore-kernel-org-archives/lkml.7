Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CE22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558450037;
	bh=45UtuzY6nu9B311oBHLASyIPC8N0XlpKmv/uJv4/Nbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OJNTZIkNiGm9iMGRYwOLb+/Hd3VPcqLd4ZjPsUwZItprQq8m7R8QfofdTyWNNaBQq
	 my50pp1AL2iYeay7n/N3EfjHrDN0+uNED5qr37aJxGYX5gyGysm1+xB2YX7N7chiKF
	 ZQIF+JC6DyCxVwlJuN1yOUIQb7QNtzNwBRMXM6Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfEUOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbfEUOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED24FAF8E;
        Tue, 21 May 2019 14:47:14 +0000 (UTC)
Date:   Tue, 21 May 2019 16:47:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add non_block_start/end()
Message-ID: <20190521144713.GX32329@dhcp22.suse.cz>
References: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
 <0100016adad909d8-e6c9c310-36e0-4bdd-80fd-5df1a1660041-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016adad909d8-e6c9c310-36e0-4bdd-80fd-5df1a1660041-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 14:43:38, Cristopher Lameter wrote:
> On Tue, 21 May 2019, Daniel Vetter wrote:
> 
> > In some special cases we must not block, but there's not a
> > spinlock, preempt-off, irqs-off or similar critical section already
> > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > pair to annotate these.
> 
> Just putting preempt on/off around these is not sufficient?

It is not a critical section. It is a _debugging_ facility to help
discover blocking contexts.
-- 
Michal Hocko
SUSE Labs
