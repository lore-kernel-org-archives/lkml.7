Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B09C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7BD2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FD+FwAAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfLQSZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:25:41 -0500
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:29413
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfLQSZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:25:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVuSEvmua5c7Ibf+EYnRD1p0eBefVrUjchkenIAdX5pwAE9vSoHNaMah/APXGSu9t/CZ25fgdQNxhbFxNH6a8GQz6AikEAmqtHsgq2of4/Abc1NmjNTdmkXLBdzMygsUqE4cluhi0pHJfky+mCcNhyaYEKnu/KiV9w6D69HYu4+LsU+c2F0DCR7UoEPKdc1iV8me37Nw25iKXpksRnJA2PmUVGzajk55pXTKYAZLtnNObRyoqnJ1O4/VbrvsNNz5FZAaJYYk7VIRFU+K3ryZC9E7hluHMujjJ1BmAWZrxM0TjSzaU/3OYvr4t9DodrFlC+DRuymhGei+EtTK6b68Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeoTTJUmZsjndKa2qdmMRxsX5mjEJ2RUMRZp1blrU1U=;
 b=GP9xvfCfAkPhRX8oPtsHgV70+aAS852O5ZoLNUwsTyqYf7syxIpITbohBmA/XnGgtm7qLquYc4300dFFx8hic4cLSqUkdx0Eo/AF/L0906zXsXLDRPcb5G/+yuXwkWTCDBLtz6i36AcV82dbqMCX+hJUgh181ZV2K+sfyx8BouXFJAocdnQtA/sSGJOYI5hHgNVKgoXdUFLmucp3hG/gKrXeb+Po4jsirKOXzKbFwrSGtiUIL4s2TtWw/jI5XW48NVKs+XUP4QpVehtr9o9xhe2LcKFN0tVXjtwyZK93tERH2K/WSXOEliaIkWJUjTbJxarRipprDPXFceFE1RJRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeoTTJUmZsjndKa2qdmMRxsX5mjEJ2RUMRZp1blrU1U=;
 b=FD+FwAAR/GZtRkCL3OLO6ols2VcSbWWv5eXANqHDiojpWtN7gnEi9yOkOkkQevcS0aQPlMx6PEZVzUPKiuMO/TH9MzkO5j2FULh0ArlsL50exGx/uq0koF3eYR1zwxWdScuf/EjaLUc4GeZq1ot61LzqMAPmtRO+xd1a2uDU8+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1370.namprd12.prod.outlook.com (10.168.238.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Tue, 17 Dec 2019 18:23:57 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::21c2:e26e:92df:a819]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::21c2:e26e:92df:a819%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:23:57 +0000
Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <7aacc3e8-4072-c6b9-5d0f-f687a40ad315@amd.com>
Date:   Tue, 17 Dec 2019 12:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0133.namprd12.prod.outlook.com
 (2603:10b6:0:51::29) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b23ffb91-79d5-4098-89f5-08d7831e47e6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13707F811EF171C9F11489C995500@DM5PR12MB1370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(51914003)(54534003)(189003)(199004)(5660300002)(26005)(186003)(44832011)(478600001)(53546011)(6506007)(2906002)(52116002)(36756003)(2616005)(8676002)(66556008)(110136005)(66476007)(4326008)(6512007)(86362001)(316002)(7416002)(54906003)(6486002)(31686004)(8936002)(81156014)(81166006)(66946007)(31696002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2ssCDorEFKwU+U95Odbuqgcu8boB5sSqizKPig9wuM62xNK/ZvxiJ77tDRzJKONkP8pgZQhW336qXrLtbPGdtlyjIb6HfldyXJGFr6+2CSSaV+2Dz4TZDInOTNMjccjT2l+GlGWe/tq0f/LJuR/tHTWa3x+ppAeygD2S4XpW8fzeXavyptrNYFZKiEU+mIUMsHaJ7fIguB219hszEB9Q3lHY6mymS6E0ItZ/UphA7LOjQIpRGHxScBF8qCVQqo38RY9/e0rmlRAAyLL4RdnfMzi00WD95TBIx1vtHMYs4l85mVvidT2rAGdbDKIBiA0XaOtb1upHcncSCP7boKHLcvwdgZe97Q/DeaEm85fVZIi3KG/CAV2Vb66B3vjvg+ZYErjx1r8oYReoZuD8xXS8DkMKYAnchR966RqkIrBGPNhUpZuTmq2jOON2NJJaVkTlJTjffZNL9e4abWouBiTFJZjHcki5Fac+bgIKNt4MHdwIr2UOc6M8H8rnsfEGry/FSE5H37F0/hZuJF861TGnNGIiRLqylxmuCcdtGmkdf5jRjTS7ednqiYDejLtIZwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23ffb91-79d5-4098-89f5-08d7831e47e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 18:23:57.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLnphMxYdzIJenV+fmRK5z8uBkERUhHmKxtlJ4NuLCwtjTtjsa/OeKXb5o2AQxuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,
Thanks for the patches. I did a quick test. I am seeing some failures with
this series. I need to debug to figure out what is going on. Hopefully I
will be able to spend sometime this week or next week. I will be out for
few days this week and also next week. Here is the failure..

# ./resctrl_tests -t cat
TAP version 13
ok kernel supports resctrl filesystem
ok resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem is mounted
# dmesg: [    6.558645] resctrl: L3 allocation detected
# dmesg: [    6.558646] resctrl: L3DATA allocation detected
# dmesg: [    6.558646] resctrl: L3CODE allocation detected
# dmesg: [    6.558647] resctrl: MB allocation detected
# dmesg: [    6.558647] resctrl: L3 monitoring detected
# Starting CAT test ...
ok mounting resctrl to "/sys/fs/resctrl"
cache size :16777216
ok writing benchmark parameters to resctrl FS
ok writing benchmark parameters to resctrl FS
ok Write schema "L3:0=7ff" to resctrl FS
ok Write schema "L3:15=f800" to resctrl FS
Error opening leader: No such file or directory
Killed


On 12/16/19 4:26 PM, Fenghua Yu wrote:
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.
> 
> We introduce resctrl selftest to cover resctrl features on X86, AMD
> and ARM architectures. It first implements MBM (Memory Bandwidth
> Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
> Technology), and CQM (Cache QoS Monitoring)  tests. We will enhance
> the selftest tool to include more functionality tests in the future.
> 
> The tool has been tested on Intel RDT, AMD QoS and ARM MPAM and is
> in tools/testing/selftests/resctrl in order to have generic test code
> base for all architectures.
> 
> The selftest tool we are introducing here provides a convenient
> tool which does automatic resctrl testing, is easily available in kernel
> tree, and covers Intel RDT, AMD QoS and ARM MPAM.
> 
> There is an existing resctrl test suite 'intel_cmt_cat'. But its major
> purpose is to test Intel RDT hardware via writing and reading MSR
> registers. It does access resctrl file system; but the functionalities
> are very limited. And it doesn't support automatic test and a lot of
> manual verifications are involved.
> 
> Changelog:
> v9:
> - Per Boris suggestion, add Co-developed-by in each patch to make it
>   clear who contributed to the patch set.
> 
> v8:
> Update code per comments from Andre Przywara from ARM:
> - Change Makefile and remove inline assembly code to build and test the
>   tool on ARM
> - Change the output to TAP format because the format is both readable by
>   human and other test tools.
> - Detect resctrl feature from /proc/cpuinfo instead of dmesg to support
>   generic detection on all architectures.
> - Fix a few coding issues.
> 
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
> Babu Moger (3):
>   selftests/resctrl: Add vendor detection mechanism
>   selftests/resctrl: Use cache index3 id for AMD schemata masks
>   selftests/resctrl: Disable MBA and MBM tests for AMD
> 
> Fenghua Yu (6):
>   selftests/resctrl: Add README for resctrl tests
>   selftests/resctrl: Add MBM test
>   selftests/resctrl: Add MBA test
>   selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
>   selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
>   selftests/resctrl: Add the test in MAINTAINERS
> 
> Sai Praneeth Prakhya (4):
>   selftests/resctrl: Add basic resctrl file system operations and data
>   selftests/resctrl: Read memory bandwidth from perf IMC counter and
>     from resctrl file system
>   selftests/resctrl: Add callback to start a benchmark
>   selftests/resctrl: Add built in benchmark
> 
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/resctrl/Makefile      |  17 +
>  tools/testing/selftests/resctrl/README        |  53 ++
>  tools/testing/selftests/resctrl/cache.c       | 272 +++++++
>  tools/testing/selftests/resctrl/cat_test.c    | 250 ++++++
>  tools/testing/selftests/resctrl/cqm_test.c    | 176 +++++
>  tools/testing/selftests/resctrl/fill_buf.c    | 213 +++++
>  tools/testing/selftests/resctrl/mba_test.c    | 171 ++++
>  tools/testing/selftests/resctrl/mbm_test.c    | 145 ++++
>  tools/testing/selftests/resctrl/resctrl.h     | 107 +++
>  .../testing/selftests/resctrl/resctrl_tests.c | 202 +++++
>  tools/testing/selftests/resctrl/resctrl_val.c | 744 ++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c   | 722 +++++++++++++++++
>  13 files changed, 3073 insertions(+)
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
