Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD99D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfDZJXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfDZJXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA81829150;
        Fri, 26 Apr 2019 09:23:53 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C75E366070;
        Fri, 26 Apr 2019 09:23:52 +0000 (UTC)
Date:   Fri, 26 Apr 2019 17:23:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, keescook@chromium.org
Cc:     kirill@shutemov.name, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        keescook@chromium.org, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190426092348.GO3584@localhost.localdomain>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190415194755.GJ29317@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415194755.GJ29317@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 26 Apr 2019 09:23:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 04/15/19 at 09:47pm, Borislav Petkov wrote:
> On Sun, Apr 14, 2019 at 03:28:04PM +0800, Baoquan He wrote:
> > kernel_randomize_memory() hardcodes the size of vmemmap section as 1 TB,
> > to support the maximum amount of system RAM in 4-level paging mode, 64 TB.
> > 
> > However, 1 TB is not enough for vmemmap in 5-level paging mode. Assuming
> > the size of struct page is 64 Bytes, to support 4 PB system RAM in 5-level,
> > 64 TB of vmemmap area is needed. The wrong hardcoding may cause vmemmap
> > stamping into the following cpu_entry_area section, if KASLR puts vmemmap
> > very close to cpu_entry_area, and the actual area of vmemmap is much bigger
> > than 1 TB.
 
> 
> Kirill, ack?

I sent private mail to Kirill and Kees. Kirill haven't replied yet, he
could be busy with something else as he doesn't show up recently on
lkml.

Kees kindly replied, and said he couldn't find this mail thread. He told
I can add his Reviewed-by, as he has acked this patchset in v2
thread. I just updated later to tune log and correct typos.
http://lkml.kernel.org/r/CAGXu5j+o4aSx9mMDJqTMOp-VrvWes-2YEwR1f29z8dm0rUfzGQ@mail.gmail.com

Can this be picked into tip with Kees' ack?

Thanks
Baoquan
