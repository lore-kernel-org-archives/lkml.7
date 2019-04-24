Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254B1218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfDXNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:50:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfDXNuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:50:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15DDB80D;
        Wed, 24 Apr 2019 06:50:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BCE3F5C1;
        Wed, 24 Apr 2019 06:50:17 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:50:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com,
        haozhu@nudt.edu.cn, linux@dominikbrodowski.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Message-ID: <20190424135015.GE14829@fuggles.cambridge.arm.com>
References: <20190423170445.GB21047@fuggles.cambridge.arm.com>
 <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
 <20190418112818.GA31923@lakrids.cambridge.arm.com>
 <28023.1556094688@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28023.1556094688@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:31:28AM +0100, David Howells wrote:
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > -		unsigned long, fd, off_t, off)
> > +		unsigned long, fd, off_t, pgoff)
> >  {
> > +	unsigned long off = pgoff;
> > +
> 
> Would loff_t be better?

I don't think so, isn't that still signed? I also think it's the same
size as off_t on arm64 (long long vs long).

Will
