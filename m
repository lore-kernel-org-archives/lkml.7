Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49ABC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8326205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="wcytGmxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfLKQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:16:25 -0500
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:11747
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729676AbfLKQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:16:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYtEh7eIOemWiYXowGbwGqLtACfifha/36tBAOpmLtQGfoLYemBe6p7cadgc38ETs7BDjeff4z8rvZ1WsDRRWExejTHAGFRpO+IZpxbIVjKfHGZBPW6KMVBbyrHuWuexIdGGKzdzSpkVpBmHLvRKt5UTV7cVuGXTBvKn4sp8HxZiCZGM9JaXFnmU6kJPsXog1EXgKvg+g9muDPuIlcOnUC/gycGYkYzMFXOr6nEvCYOyy2x1wz0tho+AgDoXBFzS/v1x2c8o4fCKH6IqJGMnR4yrZ7Ug7g+F25ytiL+TUoBvgcB888W7o8P3WSoGJqysSuL4rXMqj/PXCSvNprR0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT9T+O7US5jGmqmA6Neb1TbcS58108G+lpcXrfEpRXg=;
 b=fNZtHF+lVhRjvwty4FKfraM8pfGEqJV9HQBBgvjcRqOEWfJ3e9UcrYOUlHvkCx+XHYAXNweDtb9ozyFbtLj38jiPq3kWwd3eJig3r6fVU3xzj9o2TSdi92XnUOjNuat3DlmVx0LxIi+F9KuRDNxiLJkJlPbVvVAsVgZ6awcCUEiSmOjKdNchXgxaTCFn+UJ/J2EfRxch8cwqiprpH2gwC8vV+z2kY/Amo+UjS2th0haD1IzeFsez0EQ2FriBQUutClxuN9e4oHu/Li7H1AhY19a1tK9MQFbahUY7x4QZ2WmldvwHgcF6RiSwfFmLYA+KXcswxdwkC3A6Xi70eg1gYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT9T+O7US5jGmqmA6Neb1TbcS58108G+lpcXrfEpRXg=;
 b=wcytGmxVVcwH2+rM5gu834yJQ4budj2LGepRhkVKql1fA2ZiLpCPJbdaCdI0jbqdExAmg8kQ/iBhi9/3twX9NzjLOxXzKPqVr9S4G4Cic6492BQpti/GlGYoMam7Btw/JZfDv/vJRPCwx5kpQl9lw4gBba5Tf162s2vsscpepGk=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB4650.eurprd02.prod.outlook.com (20.178.41.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 16:16:21 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 16:16:21 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC PATCH v1 2/4] mm: also set VMA in khugepaged range
 invalidation
Thread-Topic: [RFC PATCH v1 2/4] mm: also set VMA in khugepaged range
 invalidation
Thread-Index: AdWwBEq3Z5BwlJ79QIOTA1r/KOTZSgANZT+AAAD2ATA=
Date:   Wed, 11 Dec 2019 16:16:21 +0000
Message-ID: <DB7PR02MB3979B35C4DED689057F60192BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
References: <DB7PR02MB3979E79A7ADF7E7B2F397418BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20191211154429.7tscxcqk725guyce@box>
In-Reply-To: <20191211154429.7tscxcqk725guyce@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70b20289-ef7e-4da8-cc13-08d77e55765d
x-ms-traffictypediagnostic: DB7PR02MB4650:|DB7PR02MB4650:|DB7PR02MB4650:
x-microsoft-antispam-prvs: <DB7PR02MB46507273C74D320A5ADB9873BB5A0@DB7PR02MB4650.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(76116006)(4744005)(9686003)(71200400001)(26005)(316002)(81156014)(54906003)(4326008)(6506007)(52536014)(66446008)(8676002)(2906002)(66946007)(64756008)(66476007)(81166006)(5660300002)(66556008)(33656002)(7696005)(86362001)(55016002)(8936002)(186003)(6916009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4650;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj7Iqx9DsJXpaAdNE2j2LpdwD20gfHax47Q6IoflEhVJiQ3nFRWp623KIGXCtai/GoVRGaJVD6jq2lbCmuI878EQNPsgylUcA0JiRELKmjEFVr2PtoQh22xDPsPxna1rnF/lJ9vES0Mz4lr7KYEY9H8DFvIQ71rGl7SX1hG9kaxoWPK5XRaU0DJpMpl+CHOGP8V6gm6byTj2GghDYlWjB7SMklDMr4Lr7+3sRE6ijhi6nLiUGE4eDWaUGJq4fSLplIcv85ktx3YaXS9X3vyjkFsuT6/ihWYtMLZsNQFZlIQFjErpdMfZ2zkZMxqnMHVZBBKWdZVwm5CTzt9EmrVx41DPIvspA/89jLqRUTlM7rWHFIpikPgJmHcb8bvwp03335hmNmnq9C07bv8x+VuEjggMhgNqIMl7bCSQFAe/P5szSgojVs8nZkearCQPXj8D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b20289-ef7e-4da8-cc13-08d77e55765d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 16:16:21.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBHN+XecFBL8dKZ8W59KgZ8p0DlPpQtCRpwVvGZulZeJNs/0tSBXhKRYxZDEHDOkt35mantzBH70x/S4Oq8WfD5txa3zha/skgRhj/SNQwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 11, 2019 at 09:29:21AM +0000, Mircea CIRJALIU - MELIU wrote:
> > MMU notifier client may need the VMA for extra info.
> > This change is needed by the remote mapping feature that inspects anon
> > VMAs with huge mappings.
>=20
> The change itself is okay, but commit message should be better.
>=20
> Do we have any user of mmu notifiers in current kernel that affected by t=
he
> missing vma here?

No. This patch is a small part of a series of commits for the remote mappin=
g feature.
The kernel can do well without it.

>=20
> And subject starting with 'also' looks wrong to me.
>=20
> --
>  Kirill A. Shutemov

Mircea
