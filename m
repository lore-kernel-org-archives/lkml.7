Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27021C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B8A218A5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iMuxCEKw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fl/8Y45D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfCWEVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:21:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36014 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725835AbfCWEVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:21:39 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2N4ESSv032173;
        Fri, 22 Mar 2019 21:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=UbZnS0KnFAW2TeW+PLXM7bCsb++JKWtWpZHRzNOdiKo=;
 b=iMuxCEKwMbLBakrV2qHYhqdXEV8xRGjLNwskxocaIS1aq0ZP9MSEyj64zZJgvoJXKB56
 z2tSsyDJ3+sPZ4N+HB2YNFmdESsm7aadm1aENPy+5xJZzBNz32YRpVG6aei+iYtSQ0AB
 M6WPPvENWsBc4Zf3C8Hda8nVTZFIQX+hjxLMI3lNWPUxyF0jFUaYV/o9NMaI8UNgVE0u
 C4I5oZIsRPWaZZuxtqH7W1VQQr/zV8ttqgh2uCewNkOrZUH6LFJ6vdcr9O7ydIBfOEHB
 ejWeTTBByVQamYy96IO9tN0CzwFB0r+BQYpsPgs8CUClJKYDKp8ry6sSqrhR+6l02URr oA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rddgd8122-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Mar 2019 21:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbZnS0KnFAW2TeW+PLXM7bCsb++JKWtWpZHRzNOdiKo=;
 b=fl/8Y45DUKBCgUFhqmhkiJL5HY3XA3JLVxDx+/w634hQp+kHWVlexwonPLBqyzu1qbarD5pwaSasFjMnXbSLrR0ShdpoLEWmIB+10AaZNHtiShaRM58/rjYRua1ua44ccWgzdPPmT5Lln68tSJUNN2ztwPGBOkiP6OmVZBpxIIQ=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2501.namprd07.prod.outlook.com (10.166.200.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Sat, 23 Mar 2019 04:19:33 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::109:b92f:ec67:cc5c%4]) with mapi id 15.20.1709.015; Sat, 23 Mar 2019
 04:19:33 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Topic: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in
 MDIO read/write functions.
Thread-Index: AQHU3bIVpKCfblmDGkCRl74YIwcb1aYWKF4AgAJ6VvA=
Date:   Sat, 23 Mar 2019 04:19:32 +0000
Message-ID: <CO2PR07MB2469C8EA090D79D97F1BFFE1C15C0@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190223152540.GE10693@lunn.ch>
 <1552930948-6755-1-git-send-email-pthombar@cadence.com>
 <20190321142506.GD17655@lunn.ch>
In-Reply-To: <20190321142506.GD17655@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kYTA3M2Q0Yy00ZDIyLTExZTktODRlOS0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcZGEwNzNkNGUtNGQyMi0xMWU5LTg0ZTktMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIxOTEyIiB0PSIxMzE5Nzc4ODM3MDM5MTU4ODIiIGg9IlhvZ0VjUGVnN05Mbk1SclFqbWUzb1ZYMFNKVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1b9e458-2698-4c3c-f7b8-08d6af46c074
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2501;
x-ms-traffictypediagnostic: CO2PR07MB2501:
x-microsoft-antispam-prvs: <CO2PR07MB25011BE74DD73CD87CE2061AC15C0@CO2PR07MB2501.namprd07.prod.outlook.com>
x-forefront-prvs: 0985DA2459
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(13464003)(36092001)(6246003)(107886003)(446003)(476003)(105586002)(11346002)(9686003)(25786009)(68736007)(55016002)(6436002)(8936002)(486006)(71190400001)(71200400001)(53936002)(256004)(76176011)(74316002)(7696005)(106356001)(4326008)(229853002)(305945005)(54906003)(316002)(7736002)(186003)(52536014)(99286004)(102836004)(26005)(81166006)(2906002)(14454004)(478600001)(33656002)(97736004)(8676002)(66066001)(81156014)(6116002)(5660300002)(6506007)(86362001)(6916009)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2501;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eKQCxblLInwpPhcH7oesCgIwLZJGpAmPTV/YT/MVXTGYui0JtcBxeuRZ+QTBOSaMeSyjCd9IU6qCHjdHCI3pSAADdRcpyuEvWHsTt5sCcOTJqhGRatq/ywKzM8GbkOAxJgE2q5951qX80uwfQl2Da/UuYG8HIOoOSOy0kV+kxrujgEXJRpEUsIshZvA9mJ/VDNTCA9ASm9J1y7URux8O76368f/cxf6dIu9q+MJi2NGL4VcxcrzoCR0tED3E4I2vqAH7wyeWB7f2EFfBXmzTBo3BtDUHEk6yWecQ2f4ap68VHb6rSiPRv2nYrbXNnZrmR3Ub1kQypn+yZR3j2YNsgRX3CC5zkGJulFZNNKU02Mk5aRHwb1hbArcwnl5CPn+DDVc00/IhjeXf5mgezn54VkntHcsYd0aAKhacQx3Ksjg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b9e458-2698-4c3c-f7b8-08d6af46c074
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2019 04:19:32.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2501
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903230031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Thursday, March 21, 2019 7:55 PM
>To: Parshuram Raju Thombare <pthombar@cadence.com>
>Cc: nicolas.ferre@microchip.com; davem@davemloft.net;
>netdev@vger.kernel.org; f.fainelli@gmail.com; hkallweit1@gmail.com; linux-
>kernel@vger.kernel.org; Rafal Ciepiela <rafalc@cadence.com>; Piotr Sroka
><piotrs@cadence.com>; Jan Kotas <jank@cadence.com>
>Subject: Re: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in=
 MDIO
>read/write functions.
>
>EXTERNAL MAIL
>
>
>On Mon, Mar 18, 2019 at 05:42:28PM +0000, Parshuram Thombare wrote:
>> Sorry for sending this patch again, but I didn't sent previous email
>> --in-reply-to last comment on v1 of this patch. So rectifying this
>> mistake.
>>
>> This version 2 of patch to modify MDIO read/write functions to support
>> communication with C45 PHY in Cadence ethernet controller driver.
>>
>> Changes:
>> 	1. Added timeout
>> 	2. Removed unused operation macro
>MACB_MAN_C45_POST_READ_INCR
>>
>> I thought of starting with relatively smaller, independant and simpler c=
hanges.
>> This patch is independant of patch series and looks relatively
>> straight forward with aim of supporting C45 PHY for support of high spee=
d
>PHY's.
>
>Hi Parshuram
>
>Something i asked last time, but i'm not sure i got an answer.  Do all gen=
erations
>of the MDIO controller support C45? If the older versions only support C22=
, we
>need to be sure it does the right thing when asked to do a C45 transfer.

Hi Andrew,

There are some older versions of controller which doesn't support C45. I wi=
ll make
sure that driver return error for C45 transfer requests when it is not supp=
orted by
controller.

>
>      Andrew

Regards,
Parshuram Thombare
