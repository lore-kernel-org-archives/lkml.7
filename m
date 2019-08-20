Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0E020644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="RSdXzZbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfHTCQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:16:32 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:23259
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728719AbfHTCQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdy38XKCmZ6tBeV7NhsA7mEjAYjuletA+Ps2BJbc/5rFEp0ueb8cP9YiOZkyaLZ9yWCy0VZl0jQ0GoBo/+AMg4Pmnk4XR2w+x9EUzn7rJ2PTPN0bwqRfYUsVy8JQoC5ZnJYdOxrpoUPIlqrVb0ubqv9nU+yWK/Yl/WHZnGGgqegwzd++ikbYMpzoEUwWzJ56JZkat2UYlkOHDuNBvITkyyp5MA3WVfITXHAeGV9KHSFqlIyjuxGK8G1/5uyVdfs+M8YkQZ7CpfCy1PtfNMXb9NzcBtCl1AFhNLHBLz0Mo61r4cxA5lvgBIgN5PjS4ifTugAOfyLSJW76AS8Ji8z/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fWn5ZVY+Buvu57kcoMarviNFMpCfcENGk0jXt8qfXw=;
 b=PF/5QxwraYGCsMAMPXt6scaFWurwFr/DDFAhbLZ5Q7umJ4g/FF5JS9qGNRX3GwDony+iX1H76qcwiq3JRFvzhvB68K6jLlYASMPcatXpUsdOfNR112XYXm+NCje3LGm2maqVFLKxtFvC/zM+S3WKJoXxf6nMnSGmKZ3xuPhklf5kofAqKdE+jfXWWrvscHseboQ7ZM3HmcDYGn8F4gNKDhF43Wmrzf4oTgAqqt6yAGW5jaIa/rTOgmSvvBk7uXMi1JVxP9uLQ6BDTKpq9T8JTd9PB4dswDfBfMZMLolWsWqEWxORdJ1MlIzZxen/01TQAarKURTm1TaUv6hLjf78tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fWn5ZVY+Buvu57kcoMarviNFMpCfcENGk0jXt8qfXw=;
 b=RSdXzZbH9JdiJvR5tvsJTsMfndFs+JhKDbSOh83PEdlW7al6a7QRcHc9jRjhGD4D/RurWjTYLiuSrii9b5ECTvLu88eq6EOKWqrS8Pn4bJ4meXxcZjkm2cDD+NZrbTNrjyEJWBUFyfhTQ/bpL0MF0+mESDL58EHbk4J5pz/nN4o=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3896.namprd03.prod.outlook.com (20.177.124.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 02:16:28 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 02:16:28 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
CC:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 4/4] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH 4/4] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVVoKNUq/zpqtyiEKe+wuBFBglYqcCr98AgACajgA=
Date:   Tue, 20 Aug 2019 02:16:28 +0000
Message-ID: <20190820100522.55bc3f42@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
        <20190819192706.46ce2c1d@xhacker.debian>
        <1566232996.v8nlwmnjqa.naveen@linux.ibm.com>
In-Reply-To: <1566232996.v8nlwmnjqa.naveen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::17) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 566d4848-98f9-405c-5850-08d7251468a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3896;
x-ms-traffictypediagnostic: BYAPR03MB3896:
x-microsoft-antispam-prvs: <BYAPR03MB38960943AD7B44F0486F98D2EDAB0@BYAPR03MB3896.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39850400004)(346002)(189003)(199004)(6506007)(386003)(316002)(7416002)(229853002)(71200400001)(71190400001)(102836004)(26005)(14454004)(6916009)(6486002)(76176011)(6436002)(1076003)(6512007)(486006)(476003)(9686003)(14444005)(52116002)(256004)(4744005)(7736002)(11346002)(54906003)(186003)(5660300002)(99286004)(305945005)(446003)(478600001)(66066001)(8936002)(25786009)(4326008)(3846002)(6116002)(81166006)(81156014)(8676002)(6246003)(2906002)(53936002)(50226002)(66476007)(64756008)(66446008)(66556008)(66946007)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3896;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 50xz/V+MdxuhdU8rdQ0+VCbgWlydRVZbPL66Tmdqq7Eo/oXA/Kq26lSMh8//f7RwCLaAagMAdxkfL2ZAejM9Bc2refH6DA4RIQK8uELpq9P8EDIzI4ynXYVfjs2gEWHBEhPl/Y97pfLFbhayquCJf4qFnhj3sEgNuRz46JkQqxcr/W+9xCNEh0YshTn6H0godBe6XYNS0en4+v84kXLYm5z+XnsRGxNNSqK4H34+3RYxT6qQo484YAsyr3QWHs1cTnfmK/kSmlXPkskc/6vQuOkIu2UYlTYJNBRxzFLHoxiZxn7vjYnkIEKmCjQ6cpiRDc56CBaFSCFk/i6yeB2vQ/FuACM/Tmxx0BsD2NmTAffO/yJa/p97iOAciTfJbrMx7pDj++aqsTDcaKLau4v9JsOyw2Rtl2qcbj/aqhLcdGs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D513D93F6612794EA8269E652E4FC9F8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d4848-98f9-405c-5850-08d7251468a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 02:16:28.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvQOFQFDQin6lhSGmujrZnU7giJKF37UMb5vghHNu0AbuS/zbWra/9IKT3ga+876XJvKRaj6ZaXR1lACuvEcDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 22:22:12 +0530 "Naveen N. Rao" wrote:


>=20
>=20
> Jisheng Zhang wrote:
> > This patch implements KPROBES_ON_FTRACE for arm64.
> >
> > ~ # mount -t debugfs debugfs /sys/kernel/debug/
> > ~ # cd /sys/kernel/debug/
> > /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> >
> > before the patch:
> >
> > /sys/kernel/debug # cat kprobes/list
> > ffffff801009ff7c  k  _do_fork+0x4    [DISABLED] =20
>=20
> This looks wrong -- we should not be allowing kprobe to be registered on

Yes. I made a mistake when dumping this log. The kernel isn't as clean
as "before the patch".


> ftrace address without KPROBES_ON_FTRACE. Is _do_fork+0x4 the location
> of ftrace entry on arm64?

Indeed, w/o KPROBES_ON_FTRACE, it should be _do_fork+0x0

Thanks


