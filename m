Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F19C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248FA20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="325yKLgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfDBPVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:21:17 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:30560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfDBPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyzjJWLbAcFFpVMr/KbSJWvNtzaj34doeXQhev6+E90=;
 b=325yKLgo9+nrBK3jfqmzYga0ZFy66ZpAD8tAA7ZDC+plQJbLLU17VvdDSncnJOceFovojSqINy7MSAShTViH7e3WPgfOvH+RnlImNwY7XBRePhXwKECtRLKNCmd1A3TgEc/CpXSdfNo8PHxjYNSy0oNmkuktZb4M4PZX7TC8kKs=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 15:21:13 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:21:13 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v4 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Topic: [PATCH v4 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Index: AQHU6We0TsxwmRanCU68TGyIRJtYTw==
Date:   Tue, 2 Apr 2019 15:21:12 +0000
Message-ID: <cover.1554218314.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN4PR0401CA0035.namprd04.prod.outlook.com
 (2603:10b6:803:2a::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61005864-c84f-48b8-7820-08d6b77ed70a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB3257F4330B8AF2D59B9E75EBEC560@DM6PR12MB3257.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(106356001)(7416002)(110136005)(50226002)(66066001)(105586002)(102836004)(2906002)(476003)(2616005)(5660300002)(386003)(256004)(486006)(6506007)(99286004)(6436002)(36756003)(186003)(6486002)(14444005)(97736004)(2501003)(81156014)(81166006)(8936002)(316002)(3846002)(966005)(72206003)(14454004)(4326008)(26005)(6512007)(6306002)(68736007)(52116002)(8676002)(25786009)(54906003)(305945005)(7736002)(71200400001)(53936002)(86362001)(71190400001)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5r7F6lGWOFMHoDJf+p2o7p4jv6tEYHCkYTZSTJUE/HcTeCTl4Z4p2pFNAsnKEc2X9CBCbq4bVedq6bNnBvMgh5z++CEEsi2wsjAlIOasxbe5zVVTmo6pRshcApzdSBveR4cufG5cZz+wk2AyQ33m6rKyMXd4JkNCsMm1lH5KqtLBGtNEr7EP79U6+/KBMQHIX5VYoKQb/tac6AG2D3ysFdye8v04PFpEKwWPte3nsAJnJlGfqGcZJ3gS1iQO9JQiH9YLy79Znt8kwiJVHj2YoT0iIWVxUQiuaTTc61T+0pnTCreVbrLlwW/EHCyMW8wb6WW5qh66Se0RggTc5HNbOzRY1nZqrFqKlW1olVGGXxB0pMMAB+xMfDDcJkWURKItO9z1ZFO917FB59mD3c9lPgehnW0QsEgkYmJWHONj+Cs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61005864-c84f-48b8-7820-08d6b77ed70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:21:13.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses issues with increased NMI latency in newer
AMD processors that can result in unknown NMI messages when PMC counters
are active.

The following fixes are included in this series:

- Resolve a race condition when disabling an overflowed PMC counter,
  specifically when updating the PMC counter with a new value.
- Resolve handling of active PMC counter overflows in the perf NMI
  handler and when to report that the NMI is not related to a PMC.
- Remove earlier workaround for spurious NMIs by re-ordering the
  PMC stop sequence to disable the PMC first and then remove the PMC
  bit from the active_mask bitmap. As part of disabling the PMC, the
  code will wait for an overflow to be reset.

The last patch re-works the order of when the PMC is removed from the
active_mask. There was a comment from a long time ago about having
to clear the bit in active_mask before disabling the counter because
the perf NMI handler could re-enable the PMC again. Looking at the
handler today, I don't see that as possible, hence the reordering. The
question will be whether the Intel PMC support will now have issues.
There is still support for using x86_pmu_handle_irq() in the Intel
core.c file.

Also, I couldn't completely get rid of the "running" bit because it
is used by arch/x86/events/intel/p4.c. An old commit comment that
seems to indicate the p4 code suffered the spurious interrupts:
Commit 03e22198d237 ("perf, x86: Handle in flight NMIs on P4 platform").

---

Changes from v3:
- Changed nmi.h include from asm/nmi.h to linux/nmi.h.
- Let the information about the last patch in the cover letter, but
  removed the questions which were previously answered.
- Removed the RFC tag.

Changes from v2 (based on feedback from Peter Z):
- Simplified AMD specific disable_all callback by calling the common
  x86_pmu_disable_all() function and then checking and waiting for
  reset of and overflowed PMCs.
- Removed erroneous check for no active counters in the NMI latency
  mitigation patch, which effectively nullified commit 63e6be6d98e1.
- Reworked x86_pmu_stop() in order to remove 63e6be6d98e1.

Changes from v1 (based on feedback from Peter Z):
- Created an AMD specific disable_all callback function to handle the
  disabling of the counters and resolve the race condition
- Created an AMD specific handle_irq callback function that invokes the
  common x86_pmu_handle_irq() function and then performs the NMI latency
  mitigation.
- Take into account the possibility of non-perf NMI sources when applying
  the mitigation.

This patch series is based off of the perf/core branch of tip:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

  Commit 1a9df9e29c2a ("Merge git://git.kernel.org/pub/scm/linux/kernel/git=
/davem/net")

Tom Lendacky (3):
  x86/perf/amd: Resolve race condition when disabling PMC
  x86/perf/amd: Resolve NMI latency issues for active PMCs
  x86/perf/amd: Remove need to check "running" bit in NMI handler

 arch/x86/events/amd/core.c | 139 +++++++++++++++++++++++++++++++++++--
 arch/x86/events/core.c     |  13 +---
 2 files changed, 137 insertions(+), 15 deletions(-)

--=20
2.17.1

