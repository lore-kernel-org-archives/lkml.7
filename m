Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41356C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D0322B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="Ial7z0VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfLKRIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:08:41 -0500
Received: from mail-eopbgr10102.outbound.protection.outlook.com ([40.107.1.102]:38727
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfLKRIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:08:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+slGJvBeQw0qfJGzSR+aZIywHKVkVMlnQNjJCIuaGhxkQyGKqjMegWmI4vzSciDZj8pJ5Pq3kPHDThr7Ffn9DJ+SKJhD22ESqzePxYl2+9dkETbBOsD6LKOGJS0xz6O0seLck8CD+FN8xs+Epg1JLAXfsN9HB+FUnLB98Rf9xZgF/oOcTWRG2T7dqz1wD4Vp+qWYMx/n+ng6FChpMSOvhXFiEI+Isw6PgP3rpqynhSwzcYNygF0/vqI8usurZ/GJv9JTTn0WTzuW4Sng1HLxO8TxuQX0lsi4uXCBSx2BehN24dnT45A8XlYt4HdKoOUqRu+S+SL1cVO+d33buXB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFJz3HSZlvQH0nB1gA7QB6NuStr/IB6AL9hJjpL+fJc=;
 b=k6KDWG9aCouqqG1qDpTZey9Ca6fsb+Wm/5nuSK8PYsem1gCcczZ4hYzUYU88H/5qbUtBPHChTLzc5YYDB8WPL7CuamsrUdccPg2tMs4iJ7hAbtQVnC9/RfaAcG+KJ/KFEpVKBxHYgzM1p3aEFqiDwRi1rnsvkH4FcFsjrLuWdf1sUKC1l19I0Z1LlylFiAj6LpVdl2v/lvIwpjCHByIbb2hpNhiISHyfIsRasDP1ARq+SdcwFrcLRVPYEq6j4Ln920kmxsuhHBm0QKHLItomVuR48zDOwZdnKs/s6EhmSCbKcxeqmiDSU0Tnb1ielVlyKDCVXgA0bWbdN531PjjT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFJz3HSZlvQH0nB1gA7QB6NuStr/IB6AL9hJjpL+fJc=;
 b=Ial7z0VX+i2TkLW/ztdbCt7CIgd9rz79y8qVqMCmhtoeBc5izSNjCOpuFd/RJ9flvKTWyuDcvcx19xG3Zycz0m100CaBwM7XrZvJQ12p5FDPNx/z7IyZ5nTz+/rb17TQe3sZ5sf5Ngl6zLFE77qIjKUh61HKtZ2e7sUG1qIFw+k=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB5100.eurprd02.prod.outlook.com (20.178.45.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Wed, 11 Dec 2019 17:08:36 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 17:08:36 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC PATCH v1 3/4] thp: fix huge page zapping for special PMDs
Thread-Topic: [RFC PATCH v1 3/4] thp: fix huge page zapping for special PMDs
Thread-Index: AdWwBRVdoL1dw8xpR1utr5q5yXwQBwANjjkAAAKGGBA=
Date:   Wed, 11 Dec 2019 17:08:36 +0000
Message-ID: <DB7PR02MB397968E491D23C0F5B611970BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
References: <DB7PR02MB3979BC324920A783BD5BB721BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20191211155444.nx4o363rlskmvyhr@box>
In-Reply-To: <20191211155444.nx4o363rlskmvyhr@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ef84b4a-ade8-4f20-4322-08d77e5cc2c5
x-ms-traffictypediagnostic: DB7PR02MB5100:|DB7PR02MB5100:|DB7PR02MB5100:
x-microsoft-antispam-prvs: <DB7PR02MB51009E90D07B308A31ADB229BB5A0@DB7PR02MB5100.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(66476007)(8676002)(66446008)(478600001)(4744005)(76116006)(66946007)(52536014)(81156014)(6916009)(81166006)(5660300002)(64756008)(66556008)(54906003)(86362001)(55016002)(4326008)(186003)(71200400001)(2906002)(8936002)(7696005)(6506007)(26005)(33656002)(316002)(9686003)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB5100;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOxaJFyDA2NH8d1yQFdZ2KSrJM7w8uKYOxoaMQe4BrbH51MmkAxwAvQ68+W6JFvpC8lyo+EIeW+vG+O2jt7Sr8F6hjvM3why7hrq6/RLufOkrR6CZjhInKGuOMlZ89tRD700y+Yup/ho9L2+Ktv56RCIavnxIwUWnEWvdbTllD7Cy7aMF1rR4udN7zWQgPu1AmhaY1IlZnjpgsp4HvauWuW6E8cv7ZfQTVUWheI2bFt1eTHIXmo/vlSqAkaI4GX5XR9eJzJ+AS5jnHtrLnxXI9ZLNw4vxSyDG8fQiv9j+Xq8qcD/BgwPX1JDfWW2YWJiwgYVn5NuGcb1Eo1p+ACmMT1jRLjuaPzKaH2DBvHn+oKPLhO3++RaERnuPgb7P8c3AWy+N4KuGY3RCP7dVd60MoaH6nRl1B8styNrqN+6Gqoaw2h59atYN2VxiOd6Nz5lxzbMVL3s3KxBJZsMvjTGUcU0FEo3csO1NPOWD4HthZzVMkDNGC4hXI/wIxqMHqNP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef84b4a-ade8-4f20-4322-08d77e5cc2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 17:08:36.5473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5AbOuECrJo9U0W3Vh1mLeN4N49NFgQHm6dPFa9Av/UeXX/KQHTt91YOLR1VAocuEvAIqZI8JN95K2TQNmCBarnMjuZsKd6j2JB3R56lZew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 11, 2019 at 09:29:20AM +0000, Mircea CIRJALIU - MELIU wrote:
> > When calling zap_vma_ptes() on VM_PFNMAP VMAs involving huge
> mappings,
>=20
> Do we have such VMAs?

I have such VMAs in the remote mapping feature.
Any reason why these VMAs are dangerous?

>=20
> --
>  Kirill A. Shutemov
>=20
> ________________________
> This email was scanned by Bitdefender
