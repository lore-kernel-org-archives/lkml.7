Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A549C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275020665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfIRVCZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:02:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:20934 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfIRVCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:02:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 14:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="186585820"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2019 14:02:24 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 14:02:24 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Sep 2019 14:02:23 -0700
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Sep 2019 14:02:23 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.63]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.210]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 15:02:21 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "gdb-patches@sourceware.org" <gdb-patches@sourceware.org>,
        Joel Brobecker <brobecker@adacore.com>,
        Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH v8 00/17] Enable FSGSBASE instructions
Thread-Topic: [PATCH v8 00/17] Enable FSGSBASE instructions
Thread-Index: AQHVaaXKMlv63mWJSE+2kNrvmPQ3k6cpY7YAgAj2SoA=
Date:   Wed, 18 Sep 2019 21:02:20 +0000
Message-ID: <321CD2BC-29E8-4537-A128-7DB24ECBC201@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
 <034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org>
In-Reply-To: <034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.155.235]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DFDB27BC94EDB46A20F55F4BC387229@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 12, 2019, at 21:10, Andy Lutomirski <luto@kernel.org> wrote:
> 
> I also think that, before this series can have my ack, it needs an actual gdb maintainer to chime in, publicly, and state that they have thought about and tested the ABI changes and that gdb still works on patched kernels with and without FSGSBASE enabled.  I realize that there were all kinds of discussions, but they were all quite theoretical, and I think that the actual patches need to be considered by people who understand the concerns.  Specific test cases would be nice, too.
> 
> Finally, I wrote up some notes here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=70a7d284989e3539ee84f9d709d6450099f773fb
> 
> I want to make sure that they're accounted for, and that patch should possibly be applied.  The parent (broken link, but should fix itself soon):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=166324e907f8a71c823b41bbc2e1b5bc711532d8
> 
> may also help understand the relevant code.

Adds GDB folks and here is a link to the patch0 entry in this series for them:

https://lore.kernel.org/lkml/1568318818-4091-1-git-send-email-chang.seok.bae@intel.com/

Thanks,
Chang
