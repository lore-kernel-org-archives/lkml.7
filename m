Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD37C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F0E20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="bMCgNng2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfGOSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:18:30 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:36310
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729277AbfGOSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/sJdp6f9DBn1hfu27EnRmS51Jb4NsBrvGR/WYRdj2lUXYi/DK5E2/r9YQGUb8MYHHbDEeu1xzC331UhwSVeWMWM9M2ozOa+cLYBCoe72F+lZJzigppFNbEBIsqoAgHibblmJTvC5JUof5+z4omTgBL18mv/zLSoR12V8wGCRgghE824pRAeEjJjnD5KECwRWHIjyGywL4AirmannCCvy6dxke1HZ9e3IV4Yt5BNeReVbDeQs7htqD6aSt/DN3D6McerlfC5SGVfcLbWLdcL11MHoOuQWU8ySFtNwqTqdML/M6F9rvqgP2MCvxVzFjfn01gWpAddv8QWdRUvzxGQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8bKAMw1TzLh/zcBNKDjG8EzjHsqJIxYWd+bxo7XTSg=;
 b=YPhNY0Fap1HvZEQVrnQ/k5opuDH4A7LVGaalJ1+ahvIbRomvQIIwOi3pfcXB3RAzT002crpjpl9mrV5WiuZPyWHElegd9MGgJcnlqEf0GwmgMUByo9kw5RgveGeUG7SM9T4L+qtJUIWWZK34nk/yGnKMuoxgpodA7U5x4D2DNTzsEWvuRrJoDSSFhwUMkfEQe5v57laLz42Q8N6WhFHwC0JX663pD8mPP+zGXaf6OrxvtCXFx+vQqp0QEpONTOD0Lu5p+CL0xqYYeTqwHz4tHP1bwSxN5HwjKknTHJbUfiQgD/jPi7ERonmduVSSZg9Ky9Pk3jtg2izXNVRLircPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8bKAMw1TzLh/zcBNKDjG8EzjHsqJIxYWd+bxo7XTSg=;
 b=bMCgNng2IfNB7h0mkrXXuBtxS44rBbE8b/pQN/2iANx8PlDv8BEDoi0yWQrzdPqimqOoRV6QDZ8XLDeSukAMz9cFoXMBEQvWQ69NBIu4N1ZsiQV8jgP2nZshCt7b+vdORpLUXM25vrdZvvT00mczyWp8UjU5zmSzhgtmS/3A30g=
Received: from SN6PR05MB4783.namprd05.prod.outlook.com (52.135.115.17) by
 SN6PR05MB5231.namprd05.prod.outlook.com (20.177.248.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.6; Mon, 15 Jul 2019 18:18:26 +0000
Received: from SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::25ae:a9c7:8cc2:24cb]) by SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::25ae:a9c7:8cc2:24cb%7]) with mapi id 15.20.2094.007; Mon, 15 Jul 2019
 18:18:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Julien Freche <julienfreche@icloud.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Thread-Topic: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Thread-Index: AQHVMPt0L6ZZyVuj50Kj0VV7uF8wRqbIslcAgAEDfYCAAHvigIAB37YA
Date:   Mon, 15 Jul 2019 18:18:26 +0000
Message-ID: <6FB931D1-9C2C-444F-9CC2-32FBBDCC2990@vmware.com>
References: <20190702100519.7464-1-namit@vmware.com>
 <20190713144920.GA7495@kroah.com>
 <AF1518AA-309B-466F-ACD2-1CAD04A72716@vmware.com>
 <F1F879E1-096A-4C06-87C6-6D00F12F7343@icloud.com>
In-Reply-To: <F1F879E1-096A-4C06-87C6-6D00F12F7343@icloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a79cb07c-ae97-473f-3b1e-08d70950d4d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5231;
x-ms-traffictypediagnostic: SN6PR05MB5231:
x-microsoft-antispam-prvs: <SN6PR05MB523122F0A3FE6E45984CB385D0CF0@SN6PR05MB5231.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(2616005)(6436002)(66066001)(99286004)(102836004)(68736007)(81166006)(81156014)(66476007)(8936002)(6246003)(486006)(4744005)(26005)(186003)(5660300002)(11346002)(8676002)(76176011)(6486002)(86362001)(4326008)(53546011)(6506007)(2906002)(229853002)(14454004)(33656002)(71200400001)(71190400001)(446003)(476003)(478600001)(305945005)(6116002)(3846002)(6512007)(25786009)(256004)(14444005)(66556008)(66446008)(64756008)(53936002)(110136005)(7736002)(91956017)(316002)(36756003)(76116006)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB5231;H:SN6PR05MB4783.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HBp6wKUxMMSpCY0yowbBpvSWWKPhCpn9ONFWYGMv7asLDDIYxihv/+s2yM3Atn2MnWHQq56O8OB61eW0OA7cOeo/9BRCvKm27k0BLuFQ0iVl+mhlwGKMEEz9+CYB5FzC7tuKVkNFYkkMQnuFq6Dh+FsCynmuK27wNWB9NhW9OY33TZosx609O4z38p0UTBstZpf6sKOKcnCZKw1V5EKHpTp/pXQY52EpWXAQsdQrd3sr4sf9WqSTuZoIQSDN2gWGy2FOwdA5lYig7AufrR+HdouNWmZePyat/a64XK1ubEoF1VKXm++B3wbU5ItrOvEt3bD8Cfj1Nf2f5mxaCAvbOzqexiwIPvnBDUwBn3BwMoIeCIkybe0O999DfWujYd/oCdvnPd3bFR6WRgDBcv7/U3jW/ZZZr51c+UrYqd462Hs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E62736D66083A244AE635F17DB702F5C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79cb07c-ae97-473f-3b1e-08d70950d4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 18:18:26.7296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 14, 2019, at 6:41 AM, Julien Freche <julienfreche@icloud.com> wrot=
e:
>=20
>=20
>=20
> On Jul 14, 2019, at 12:18 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
>>> On Jul 13, 2019, at 7:49 AM, Greg Kroah-Hartman <gregkh@linuxfoundation=
.org> wrote:
>>>=20
>>>> On Tue, Jul 02, 2019 at 03:05:19AM -0700, Nadav Amit wrote:
>>>> Julien will not be a maintainer anymore.
>>>>=20
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>> ---
>>>> MAINTAINERS | 1 -
>>>> 1 file changed, 1 deletion(-)
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 01a52fc964da..f85874b1e653 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -16886,7 +16886,6 @@ F:    drivers/vme/
>>>> F:    include/linux/vme*
>>>>=20
>>>> VMWARE BALLOON DRIVER
>>>> -M:    Julien Freche <jfreche@vmware.com>
>>>=20
>>> I need an ack/something from Julien please.
>>=20
>> Julien, can I please have you Acked-by?
>=20
> The change looks good to me, Nadav. Thanks for updating the maintainer li=
st.

Thanks, Julien. Greg, do you want a v2 with an Acked-by?

[ Note that Julien's email address will be different than the one on the
MAINTAINER list ]=
