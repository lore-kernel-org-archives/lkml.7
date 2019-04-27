Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D122C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAD1206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anuLVemm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfD0BxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:53:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36378 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfD0BxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:53:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id w20so1734606plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0VKk+EAi5u5Uun6wBIN+muqXBgzzEs95GkHwVG5AAA=;
        b=anuLVemm2cS9eYF8xrdrwSlIQY4mMWHdXLDko+6AmctdVHFyF5pQaGa1SeN03K7rrV
         OCNQzJvzftqVbUoLyHTYPZBbUnfJcKDZ5UdXqXHSKsGDdAWUglACEGTREID86yWfbit9
         dVLK7b97qd2DLolrjLXXfo2U5j3jMBwunkG8+NqUhpUllSrofHUg02I7+bbDVIAtTCii
         5/YFx7IoojLdfRZ37NfXOGWRI39lUQQL3a2F9NsFiAS/QJJpqxZCxHBLdMC9oHJWqACB
         PJm6bC6+IXoHRaW55sgvw2UwKZGVHppqkASMv3q6vxVLu3vCMSw2zpVYFG1iFY+IyFsO
         Kfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C0VKk+EAi5u5Uun6wBIN+muqXBgzzEs95GkHwVG5AAA=;
        b=qmISKlyoc2eqgGWXR6ZeEYnCp5s8a1RaaIpsRmDzYI1mZRk1P2DDYRf065CzTApDtU
         zZqwaaHBDj0JtTx5y8scalXES1h0svgb2m6933r/8N2Fi70J5UBVNj6++MZ31vIWd+pC
         tstV4IZYCaVamNG2dozX01PU9YbAk+lrqIfEQI0sdGrCKdFo5LHW2iE8IEs3skVBIpGw
         00O4bPdv0Za5spZJFjCxZtj8Z8Lf/8juGwZYE1K6YXFv9Qc3AkcjTRZF2+lcxvgTUhDN
         aRfz5MdBOCNGsB+aEaRM2nawCKtmrwCDDvRkknUfLoo79lirAcnCrqQGPqQEa1FUarjh
         vm8A==
X-Gm-Message-State: APjAAAWnoyNtx4sC6kXBhzKpAX/pZV+f2G8RtvzrtNZtVi0os1x6RMBf
        ICqzqxAqwfeJtQiVDq9AfpdkYg==
X-Google-Smtp-Source: APXvYqzLc91mh/R/1sCU3aj6tk7P3taVwaDKlm61Xk6iVK1dTUs3AnXwhAqNlKEB6ez6miyXsn0kYQ==
X-Received: by 2002:a17:902:7206:: with SMTP id ba6mr14556564plb.301.1556330000083;
        Fri, 26 Apr 2019 18:53:20 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id f63sm46374543pfc.180.2019.04.26.18.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 18:53:17 -0700 (PDT)
Date:   Fri, 26 Apr 2019 18:53:15 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, dave@stgolabs.net,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, haren@linux.vnet.ibm.com,
        Nick Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <20190427015315.GA174296@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
 <20190423093851.GJ11158@hirez.programming.kicks-ass.net>
 <05df6720-7130-62fe-a71f-074b6fafff3e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05df6720-7130-62fe-a71f-074b6fafff3e@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:33:44AM +0200, Laurent Dufour wrote:
> Le 23/04/2019 à 11:38, Peter Zijlstra a écrit :
> > On Mon, Apr 22, 2019 at 02:29:16PM -0700, Michel Lespinasse wrote:
> > > The proposed spf mechanism only handles anon vmas. Is there a
> > > fundamental reason why it couldn't handle mapped files too ?
> > > My understanding is that the mechanism of verifying the vma after
> > > taking back the ptl at the end of the fault would work there too ?
> > > The file has to stay referenced during the fault, but holding the vma's
> > > refcount could be made to cover that ? the vm_file refcount would have
> > > to be released in __free_vma() instead of remove_vma; I'm not quite sure
> > > if that has more implications than I realize ?
> > 
> > IIRC (and I really don't remember all that much) the trickiest bit was
> > vs unmount. Since files can stay open past the 'expected' duration,
> > umount could be delayed.
> > 
> > But yes, I think I had a version that did all that just 'fine'. Like
> > mentioned, I didn't keep the refcount because it sucked just as hard as
> > the mmap_sem contention, but the SRCU callback did the fput() just fine
> > (esp. now that we have delayed_fput).
> 
> I had to use a refcount for the VMA because I'm using RCU in place of SRCU
> and only protecting the RB tree using RCU.
> 
> Regarding the file pointer, I decided to release it synchronously to avoid
> the latency of RCU during the file closing. As you mentioned this could
> delayed the umount but not only, as Linus Torvald demonstrated by the past
> [1]. Anyway, since the file support is not yet here there is no need for
> that currently.
>
> [1] https://lore.kernel.org/linux-mm/alpine.LFD.2.00.1001041904250.3630@localhost.localdomain/

Just to make sure I understand this correctly. If a program tries to
munmap a region while page faults are occuring (which means that the
program has a race condition in the first place), before spf the
mmap_sem would delay the munmap until the page fault completes. With
spf the munmap will happen immediately, while the vm_ops->fault()
is running, with spf holding a ref to the file. vm_ops->fault is
expected to execute a read from the file to the page cache, and the
page cache page will never be mapped into the process because after
taking the ptl, spf will notice the vma changed.  So, the side effects
that may be observed after munmap completes would be:

- side effects from reading a file into the page cache - I'm not sure
  what they are, the main one I can think of is that userspace may observe
  the file's atime changing ?

- side effects from holding a reference to the file - which userspace
  may observe by trying to unmount().

Is that the extent of the side effects, or are there more that I have
not thought of ?

> Regarding the file mapping support, the concern is to ensure that
> vm_ops->fault() will not try to release the mmap_sem. This is true for most
> of the file system operation using the generic one, but there is currently
> no clever way to identify that except by checking the vm_ops->fault pointer.
> Adding a flag to the vm_operations_struct structure is another option.
> 
> that's doable as far as the underlying fault() function is not dealing with
> the mmap_sem, and I made a try by the past but was thinking that first the
> anonymous case should be accepted before moving forward this way.

Yes, that makes sense. Updating all of the fault handlers would be a
lot of work - but there doesn't seem to be anything fundamental that
wouldn't work there (except for the side effects of reordering spf
against munmap, as discussed above, which doesn't look easy to fully hide.).

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
