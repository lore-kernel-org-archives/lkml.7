Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E90C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A820721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mH7lfthJ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zCGoKrhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgAIEQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:16:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62910 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727417AbgAIEQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 23:16:43 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0094F2ie021000;
        Wed, 8 Jan 2020 20:16:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=gqd8kDyiNWjov9R7Xvryp/rFu0JGZ+ZcDYmXO05ugQY=;
 b=mH7lfthJzGNIASoFzhO0BoGu4iXHwLTB6rAsYpPMnb1dTAYHiP/1dxpF0QxhAmQtax+L
 jkI/jq6YHU+/IRqczPTYyZ3jm/gRfeKzRRueH/RLTMoArI5T2GZQyBmMmMlQ9zDweF4B
 EPEmgjRYNs7POATBuxEpwDIVE6OEolKXC1IhlAs+3lKQ8jLYS8LAuJD2GWJwl096VfNm
 oN1E5jqTdC1DeoK5dK7ZUummAPAzdlvv5LKVMqcLSTl1wXI6HamMcNQx9cZDiy7dDn2K
 L66QoyL4nZ/VhVYQmVd7/W9IAugfscOwx2G/iqjaGpWgLp6w8mj37tfcWeT/APN13MnK Rw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xaq620e9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 20:16:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYO1SZrLME6QPcphSSlhUzlXQsfpOraiz0N59rA1kHPcm3AtZH8iq24AS/Uoab6OHBnm7e3loXndvQsJcq32Ux+MR32dXlAkSnKnoXlpzmjsczvSLZVRqetNBCcDxebtIC34n0hsp3LyQvhP1KsKtNptO8kn2SQNN4u4f18XMenIn8ICbiqhaZiKrWQj2ApaW6ugSf7uGDSBs4kBatPwVq7T7W3sw54tXNLQ9qj+ZSYz44814knCqU6X12JunEgI32wzZiVebhMtcEOLoYzajv3VYOAZoDD4WTANvOPq4sQPw4hu1bvKXMpC0vI4rROULADrZcmSXeHpn3WSdVh4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqd8kDyiNWjov9R7Xvryp/rFu0JGZ+ZcDYmXO05ugQY=;
 b=JIJGsOBRuu1ew050VB2OiaMoj4PYKROgeCVqy6twQ4szsBFaGUyUKa5m4REAYU0YKSZ9WJn9/hS7Ttc+mKgLiT88v195i9iIyB3McresRRkzqXtA5BGRNOAH9Qr7LUMeA1r06IXI7P0PZ7pUDtd1Vo5H0Gp60Aj/x3IG/CjcRwBb7HEIbjIJwWVARxsjn/AH1IJEd8KJtycx7LUBYoTTWVWzfQMAlrlqfP0pXmrurX8U5Rcw1AfbHFVOH8VGcozut7xYprwfAiKwULNLxsQoleoBT5/vbGc3JpeOJUq8aIucWVDoETW7sjPywk6WnBFIjTXjL9Fzr7TCObfhJsik4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqd8kDyiNWjov9R7Xvryp/rFu0JGZ+ZcDYmXO05ugQY=;
 b=zCGoKrhwWr6/NNQ1W/hk1w3ewesAtw4dLpfRrqIy+6j+z1g9kty1CLZE+Zp/gyAl9a94z9FJNVhO0E/K7A5DIbOZlJcSZQPWhiLAOBIbp1ib01XY5KvFv/bEnJ06mR/Jh5xS9r1RzRbjRf10doqFeElpfcImVmb8EAFbrJQRkeE=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5096.namprd07.prod.outlook.com (20.177.125.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 04:16:26 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 04:16:26 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Topic: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Index: AQHVxhgd/L7cK1vWyke0JuU/54YkXqfg0gYAgADnxWA=
Date:   Thu, 9 Jan 2020 04:16:26 +0000
Message-ID: <BYAPR07MB4709DB56EF568E410881E7EFDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142250.GA2383861@kroah.com>
In-Reply-To: <20200108142250.GA2383861@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2IzY2ZkZGQtMzI5Ni0xMWVhLTg3NTItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNiM2NmZGRmLTMyOTYtMTFlYS04NzUyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQ1MyIgdD0iMTMyMjMwMTY5ODM0Njc2MjA5IiBoPSJjTnA2T3ZJajdraWVwWnpjaWV4ZldXaTg4QjA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c843d81-9b7c-47d6-4fc3-08d794bab1b7
x-ms-traffictypediagnostic: BYAPR07MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB509660050736DA61CA5A71A1DD390@BYAPR07MB5096.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(36092001)(189003)(71200400001)(81156014)(8676002)(478600001)(7696005)(8936002)(52536014)(2906002)(9686003)(316002)(4326008)(33656002)(55016002)(66446008)(66946007)(6506007)(76116006)(186003)(5660300002)(6916009)(26005)(54906003)(81166006)(86362001)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5096;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3eRbb7wlZBiwt5IvzF7ElUhk6dfOJLhzX2q/Bmg9FnkqYBbZir8AlDTBHRx27XMIKdRM3a/kyjq+MGkDW3CWdzF2nbezyDMfAag1atNFykuU9bZV9DKnsmHxu62cSfSrW+QJhdkUfUEOrROGGZ43ZJE4V1E52uNIIFXV9BmuHa+1drS2SzTy67NDUsOHI5sNQIvsRo1XJ+UMijDGy81C2ONCZ4hiXBu0GpyYvB8gXXiK4xcggSoXlkEC+XtxXabg2Futqo3bO1t9bidmxyDoqDgSi3v8TasgsbkxWiVyDwKN7tlDqY9q3ucZnABOj47Kv1qt46v8qGfpLGe3mFNl8rFSfD/LFLuA4EJDpdzI6iazlp85fqPk7puoONjpOy+c0mMxDc5x1iK0XzmJXnn/1pGFyEvJfiFqkyU/VegSKmTStpv2ktpskXGJABDblOq46Zcxw0er9fMRCE4bGZLy51JjtiNT9GYGksnxWHxEiqTAUvHfd42OVXT9E2p5b3h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c843d81-9b7c-47d6-4fc3-08d794bab1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 04:16:26.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLS/ynXNB7W2abAimK0DVK78MdPPbftMvsCz7blsv9qw618yp+YSfrVi73cguelH39IBkGWsWvywVlpmqRF+RVb5yVA2Xu1N8+3mtMcF5v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5096
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_07:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>
>On Wed, Jan 08, 2020 at 12:37:18PM +0100, Pawel Laszczak wrote:
>> The ARM core hang when access USB register after tens of thousands
>> connect/disconnect operation.
>>
>> The issue was observed on platform with android system and is not easy
>> to reproduce. During test controller works at HS device mode with host
>> connected.
>>
>> The test is based on continuous disabling/enabling USB device function
>> what cause continuous setting DEVDS/DEVEN bit in USB_CONF register.
>>
>> For testing was used composite device consisting from ADP and RNDIS
>> function.
>>
>> Presumably the problem was caused by DMA transfer made after setting
>> DEVDS bit. To resolve this issue fix stops all DMA transfer before
>> setting DEVDS bit.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Signed-off-by: Peter Chan <peter.chan@nxp.com>
>> Reported-by: Peter Chan <peter.chan@nxp.com>
>> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>> ---
>>  drivers/usb/cdns3/gadget.c | 84 ++++++++++++++++++++++++++------------
>>  drivers/usb/cdns3/gadget.h |  1 +
>>  2 files changed, 58 insertions(+), 27 deletions(-)
>
>Any reason to forget linux-usb@vger.kernel.org for usb patches?

No reason. I missed it.=20
+ linux-usb@vger.kernel.org

Thanks,
Pawell

>
>thanks,
>
>greg k-h
