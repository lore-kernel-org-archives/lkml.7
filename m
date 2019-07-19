Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923032082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lvLaRv45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGSE6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:58:14 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56929
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfGSE6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXpASLKhRY3EBW8t9O14ngJ9dHceF5T81Wg0HJnSrKpO6o1AxxgIfqJlY9mBYM7gZxt5918L5PzEHjVbuKkg4NPtXuChi6kka+yRSr3iIjUtxiS0RScOPWl2yYvc4gC4yUnybN/X6YIhi5HT6QeBGBL4oSLnpwlTia+SxgYVgg13ZsgDudOpN2VqEwTmfIznsG7IFULNyCCphiMMJuBFgI43Qcj3AQwjpA0qXJct5W5DqNKfVj2tlBK9k2PJipsKMJ+xMHcMwHtlCk3ACZLdPe6gD7fJO7xd82W3pHXxUa6pmFF/vCkMdxNNOohsJVKJD1+GJP/I3rMxknSh+x1nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnPmiQ2oYMbrdy2TRlFxsPd6zK0DvaW43xcMigvn58M=;
 b=oYvMXT29wkzQITOssyLIprluWfCO3XUHX7+7MVSij/p3GL1rqxUC4b7VrohSjyMSL53EuFVHxNNcwCLmUESMeBlW8ibbLKVGQ1kxT0cpz2VGnIFywyalEdPh3veyK+fy21B0tqlxJZ/BkspMpeEOEwnL0cB4MjAftc8AP5yBkckcAxViTHQCZdELR8Rpy70HzEsbAEdkoGhN/CYnau1h4emqsbAQtgxDTaC9MwlvFVbyTQNp/d+42+5HJq16p/37vTrJGaQbFzQoy3MERP+mQLyIp4a/7SgTaSlCDFtOtwS9IoaQwxpysR1Ru2SrpLlPHDuUcYDgFvyjKM+170UFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnPmiQ2oYMbrdy2TRlFxsPd6zK0DvaW43xcMigvn58M=;
 b=lvLaRv45FZa+Cx/iOPOkK+FyKhbZ5ToVCQMZZwNExg8ed4UJmLhhiwTvRGF3fOVRglY5Nk/m8Oe3+4qf0jTCRG3e1kxaBocuXm0j0qrNf4VJw+KFJPZ9zrqleoGDNC3rB1WhnjXMrA5PJyt4HGqGhegMX1GU5mOzDczQqqGhUc0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4087.namprd05.prod.outlook.com (52.135.199.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.7; Fri, 19 Jul 2019 04:58:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Fri, 19 Jul 2019
 04:58:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Mike Travis <mike.travis@hpe.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
Thread-Topic: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
Thread-Index: AQHVPc0usbowTTFECki3EVK5pK8NM6bRNtyAgAAqp4A=
Date:   Fri, 19 Jul 2019 04:58:10 +0000
Message-ID: <19740EC6-0E12-4D87-AC48-E360B29FB343@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-9-namit@vmware.com>
 <54c082c5-ebee-8fd7-cf69-b8c15b60a329@hpe.com>
In-Reply-To: <54c082c5-ebee-8fd7-cf69-b8c15b60a329@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:2504:b1de:87a5:a923]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1b84e35-3a3a-43c9-01cb-08d70c05b278
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4087;
x-ms-traffictypediagnostic: BYAPR05MB4087:
x-microsoft-antispam-prvs: <BYAPR05MB4087F56BE0C235D165E35E6AD0CB0@BYAPR05MB4087.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(76176011)(478600001)(4326008)(68736007)(6436002)(186003)(102836004)(25786009)(2616005)(476003)(11346002)(446003)(46003)(81156014)(81166006)(8676002)(6486002)(6246003)(2906002)(36756003)(6116002)(8936002)(33656002)(53936002)(6506007)(53546011)(305945005)(6512007)(66446008)(66946007)(7736002)(71200400001)(71190400001)(486006)(99286004)(229853002)(256004)(14444005)(14454004)(66556008)(66476007)(64756008)(5660300002)(4744005)(6916009)(54906003)(296002)(316002)(76116006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4087;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rhwrXEJxwVOj3PwVTi7KHdiSPjJpEYDltAd14wObqxBYrbdMiTQgA1dTCLVdp7YL3ei3LqVEujoitxlbxxYYX1nEtbrVKQDbeLAejduVLNPK086plK1a7Z8//sjRjE0ZPtFUnwfkTMepXAellcwzVfnnN2UjXGYc6VyM/iAtLn48BAZG7ye4TB3yy/HhNMtdXuSk52HVgwR2vmljSY84Al6n/5i2+TO4R4rhzr3hoadpTR4IhLgg7TzpxtomXb7WoOZjQbElwyEjO3Lq5iRxPPd7aWVz3w1rOqElo8YbSGTQFYXX8D7yIqBXdiqufWXYcWOmOYqy111neQ5LevL01KGCCCNUCKtKQhZHzIsbFKbcUgHykWlmM6Zjy1+bj6PRF/3du/9kktjqNLXKG4EP3Pkjgibrf7pCyb7JUNpRXxg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2BBA571180CF745A60FE4E65BABC0B0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b84e35-3a3a-43c9-01cb-08d70c05b278
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 04:58:10.3384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 18, 2019, at 7:25 PM, Mike Travis <mike.travis@hpe.com> wrote:
>=20
> It is a fact that the UV is still the UV and SGI is now part of HPE. The =
current external product is known as SuperDome Flex.  It is both up to date=
 as well as very well maintained.  The ACK I provided was an okay to change=
 the code, but please make the description accurate.

Indeed. Sorry for that - I will update it in v4. I guess you will be ok wit=
h
me copy-pasting parts of your response into the commit log.

