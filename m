Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A3C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F1920640
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfIIQRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfIIQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B6673067285;
        Mon,  9 Sep 2019 16:17:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76ED660BF3;
        Mon,  9 Sep 2019 16:17:34 +0000 (UTC)
Date:   Mon, 9 Sep 2019 18:17:32 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com
Subject: Re: [PATCH] kvm_s390_vm_start_migration: check dirty_bitmap before
 using it as target for memset()
Message-ID: <20190909181732.2d079536@redhat.com>
In-Reply-To: <18230047-35d7-2dfb-948e-2645fcab18e7@redhat.com>
References: <20190909145545.11759-1-imammedo@redhat.com>
        <18230047-35d7-2dfb-948e-2645fcab18e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 09 Sep 2019 16:17:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 17:47:37 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 09.09.19 16:55, Igor Mammedov wrote:
> > If userspace doesn't set KVM_MEM_LOG_DIRTY_PAGES on memslot before calling
> > kvm_s390_vm_start_migration(), kernel will oops with:
> >   
> 
> We usually have the subject in a "KVM: s390: ..." format. Like
> 
> "KVM: s390: check dirty_bitmap before using it as target for memset()"
> 
> >   Unable to handle kernel pointer dereference in virtual kernel address space
> >   Failing address: 0000000000000000 TEID: 0000000000000483
> >   Fault in home space mode while using kernel ASCE.
> >   AS:0000000002a2000b R2:00000001bff8c00b R3:00000001bff88007 S:00000001bff91000 P:000000000000003d
> >   Oops: 0004 ilc:2 [#1] SMP
> >   ...
> >   Call Trace:
> >   ([<001fffff804ec552>] kvm_s390_vm_set_attr+0x347a/0x3828 [kvm])
> >    [<001fffff804ecfc0>] kvm_arch_vm_ioctl+0x6c0/0x1998 [kvm]
> >    [<001fffff804b67e4>] kvm_vm_ioctl+0x51c/0x11a8 [kvm]
> >    [<00000000008ba572>] do_vfs_ioctl+0x1d2/0xe58
> >    [<00000000008bb284>] ksys_ioctl+0x8c/0xb8
> >    [<00000000008bb2e2>] sys_ioctl+0x32/0x40
> >    [<000000000175552c>] system_call+0x2b8/0x2d8
> >   INFO: lockdep is turned off.
> >   Last Breaking-Event-Address:
> >    [<0000000000dbaf60>] __memset+0xc/0xa0
> > 
> > due to ms->dirty_bitmap being NULL, which migh crash the host.  
> 
> s/migh/might/
> 
> > 
> > Make sure that ms->dirty_bitmap is set before using it or
> > print a warning and return -ENIVAL otherwise.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > 
> > PS:
> >   keeping it private for now as issue might DoS host,
> >   I'll leave it upto maintainers to decide if it should be handled as security
> >   bug (I'm not sure what process for handling such bugs should be used).
> > 
> > 
> >  arch/s390/kvm/kvm-s390.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index f329dcb3f44c..dfba51c9d60c 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -1018,6 +1018,10 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
> >  	/* mark all the pages in active slots as dirty */
> >  	for (slotnr = 0; slotnr < slots->used_slots; slotnr++) {
> >  		ms = slots->memslots + slotnr;
> > +		if (!ms->dirty_bitmap) {
> > +			WARN(1, "ms->dirty_bitmap == NULL\n");
> > +			return -EINVAL;
> > +		}  
> 
> if (WARN_ON_ONCE(!ms->dirty_bitmap))
> 	return -EINVAL;
> 
> But I wonder if the WARN is really needed. (or simply a wrong usage of the interface)
I added WARN because of there is no any visible sign that something
went wrong in userspace, this way at least we would have a trace of
invalid API usage.

But I can drop it if you prefer.

> 
> 
> >  		/*
> >  		 * The second half of the bitmap is only used on x86,
> >  		 * and would be wasted otherwise, so we put it to good
> >   
> 
> You should add
> 
> Fixes: afdad61615cc ("KVM: s390: Fix storage attributes migration with memory slots")
> Cc: stable@vger.kernel.org # v4.19+
> 
> Thanks!

