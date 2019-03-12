Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74088214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfCLKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfCLKMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B2B53697F;
        Tue, 12 Mar 2019 10:12:53 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8261001DEA;
        Tue, 12 Mar 2019 10:12:50 +0000 (UTC)
Date:   Tue, 12 Mar 2019 18:12:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, dyoung@redhat.com, x86@kernel.org
Subject: Re: [PATCH v2 3/3] x86/kdump/64: Change the upper limit of
 crashkernel reservation
Message-ID: <20190312101248.GM21116@MiWiFi-R3L-srv>
References: <20190312005004.19182-1-bhe@redhat.com>
 <20190312005004.19182-4-bhe@redhat.com>
 <20190312094838.f4agowhd5rlaa3hn@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312094838.f4agowhd5rlaa3hn@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Mar 2019 10:12:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 at 12:48pm, Kirill A. Shutemov wrote:
> >  #ifdef CONFIG_X86_32
> >  # define CRASH_ADDR_LOW_MAX	(512 << 20)
> >  # define CRASH_ADDR_HIGH_MAX	(512 << 20)
> >  #else
> >  # define CRASH_ADDR_LOW_MAX	(896UL << 20)
> > -# define CRASH_ADDR_HIGH_MAX	MAXMEM
> > +# define CRASH_ADDR_HIGH_MAX	(1ULL < 46)
> 
> Maybe
> 
> # define CRASH_ADDR_HIGH_MAX (64UL << 40)
> 
> to match the notation for the rest of defines?
> 
Sure, I will replace it, and repost a whole patchset with your ack added
on each patch. Thanks for your careful reviewing and great suggestions.

> 
> Otherwise the patchset look good to me. You can use my ack for all of
> them:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> >  #endif
> >  
> >  static int __init reserve_crashkernel_low(void)
> > -- 
> > 2.17.2
> > 
> 
> -- 
>  Kirill A. Shutemov
