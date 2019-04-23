Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCD8C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9681F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfDWO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:57:41 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:30984 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfDWO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:57:41 -0400
X-IronPort-AV: E=Sophos;i="5.60,386,1549929600"; 
   d="scan'208";a="89179972"
Date:   Tue, 23 Apr 2019 16:56:01 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v2 1/2] xen/pvh: set xen_domain_type to HVM
 in xen_pvh_init
Message-ID: <20190423145601.7qwu63sz2ycg5ywj@Air-de-Roger>
References: <20190423130416.68935-1-roger.pau@citrix.com>
 <c2e1612e-d6c2-ba46-b49e-4e0fe95a1d7e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2e1612e-d6c2-ba46-b49e-4e0fe95a1d7e@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:37:51AM -0400, Boris Ostrovsky wrote:
> On 4/23/19 9:04 AM, Roger Pau Monne wrote:
> > Or else xen_domain() returns false despite xen_pvh being set.
> 
> Is this new xen_domain() invocation somewhere in EFI initialization that
> you add in the second patch?

Yes, there's a xen_initial_domain() call in xen_efi_probe() which
would return false without this fix.

> Asking because I am trying to figure out whether this needs to go to
> stable tree.

I'm not aware of this being an issue without the EFI code that I add
in patch 2, xen_domain_type would get set slightly later in the boot
process.

I guess both patches should be backported to 4.19 since that's the
only LTS release that has PVH dom0 support IIRC, and it would be good
to get this fixed.

Thanks, Roger.
