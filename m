Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C597C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E683F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCMdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B024AC067C06;
        Wed,  3 Apr 2019 12:33:41 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1335C883;
        Wed,  3 Apr 2019 12:33:35 +0000 (UTC)
Date:   Wed, 3 Apr 2019 14:33:33 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and
 refactor struct
Message-ID: <20190403143333.2a3db681.cohuck@redhat.com>
In-Reply-To: <599addd3-a4f8-d4e7-5898-dc45f52cd7a6@redhat.com>
References: <20190402174636.15175-1-walling@linux.ibm.com>
        <20190402174636.15175-2-walling@linux.ibm.com>
        <599addd3-a4f8-d4e7-5898-dc45f52cd7a6@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 03 Apr 2019 12:33:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 14:03:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 02.04.19 19:46, Collin Walling wrote:
> > Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
> > for the availability of hardware support for the instruction.
> > 
> > In order to support this instruction for a KVM/QEMU guest, we
> > would need to provide modifications to the SCLP Read SCP Info
> > data, which will in turn reduce the maximum number of CPUs that
> > may be provided to the guest. This issue introduces compatability
> > and legacy concerns.
> > 
> > Let's circumvent this issue by removing the bit check and blindly
> > executing the instruction. An exception table rule is in place to
> > catch the case where hardware does not support this instruction.
> > 
> > While we're at it, let's condense the version code fields in the
> > diag318_info struct until we can determine how it will be used.
> > 
> > This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43
> > 
> > Signed-off-by: Collin Walling <walling@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/diag.h |  6 ++----
> >  arch/s390/kernel/setup.c     | 12 ++++++------
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
> > index 19562be22b7e..215516284175 100644
> > --- a/arch/s390/include/asm/diag.h
> > +++ b/arch/s390/include/asm/diag.h
> > @@ -298,10 +298,8 @@ struct diag26c_mac_resp {
> >  union diag318_info {
> >  	unsigned long val;
> >  	struct {
> > -		unsigned int cpnc : 8;
> > -		unsigned int cpvc_linux : 24;
> > -		unsigned char cpvc_distro[3];
> > -		unsigned char zero;
> > +		unsigned long cpnc : 8;
> > +		unsigned long cpvc : 56;

That part looks reasonable (we don't have a proper convention yet, have
we?)

> >  	};
> >  };
> >  
> > diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> > index 2c642af526ce..fe70201f8b5d 100644
> > --- a/arch/s390/kernel/setup.c
> > +++ b/arch/s390/kernel/setup.c
> > @@ -1011,15 +1011,15 @@ static void __init setup_control_program_code(void)
> >  {
> >  	union diag318_info diag318_info = {
> >  		.cpnc = CPNC_LINUX,
> > -		.cpvc_linux = 0,
> > -		.cpvc_distro = {0},
> > +		.cpvc = 0,
> >  	};
> >  
> > -	if (!sclp.has_diag318)
> > -		return;
> > -
> >  	diag_stat_inc(DIAG_STAT_X318);
> > -	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
> > +	asm volatile(
> > +		"	diag	%0,0,0x318\n"
> > +		"0:	nopr	%%r7\n"
> > +		EX_TABLE(0b,0b)
> > +		: : "d" (diag318_info.val));
> >  }
> >  
> >  /*
> >   
> 
> That smells like a nasty hack to not expose new features in QEMU and
> deal with the issue of handling CPU limits. No, I don't like this.
> 
> Fix QEMU, not the kernel.
> 

I agree. The compat handling is a bit annoying, but I don't think we
can get around it.
