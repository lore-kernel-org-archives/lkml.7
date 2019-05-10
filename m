Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01632C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D3217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfEJRgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:36:03 -0400
Received: from foss.arm.com ([217.140.101.70]:53646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfEJRgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:36:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D33F9A78;
        Fri, 10 May 2019 10:36:02 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 756553F6C4;
        Fri, 10 May 2019 10:36:00 -0700 (PDT)
Date:   Fri, 10 May 2019 18:35:56 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Message-ID: <20190510183556.24c33f02@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:50:29 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi Fenghua, Babu,

> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.

That's very much appreciated! We decided to use that tool here to detect
regressions in James' upcoming resctrl rework series. While doing so we
spotted some shortcomings:
- There is some unconditional x86 inline assembly which obviously breaks
the build on ARM.
- The result output is somewhat confusing, I find it hard to see whether a
test succeeded or not, also it's not easily parseable by scripts.
- There are some basic tests missing (does the filesystem exist? Is the
mount point visible?)
- Some tests create files in the current directory. This is somewhat
confusing if you happen to be in some sysfs directory, for instance. I
don't think we really need temporary files (pipes should cover most of the
cases), but in case we do, we should create them in some /tmp directory,
probably by using a glibc function for this.
- There were some problems that newer GCC and clang complained about.

For now I didn't look too closely at the actual test algorithms, but
decided to fix those things first. I replied to some of the smaller issues
I spotted on the way in the individual patch mails.

For the bigger things (new tests, result formatting) I just went ahead and
fixed them in my own branch [1] (work in progress!). I went with TAP
formatting, because this is both readable by humans and can be processed
by the "prove" tool (or any other simple UNIX tool, for that matter).

I used this amended version to do some regression testing on James'
resctrl rework series, which involved boot testing more than 100 patches,
so automation is key here. The result looks like this:
===================
TAP version 13
ok kernel supports resctrl filesystem
ok resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem not mounted
# Starting MBM BW change ...
ok MBM: bw change # SKIP memory bandwidth not supported
# Starting MBA Schemata Change ...
ok MBA: change-schemata # SKIP memory bandwidth not supported
# Starting CQM test ...
ok mounting resctrl to "/sys/fs/resctrl"
ok CQM: test # SKIP L3 not supported
# Starting CAT test ...
ok mounting resctrl to "/sys/fs/resctrl"
cache size :31457280
ok writing benchmark parameters to resctrl FS
ok Write schema "L3:0=7fff" to resctrl FS
ok cache difference more than 4 %
# Percent diff=16
# Number of bits: 15
# Avg_llc_perf_miss: 306994
# Allocated cache lines: 368640
ok CAT: test
1..11
=================

Appreciate any feedback on this!

Cheers,
Andre.

[1] http://linux-arm.org/git?p=linux-ap.git;a=shortlog;h=refs/heads/resctrl-selftests-wip
git://linux-arm.org/linux-ap.git    branch: resctrl-selftests-wip

> We introduce resctrl selftest to cover resctrl features on both
> X86 and ARM architectures. It first implements MBM (Memory Bandwidth
> Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
> Technology), and CQM (Cache QoS Monitoring)  tests. We can enhance
> the selftest tool to include more functionality tests in future.
> 
> The tool has been tested on both Intel RDT and AMD QoS.
> 
> There is an existing resctrl test suite 'intel_cmt_cat'. But the major
> purpose of the tool is to test Intel(R) RDT hardware via writing and
> reading MSR registers. It does access resctrl file system; but the
> functionalities are very limited. And it doesn't support automatic test
> and a lot of manual verifications are involved.
> 
> So the selftest tool we are introducing here provides a convenient
> tool which does automatic resctrl testing, is easily available in kernel
> tree, and will be extended to AMD QoS and ARM MPAM.
> 
> The selftest tool is in tools/testing/selftests/resctrl in order to have
> generic test code for all architectures.
> 
> Changelog:
> v7:
> - Fix a few warnings when compiling patches separately, pointed by Babu 
> 
> v6:
> - Fix a benchmark reading optimized out issue in newer GCC.
> - Fix a few coding style issues.
> - Re-arrange code among patches to make cleaner code. No change in patches
> structure.
> 
> v5:
> - Based the v4 patches submitted by Fenghua Yu and added changes to support
>   AMD.
> - Changed the function name get_sock_num to get_resource_id. Intel uses
>   socket number for schemata and AMD uses l3 index id. To generalize,
>   changed the function name to get_resource_id.
> - Added the code to detect vendor.
> - Disabled the few tests for AMD where the test results are not clear.
>   Also AMD does not have IMC.
> - Fixed few compile issues.
> - Some cleanup to make each patch independent.
> - Tested the patches on AMD system. Fenghua, Need your help to test on
>   Intel box. Please feel free to change and resubmit if something
>    broken.
> - Here is the link for previous version.
>   https://lore.kernel.org/lkml/1545438038-75107-1-git-send-email-fenghua.yu=
> @intel.com/
> 
> v4:
> - address comments from Balu and Randy
> - Add CAT and CQM tests
> 
> v3:
> - Change code based on comments from Babu Moger
> - Remove some unnessary code and use pipe to communicate b/w processes
> 
> v2:
> - Change code based on comments from Babu Moger
> - Clean up other places.
> 
> Arshiya Hayatkhan Pathan (4):
>   selftests/resctrl: Add MBM test
>   selftests/resctrl: Add MBA test
>   selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
>   selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
> 
> Babu Moger (3):
>   selftests/resctrl: Add vendor detection mechanism
>   selftests/resctrl: Use cache index3 id for AMD schemata masks
>   selftests/resctrl: Disable MBA and MBM tests for AMD
> 
> Fenghua Yu (2):
>   selftests/resctrl: Add README for resctrl tests
>   selftests/resctrl: Add the test in MAINTAINERS
> 
> Sai Praneeth Prakhya (4):
>   selftests/resctrl: Add basic resctrl file system operations and data
>   selftests/resctrl: Read memory bandwidth from perf IMC counter and
>     from resctrl file system
>   selftests/resctrl: Add callback to start a benchmark
>   selftests/resctrl: Add built in benchmark
> 
>  MAINTAINERS                                     |   1 +
>  tools/testing/selftests/resctrl/Makefile        |  16 +
>  tools/testing/selftests/resctrl/README          |  54 ++
>  tools/testing/selftests/resctrl/cache.c         | 274 +++++++++
>  tools/testing/selftests/resctrl/cat_test.c      | 242 ++++++++
>  tools/testing/selftests/resctrl/cqm_test.c      | 173 ++++++
>  tools/testing/selftests/resctrl/fill_buf.c      | 210 +++++++
>  tools/testing/selftests/resctrl/mba_test.c      | 178 ++++++
>  tools/testing/selftests/resctrl/mbm_test.c      | 150 +++++
>  tools/testing/selftests/resctrl/resctrl.h       | 117 ++++
>  tools/testing/selftests/resctrl/resctrl_tests.c | 238 ++++++++
>  tools/testing/selftests/resctrl/resctrl_val.c   | 723 ++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c     | 668 ++++++++++++++++++++++
>  13 files changed, 3044 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/Makefile
>  create mode 100644 tools/testing/selftests/resctrl/README
>  create mode 100644 tools/testing/selftests/resctrl/cache.c
>  create mode 100644 tools/testing/selftests/resctrl/cat_test.c
>  create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
>  create mode 100644 tools/testing/selftests/resctrl/mba_test.c
>  create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c
> 

