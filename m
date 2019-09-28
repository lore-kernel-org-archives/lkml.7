Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845AEC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7842146E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dLJ87Vj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfI1BcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:32:24 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1281
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfI1BcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:32:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utw4VVvJTUsoz5htniM82oddyvY+8YejKROI+6BwJGwr7jbtNjL6X3PTAoSMBHsxqPGL35xgEzDuKExEDuFa9ka6Phhzt5jgE7YknF4GWhBd579W2aF3US69hayfevGLNMLNWjlrCOczMxnKT8NKJyauBYMDI07SM3vNyMSBxsusxRo9RYcPHUPONhTz41s8DhfOLXLTipmRykCZIHCguP3vciWKpRDV2HhR3uGm+ggmc5jjQxO9Jv11O9w07VYmOERSA9ZxltHMWHK9HKH1k7KaNo0Ki8PFu+X3dd/5ZAuPwKjmirL2oz2lnkw+oPO72CcL223hJS8uygQAk1PcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or5waImo+3BOMhqPvSUSRQekAOlYSjMsQQ7rYVpbQys=;
 b=OODkabnbPAE7h2HvENTYAWe0S1ibcfCpqoB3Bxc3MWxNzildiN810NpRsglXeiG1WaiURs37iyZ5jzFG1QDIOyy5S67Sz5vGTAsF6CG6vcAJjzvZMEQXXnpHFPbfvbJxyIsjsoZsR7/kN5mSOFqbsWR/ukNc+P6FIVvdl+obpcDXnda/osA4XcSedhnnRwEw+Y7CergTNCbZqNMgv4OobSK1JVqY0aPgrKMG2kzHr+iq+3JjhFzhy4lwMj47KWCVC2iiXRGYxsHlcwU3DdmXAtH1u2NKKva73sYyGFN9KzQQurVTKxRbEPRlT3fm9lmxN2LpntFthvEqNHWi0ShYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or5waImo+3BOMhqPvSUSRQekAOlYSjMsQQ7rYVpbQys=;
 b=dLJ87Vj7N1EnmXpdpygQp1C/x1KHgR4a/wAlf+DzmhjeeBGlAmqZSAyGeVRqWC7rfiwtMVr/hYDkT/RL1+tvb0tkuc0yD/PQFpGSwKKVB+xYDzn74n2xAEu5wUNPIouBZWnjHiPwvCGc89oech9aczLh1zEJD8tRrwTY0ZXHqc0=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1153.namprd21.prod.outlook.com (20.179.72.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Sat, 28 Sep 2019 01:32:19 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Sat, 28 Sep 2019
 01:32:19 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: RE: [PATCH] perf map: fix overlapped map handling
Thread-Topic: [PATCH] perf map: fix overlapped map handling
Thread-Index: AdVv5y6SzPv23L21QnSQJe3E6wWQgAAA9l0AAAMWwpABVHUWAAAUmtAQ
Date:   Sat, 28 Sep 2019 01:32:18 +0000
Message-ID: <BN8PR21MB13625A503C82F5135AB1706CF7800@BN8PR21MB1362.namprd21.prod.outlook.com>
References: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190920193852.GI4865@kernel.org>
 <BN8PR21MB1362B1921DF8ABF3A19B43A5F7880@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190927153540.GB20644@kernel.org>
In-Reply-To: <20190927153540.GB20644@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-28T01:32:17.5799580Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9324a5d-6f2d-4418-859a-cf61ccaa864d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d373467f-2685-4b29-4c91-08d743b3b3ec
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1153:|BN8PR21MB1153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB1153B9E6EDB3E2975F5583AEF7800@BN8PR21MB1153.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(229853002)(66446008)(478600001)(10090500001)(33656002)(55016002)(9686003)(8936002)(256004)(6916009)(8676002)(25786009)(11346002)(4326008)(486006)(71200400001)(52536014)(81156014)(6246003)(5660300002)(86362001)(446003)(81166006)(107886003)(66476007)(76176011)(7696005)(186003)(3846002)(99286004)(6116002)(6506007)(71190400001)(7736002)(476003)(6436002)(14454004)(8990500004)(305945005)(64756008)(66066001)(102836004)(54906003)(74316002)(76116006)(22452003)(316002)(2906002)(66556008)(10290500003)(7416002)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1153;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+YjxbdJtKBIDTci7PvyVUQycCFq4iH7N6RJJ+VqE8/HGxCT3IpmiPbampCzlc2q21KqVmqJRErR2k9CKM2nAUgvFplRuUsn9G3AuzhxSOGNja4sDFDXm0j9I4szSLC7JnjbM/m2dy7zZVD6SaQzCGl5UWPvnElQlEjfewb1+WQw1gyF8lTTusqWylddtbeFdGGGvxKCIP1yR1NRA/h6eILviBZHBog8ZHuarrgMfdxqmuiPPMTZeTK/XjmNsB5yo8bp7d/ybKBV7kWgjEpHpXSngLnPJ1UMZWVReRBFgBHXGqpbHQ0300wRSE1VWtTiVkCYR5pFLDI7dCktLPt3NW4vdnH1dM9fjc0PhP87x98niAIUOCaw5x3Znxxd7tu2tNPn/D8wfBAmokyX0w4GNbYxdw9UC2xLBHr8nStXP/A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d373467f-2685-4b29-4c91-08d743b3b3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 01:32:19.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVOGAvV06lw+q4Im8WduHcWPTYJD/9L7OR5IZiTrA2oXMut9KeKGuM4B0r4vsQtKgH9ItJveqM+UtUUCoDaiaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> An earlier version of this patch used:
>>   			after->start =3D map->end;
>> +			after->pgoff +=3D map->end - pos->start;
>>=20
>> Instead of the newer Functionally equivalent:
>>   			after->start =3D map->end;
>> +			after->pgoff =3D pos->map_ip(pos, map->end);
>>=20
>> I preferred the latter form as it made more sense with the assertion tha=
t the mapping of map->end should match in pos and after.
>
> So, if they are equivalent then I think its better to use code that resse=
mbles the kernel as much as possible, so that when in doubt we can compare =
the tools/perf calcs with how the kernel does it, filtering out things like=
 the PAGE_SHIFT, can we go that way?
>
> Also do you have some reproducer, if you have one then we can try and hav=
e this as a 'perf test' entry, bolting some more checks into tools/perf/tes=
ts/perf-record.c or using it as a start for a test that stresses this code.
>
> This is not a prerequisite for having your fix on, but would help checkin=
g that perf doesn't regresses in this area.
>
> - Arnaldo

I have updated the patch to use the earlier version, which more closely mat=
ches the kernel.

I have updated the commit message to include the repro info.

I am including a few other patches I have generated while adding support fo=
r perf jitdump to coreclr.
