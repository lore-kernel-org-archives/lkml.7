Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414EA2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qu4lNN6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJBUsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:48:39 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:24064
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728722AbfJBUsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW5NK1u+bx7gwhYPkGwTz0VOKQI+RS0nPUUYbwXs1mafC7QbPCWXqZBJXeP7Me55/c9qawHMm+iNsnYPnaAIWXCMGTk4ecB4a5kWrfopY1JjYdnO6FLBtNYeYIbYqFvIfE9Z+Qk5G07IZsKYz/cc7Q21XOcmv1mAyupoEylCbq7lBDAhpUw4iA0IuDQoo8ZVPeCjAuaHElSrtBP3nDg0yKge+O+VfGDl9NSs7DJFx9DAeEW8qMefy0dhLkhhemTv1Ulx6X78MIrcNZRGimHeIHg5TaC2gr88BLdaB9QqGrWcEMR2gggdlzgiKCeXAvoZcCUkDYMqu0t2ltBf/66pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPzpTXppfjdL5KNXQs0g2YBHtKZaKeqqUtZFl45Tjw=;
 b=NvHTkXSVzBw2/lAqMQDA9czGWbG1gL8yLuCDFwG1hbnjSlOE2WrpCuXymGw22atnpyZypMhRgYACjn0KG7qnIzv/n9mG0uDB6hXNQfW5jbDeva5qSNJ3tX93MEbsJ0yS6rFxWwCGzGLxXZuUxT8dVzA/2PdrPgPuK3tNxtB8tTUVLFl+L5b/pHk1Q5BqoiwGXKjk1KOqWK198gsPyRjYIhwcet4NqEY8pzHjfkc8VG8jaF/XSqV7GJzygpy14HDn9n7BUi722I4m3J/qYC1WltphcRONnqrsqpK2KVUfzalk0AbrH2UxwGq37TR1xXVoU0l/Ikabl/BgVrHQfFe9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPzpTXppfjdL5KNXQs0g2YBHtKZaKeqqUtZFl45Tjw=;
 b=Qu4lNN6yZq+p8caMXOjdES7QWUQv1dRPaSX71ghJwMw7PggBUmo/MPaKg1w69V8KaPi2T+7WRU+4iMwkvD1GQkXndULQDX4v2VkhqOAUrEhAvG/+XfF1dzdjQECT8ywIqoEVcg3yEtGBnVybUy3HB6VjTg+gMMPPtp0AIe98MVg=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1219.namprd21.prod.outlook.com (20.179.73.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.6; Wed, 2 Oct 2019 20:48:36 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.017; Wed, 2 Oct 2019
 20:48:36 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: RE: [PATCH 3/4 RESEND] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH 3/4 RESEND] perf inject --jit: Remove //anon mmap events
Thread-Index: AdV30UpDWyGhNX8tTHCRL/VpRSaZoAAZKRmAAEsjzRA=
Date:   Wed, 2 Oct 2019 20:48:36 +0000
Message-ID: <BN8PR21MB1362E6377A5663BA1C2DF14EF79C0@BN8PR21MB1362.namprd21.prod.outlook.com>
References: <BN8PR21MB13622159D33A3EBCADDF4B2FF7820@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20191001085511.GB30823@krava>
In-Reply-To: <20191001085511.GB30823@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-02T20:48:35.1375330Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=247eaaff-94a0-4930-a3b4-1d37f04ff329;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24c279f0-5e97-4f0e-d7b8-08d74779e5d0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1219:|BN8PR21MB1219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB1219836FF8644BDB612FCF70F79C0@BN8PR21MB1219.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(3846002)(74316002)(9686003)(6436002)(7736002)(54906003)(2906002)(8676002)(81156014)(229853002)(33656002)(8936002)(81166006)(86362001)(55016002)(64756008)(71190400001)(256004)(66446008)(66556008)(99286004)(305945005)(66066001)(14444005)(71200400001)(66476007)(66946007)(316002)(22452003)(52536014)(558084003)(5660300002)(6916009)(7416002)(6116002)(10090500001)(26005)(186003)(6246003)(76176011)(6506007)(4326008)(102836004)(7696005)(14454004)(10290500003)(25786009)(478600001)(476003)(486006)(446003)(11346002)(8990500004)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1219;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ufpUItS+ECdLf6RJ7VGu9RHR3acV+q5lniO8ucVaJk9BGyjXzW2mb+pvN6Xybj70bK5Yjt3pyZJGZPjNWnmr0M85cwN7J1uHq3EKElOf646kzPfjoIpzZGFAF5dz05T3GU4Ro3MHwPUddZE6VxJiGMRr3PpIGk1vtdA7pbYX3QUNvdAhOwrqVXJq0/35LT159P0rkYDOyuWFxwPxypBIBfUYehQAYzRJ6BHQsGIJazw286bgHqtOL214ukmsjpRBqGkQvILJEgnRIwNgX2dBus+z26KbRHNpg4uJ2vqJKAF+MH+1thdXljvaU1p4a00bQru9Lb/PihrrEQ/dDLM/HXzEeR89Xy+upwrzCoO+LiZWn+Gg+O54ikKxvh9Cu/XxqDYMxm7qgBxkhI+eFBEOjMUnTa+ttSVfXL4JtoyWl8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c279f0-5e97-4f0e-d7b8-08d74779e5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 20:48:36.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6om4fEyW4FignAZ2kkE4Z2po3Uk4fE0Czvv8xdbNZeviBHt1twku9TLOUSX9sMq5VOwKqhEOTeZB6Q9gN7oWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> looks like Andi is right, I'm still getting malformed patch error

> the patch has extra characters '=3D20' and broken lines, like:

My apologies, I was trying to get by with an inappropriate mailer.=20

I have an sendmail account now, and will resend.
