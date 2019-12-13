Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E324658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VzLXSu8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLMIYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:24:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:57091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfLMIYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:24:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 00:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="239226103"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2019 00:24:51 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Dec 2019 00:24:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 13 Dec 2019 00:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmAn/6/x5VPXqoUHfnFpT9xcruHWT1/RuD8atKtYK0mUIUGvOUwFap1QgO1osW+PNF/MaaQOMPmOc30g4d//PygbutwXt1EwPkgZgWchm/LUOq+AVLE6x0t6ENgmb4q0fSYwtuOfsRj013KNQVCtku+dstMvOQzYsjRL1PbvGhlck6ghcUn2tGlqKWqbPeXGQz7/wtFurfyU5MO3CuOqdRfP6pglQfThQ15JdBXNk4MMiXKQUwlNuH6yx4htn/2OrI12PaYuKGR+getJld2BCEEUcRt2CZAVCBz8AwfKpL04pLOwlO3Rv9S+V0QdFa7QUEf1eHCsKeB8gTlXMGbH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEIhJFh1YQwaWlCinWTM95lIrC6elA0l2H46jhhMOFE=;
 b=ma+pOW0zPuPPoojYE29fdJ6mliMJ46mo85oGLw26EVZ2CykKWyzJZlZ7tVSB/tVTFD0heBlC4tNyvpcT8Bff2yoWJA0WyqG3N3gS5watjjwiX9/UkC/jPy+09mXO58ZKAKgNMu0rgOTvXLG4ld7ecPDS2jSChY0t2ZVa7h8VYvHk101pXe+eEI3pmEq6r4J6MqihtjDOwtbw2wowqMEwsOsz4OdDpc0/0r0nm29A+oQ1CnpoD8aIBFbOjtXUS7J5ES7/Iy5aSfw1NbUCnUpHdcRTLS8kHADB9cJJZuQIxUDBLjpFl+eOO4+K2A5Yuyc7qqjfJNyhL4kP4ejhQ4VQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEIhJFh1YQwaWlCinWTM95lIrC6elA0l2H46jhhMOFE=;
 b=VzLXSu8VrJHfl7b+73HlN5cPs2dXzFnL2x7B7IS03/OE/x8g6pwLMWuTuvDco0dL3V8TD8eTTrqgu36Lz9p/IAVQdQpgozSCFVYF2S6/p9C242LOuHUejkCzAsi/fVtaKWyGSUqoLcOwpuEGop6cccldD7EPhp8nZ2PCntiQZ0M=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB4143.namprd11.prod.outlook.com (20.179.150.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Fri, 13 Dec 2019 08:24:50 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 08:24:49 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "'lftan.linux@gmail.com'" <lftan.linux@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] arch/nios2 fix for v5.5-rc2
Thread-Topic: [GIT PULL] arch/nios2 fix for v5.5-rc2
Thread-Index: AdWxjlsJIo35b10gQX6XFgISDbGgDQ==
Date:   Fri, 13 Dec 2019 08:24:49 +0000
Message-ID: <MN2PR11MB4509EB06FE5B942083D9E097CC540@MN2PR11MB4509.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2NiMGExMmYtY2IwYi00ZGI2LWEwNGItNWU2MGE1ODk1YmZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNlVBZm00bWtWU2FNYWZhWm5zMWhTYUlGVzJzVGYxWkVDQzZuM0F2aTNycFBhN3BHVlBkc25sTkVYeWFhc0ZCSiJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cab0a825-69c9-4b7d-6ff4-08d77fa5ebde
x-ms-traffictypediagnostic: MN2PR11MB4143:
x-microsoft-antispam-prvs: <MN2PR11MB41433BEAFC84151958FA2450CC540@MN2PR11MB4143.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(81156014)(81166006)(66556008)(66476007)(2906002)(76116006)(52536014)(4001150100001)(186003)(6916009)(64756008)(33656002)(8936002)(8676002)(71200400001)(55016002)(316002)(66946007)(54906003)(66446008)(6506007)(5660300002)(4744005)(86362001)(7696005)(9686003)(4326008)(26005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB4143;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKIjVhOs5kO5pK+eo/ZrDc8mkEgAJ3wJSsLrfd+PExb8uLC+Qz2SIj5JC1OOqU+NliRVhqxh3GWxAlW1Vu5nPby6la2Tofwaa6zsYWDyKq1FGU+KBfy0BJY1Fdfide2YwrG+w1mzs8T3TrKH9hotwenw/VNsNrEwdsk+qUnpzQCxezzY7N0ox1Y/eCHBb2rMTPCnGUJi/hT2v3kTDi6sA2jLrQJ7icVJpEk9CQyrN8/SWyUZtOjY6wXuUijBNyWF6ZDaUQErrL6aZECvJTn3DxYZk6j4hSfz2EUX8NNK91bj4e70FZl+1dePobVr3+mIr9BBRVvA2BnK2xT/qOFOwUbvQPyhRhwybJh+T5yy7XWrSmJ+PqagMFwrfqc3dHoQSz2ph6Msnwi6IjO+mlL4Q3ssJg5prp3GMPdWr1kWvyZkESDbwl7Gu0GtgOiT/qtu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0a825-69c9-4b7d-6ff4-08d77fa5ebde
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 08:24:49.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xr3LfWrSy2F01Ts+1dkAPwxvNiUKdj8ZfF1S+VsQ9ekJ8dz0NYbILGDbDNiKGsikU4GudrJEGsVTC6U9L+vzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4143
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus

Please pull the arch/nios2 fix for v5.5-rc2.

Thanks.

Regards
Ley Foon


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a=
:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-=
v5.5-rc2

for you to fetch changes up to e32ea127d81c12882f39c2783d78634597ff21a2:

  nios2: Fix ioremap (2019-12-12 16:34:33 +0800)

----------------------------------------------------------------
nios2 update for v5.2-rc2

nios2: Fix ioremap

----------------------------------------------------------------
Guenter Roeck (1):
      nios2: Fix ioremap

 arch/nios2/mm/ioremap.c | 8 ++++++++
 1 file changed, 8 insertions(+)
