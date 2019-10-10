Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36115206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kUPo+0Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJJThk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:37:40 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:33679
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfJJThj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccEkfK0D6foFht/IrtCbeqdREyun3ab5vLsSm3L73PlPWxF+DJEi9rlo4yJ3KW5QSvjC9eOeQTWjJuaZL8m3cxVa1Aqc8KT+nzFeMcNIodU0/Bgt915NeSO0lOnn/fPEcUFosgxKqmPVocqjoSwPcUtd+SmRJP1s+Eq7VdOam81r49PXFlyy9m5kDyvT8sKIUed+pkiZPaFsyOgu16nj1IpKA57KzbxE1q6iL06uA09tIr/XyHqnkdJ/PgDSdqB9JqMGnrJe5o6CLqiDE81AhyND+K8SevShSdjvJcLjcnlFMa048dwvXc0qDjz9amrKMjSH1d+S/Ere8ZwfLMGHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mXdB3i5JeOmNo+B9Q4wnLveLWNpISnToCMurGa9awk=;
 b=bhSLVuaijBCXsFD77Q37HX2LpTKPE0ejsD9Sdz5jG/JKMHaYCoYWFsNHEPDuqZksEp3LrZLv4dSrAlJ87k36vkJcEBwpPdfW6lI9h+hylkLNSu0foTGdBZjQcif+or7s6BlZ0a0ChrthHg9qsoI1lCKVu0DY8+cRv+xi6xinytYS8FMs1cuSyhpgAyDFJJsQUqcPuj9yc7h/in2nO8xGxhMJygik/csPqYwdvjyu9ldJBKe5meKL36ZCR17jTjYh9y0Jf1pVQmmoQRZsGN7CLk5fmTJ8sDllGEdbXtFkee1iYkby9Gqm9qPoqKUJddecSwu4Hp0FINBAIDPu78fq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mXdB3i5JeOmNo+B9Q4wnLveLWNpISnToCMurGa9awk=;
 b=kUPo+0QqbklQDa5lf7M1/nD4asxtM5/tOyIdEAYZbiKGVzQL2GRm6cJDmSmXTXqo4FV1CQEsRTpYXxFJDkorBL46Bsmet0JvBtRUYQiHsROytJSPj5TEgDoXU3BRv+2YvAHFXyn/QnZ8gwP9ltu734OSgiGrY26fgqDdp6i+3Cg=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5309.eurprd04.prod.outlook.com (20.177.50.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 19:36:55 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef%3]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 19:36:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Colledge <joel.colledge@linbit.com>
CC:     Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
Thread-Topic: [PATCH] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
Thread-Index: AQHVc7J2WTi3Jq2z7EqErfeE4WWeNw==
Date:   Thu, 10 Oct 2019 19:36:55 +0000
Message-ID: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190925150308.6609-1-joel.colledge@linbit.com>
 <a87e01b0-73f1-8a86-d7c0-2700e1032b92@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ac3a1b9-5e7c-4a83-205f-08d74db93582
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5309:
x-microsoft-antispam-prvs: <VI1PR04MB53092CFB39B6E4E59D551C31EE940@VI1PR04MB5309.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(6116002)(316002)(478600001)(26005)(186003)(14454004)(25786009)(110136005)(256004)(8676002)(81156014)(7696005)(305945005)(81166006)(7736002)(86362001)(229853002)(8936002)(99286004)(14444005)(55016002)(9686003)(76176011)(3846002)(6436002)(76116006)(6506007)(446003)(53546011)(6246003)(33656002)(5660300002)(91956017)(66066001)(71190400001)(71200400001)(44832011)(52536014)(66446008)(64756008)(66556008)(66476007)(102836004)(4326008)(476003)(74316002)(66946007)(486006)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5309;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cuRyvzhXVRHVNOuM6yg4fAcjBs1KEOFMNdJsCWqX4JgCUcpEwMY7TaWYZgKyHBS3CzPwhxC7nBLSEeMr0+9UItKjS7hGSqobGM7xIGI8YU0pM30stpBv5K/c7hJTRbaQ0I876pBx7enLLR/Qwfn/3C4F/JmISghYvEJNQrqt9GwNwYlDhSyxz28p1uovW9uqh9n6qcfK+v/xTGkHHgTnOZw3/hRil9Km08b+UaeX89ldlen0WAP40bCa0EpdNu+HDeyZeB3+GZBHG9xdi+6egW1PaTHKobPL9BMOan4lx+QJOh9DpGMUOd4J8KFeBAQ5sXZgDijWkmIfzoMnsj1fns6kGZi2c71EA45K6XhRJdS0PrKGVGrpsgH20L1LzaGt9Brka1OpAYjzvKvp6+VvmJ0qHP1/dbldl4SKm4qkVX4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac3a1b9-5e7c-4a83-205f-08d74db93582
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:36:55.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rdjWkGttmYwf5JS+XYLinFJtpegisN0dPNv0VmhHdfe8Uwq8LiR4d7qdex4CyIDAV2TGQhkLDH6BKW4zwWp9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.2019 18:14, Jan Kiszka wrote:=0A=
> On 25.09.19 17:03, Joel Colledge wrote:=0A=
>> When CONFIG_PRINTK_CALLER is set, struct printk_log contains an=0A=
>> additional member caller_id. As a result, the offset of the log text is=
=0A=
>> different.=0A=
>>=0A=
>> This fixes the following error:=0A=
>>=0A=
>>    (gdb) lx-dmesg=0A=
>>    Python Exception <class 'ValueError'> embedded null character:=0A=
>>    Error occurred in Python command: embedded null character=0A=
>>=0A=
>> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>=0A=
>> ---=0A=
>>   scripts/gdb/linux/constants.py.in | 1 +=0A=
>>   scripts/gdb/linux/dmesg.py        | 4 +++-=0A=
>>   2 files changed, 4 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/const=
ants.py.in=0A=
>> index 2efbec6b6b8d..3c9794a0bf55 100644=0A=
>> --- a/scripts/gdb/linux/constants.py.in=0A=
>> +++ b/scripts/gdb/linux/constants.py.in=0A=
>> @@ -74,4 +74,5 @@ LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)=0A=
>>   LX_CONFIG(CONFIG_HIGH_RES_TIMERS)=0A=
>>   LX_CONFIG(CONFIG_NR_CPUS)=0A=
>>   LX_CONFIG(CONFIG_OF)=0A=
>> +LX_CONFIG(CONFIG_PRINTK_CALLER)=0A=
>>   LX_CONFIG(CONFIG_TICK_ONESHOT)=0A=
>> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py=0A=
>> index 6d2e09a2ad2f..1352680ef731 100644=0A=
>> --- a/scripts/gdb/linux/dmesg.py=0A=
>> +++ b/scripts/gdb/linux/dmesg.py=0A=
>> @@ -14,6 +14,7 @@=0A=
>>   import gdb=0A=
>>   import sys=0A=
>>   =0A=
>> +from linux import constants=0A=
>>   from linux import utils=0A=
>>   =0A=
>>   =0A=
>> @@ -53,7 +54,8 @@ class LxDmesg(gdb.Command):=0A=
>>                   continue=0A=
>>   =0A=
>>               text_len =3D utils.read_u16(log_buf[pos + 10:pos + 12])=0A=
>> -            text =3D log_buf[pos + 16:pos + 16 + text_len].decode(=0A=
>> +            text_start =3D pos + (20 if constants.LX_CONFIG_PRINTK_CALL=
ER else 16)=0A=
>> +            text =3D log_buf[text_start:text_start + text_len].decode(=
=0A=
>>                   encoding=3D'utf8', errors=3D'replace')=0A=
>>               time_stamp =3D utils.read_u64(log_buf[pos:pos + 8])=0A=
> =0A=
> Sorry for the delay:=0A=
> =0A=
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>=0A=
> =0A=
> I suspect we will see more in nearer future with upcoming printk rework..=
.=0A=
=0A=
The patch looks correct but I'm curious: is there a reason this code =0A=
doesn't use struct printk_log?=0A=
=0A=
GDB already knows about struct offsets so there should be no need to =0A=
handle ifdefs with arithmetic.=0A=
=0A=
Is it realistic to use gdb without struct layout info?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
