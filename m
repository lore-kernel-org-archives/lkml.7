Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AEDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F06A20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="QB5ae7bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfE0Rea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:34:30 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:20243
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfE0Rea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/RTmYrHGZxUG+cRKg7uR2cG6FZ6G5Hf3b9rZYSkqyE=;
 b=QB5ae7bWKsPdDt+8oDDP5O2LJ+8zN0MzubXKwNcX5+0aO1yHy0t0/3V1hatauQDlHl0e80cvHX6+d2Y00msmnQguTZBDtDG8BuHZ2B7h3fZBhK4oAxit8MPZrxEQfUT/qSTxEbHKeWeSlGw/xFQ7EOfDisUqeWK9p3dcSpPSaD8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4885.namprd05.prod.outlook.com (52.135.235.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.15; Mon, 27 May 2019 17:34:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.007; Mon, 27 May 2019
 17:34:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/6] cpumask: Purify cpumask_next()
Thread-Topic: [RFC PATCH 2/6] cpumask: Purify cpumask_next()
Thread-Index: AQHVEtL01bbPeKZ8oUGZpk8eFnzdaKZ+p1cAgACX3YA=
Date:   Mon, 27 May 2019 17:34:26 +0000
Message-ID: <5EE58FF7-FDAA-4C4E-8A61-B8BECC29CDD3@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-3-namit@vmware.com>
 <20190527083052.GR2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190527083052.GR2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69896ef2-9984-4269-8959-08d6e2c990fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4885;
x-ms-traffictypediagnostic: BYAPR05MB4885:
x-microsoft-antispam-prvs: <BYAPR05MB48857A3A4B3059F27E1E3BE5D01D0@BYAPR05MB4885.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(6506007)(54906003)(53546011)(6916009)(316002)(76176011)(446003)(256004)(82746002)(36756003)(102836004)(26005)(2616005)(14454004)(476003)(486006)(3846002)(6116002)(86362001)(305945005)(73956011)(7736002)(66446008)(64756008)(66556008)(66476007)(478600001)(66946007)(76116006)(83716004)(71200400001)(71190400001)(8676002)(8936002)(99286004)(81156014)(81166006)(11346002)(2906002)(6486002)(5660300002)(6436002)(4744005)(25786009)(229853002)(4326008)(68736007)(6246003)(186003)(6512007)(33656002)(53936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4885;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /gqBA8eO+dMhXEHIyeJ3dnQS7loqyaChbTMfVVGneV2D4DvKGbru1GBrybrvfh7lidw24LGMzqaLFQ9t2Hd3Z9Zgl2veRe9n8sVebeS1DzX/0dwrURzXIdCOuudbG7MjjJ1fDQHC+wN1ciDpxwrSandZPPwVCDAgxqVf0m9h2eHksJTxsKsaVS2Kgwm02za72wKmeg5nrBCIZC+dJMQ7lBBe5OuslK6AkYxTrMz46uYV17IfwOeKwePCVrCSKNXZXLG6PC1IrNP9HMT0qhnu63Lk7FJULFkT4VNduXR3im5LSyWNtZPrJNvWmYM5qWIA54Qadkd6c0p0XhawZYXlTEte0jZ3iunLq88vVqS47V3FkiEe3/dkPPI2KFisxKuql6x3/0eR3Ed5juDSr8265Ms0dgbam9lGJpjeQrVsKKQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <590182A5FF348047B747D164DCFDB8C7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69896ef2-9984-4269-8959-08d6e2c990fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 17:34:26.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 27, 2019, at 1:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Sat, May 25, 2019 at 01:21:59AM -0700, Nadav Amit wrote:
>> cpumask_next() has no side-effects. Mark it as pure.
>=20
> It would be good to have a few word on why... because apparently you
> found this makes a difference.

I see that eventually it did not make any difference. I saw in the past tha=
t
some instances of the kernel are affected by it, but I will remove it from
this patch-set in the next iteration.
