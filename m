Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E01ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0620820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440088AbfJQO23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbfJQO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:28:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34890307D985;
        Thu, 17 Oct 2019 14:28:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5859D5C1B5;
        Thu, 17 Oct 2019 14:28:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Oct 2019 16:28:27 +0200 (CEST)
Date:   Thu, 17 Oct 2019 16:28:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Message-ID: <20191017142824.GA453@redhat.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-5-songliubraving@fb.com>
 <20191016121031.GA31585@redhat.com>
 <CE3DD093-E5B4-4C98-A7B7-3B05D7732D3C@fb.com>
 <20191017084714.GB17513@redhat.com>
 <A1DBC6EA-CBAB-45FE-919D-6D77D29DDE1D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1DBC6EA-CBAB-45FE-919D-6D77D29DDE1D@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 14:28:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Song Liu wrote:
>
>
> > On Oct 17, 2019, at 1:47 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 10/16, Song Liu wrote:
> >>
> >>> On Oct 16, 2019, at 5:10 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >>>
> >>>> @@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >>>> 	if (ret <= 0)
> >>>> 		goto put_old;
> >>>>
> >>>> +	WARN(!is_register && PageCompound(old_page),
> >>>> +	     "uprobe unregister should never work on compound page\n");
> >>>
> >>> But this can happen with the change above. You can't know if *vaddr was
> >>> previously changed by install_breakpoint() or not.
> >>
> >>> If not, verify_opcode() should likely save us, but we can't rely on it.
> >>> Say, someone can write "int3" into vm_file at uprobe->offset.
> >>
> >> I think this won't really happen. With is_register == false, we already
> >> know opcode is not "int3", so current call must be from set_orig_insn().
> >> Therefore, old_page must be installed by uprobe, and cannot be compound.
> >>
> >> The other way is not guaranteed. With is_register == true, it is still
> >> possible current call is from set_orig_insn(). However, we do not rely
> >> on this path.
> >
> > Quite contrary.
> >
> > When is_register == true we know that a) the caller is install_breakpoint()
> > and b) the original insn is NOT int3 unless this page was alreadt COW'ed by
> > userspace, say, by gdb.
> >
> > If is_register == false we only know that the caller is remove_breakpoint().
> > We can't know if this page was COW'ed by uprobes or userspace, we can not
> > know if the insn we are going to replace is int3 or not, thus we can not
> > assume that verify_opcode() will fail and save us.
>
> So the case we worry about is:
> old_page is COW by user space,

no, in this case the page shouldn't be huge,

> target insn is int3, and it is a huge page;
> then uprobe calls remove_breakpoint();

Yes,

> Yeah, I guess this could happen.

Yes,

> For the fix, I guess return -Esomething in such case should be sufficient?

this is what I tried to suggest from the very beginning.

Oleg.

