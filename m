Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41C3C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F8921851
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="L5UQjTDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfGaRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:02:28 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:38759
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbfGaRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOXT2KUTfxcPvEMCppPXk2wrMj4BZLasKl0MVTzmNI0fkSjLV66M4uEv4krqsabdQDAjj/97Yq17EVEK1CYwucARO5gIJ8n49ieAhWP84LKaiJXcCQuzJR2yUnt1e8yP8sAwa7oVw4aMqLe84HOk7VQrTvm3gGJdXNzMc/W56FObR+HJ9D8hv4Qey2bPXSJmcFVGjUXd2Z5LR4WCqHcDwlr89wMcx6SvIx5WIiWdqZdZdFf7rVeBTOniH9u2pzNo7r02r6//ESGNRHeNrfPnix8l/pazfCnh6Ivg6dPk76aksMhEYb2i/t9gJJ7O1u762oYwKhwdbDrus5mfExRACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h66GYamRh5h8PU3T095hhzCj9UAlrpEZrkJYNRToWEw=;
 b=XwwlJYgAJQ4rZvYxgaUjCaHIM3BgbPeo8fO7H8WknkiiXp6hPzMXD+HBG0xTmdt5pD5/tsUT6PEoJqkKChPfD7QtMM3203BxKoiY+J5ljyjUjfNrmfwKXb7PV/kZbVW1BRyAWbM0QyMJbIlPAY2LCyM7KY5ioZb9MM5wNwt7HLSIOc+06lDgWhuag9DToWEsnafL8alrqHyG7sa7XCcwarWyTLzgos3EnWmjkG+BLz+BXoWnJ7Jh+/ptHMdFsbqC5fo0/L1D/EhC/OUgSg3pxO/BsTF3mutzY9Cyo6Gx9ZIikl3Ao5OXK5S82QOPRhYmts1cCdJz1dK3+M2ovDYY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h66GYamRh5h8PU3T095hhzCj9UAlrpEZrkJYNRToWEw=;
 b=L5UQjTDS1konX8ry82cmnIKY6y4buSB33dhb+3UGmgB1jB4Vg1G2ZhzCOwrInofPuCtPO3GvfZL63BtlB/3W59RYqZg0AT9ehbXxTjjCeTwybV7EXAQ6AWY+31P8WpQYtN4KeeuCQ4x6NJpluZzswU0VAXr0RZuQgyYmgdREKs0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3231.eurprd05.prod.outlook.com (10.170.238.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 17:02:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 17:02:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Thread-Topic: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Thread-Index: AQHVRpr2/Xz4jNPu6k2DNRcwdQGPdqbkuYYAgAA8sIA=
Date:   Wed, 31 Jul 2019 17:02:24 +0000
Message-ID: <20190731170219.GG22677@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-3-hch@lst.de>
 <a4586f5c-0ae4-8cbd-65ff-dfe70d34f99b@amd.com>
In-Reply-To: <a4586f5c-0ae4-8cbd-65ff-dfe70d34f99b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e18b437b-1d80-4064-93a4-08d715d8dbb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3231;
x-ms-traffictypediagnostic: VI1PR05MB3231:
x-microsoft-antispam-prvs: <VI1PR05MB3231B23EE08859787CFF93EECFDF0@VI1PR05MB3231.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(6512007)(478600001)(66556008)(6916009)(6436002)(11346002)(14454004)(229853002)(446003)(256004)(7416002)(6116002)(3846002)(54906003)(53936002)(305945005)(36756003)(86362001)(316002)(486006)(2906002)(476003)(2616005)(66066001)(33656002)(4744005)(81156014)(8676002)(102836004)(26005)(6506007)(66446008)(71200400001)(1076003)(53546011)(386003)(6486002)(81166006)(4326008)(99286004)(6246003)(52116002)(76176011)(68736007)(66476007)(64756008)(66946007)(25786009)(5660300002)(71190400001)(8936002)(186003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3231;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XvANRZ0wSiwaYImTi/Xr3Vcjvyb3jUZ9kXGpIMAMliLL6nh88DIR9Yh1Zop+BRn/H8Ent1VUnvJsbHWZ2M6wXZBC7utyFXLbpNkbuXcvSREmn69Vjgy9PZoVRZvZjJmGYQy96YC/pPe6eAJXl63HvODgzwUjaz2yy2i2kJea4byM3/AV8p0T+OYwG+WYSIWwJbqWlF6x2pX7NEku1uagH3ZhYaovCn0XJ8Ng0oOvKn9KUrtJRtcyB1WmZKjyFlGGb34I0aa3oYIex22SOsO3C+cC0zOnj089fsi3t9ySZu9jjRa/qEgBWRhE9fLEGuDenzxZOuM4FPdDyp6B3gAm7cXxSg5Kfjb+gyNtPrlWEuFUQBS45zRynPfUGNRudHAY6IhgLvaZjl8nqJltfM/1+bgV7RLjNuiYlQZL8IdecDA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FAC49FFA8B421F49B49EF44701A00263@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18b437b-1d80-4064-93a4-08d715d8dbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:02:24.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:25:06PM +0000, Kuehling, Felix wrote:
> On 2019-07-30 1:51 a.m., Christoph Hellwig wrote:
> > The list is used to add the range to another list as an entry in the
> > core hmm code, so there is no need to initialize it in a driver.
>=20
> I've seen code that uses list_empty to check whether a list head has=20
> been added to a list or not. For that to work, the list head needs to be=
=20
> initialized, and it has to be removed with list_del_init.=20

I think the ida is that 'list' is a private member of range and
drivers shouldn't touch it at all.

> ever do that with range->list, then this patch is Reviewed-by: Felix=20
> Kuehling <Felix.Kuehling@amd.com>

Please put tags on their own empty line so that patchworks will
collect them automatically..

Jason
