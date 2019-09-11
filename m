Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3CECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485AE2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfIKHWg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:22:36 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45536 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:22:35 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x8B7MKAk020343
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 11 Sep 2019 16:22:20 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8B7MK2T021862;
        Wed, 11 Sep 2019 16:22:20 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8B7MDR1021065;
        Wed, 11 Sep 2019 16:22:20 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-936117; Wed, 11 Sep 2019 16:21:14 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Wed,
 11 Sep 2019 16:21:13 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "osalvador@suse.de" <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] Hwpoison soft-offline rework
Thread-Topic: [PATCH 00/10] Hwpoison soft-offline rework
Thread-Index: AQHVZ8LTy7PIWQBirkyAnAoCBs9f5aclXX4AgAAOxICAAAOJAIAADMoA
Date:   Wed, 11 Sep 2019 07:21:12 +0000
Message-ID: <20190911072112.GA12499@hori.linux.bs1.fc.nec.co.jp>
References: <20190910103016.14290-1-osalvador@suse.de>
 <20190911052956.GA9729@hori.linux.bs1.fc.nec.co.jp>
 <20190911062246.GA31960@hori.linux.bs1.fc.nec.co.jp>
 <59dce1bc205b10f67f17cf9d2e1e7a04@suse.de>
In-Reply-To: <59dce1bc205b10f67f17cf9d2e1e7a04@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <80CDEFCDA81BC34D9226C8BC8FBFE853@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:35:26AM +0200, osalvador@suse.de wrote:
> On 2019-09-11 08:22, Naoya Horiguchi wrote:
> > I found another panic ...
> 
> Hi Naoya,
> 
> Thanks for giving it a try. Are these testcase public?
> I will definetely take a look and try to solve these cases.

It's available on https://github.com/Naoya-Horiguchi/mm_regression.
The README is a bit obsolete (sorry about that ...,) but you can run
the testcase like below:

  $ git clone https://github.com/Naoya-Horiguchi/mm_regression
  $ cd mm_regression
  mm_regression $ git clone https://github.com/Naoya-Horiguchi/test_core 
  mm_regression $ make
  // you might need to install some dependencies like numa library and mce-inject tool
  mm_regression $ make update_recipes

To run the single testcase, run the commands like below:

  mm_regression $ RECIPEFILES=cases/page_migration/hugetlb_migratepages_allocate1_noovercommit.auto2 bash run.sh
  mm_regression $ RECIPEFILES=cases/cases/mce_ksm_soft-offline_avoid_access.auto2 bash run.sh
  
You can run a set of many testcases with the commands like below:

  mm_regression $ RECIPEFILES=cases/cases/mce_ksm_* bash run.sh
  // run all ksm related testcases. I reproduced the panic with this command.

  mm_regression $ run_class=simple bash run.sh
  // run the set of minimum testcases I run for each releases.

Hopefully this will help you.

Thanks,
Naoya Horiguchi
