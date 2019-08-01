Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B52C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD3D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="k3CYZNK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbfHATWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:22:18 -0400
Received: from mail-eopbgr680071.outbound.protection.outlook.com ([40.107.68.71]:33487
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbfHATWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv4pdDlLx1dLbGPMTtO+WoqA8HR60jPxhvQ87SPomrSfRJrY56BchndO2MoFPVHxTYHR608ysPwT6SzlBo4N8y4WxrEFiHhyZdCcg2dr1Mh9fU8qVsLip0hZdH6FLUAj2U9bH3ppIoHtLTZq6R/pmhHZk+rAsS0wC+dac713ATMuVRLxDM/MtuRTSYZAsIwmVp8hmm8rpwypdHfFzdbUn3FklUoKkazIWDHju5Fei6pg6pNsQ757iNyqAzniaiZpO0/Q3SsT/TSiMvrhQgUdN0/V7e8fNxbkI7h3L2vS2PH1jHbBrA1iztoMq+oCM6X9otWkcZOAkeHI/LYLRi2hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf+B579s1SNexNUobqYpQFv9Xof02ZMVZ5eddXmfQGE=;
 b=ogpP/qQnILuM9PkkgCta+XGWRM7nGIjMThk3CtsbSYhuyx39bZULykfnIn3jSy+cdqCLBzvObQg6S/agswn5XgyU+8qKeLYdIisz+fMlYBXURfomTxMRqwIrKUxtojwXSnH+75qRsmd2KzUDRFBQDJSZ5xGHFSScuF3ppKB5SalGUrcoskDbiP98k58shnwEW/RBIORSci0xDcx1DkV2xohc7p8ZWrVb9hQC6ILOvriudtzzmwAe0rs13G6BOTxKgB3/2V6wKcCBToo7zVnFe4j+y1Tu33Lw0+zrXxwAtozsSwXzklqewc5iaHggrcbaEi6tOsgxr0/+FNE5f1ylfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=daktronics.com;dmarc=pass action=none
 header.from=daktronics.com;dkim=pass header.d=daktronics.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf+B579s1SNexNUobqYpQFv9Xof02ZMVZ5eddXmfQGE=;
 b=k3CYZNK9BdMLwu745LPF6hwdnzp8FYDZf4qvKQDaGWclujEgOlPWk3sI70+NiI6yrJZjyUpDbCLbuRg681l3fwkVxpePjR7MehML9AJ3MUc2xWtvHVD6aR4gM96TzV2xfGyTdTr5r9yTyK5J3I6AzgSYjc8voCJT+FrSvNxnOXU=
Received: from BYAPR02MB4005.namprd02.prod.outlook.com (20.176.248.143) by
 BYAPR02MB4984.namprd02.prod.outlook.com (20.176.253.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 19:22:13 +0000
Received: from BYAPR02MB4005.namprd02.prod.outlook.com
 ([fe80::ddfd:31d2:4c5d:f75c]) by BYAPR02MB4005.namprd02.prod.outlook.com
 ([fe80::ddfd:31d2:4c5d:f75c%6]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 19:22:13 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Harsh Jain <harshjain32@gmail.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging:kpc2000:Fix dubious x | !y sparse warning
Thread-Topic: [PATCH] staging:kpc2000:Fix dubious x | !y sparse warning
Thread-Index: AQHVSIcHzcxxBjSjT06bdC+lWh47aqbmq2jA
Date:   Thu, 1 Aug 2019 19:22:13 +0000
Message-ID: <BYAPR02MB400519AC022AB41054C110FDEEDE0@BYAPR02MB4005.namprd02.prod.outlook.com>
References: <20190731183606.2513-1-harshjain32@gmail.com>
 <20190801163437.GA8360@kroah.com>
In-Reply-To: <20190801163437.GA8360@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:2d0d:49c4:33aa:6af4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a99640-0fc6-4af1-8b87-08d716b58ed7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR02MB4984;
x-ms-traffictypediagnostic: BYAPR02MB4984:
x-microsoft-antispam-prvs: <BYAPR02MB4984710B2AF438BF069C6174EEDE0@BYAPR02MB4984.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(13464003)(199004)(189003)(14444005)(476003)(52536014)(76116006)(81166006)(305945005)(4326008)(11346002)(7736002)(229853002)(46003)(64756008)(8676002)(486006)(66446008)(5660300002)(256004)(66556008)(446003)(25786009)(81156014)(86362001)(68736007)(66476007)(6246003)(8936002)(74316002)(71190400001)(66946007)(76176011)(99286004)(102836004)(110136005)(478600001)(316002)(71200400001)(6436002)(9686003)(33656002)(53936002)(2906002)(186003)(55016002)(6506007)(54906003)(14454004)(6116002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4984;H:BYAPR02MB4005.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EDV3zC4EF0s1DHw+JfxXiYBBsNLXIjvYDQ+M9pflEX3UzAZoXITjjfh8nE7smc6TDSt6X2+w0+Vm3MGjjR7ll8cRClmkJhvQdZukA2mAyIiW0sIJPbx1IUTkFq43urTELE7Hr2kY17PFjRB4ePJvniYlN3grMIen3QLp2cqlOY18BoAdXNemTF9gg1sZL6BYPBZ6A3eG7zw1l0PW57KVKrwJ05VU2HJkkBZ1sesTQPqPR+gEJrXvxpDHtz5mIpXrsVFhD6aV6XQIzeTOTpibGLy9DwTXcXAvw1NJ3GjQ4hsKqW/5Yn59T6zMZQNCuceI5Lbm+5e+NRSpjZDU34zR4mvgnUMQAaHl2uhyi08CpJjzNp1z4YPsThjhDZXeaj4HpO0Ov3d/DH6zaKHy0+L8NpsJ/fAzf/YQGf185Kr35mo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a99640-0fc6-4af1-8b87-08d716b58ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 19:22:13.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: matt.sickler@daktronics.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of =
Greg KH
>Sent: Thursday, August 01, 2019 11:35 AM
>To: Harsh Jain <harshjain32@gmail.com>
>Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] staging:kpc2000:Fix dubious x | !y sparse warning
>
>On Thu, Aug 01, 2019 at 12:06:06AM +0530, Harsh Jain wrote:
>> Bitwise OR(|) operation with 0 always yield same result.
>> It fixes dubious x | !y sparse warning.
>>
>> Signed-off-by: Harsh Jain <harshjain32@gmail.com>
>> ---
>>  drivers/staging/kpc2000/kpc2000_i2c.c | 16 +---------------
>>  1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc=
2000/kpc2000_i2c.c
>> index b108da4..5f027d7c 100644
>> --- a/drivers/staging/kpc2000/kpc2000_i2c.c
>> +++ b/drivers/staging/kpc2000/kpc2000_i2c.c
>> @@ -536,29 +536,15 @@ static u32 i801_func(struct i2c_adapter *adapter)
>>
>>       u32 f =3D
>>               I2C_FUNC_I2C                     | /* 0x00000001 (I enable=
d this one) */
>> -             !I2C_FUNC_10BIT_ADDR             | /* 0x00000002 */
>> -             !I2C_FUNC_PROTOCOL_MANGLING      | /* 0x00000004 */
>>               ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC=
 : 0) | /* 0x00000008 */
>> -             !I2C_FUNC_SMBUS_BLOCK_PROC_CALL  | /* 0x00008000 */
>>               I2C_FUNC_SMBUS_QUICK             | /* 0x00010000 */
>> -             !I2C_FUNC_SMBUS_READ_BYTE        | /* 0x00020000 */
>> -             !I2C_FUNC_SMBUS_WRITE_BYTE       | /* 0x00040000 */
>> -             !I2C_FUNC_SMBUS_READ_BYTE_DATA   | /* 0x00080000 */
>> -             !I2C_FUNC_SMBUS_WRITE_BYTE_DATA  | /* 0x00100000 */
>> -             !I2C_FUNC_SMBUS_READ_WORD_DATA   | /* 0x00200000 */
>> -             !I2C_FUNC_SMBUS_WRITE_WORD_DATA  | /* 0x00400000 */
>> -             !I2C_FUNC_SMBUS_PROC_CALL        | /* 0x00800000 */
>> -             !I2C_FUNC_SMBUS_READ_BLOCK_DATA  | /* 0x01000000 */
>> -             !I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | /* 0x02000000 */
>
>This is ok, it is showing you that these bits are explicitly being not
>set.  Which is good, now you can go through the list and see that all
>are accounted for.
>
>So I think this should stay as-is, thanks.

I was going to say the same thing, but I didn't know what the kernel style =
guideline was.
Would Linus prefer this style or would commenting them out be preferred?
Seems like the sparse warnings means the current style is not acceptable?

