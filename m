Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6480BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B372054F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfJHXVx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:21:53 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:50883 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHXVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:21:52 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x98NLWJi014370
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Oct 2019 08:21:32 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x98NLW2b008602;
        Wed, 9 Oct 2019 08:21:32 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x98NLHSZ010859;
        Wed, 9 Oct 2019 08:21:32 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9250569; Wed, 9 Oct 2019 08:18:32 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0439.000; Wed, 9
 Oct 2019 08:18:32 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
Thread-Topic: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
Thread-Index: AQHVfgQYMR1+dM5I0kqkeQcqu0tLzKdQyn2A
Date:   Tue, 8 Oct 2019 23:18:31 +0000
Message-ID: <20191008231831.GB27781@hori.linux.bs1.fc.nec.co.jp>
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
 <9af6b35d-bfbf-7f87-a419-042dff018fdd@oracle.com>
In-Reply-To: <9af6b35d-bfbf-7f87-a419-042dff018fdd@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9FE488C625E5C44BB985629469BD079F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

I think that this patchset is good enough and ready to be merged.
Andrew, could you consider queuing this series into your tree?

Thanks,
Naoya Horiguchi

On Tue, Oct 08, 2019 at 11:13:23AM -0700, Jane Chu wrote:
> Hi, Naoya,
> 
> What is the status of the patches?
> Is there anything I need to do from my end ?
> 
> Regards,
> -jane
> 
> On 8/6/2019 10:25 AM, Jane Chu wrote:
> > Change in v4:
> >   - remove trailing white space
> > 
> > Changes in v3:
> >   - move **tk cleanup to its own patch
> > 
> > Changes in v2:
> >   - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
> >   - ran checkpatch.pl check, pointed out by Matthew;
> >   - Noaya pointed out that v1 would have missed the SIGKILL
> >     if "tk->addr == -EFAULT", since the code returns early.
> >     Incorporated Noaya's suggestion, also, skip VMAs where
> >     "tk->size_shift == 0" for zone device page, and deliver SIGBUS
> >     when "tk->size_shift != 0" so the payload is helpful;
> >   - added Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > 
> > Jane Chu (2):
> >    mm/memory-failure.c clean up around tk pre-allocation
> >    mm/memory-failure: Poison read receives SIGKILL instead of SIGBUS if
> >      mmaped more than once
> > 
> >   mm/memory-failure.c | 62 ++++++++++++++++++++++-------------------------------
> >   1 file changed, 26 insertions(+), 36 deletions(-)
> > 
> 
