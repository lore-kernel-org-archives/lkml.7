Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DCC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737520673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fsp3h3Dk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fsp3h3Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503251AbfIWWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:12:19 -0400
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:28277
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390504AbfIWWMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxPYmK7WFuEBQebz6cMFWBH5/jJqKOTcrsaDyaE8ls=;
 b=Fsp3h3Dkvq/8GUDhnVrjnYVuZqLPbiMALObxfLAWB7vSwQFV5syG7Zc/csSG+DNO9wF0O8vq/Tusjfc6IdchWnKhh4bUT1EAhuPVW7mQqWblKdycHT9mT+Jpc1V8P2k+3YhKOpsHvJrGrvnJRq60K7MFzql/asXoN3URRULaLDA=
Received: from VI1PR08CA0121.eurprd08.prod.outlook.com (2603:10a6:800:d4::23)
 by DB7PR08MB3276.eurprd08.prod.outlook.com (2603:10a6:5:21::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 22:12:08 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0121.outlook.office365.com
 (2603:10a6:800:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Mon, 23 Sep 2019 22:12:07 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Mon, 23 Sep 2019 22:12:06 +0000
Received: ("Tessian outbound 5061e1b5386c:v31"); Mon, 23 Sep 2019 22:12:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 394ef2e6d5723c5b
X-CR-MTA-TID: 64aa7808
Received: from 6adc40626b39.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 551BFE9E-9BF3-4F35-BA78-ED7BE706112A.1;
        Mon, 23 Sep 2019 22:11:59 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6adc40626b39.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 22:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJxSWvo3isi2rScM4EWK+R+ZSLube5YTwe1clPtFCpEXnkonb1U5x9qovDG4UH4Lp1iiH/4CQQQZ//hkdkVOoiXSlfMV4DQO2sq3cjlYHn+xBbu6RskMUhFJzA9s2R/ucoLJsZQqqmGleccL6MimK3QF5dZfdt8oql7FaZ2f3L/9Ddekq/Sd/lIZiqxzUKNztZzXsf2yM/VLy7EHwJ2Y3EZfX22qwuB8GFb7OG4w5LskUVJPKab7hyrD8lndx0dTh+v20O9HOLhXUOBPkiEWygi5Exa+D6+aR4IZJwg3NlgcNl+zrXYZxN2shQoGkzWhq8CpaXTDY4237oSnpWPf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxPYmK7WFuEBQebz6cMFWBH5/jJqKOTcrsaDyaE8ls=;
 b=OEaX/60YWtNUt6SWsrsGfSMqSyOZ40CdAeHDLmeSlLPl0Do6/uCzMsLOuHEjMcHls21r3xcYjtPoDHiwK2XLbt8bR3M3OiAy2iC4puPBlYp0Luo1m9vnSsUXsQE6A48uDn049d4TCKDpUdFVx9kePB4kZhceWtjHAtPfvZMgTQChW+AXPtJNdGvcY/dZIZJ+UnNOqXXB5O/mWDtkJ9GciMacgkFQindGtUZ4XImwcg9CzN3yDPga6vWrty0hTiubEahnH5KvkuNxIl/OC1ShpMnU8Ei/+3YWI/a08TGSXLYMcxGa2C7v9VRd8f8xT1NITaSkz2A7GLIBb8Umd5XDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxPYmK7WFuEBQebz6cMFWBH5/jJqKOTcrsaDyaE8ls=;
 b=Fsp3h3Dkvq/8GUDhnVrjnYVuZqLPbiMALObxfLAWB7vSwQFV5syG7Zc/csSG+DNO9wF0O8vq/Tusjfc6IdchWnKhh4bUT1EAhuPVW7mQqWblKdycHT9mT+Jpc1V8P2k+3YhKOpsHvJrGrvnJRq60K7MFzql/asXoN3URRULaLDA=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 22:11:56 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 22:11:56 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RESEND][PATCH v8 5/5] kselftests: Add dma-heap test
Thread-Topic: [RESEND][PATCH v8 5/5] kselftests: Add dma-heap test
Thread-Index: AQHVZOOJZ3fRkDl+s0aCkKKSUkpz7qc57gQA
Date:   Mon, 23 Sep 2019 22:11:56 +0000
Message-ID: <20190923221150.lolc72yvuyazqhr6@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-6-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-6-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.165]
x-clientproxiedby: MRXP264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::17) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 27bc9345-0ac5-4d3a-bbd1-08d740731202
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3829;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3829:|AM6PR08MB3829:|DB7PR08MB3276:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3276A8B75337803AA9DE4ECDF0850@DB7PR08MB3276.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1186;OLM:1186;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6506007)(26005)(7736002)(81166006)(186003)(52116002)(316002)(99286004)(64756008)(66476007)(66446008)(229853002)(66946007)(4326008)(25786009)(66556008)(446003)(9686003)(386003)(76176011)(6512007)(6246003)(102836004)(7416002)(58126008)(305945005)(476003)(6436002)(11346002)(5660300002)(2906002)(14454004)(71200400001)(71190400001)(54906003)(14444005)(6486002)(486006)(81156014)(256004)(44832011)(1076003)(6916009)(8676002)(6116002)(478600001)(8936002)(66066001)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3829;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: y4wcpHbwn05Mh5/yTpViLC5sZUkdpN2NBz9UlgppBlkaXMQZ5dUjUQtzDWbufKxy7gPZ9G37qsfYPndpxQRfvbeaHP7MGoCI9VcfujFE23I81mVAnKOTeD8qDZxLTaTNThUb7+EJqy3ABgqeJ1rK9YRJQV+uIfPFhJLlh/EiFUDwZ8Ch7G8Jj2mwkopLcIth9jZ1keL9TZbwkI2LesFwOlMBMWhErJ/kXS5qXqX9fLe3EeTscM6o3O3eB5M0kqPtKMDqpmhRuBwXlFajwF0eu5GCmQO0VsFRbQpNsQM79gWpwDZGR8PiHY6d96/lmgXyAKsurb9D0xE4qd9Ytm8xD2FeiA50GZMPTWVRzYjaPVxxK4XkPRCifI4u7CN2NDUOPug9IDAxVOSMDgqjWCeyzdwaw3NBjgXfFWFqzWncFAQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <199E28AC96A5E743936B9CFDD040D20F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(346002)(376002)(396003)(199004)(189003)(6862004)(50466002)(3846002)(23726003)(6116002)(46406003)(6506007)(386003)(186003)(6512007)(9686003)(446003)(229853002)(316002)(22756006)(2906002)(6486002)(54906003)(4326008)(6246003)(76176011)(486006)(47776003)(63350400001)(102836004)(99286004)(66066001)(476003)(97756001)(11346002)(70206006)(25786009)(70586007)(1076003)(336012)(36906005)(356004)(305945005)(8676002)(7736002)(14444005)(86362001)(478600001)(58126008)(8936002)(26005)(8746002)(81166006)(81156014)(76130400001)(26826003)(5660300002)(14454004)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3276;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53729a3a-6f55-4478-0b3b-08d740730bc6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3276;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 2pBkLCpq01Bqa56LLjQ4N1bUtQtrB/a1j/E0d8mGgtNgNJAl/U9+8oaKe+aOxMt1zlWEsQdF/T0KmuLdq7om8zz+b2zaCOGNb2Eb7LrVMNywfZPIGdwoGRjXz32cKH3ah+kyZY60/DJaJQ3lrgtQp2Amvyzvhrh65r2HoNLSUx8lAcaxsyAs4D0WYPyfkAF2sZpGGDf8OBBxqXnzYjbPJKWP+icuL4uHnI51Ztq2PWZFH4eWcO0jOICuLiveJHrh72nzNSPwHt307C3MwToAfFMk4IkkZ75AOZmcE1MaL5+kXUqialAudF9wLjznIrWO5xYly3IA5W5yeNP00CPW5NCPF8Oo4WEUGHCFVL/u4kpHpcEGzB22X01Zu2/4nIm+rFWS5XLfhkAT0Xeyk+5/zWNyiVsffpgjc4NmSKR3bdw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 22:12:06.3079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc9345-0ac5-4d3a-bbd1-08d740731202
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I didn't see any response about using the test harness. Did you decide
against it?

On Fri, Sep 06, 2019 at 06:47:12PM +0000, John Stultz wrote:
> Add very trivial allocation and import test for dma-heaps,
> utilizing the vgem driver as a test importer.
>=20
> A good chunk of this code taken from:
>   tools/testing/selftests/android/ion/ionmap_test.c
>   Originally by Laura Abbott <labbott@redhat.com>
>=20
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Switched to use reworked dma-heap apis
> v3:
> * Add simple mmap
> * Utilize dma-buf testdev to test importing
> v4:
> * Rework to use vgem
> * Pass in fd_flags to match interface changes
> * Skip . and .. dirs
> v6:
> * Number of style/cleanups suggested by Brian
> v7:
> * Whitespace fixup for checkpatch
> v8:
> * More checkpatch whitespace fixups
> ---
>  tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 ++++++++++++++++++
>  2 files changed, 239 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>=20
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testin=
g/selftests/dmabuf-heaps/Makefile
> new file mode 100644
> index 000000000000..8c4c36e2972d
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS +=3D -static -O3 -Wl,-no-as-needed -Wall
> +#LDLIBS +=3D -lrt -lpthread -lm
> +
> +# these are all "safe" tests that don't modify
> +# system time or require escalated privileges
> +TEST_GEN_PROGS =3D dmabuf-heap
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> new file mode 100644
> index 000000000000..e439d6cf3d81
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include <linux/dma-buf.h>
> +#include <drm/drm.h>
> +
> +#include "../../../../include/uapi/linux/dma-heap.h"
> +
> +#define DEVPATH "/dev/dma_heap"
> +
> +static int check_vgem(int fd)
> +{
> +	drm_version_t version =3D { 0 };
> +	char name[5];
> +	int ret;
> +
> +	version.name_len =3D 4;
> +	version.name =3D name;
> +
> +	ret =3D ioctl(fd, DRM_IOCTL_VERSION, &version);
> +	if (ret)
> +		return 0;
> +
> +	return !strcmp(name, "vgem");
> +}
> +
> +static int open_vgem(void)
> +{
> +	int i, fd;
> +	const char *drmstr =3D "/dev/dri/card";
> +
> +	fd =3D -1;
> +	for (i =3D 0; i < 16; i++) {
> +		char name[80];
> +
> +		sprintf(name, "%s%u", drmstr, i);
> +
> +		fd =3D open(name, O_RDWR);
> +		if (fd < 0)
> +			continue;
> +
> +		if (!check_vgem(fd)) {
> +			close(fd);

I didn't spot this last time, but there's an (unlikely) error scenario
here if there's >=3D 16 DRM devices and none of them are vgem, then
you'll return a stale fd.

> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +	return fd;
> +}
> +
> +static int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
> +{
> +	struct drm_prime_handle import_handle =3D {
> +		.fd =3D dma_buf_fd,
> +		.flags =3D 0,
> +		.handle =3D 0,
> +	 };
> +	int ret;
> +
> +	ret =3D ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
> +	if (ret =3D=3D 0)
> +		*handle =3D import_handle.handle;
> +	return ret;
> +}
> +
> +static void close_handle(int vgem_fd, uint32_t handle)
> +{
> +	struct drm_gem_close close =3D {
> +		.handle =3D handle,
> +	};
> +
> +	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
> +}
> +
> +static int dmabuf_heap_open(char *name)
> +{
> +	int ret, fd;
> +	char buf[256];
> +
> +	ret =3D sprintf(buf, "%s/%s", DEVPATH, name);

snprintf(), just because why not?

> +	if (ret < 0) {
> +		printf("sprintf failed!\n");
> +		return ret;
> +	}
> +
> +	fd =3D open(buf, O_RDWR);
> +	if (fd < 0)
> +		printf("open %s failed!\n", buf);
> +	return fd;
> +}
> +
> +static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
> +			     int *dmabuf_fd)
> +{
> +	struct dma_heap_allocation_data data =3D {
> +		.len =3D len,
> +		.fd_flags =3D O_RDWR | O_CLOEXEC,
> +		.heap_flags =3D flags,
> +	};
> +	int ret;
> +
> +	if (!dmabuf_fd)
> +		return -EINVAL;
> +
> +	ret =3D ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
> +	if (ret < 0)
> +		return ret;
> +	*dmabuf_fd =3D (int)data.fd;
> +	return ret;
> +}
> +
> +static void dmabuf_sync(int fd, int start_stop)
> +{
> +	struct dma_buf_sync sync =3D {
> +		.flags =3D start_stop | DMA_BUF_SYNC_RW,
> +	};
> +	int ret;
> +
> +	ret =3D ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
> +	if (ret)
> +		printf("sync failed %d\n", errno);
> +}
> +
> +#define ONE_MEG (1024 * 1024)
> +
> +static void do_test(char *heap_name)
> +{
> +	int heap_fd =3D -1, dmabuf_fd =3D -1, importer_fd =3D -1;
> +	uint32_t handle =3D 0;
> +	void *p =3D NULL;
> +	int ret;
> +
> +	printf("Testing heap: %s\n", heap_name);
> +
> +	heap_fd =3D dmabuf_heap_open(heap_name);
> +	if (heap_fd < 0)
> +		return;
> +
> +	printf("Allocating 1 MEG\n");
> +	ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> +	if (ret) {
> +		printf("Allocation Failed!\n");
> +		goto out;
> +	}
> +	/* mmap and write a simple pattern */
> +	p =3D mmap(NULL,
> +		 ONE_MEG,
> +		 PROT_READ | PROT_WRITE,
> +		 MAP_SHARED,
> +		 dmabuf_fd,
> +		 0);
> +	if (p =3D=3D MAP_FAILED) {
> +		printf("mmap() failed: %m\n");
> +		goto out;
> +	}
> +	printf("mmap passed\n");
> +
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> +
> +	memset(p, 1, ONE_MEG / 2);
> +	memset((char *)p + ONE_MEG / 2, 0, ONE_MEG / 2);
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
> +
> +	importer_fd =3D open_vgem();
> +	if (importer_fd < 0) {
> +		ret =3D importer_fd;
> +		printf("Failed to open vgem\n");
> +		goto out;
> +	}
> +
> +	ret =3D import_vgem_fd(importer_fd, dmabuf_fd, &handle);
> +	if (ret < 0) {
> +		printf("Failed to import buffer\n");
> +		goto out;
> +	}
> +	printf("import passed\n");
> +
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> +	memset(p, 0xff, ONE_MEG);
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
> +	printf("syncs passed\n");
> +
> +	close_handle(importer_fd, handle);
> +
> +out:
> +	if (p)
> +		munmap(p, ONE_MEG);
> +	if (importer_fd >=3D 0)
> +		close(importer_fd);
> +	if (dmabuf_fd >=3D 0)
> +		close(dmabuf_fd);
> +	if (heap_fd >=3D 0)
> +		close(heap_fd);
> +}
> +
> +int main(void)
> +{
> +	DIR *d;
> +	struct dirent *dir;
> +
> +	d =3D opendir(DEVPATH);
> +	if (!d) {
> +		printf("No %s directory?\n", DEVPATH);
> +		return -1;
> +	}
> +
> +	while ((dir =3D readdir(d)) !=3D NULL) {
> +		if (!strncmp(dir->d_name, ".", 2))
> +			continue;
> +		if (!strncmp(dir->d_name, "..", 3))
> +			continue;
> +
> +		do_test(dir->d_name);

As far as I understand it, if main() always returns zero, this test will
always be indicated as a "pass" - shouldn't there be at least some
failure scenarios?

Cheers,
-Brian

> +	}
> +	closedir(d);
> +
> +	return 0;
> +}
> --=20
> 2.17.1
>=20
