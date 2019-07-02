Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D62146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gamcFUNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGBPK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:10:57 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:23214
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfGBPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:10:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=mVd64Cl1efRGb7r76vG8ZKm11Xh3tL8wSz7OxzxcrprhYqmTLGlG0utkpcReXytCGmWnrb9J3YeIfcEqmDxF+rT9+HkUzJCE0upIvsnCSMwXXBQI4JG9EZnDHnnzas+Z+ta9f60NNpfEJM/0njAMtjprYkK2nqYCRUkd2yE03RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypL3h1aE0ifXzENY1ynF5r/W7g7fyl+MdwMwRPxJ68U=;
 b=V404N+sfjROltsGNVTttUgNazKcZaXPhyd4R3FElhbO3cd32CsNdUTknWBuFJCQYLjGOI7nv1BMU8s/daCzrZfFLd6xa3xfmG+QOgBnncRgk+Nx9ATS7FvQR1Ecmi86XN7SxqjJ1HCcmY8Pt4EvSmeLVq7e3hCSfUn9GjVpZm6I=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypL3h1aE0ifXzENY1ynF5r/W7g7fyl+MdwMwRPxJ68U=;
 b=gamcFUNqW3gd3OSNzUIC1poIAoL/X4lshYesD5cfVY18Zxgn/NbCjTKk9zcdjEttx+TYOpa3XxhaHFJGRVbw8lJx4oLJcaUEUfvHOI8wesEU3BUnA6UDqZZ74/13oVwdRxN5uXNBoZKpTl2grBbO878S8hGFElI2aT1etQH0IZo=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1640.namprd12.prod.outlook.com (10.172.72.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 2 Jul 2019 15:10:53 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::a1e9:d665:b7a3:87e3]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::a1e9:d665:b7a3:87e3%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 15:10:53 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sandipan@linux.ibm.com" <sandipan@linux.ibm.com>,
        "mpetlan@redhat.com" <mpetlan@redhat.com>,
        "kim.phillips@arm.com" <kim.phillips@arm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tests: Fix record+probe_libc_inet_pton.sh for
 powerpc64
Thread-Topic: [PATCH] perf tests: Fix record+probe_libc_inet_pton.sh for
 powerpc64
Thread-Index: AQHVMOhVtu8jyQ0evkOp2Ur+S+L6sA==
Date:   Tue, 2 Jul 2019 15:10:53 +0000
Message-ID: <dfdd84b7-eb68-cde2-903d-1542e3f80896@amd.com>
References: <1561630614-3216-1-git-send-email-s1seetee@linux.vnet.ibm.com>
In-Reply-To: <1561630614-3216-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0031.prod.exchangelabs.com (2603:10b6:805:1::44)
 To CY4PR12MB1798.namprd12.prod.outlook.com (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5ee8208-7871-47ec-1303-08d6feff79b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1640;
x-ms-traffictypediagnostic: CY4PR12MB1640:
x-microsoft-antispam-prvs: <CY4PR12MB16400E67C171E5BCFCF4808587F80@CY4PR12MB1640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(6512007)(7416002)(478600001)(71190400001)(8936002)(36756003)(6486002)(73956011)(76176011)(6246003)(31696002)(6436002)(71200400001)(2906002)(110136005)(229853002)(81166006)(316002)(81156014)(305945005)(8676002)(31686004)(4744005)(53936002)(14454004)(99286004)(52116002)(26005)(2501003)(386003)(53546011)(186003)(2201001)(68736007)(102836004)(25786009)(6506007)(66066001)(5660300002)(64756008)(476003)(2616005)(66946007)(486006)(66476007)(6116002)(3846002)(11346002)(446003)(66446008)(256004)(66556008)(86362001)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1640;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NUX49aMiZ3ekLtMlWhJXL3ioqQ+1AylsVv8UlZY8gk5o52Pk/fro0lyHck7GMF8sl3Sx/9IqimEKHuHi/k7AE1UwjHNkBJYeT4hwjuDpc2Ffh2lyJtHbFAQwMEU7LOPzoxgMH9CF0Mo4RaxThzqraKFamKbUTC3A0hLCxlaFl7nksaDvNcsop4bM0RnIT+ltFBZhxcLqsp0XkpMclszy3vvlkRp5J9JhFIR85GqUgyTWNdO0FSPDBm9BDJ2Nb8KFWzTWli4uAJ/09Nk3VO7JXRTj8oI8w1kOC4XDePefR6gAhIaZVFCgInZqjuMm8MWz8IkhnPtnkh4g5W10mQhC+TSidgg86ijeJKlzeE3jrgLMlyPmgyDYVmwrvEzKFkCfXdDVLwLiMuBZXoQnGWKE53txj5xW+kddfd2GTDqL94Q=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <171853DC4E7E64458EA2508B53942E1C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ee8208-7871-47ec-1303-08d6feff79b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 15:10:53.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 5:16 AM, Seeteena Thoufeek wrote:
> 'probe libc's inet_pton & backtrace it with ping' testcase sometimes
> fails on powerpc because distro ping binary does not have symbol
> information and thus it prints "[unknown]" function name in the
> backtrace.
>=20
> Accept "[unknown]" as valid function name for powerpc as well.
...
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

Fixes: 1632936480a5 ("perf tests: Fix record+probe_libc_inet_pton.sh withou=
t ping's debuginfo")
Reviewed-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
