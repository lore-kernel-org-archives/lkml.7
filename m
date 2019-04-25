Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE263C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623720652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfDYKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:04:41 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:15299 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDYKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:04:41 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549929600"; 
   d="scan'208";a="89274307"
Date:   Thu, 25 Apr 2019 12:02:59 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] xen/pvh: correctly setup the PV EFI interface for
 dom0
Message-ID: <20190425100259.f2k7ayzlxctucitg@Air-de-Roger>
References: <20190423130416.68935-1-roger.pau@citrix.com>
 <20190423130416.68935-2-roger.pau@citrix.com>
 <2359c97c-1125-cfd2-44c2-7e9ce7972558@oracle.com>
 <20190424154504.vzkkobxsesc3oval@Air-de-Roger>
 <131ff20e-5f28-40ef-37a0-422f6508c115@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <131ff20e-5f28-40ef-37a0-422f6508c115@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:45:43AM -0400, Boris Ostrovsky wrote:
> On 4/24/19 11:45 AM, Roger Pau Monné wrote:
> > On Wed, Apr 24, 2019 at 11:36:41AM -0400, Boris Ostrovsky wrote:
> >> On 4/23/19 9:04 AM, Roger Pau Monne wrote:
> >>> This involves initializing the boot params EFI related fields and the
> >>> efi global variable.
> >>>
> >>> Without this fix a PVH dom0 doesn't detect when booted from EFI, and
> >>> thus doesn't support accessing any of the EFI related data.
> >>>
> >>> Reported-by: PGNet Dev <pgnet.dev@gmail.com>
> >>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> >> Hmm.. This seems to be breaking save/restore for me (for domU), and I
> >> can't see any obvious reasons.
> >>
> >> Can you try it?
> > Sure, thanks for the extra testing! I have to admit I haven't tested
> > save/restore with this patch applied, it didn't come to mind it might
> > affect that functionality.
> >
> > I assume it's save/restore of a PVH domU that's broken (HVM and PV are
> > fine)?
> >
> 
> 
> PV is fine, I haven't tried HVM.

I've tested live migration and save/restore of this series on top of
5.1.0-rc5 and seems to work fine for me. On top of which Linux version
where you testing, and can you paste the guest config file?

Thanks, Roger.
