Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3984EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C21D2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfGQRWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:22:42 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:53567 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbfGQRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:22:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C9C23181D33FC;
        Wed, 17 Jul 2019 17:22:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream96_17037daa23b2d
X-Filterd-Recvd-Size: 2239
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jul 2019 17:22:37 +0000 (UTC)
Message-ID: <18469f4c80f3dbf04eda5415f4bcf1c8fa655370.camel@perches.com>
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
From:   Joe Perches <joe@perches.com>
To:     Juergen Gross <jgross@suse.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, x86@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
Date:   Wed, 17 Jul 2019 10:22:36 -0700
In-Reply-To: <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
         <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
         <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 08:49 +0200, Juergen Gross wrote:
> On 17.07.19 08:46, Joe Perches wrote:
> > On Tue, 2019-07-16 at 12:26 +0800, Zhenzhong Duan wrote:
> > > .. as "nopv" support needs it to be changeable at boot up stage.
> > > 
> > > Checkpatch reports warning, so move variable declarations from
> > > hypervisor.c to hypervisor.h
> > []
> > > diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> > []
> > > @@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
> > >   #endif
> > >   }
> > >   
> > > -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
> > > +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
> > 
> > static?
> 
> It is being referenced from arch/x86/kernel/cpu/hypervisor.c

But wasn't it also removed from the list of externs?

Rereading the .h file, no it wasn't.  I missed that.

Perhaps the extern list could be reordered to move this
x86_hyper_xen_hvm to be next to x86_hyper_type.

I also suggest that "extern bool nopv" might be a bit
non-specific and could use a longer identifier.


