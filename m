Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfDXPpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:45:10 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:14748 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfDXPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:45:10 -0400
X-IronPort-AV: E=Sophos;i="5.60,390,1549929600"; 
   d="scan'208";a="89241361"
Date:   Wed, 24 Apr 2019 17:45:04 +0200
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
Message-ID: <20190424154504.vzkkobxsesc3oval@Air-de-Roger>
References: <20190423130416.68935-1-roger.pau@citrix.com>
 <20190423130416.68935-2-roger.pau@citrix.com>
 <2359c97c-1125-cfd2-44c2-7e9ce7972558@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2359c97c-1125-cfd2-44c2-7e9ce7972558@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:36:41AM -0400, Boris Ostrovsky wrote:
> On 4/23/19 9:04 AM, Roger Pau Monne wrote:
> > This involves initializing the boot params EFI related fields and the
> > efi global variable.
> >
> > Without this fix a PVH dom0 doesn't detect when booted from EFI, and
> > thus doesn't support accessing any of the EFI related data.
> >
> > Reported-by: PGNet Dev <pgnet.dev@gmail.com>
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Hmm.. This seems to be breaking save/restore for me (for domU), and I
> can't see any obvious reasons.
> 
> Can you try it?

Sure, thanks for the extra testing! I have to admit I haven't tested
save/restore with this patch applied, it didn't come to mind it might
affect that functionality.

I assume it's save/restore of a PVH domU that's broken (HVM and PV are
fine)?

Thanks, Roger.
