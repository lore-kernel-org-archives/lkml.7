Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62ADC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68C217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEJTUy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:20:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:13409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfEJTUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:20:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 12:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,454,1549958400"; 
   d="scan'208";a="170423417"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2019 12:20:52 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.121]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.212]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 12:20:51 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: RE: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHVB1bfoyqOXqonrkGnK2NSEBmn6qZkuI3A
Date:   Fri, 10 May 2019 19:20:50 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3BFE@ORSMSX106.amr.corp.intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <20190510183556.24c33f02@donnerap.cambridge.arm.com>
In-Reply-To: <20190510183556.24c33f02@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Friday, May 10, 2019 10:36 AM
>Andre Przywara [mailto:andre.przywara@arm.com] wrote:
> On Sat,  9 Feb 2019 18:50:29 -0800
> Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> Hi Fenghua, Babu,
> 
> > With more and more resctrl features are being added by Intel, AMD and
> > ARM, a test tool is becoming more and more useful to validate that
> > both hardware and software functionalities work as expected.
> 
> That's very much appreciated! We decided to use that tool here to detect
> regressions in James' upcoming resctrl rework series. While doing so we
> spotted some shortcomings:

This is great!

> - There is some unconditional x86 inline assembly which obviously breaks
> the build on ARM.

Will fix this as much as possible.

BTW, does ARM support perf imc_count events which are used in CAT tests?

> - The result output is somewhat confusing, I find it hard to see whether a
> test succeeded or not, also it's not easily parseable by scripts.
> - There are some basic tests missing (does the filesystem exist? Is the
> mount point visible?)

Is it OK to fold the basic tests into bigger tests? E.g. the filesystem and mount point
tests are actually part of CAT test and we just dump the sub-test results during CAT test.
Seems your test results show the sub-test results during CAT test.

> - Some tests create files in the current directory. This is somewhat confusing
> if you happen to be in some sysfs directory, for instance. I don't think we
> really need temporary files (pipes should cover most of the cases), but in
> case we do, we should create them in some /tmp directory, probably by
> using a glibc function for this.

You are right. Will generate the temp file in /tmp.

> - There were some problems that newer GCC and clang complained about.

Which GCC do you use to see the issues? We use 8.2.1 and no compilation issue is reported.

> 
> For now I didn't look too closely at the actual test algorithms, but decided
> to fix those things first. I replied to some of the smaller issues I spotted on
> the way in the individual patch mails.
> 
> For the bigger things (new tests, result formatting) I just went ahead and
> fixed them in my own branch [1] (work in progress!). I went with TAP
> formatting, because this is both readable by humans and can be processed
> by the "prove" tool (or any other simple UNIX tool, for that matter).
> 
> I used this amended version to do some regression testing on James'
> resctrl rework series, which involved boot testing more than 100 patches, so
> automation is key here. The result looks like this:
> ===================
> TAP version 13
> ok kernel supports resctrl filesystem
> ok resctrl mountpoint "/sys/fs/resctrl" exists # resctrl filesystem not
> mounted # Starting MBM BW change ...
> ok MBM: bw change # SKIP memory bandwidth not supported # Starting
> MBA Schemata Change ...
> ok MBA: change-schemata # SKIP memory bandwidth not supported #
> Starting CQM test ...
> ok mounting resctrl to "/sys/fs/resctrl"
> ok CQM: test # SKIP L3 not supported
> # Starting CAT test ...
> ok mounting resctrl to "/sys/fs/resctrl"
> cache size :31457280
> ok writing benchmark parameters to resctrl FS ok Write schema "L3:0=7fff"
> to resctrl FS ok cache difference more than 4 % # Percent diff=16 # Number
> of bits: 15 # Avg_llc_perf_miss: 306994 # Allocated cache lines: 368640 ok
> CAT: test
> 1..11
> =================
> 
> Appreciate any feedback on this!
> 
> Cheers,
> Andre.
> 
> [1] http://linux-arm.org/git?p=linux-ap.git;a=shortlog;h=refs/heads/resctrl-
> selftests-wip
> git://linux-arm.org/linux-ap.git    branch: resctrl-selftests-wip


