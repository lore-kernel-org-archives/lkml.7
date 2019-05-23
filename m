Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E186AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC9E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfEWDP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfEWDP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55C983092650;
        Thu, 23 May 2019 03:15:52 +0000 (UTC)
Received: from localhost (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0AB19C4F;
        Thu, 23 May 2019 03:15:48 +0000 (UTC)
Date:   Thu, 23 May 2019 11:15:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH v4 3/3] x86/kdump/64: Change the upper limit of
 crashkernel reservation
Message-ID: <20190523031541.GD3805@MiWiFi-R3L-srv>
References: <20190509013644.1246-1-bhe@redhat.com>
 <20190509013644.1246-4-bhe@redhat.com>
 <20190522031133.GA31269@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522031133.GA31269@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 23 May 2019 03:15:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/19 at 11:11am, Dave Young wrote:
> >  /*
> > - * Keep the crash kernel below this limit.  On 32 bits earlier kernels
> > - * would limit the kernel to the low 512 MiB due to mapping restrictions.
> > + * Keep the crash kernel below this limit.
> > + *
> > + * On 32 bits earlier kernels would limit the kernel to the low
> > + * 512 MiB due to mapping restrictions.
> > + *
> > + * On 64bit, old kexec-tools need to be under 896MiB. The later
> > + * supports to put kernel above 4G, up to system RAM top. Here
> 
> Above two lines are not reflected in code because we have removed
> the 896M limitation, it would be better to drop the two lines to
> avoid confusion. 

Missed these comments at bottom of mail.

Yes, will remove these two lines.

> 
> > + * kdump kernel need be restricted to be under 64TB, which is
> > + * the upper limit of system RAM in 4-level paing mode. Since
> > + * the kdump jumping could be from 5-level to 4-level, the jumping
> > + * will fail if kernel is put above 64TB, and there's no way to
> > + * detect the paging mode of the kernel which will be loaded for
> > + * dumping during the 1st kernel bootup.
> >   */
> >  #ifdef CONFIG_X86_32
> >  # define CRASH_ADDR_LOW_MAX	SZ_512M
> >  # define CRASH_ADDR_HIGH_MAX	SZ_512M
> >  #else
> >  # define CRASH_ADDR_LOW_MAX	SZ_4G
> > -# define CRASH_ADDR_HIGH_MAX	MAXMEM
> > +# define CRASH_ADDR_HIGH_MAX	(64UL << 40)
> 
> Maybe add a new macro in sizes.h like SZ_64T

I am fine, will add and use it here. Thanks.
