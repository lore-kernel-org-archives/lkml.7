Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776BC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCEF205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJBHDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:03:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfJBHDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:03:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E2A6AE61;
        Wed,  2 Oct 2019 07:03:34 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D30FDE04C7; Wed,  2 Oct 2019 09:03:33 +0200 (CEST)
Date:   Wed, 2 Oct 2019 09:03:33 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
Message-ID: <20191002070333.GE24815@unicorn.suse.cz>
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
 <20191002064605.GA7405@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002064605.GA7405@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:46:05AM +0200, Heiko Carstens wrote:
> On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> > 
> >    In file included from arch/s390/kvm/kvm-s390.c:44:
> >    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
> >    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
> >      179 |  asm volatile(
> >          |  ^~~
> >    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> > 
> > ...
> > 
> > I am wondering how is it possible that none of the build-testing 
> > infrastructure we have running against linux-next caught this? Not enough 
> > non-x86 coverage?
> 
> Well, there is plenty of s390 coverage with respect to daily builds
> (also here). It doesn't fail for me with gcc 9.1; so you may either
> have a different gcc version or different config options(?) so the
> compiler decided to not inline the function.

I think I found the reason: we only hit the build failure with one
special config used for zfcpdump which has

  CONFIG_CC_OPTIMIZE_FOR_SIZE=y

When I switched to CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y (which we have
in other s390x configs and which most people probably prefer), the build
does not fail even without the patch.

Michal Kubecek
