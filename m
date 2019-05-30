Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A2A243EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfE3Bgl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:36:41 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55912 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:36:41 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4U1aBLY004110
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 10:36:11 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4U1aB2E021407;
        Thu, 30 May 2019 10:36:11 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4U1V0M6011627;
        Thu, 30 May 2019 10:36:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5509030; Thu, 30 May 2019 10:35:45 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Thu,
 30 May 2019 10:35:44 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: hugetlb: soft-offline: fix wrong return value of
 soft offline
Thread-Topic: [PATCH v1] mm: hugetlb: soft-offline: fix wrong return value
 of soft offline
Thread-Index: AQHVFFJeyxW0HZW72U2AA7NEa5OFu6aB3awAgABy1IA=
Date:   Thu, 30 May 2019 01:35:44 +0000
Message-ID: <20190530013549.GA28893@hori.linux.bs1.fc.nec.co.jp>
References: <1558937200-18544-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <81a37f9c-4a85-c18d-b882-f361c4998d45@oracle.com>
In-Reply-To: <81a37f9c-4a85-c18d-b882-f361c4998d45@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A86EE488D3DDAC4DB8641398482BD783@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, May 29, 2019 at 11:44:50AM -0700, Mike Kravetz wrote:
> On 5/26/19 11:06 PM, Naoya Horiguchi wrote:
> > Soft offline events for hugetlb pages return -EBUSY when page migration
> > succeeded and dissolve_free_huge_page() failed, which can happen when
> > there're surplus hugepages. We should judge pass/fail of soft offline by
> > checking whether the raw error page was finally contained or not (i.e.
> > the result of set_hwpoison_free_buddy_page()), so this behavior is wrong.
> > 
> > This problem was introduced by the following change of commit 6bc9b56433b76
> > ("mm: fix race on soft-offlining"):
> > 
> >                     if (ret > 0)
> >                             ret = -EIO;
> >             } else {
> >     -               if (PageHuge(page))
> >     -                       dissolve_free_huge_page(page);
> >     +               /*
> >     +                * We set PG_hwpoison only when the migration source hugepage
> >     +                * was successfully dissolved, because otherwise hwpoisoned
> >     +                * hugepage remains on free hugepage list, then userspace will
> >     +                * find it as SIGBUS by allocation failure. That's not expected
> >     +                * in soft-offlining.
> >     +                */
> >     +               ret = dissolve_free_huge_page(page);
> >     +               if (!ret) {
> >     +                       if (set_hwpoison_free_buddy_page(page))
> >     +                               num_poisoned_pages_inc();
> >     +               }
> >             }
> >             return ret;
> >      }
> > 
> > , so a simple fix is to restore the PageHuge precheck, but my code
> > reading shows that we already have PageHuge check in
> > dissolve_free_huge_page() with hugetlb_lock, which is better place to
> > check it.  And currently dissolve_free_huge_page() returns -EBUSY for
> > !PageHuge but that's simply wrong because that that case should be
> > considered as success (meaning that "the given hugetlb was already
> > dissolved.")
> 
> Hello Naoya,
> 
> I am having a little trouble understanding the situation.  The code above is
> in the routine soft_offline_huge_page, and occurs immediately after a call to
> migrate_pages() with 'page' being the only on the list of pages to be migrated.
> In addition, since we are in soft_offline_huge_page, we know that page is
> a huge page (PageHuge) before the call to migrate_pages.
> 
> IIUC, the issue is that the migrate_pages call results in 'page' being
> dissolved into regular base pages.  Therefore, the call to
> dissolve_free_huge_page returns -EBUSY and we never end up setting PageHWPoison
> on the (base) page which had the error.
> 
> It seems that for the original page to be dissolved, it must go through the
> free_huge_page routine.  Once that happens, it is possible for the (dissolved)
> pages to be allocated again.  Is that just a known race, or am I missing
> something?

No, your understanding is right.  I found that the last (and most important)
part of patch description ("this behavior is wrong") might be wrong.
Sorry about that and let me correct myself:

  - before commit 6bc9b56433b76, the return value of soft offline is the
    return of migrate_page(). dissolve_free_huge_page()'s return value is
    ignored.

  - after commit 6bc9b56433b76 soft_offline_huge_page() returns success
    only dissolve_free_huge_page() returns success.

This change is *mainly OK* (meaning nothing is broken), but there still
remains the room of improvement, that is, even in "dissolved from
free_huge_page()" case, we can try to call set_hwpoison_free_buddy_page() to
contain the 4kB error page, but we don't try it now because
dissolve_free_huge_page() return -EBUSY for !PageHuge case.

> 
> > This change affects other callers of dissolve_free_huge_page(),
> > which are also cleaned up by this patch.
> 
> It may just be me, but I am having a hard time separating the fix for this
> issue from the change to the dissolve_free_huge_page routine.  Would it be
> more clear or possible to create separate patches for these?

Yes, the change is actually an 'improvement' purely related to hugetlb,
and seems not a 'bug fix'. So I'll update the description.
Maybe no need to separate to patches.

Thanks,
Naoya Horiguchi
