Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629520857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rBxKEAF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCSXS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:18:29 -0400
Received: from mail-eopbgr810114.outbound.protection.outlook.com ([40.107.81.114]:47744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfCSXS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9AUV8yR3rzMV63/2qlSM1yjoRPf1f87+s5sjU/mn74=;
 b=rBxKEAF1KZ4MunIm3XdKUGDqSTRGTrQ2P7YgoQoIctE+eRL/8pxPM5AEEBqJIn4A4EExrmbIzgY8dqNEMKP8oVaVgJDIFKhIBFWixugzQ97wUVJHa00kJeYLuIaEOIOmx9eeOCbxLKCXR4rX5biJN3EefRIJrYUDKqQxQ92+bTc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1741.namprd22.prod.outlook.com (10.164.206.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 23:18:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:18:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: entry: Remove unneeded need_resched() loop
Thread-Topic: [PATCH v2] MIPS: entry: Remove unneeded need_resched() loop
Thread-Index: AQHU20ykrAck/zUdt0q7hlvreQS7t6YTnYAA
Date:   Tue, 19 Mar 2019 23:18:25 +0000
Message-ID: <MWHPR2201MB12771A95F3320F9D1E343B23C1400@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190315163133.31632-1-valentin.schneider@arm.com>
In-Reply-To: <20190315163133.31632-1-valentin.schneider@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3dd92e7-dd04-43f9-0f09-08d6acc12fe0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1741;
x-ms-traffictypediagnostic: MWHPR2201MB1741:
x-microsoft-antispam-prvs: <MWHPR2201MB17410447566E8AD2B2319F68C1400@MWHPR2201MB1741.namprd22.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39850400004)(376002)(199004)(189003)(68736007)(446003)(316002)(105586002)(256004)(71190400001)(66066001)(14444005)(7736002)(486006)(25786009)(97736004)(74316002)(54906003)(106356001)(71200400001)(52536014)(305945005)(4326008)(6916009)(52116002)(5660300002)(6506007)(33656002)(102836004)(11346002)(6436002)(2906002)(14454004)(4744005)(229853002)(55016002)(6116002)(26005)(386003)(186003)(478600001)(99286004)(8676002)(3846002)(476003)(7696005)(44832011)(81156014)(76176011)(81166006)(8936002)(53936002)(9686003)(6246003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1741;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UdBkTTQHQ5JRVGSauXM+UsbG2tJkT9G5zRaV0pcYb8ru6Xj3eRzl5Y5MEnRncMJHiVmkjkbuvVv7vwl4kTZf6TsRsuTYZ/wwk46pocJhiN7WLF866BUIHdiku4+0i107aMZh/UEGKfAiRak1/l0tOn7j4CiqsZ/S89aXdHW0zgBBAT5RCGgkNoJTSb6CzjZMMwa56TkdeGGk9A5jn41974MfJ4KAnC6A6QuqbF1xkoX0IcyIA6hMmhm/s6eKUhIM1kHOqaBQGUSIYEgFStzktLJ7OYH8N/NjfzzJPROkxjb8QBs99k2/B4TAtAQMkN2Zn5YjZnrq6J4CjBDTV3SUwy1jt2EM17/YNcjzU5zTvEV2YBm0aS1CveKg5n3wMlR7dsTmWTxm3aQ6Mrb/aLC5P4JesgR62jNhrfL/L2qTZss=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dd92e7-dd04-43f9-0f09-08d6acc12fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:18:25.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>=20
> Note that commit a18815abcdfd ("Use preempt_schedule_irq.") initially
> removed the existing loop, but missed the final branch to restore_all.
> Commit cdaed73afb61 ("Fix preemption bug.") missed that and reintroduced
> the loop.
>=20
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@vger.kernel.org

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
