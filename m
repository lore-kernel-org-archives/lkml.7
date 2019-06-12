Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBCFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2024220874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfFLHZj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:25:39 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:38240 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfFLHZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:25:38 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5C7PBVo017699
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 16:25:11 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5C7PBwD001465;
        Wed, 12 Jun 2019 16:25:11 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5C7NqIT021960;
        Wed, 12 Jun 2019 16:25:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1232875; Wed, 12 Jun 2019 15:48:25 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Wed,
 12 Jun 2019 15:48:24 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
Thread-Topic: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
Thread-Index: AQHVH2UNBW9Lhf3e5UinMjf59GXrMKaVARSAgAAKeoCAAHo+AIABejoA
Date:   Wed, 12 Jun 2019 06:48:23 +0000
Message-ID: <20190612064830.GA25015@hori.linux.bs1.fc.nec.co.jp>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <8e8e6afc-cddb-9e79-c8ae-c2814b73cbe9@oracle.com>
 <20190611005715.GB5187@hori.linux.bs1.fc.nec.co.jp>
 <67bb5891-d0be-ffb8-3161-092c8167a960@arm.com>
In-Reply-To: <67bb5891-d0be-ffb8-3161-092c8167a960@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <65E535AA03EEC54FB0EF6A3FD422054B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 01:44:46PM +0530, Anshuman Khandual wrote:
> 
> 
> On 06/11/2019 06:27 AM, Naoya Horiguchi wrote:
> > On Mon, Jun 10, 2019 at 05:19:45PM -0700, Mike Kravetz wrote:
> >> On 6/10/19 1:18 AM, Naoya Horiguchi wrote:
> >>> The pass/fail of soft offline should be judged by checking whether the
> >>> raw error page was finally contained or not (i.e. the result of
> >>> set_hwpoison_free_buddy_page()), but current code do not work like that.
> >>> So this patch is suggesting to fix it.
> >>>
> >>> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >>> Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
> >>> Cc: <stable@vger.kernel.org> # v4.19+
> >>
> >> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > Thank you, Mike.
> > 
> >>
> >> To follow-up on Andrew's comment/question about user visible effects.  Without
> >> this fix, there are cases where madvise(MADV_SOFT_OFFLINE) may not offline the
> >> original page and will not return an error.
> > 
> > Yes, that's right.
> 
> Then should this be included in the commit message as well ?

Right, I'll clarify the point in the description.

Thanks,
- Naoya
