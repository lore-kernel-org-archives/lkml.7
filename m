Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D06206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ivZoP/mX";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="5RFiL8g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfJID7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:59:32 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20398 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbfJID7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:59:31 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x993v1fM013934;
        Tue, 8 Oct 2019 20:58:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=a1UyU5ZCM+pvSCo4oxMnFh0sOIGZZgLFGV+nxttaJxM=;
 b=ivZoP/mX/KYRdybfmUhCo03YPgc3tqu4pQzftdMzRsgtwryOEveUo+o+I/vRIQll+kEo
 3Lzuh7nn+wvm9cN+omOgKNz2dZyVS0cD/CWNyK1Uqizag2S212zfA3QY9NS48FKbDtlE
 tnfa31pHrsTY/yFeN9wN6AlSxL69Ni9atSTc8v0KkcGO34aSN/CgIvMA5eoUI43IA4bX
 +bZ3CJhv1BrdxO7GknWt0w60eBtmcvMFz8Y+c+cOLbEDexbr7N40uywPYY1UZWgPGXGM
 q7NRU4v+bTSNOZ6j9nwd4QZPIuhkyJaBDB0Tt9E3OZjTvskZJARGiixvI419iOhgxMQX Fw== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2veqqyd99v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 20:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNR2fcxdzo79YlywypYDh73Tl+4VdhzlJ1XBkg3TXthr9tYR2CVx0fqDNWHNwuX1oqujt5ZkazgeAGxn2FLrkD14+p1EQlG1WmyuBolPdOol/TQ1LkTgdM0648kHx6LfbhaHE1cAeY11JGoYmr2r7SHuOCd2rboAK0F6laVMLHxeEN4f6ULtkn7zCf8t4hDRjPKII0RuxUvtcNBjoE5keKy1XDUVYkh+AWBSWyNItMRknIjKAwMKtAw82MmBbOJEl6msibBqLIUqa4gOTxf1i9RFYkKa4nBW1uOneQiPanvye7lf+XehJ52AW0yIVOoT5+yF3ecZw+v1xKcR/ojzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1UyU5ZCM+pvSCo4oxMnFh0sOIGZZgLFGV+nxttaJxM=;
 b=k7rdjW6plokiKpHtbzjrxgFufW/pdqJvAR0VyBq8fqcI/mY6gzcRX3KkPZ3QEDlqF2YHYQvA2o1ii7W1AvdIfHCsk3QHlb4VvDgA9OesW9yoBxF3jGULXXqlsnsXVMcnNwd0yURFZ+sWPt8ha2T8K803NPpQf7NWCYIA95X1MArI51QsrqFI8o45SIcRt4ZTODQpMNhOMWdNLmNiXAssbWeQtnCEKHzxVO4ZbOeZm1zo20Vwckrk1kS0jcoUcpZtKpk6B5XPUgA5uHmGFJwHXEyY5gMcVFyhw/F5IjH0svkGktVE6Lv9XBdTKjxKcqTDZXsPmixSW2Q5e3Rt4UGUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1UyU5ZCM+pvSCo4oxMnFh0sOIGZZgLFGV+nxttaJxM=;
 b=5RFiL8g3ZONvferTqnMackMDEX6RAYDjAq5MttOoaUAYtPP0hM7PvW4wPX3CGShyvBciviizGtnvvBSfvHCbiFM5hmyXYziUTMj1WEtAC7Q37MWNgIUvoDpNcpzHyGZM5E4vgt0euoXl7qZ+aWNmapx8m9/NpM045V3s8QhsOps=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4712.namprd07.prod.outlook.com (52.135.205.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 03:58:18 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 03:58:18 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Topic: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Index: AQHVfNoFXw2jDHNhgEqi0IjSc2aZBadQUViAgABlPoCAAPccUA==
Date:   Wed, 9 Oct 2019 03:58:17 +0000
Message-ID: <BYAPR07MB4709490136F8F65A008C219EDD950@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop> <87a7abv1f2.fsf@gmail.com>
In-Reply-To: <87a7abv1f2.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 365c6a27-64d5-44d6-3543-08d74c6ceb29
x-ms-traffictypediagnostic: BYAPR07MB4712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB471210D308D8C9B852C6DB46DD950@BYAPR07MB4712.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(36092001)(189003)(199004)(5660300002)(14454004)(6116002)(476003)(486006)(3846002)(11346002)(446003)(76116006)(66556008)(66476007)(66946007)(66446008)(64756008)(25786009)(186003)(305945005)(2906002)(7736002)(53546011)(478600001)(26005)(102836004)(6506007)(74316002)(7696005)(256004)(76176011)(14444005)(99286004)(4326008)(6246003)(71200400001)(71190400001)(107886003)(86362001)(33656002)(52536014)(229853002)(66066001)(316002)(110136005)(54906003)(8676002)(81156014)(81166006)(9686003)(8936002)(55016002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KA0Q7t+npYWj3kaib0Y7BgzrMrmLve8UCdkh9XxP0jJkWBjRcSHH27/i2zmY7/7yFbkB9Ktij0WToxi/7mcWuD8gdGdy2nt9dsP5N45OVN8DdY2+ktnei4soyAQ4JodI0UKj1eRttj2GHQ7AzKpuf7tXI49Ru+EbZFtcRuY/UkC9u78DKgU5m5CHHKRf2si0yEfwgDqHA/BCXpb81Eo87r8OmvhMPwdezNiqGdouwEcoA9PD3R2+pgi8BJ+7Ifyp4F/ennd5E7LK4tOnb8S9epYcoERUH3BytJagNKzFdf9A5SDMnS+A4BVz9hiATgI5OVfdN4kuIPGUmtTmdNI3R7bvMGHfYlLIyPQHsOfi1GHrLA8RiJimMst/MHeDa2aLBU40BomBT8dVE/BBJ5gWJnio5XCqJIo2+zZocnP9ZIA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365c6a27-64d5-44d6-3543-08d74c6ceb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 03:58:18.0070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2YrVSaU9hb3NFKVZ9liBrwb8mmJNY68A01Q6kuWRhfgTLstTk7UZy9gi1n3kQUFX9E5vdEfyNUVmOz1xES7aSTNgQS10N/hW90XGramoGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_02:2019-10-08,2019-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=795 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910090033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Hi,
>
>Peter Chen <peter.chen@nxp.com> writes:
>> On 19-10-07 07:39:11, Pawel Laszczak wrote:
>>> Patch fixes issue with Halt Endnpoint Test observed
>>
>> %s/Endnpoint/Endpoint
>>
>>>
>>> during using g_zero
>>> driver as DUT. Bug occurred only on some testing board.
>>
>> g_zero is legacy, please use configfs function source_sink or loopback
>> instead.
>
>We still want fixes for those ;-)

So, if my understanding is correct in new production systems
using legacy gadget drivers is not recommended and we are not going to fix
any more bugs there.=20

The legacy gadget drivers remains in the kernel only to support the old=20
products.=20

So because we introduce new driver we should not worry  about legacy=20
gadget drivers.

Is my understanding correct ?

pawell
=20
>
>>> Endpoint can defer transition to Halted state if endpoint has pending
>>> requests.
>>
>> The implementation of halt handling is a little complicated, you may
>> consider return -EAGAIN for functional stall through usb_ep_set_halt
>> from function driver if the requests are pending, it doesn't need to
>> defer such kinds of functional stall.
>
>-EAGAIN, IIRC is only supposed to be used for IN endpoint stalls.
>
>--
>balbi
