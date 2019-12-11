Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F0C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1F82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="YB7k7lOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfLKROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:14:01 -0500
Received: from mail-eopbgr20102.outbound.protection.outlook.com ([40.107.2.102]:33377
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729786AbfLKROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:14:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKhkbAFRqncacQnCZi84v8xXyqUTyrTlEhWuRrFllW7nhiQIsHNKUyy3k4BYVYl4H/CnxbZz6UV7G9e5X0ykWCXJD4iqjMAhqJb3wXZcPPBC08aXgEcV3FAHkyE5qF9fbmTErq9bFgkfOaiIavb+9wnh5eV7yOZcyRVhYSPPlTV2FPnmP0gxGhTgWBaaQEIofR0Fd71eEf9JtJ+6Ie3m4fuco51zS2tusVAInqEIABYNEYqiNc5D2b/xuy6Ez8FyuPhyonlx8tL610C5VI+spsjOoyuNALEV2hp7zXusnW+JlCHA60Cg9sI3Dt8XDA8K5SmONlkZ6t4bKqwosw924g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUe8aM1uh6dUUrYgwjdDsjHERyVByZDwBDP+ft1l4fk=;
 b=fMtsx9yOy1fYTkdgrEjfeYG8iZKOxEWwGVCBW2Njh9Ax5dwcUkviZsFY4GfzmyuDKBWwvPp+BA9J30rB9ojef22eGjmpGlCTBq0oP/pxl2ZNeiwbIC8lntfMC8drxgKkGB8gUt1ub/iX8R3Urgy80YtNYbcCHXsLR8F42/qVKQ4Orxqqu3pXTrJOeWSs9wcNVwCikNeDnIKI2KRJsqJPRWW3buO3QKrssLC5YCe9zAOpbuXZKCcPFwmUG66TJao1h7xy0Ce9EU387CKqfdXBhagAV6UaYuQuh3wbGLzs1Hv8ZUYjMlFIFHd+ahUR9qmRlMxRywI2wCbqpufkPzc8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUe8aM1uh6dUUrYgwjdDsjHERyVByZDwBDP+ft1l4fk=;
 b=YB7k7lOwVTSyQkpYU8sONwS6kFipw0TQYnAAo+ZJEjFy5zh1CDkO5mEhKwf+x6WXZc3o1OYJU+Vx5XzWoheztqQjhMLpbBd8ml8L1VpZeZd3bhEokD0rC3DcBsS3Ijl7NL4qYSeWyp+JDQXqYA+oqPxThdDJY/NYka3vctEwEQw=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB4137.eurprd02.prod.outlook.com (20.176.239.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 17:13:57 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 17:13:57 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC PATCH v1 4/4] mm/gup: flag to limit follow_page() to
 transhuge pages
Thread-Topic: [RFC PATCH v1 4/4] mm/gup: flag to limit follow_page() to
 transhuge pages
Thread-Index: AdWwBRVo97ip28i7RLG6c8GTBoWkWgANoD+AAAKKloA=
Date:   Wed, 11 Dec 2019 17:13:57 +0000
Message-ID: <DB7PR02MB3979E3D361EC89D30416FACABB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
References: <DB7PR02MB3979ECF6271070E49D062EAFBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20191211155645.pkxphc4uo7ir6pbb@box>
In-Reply-To: <20191211155645.pkxphc4uo7ir6pbb@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e8d451-3932-4f22-0f9c-08d77e5d8228
x-ms-traffictypediagnostic: DB7PR02MB4137:|DB7PR02MB4137:|DB7PR02MB4137:
x-microsoft-antispam-prvs: <DB7PR02MB4137B4555A5BA95A472D8711BB5A0@DB7PR02MB4137.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(52536014)(26005)(478600001)(4326008)(66446008)(6506007)(76116006)(186003)(54906003)(7696005)(2906002)(66946007)(33656002)(81156014)(64756008)(81166006)(9686003)(55016002)(71200400001)(8936002)(8676002)(86362001)(6916009)(4744005)(66556008)(66476007)(5660300002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4137;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zczQ7k16rOHvgTahbCgOOw1H2SX8stGwsQJ5E7x5HzpcgDX8ARPl7kvys9XRKzJemDiFpjaZ0DOztTYyTM/uGy5Bfsnbx95D4RXhJstJ3VPkbmw7SCXcSmQXnVC5R26w3gi8rA8snDp5ESgXQkypo4uGAqWVbfVYmDTRmrtguIPXMBMlQWM+vQ4zTN5tncheXKZZThCqLvkNaRUwlAzInLQy+h2HTc3WvqYTMxpYr39VX5cUh9buF+yJ/fk/MI4IUQE/ZmEYTbSCIi3dGST8/mjsZ7V2WaoYbZwFCmyiqfMHRDcAN46viieF9stJ0phiOOetGYibbaremMinjPB4/S1BHTgaeb47SSRvOMMxofw5+uy8obuZ1KToWA0fAKYJiIv+bYzH+iNtAHBteR9BeVSCYK0iaBARCgKHHAYdQfYz8q2MjkpGBwtU0CspU0VF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e8d451-3932-4f22-0f9c-08d77e5d8228
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 17:13:57.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vonPK8VLoQgAHL/5Sgsgt8aAD87wTMVQhBWADdcfZC+KnCsxZIJvYk9OL+lEmjQmZz8FMO6fJo9Odn5LlvrxyFbTbSKXiSSs7XSvOiMGodQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 11, 2019 at 09:29:19AM +0000, Mircea CIRJALIU - MELIU wrote:
> > Sometimes the user needs to look up a transhuge page mapped at a given
> address.
>=20
> There is no such examples in the current kernel, right?

This is a helper patch for remote mapping main patch.
It helps to establish an exact mirror of another process page table.
And exact also involves huge mappings.

>=20
> --
>  Kirill A. Shutemov
>=20
> ________________________
> This email was scanned by Bitdefender
