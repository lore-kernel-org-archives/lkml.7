Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FBBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6956D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="d6QiJh0q";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OflZVmEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfJHH53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:57:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:29516 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730177AbfJHH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:57:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987q4RG013229;
        Tue, 8 Oct 2019 00:57:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=M7yjok1PMaloHjrHwMpQ2utK7Pj4gZ84Jk8qOaBwoLQ=;
 b=d6QiJh0quUQhyAJPbhBOERsCCwQBjOq1UU53hFmqXIGASCd1liiyNu2vqADbxFvZLLlj
 tcPiatsx4NF/cqGs7CvAuqHtezxNKEOd3Qy7yZw6jIQJjHRSC29YpwiklqA+9kl2PUSN
 CSTo1jDL1n+nU/iZf2UZwM77tRRLbdPRhwsbsy+PdME9enqegHut6E/Hhc4mzkKjKthJ
 Y3CVHe4aSfntI3fA/uMHc47hvWQIWY73c42dF+qtsRVH2rhcWx6/vzdwkt6pkuLKUxRR
 Vb0hV0xUea+ATGgtYn4W+ExRmGbg4eT+Fn5pM9oK8v//Jv/D8TyIG1fv+mlyTTlXbwZ1 +A== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2053.outbound.protection.outlook.com [104.47.41.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2veqqy9h1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 00:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9JRhfWDPmCW+4KdiCCOSbj6HwdtkQMG9PDuo4Ct/zz/HppHyjOUDusct7v8cAzQEsSNhMJh4Y9yL86J8zoawMThlLdSDDux/m2GkQycCu9070ou0LETmKQADkn1nJIqNBAUnNIMbWQ/TobOPFa8extk/FtadyI07c0I3fvEIjd0vLS3irxU5PiT58Q/I7WXeP5vZ2ThkwTctC3TSNrfcpKnAUImK8Aj8s5eFz4Oqtbna3QO+ol6vfhyfqD92VZM7+02RWZlY1x/sWP/yf3mwzbs9dgcKSr2Oihg+KFHuK9FN3UMz++txdHktajoB4O12ArxAIRY4zxq22sf9IyoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7yjok1PMaloHjrHwMpQ2utK7Pj4gZ84Jk8qOaBwoLQ=;
 b=HRYqeoU7N3V+A+Mmn1eje/lJRGcyvcaSETOpgxDq6yxoIofN+r1c7SNh4hYawqziabXqKbDrWgNNFXZCOgNW16Axg8LVBYm9nK4Wohn0/Q5QwC0T4F0tTtdEJq202Q5b806CdQ1Tpr4HTApBnSmxKt99leuUcMKRnvDhg/g9ZE1GHr8eidkK9QNFoI4RO/284GTMfcddCzKV49/cxMXi8jJmgvxSV4y0QIctQaw/8xSADkKdXDBIusfin7SEpwDnKyMG8cnr2X7Fe5w0JWHZktzPeV1XB9rE/pJd1ymmurMg23GOM3vjzkysUnAMOZpRhs/WIpkRnpwz93vBNfgo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7yjok1PMaloHjrHwMpQ2utK7Pj4gZ84Jk8qOaBwoLQ=;
 b=OflZVmEbB/7Hiu0YlVftWza4u+ywuyBahsfsA1hXc5/+m3MIt4vhOO7aF4xiZTsg9nGQqaXmsnTmG2Zubc1kJ5Evx1SyjzRM6/pf6J8IM+QcLkPRqAIatrp+xs+IK5RqaIonGD1gT0bbJtbS6SAhe2oFruOGFlzJsRQToW7KxfM=
Received: from BN7PR07MB4705.namprd07.prod.outlook.com (52.135.250.156) by
 BN7PR07MB4355.namprd07.prod.outlook.com (52.135.247.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 07:57:16 +0000
Received: from BN7PR07MB4705.namprd07.prod.outlook.com
 ([fe80::2898:cfa7:643b:34ed]) by BN7PR07MB4705.namprd07.prod.outlook.com
 ([fe80::2898:cfa7:643b:34ed%3]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 07:57:16 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Topic: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Index: AQHVfNoFXw2jDHNhgEqi0IjSc2aZBadQUViAgAAG8EA=
Date:   Tue, 8 Oct 2019 07:57:16 +0000
Message-ID: <BN7PR07MB47056F9852550657E9651DD7DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop>
In-Reply-To: <20191008065619.GE5670@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b4b00e-7adf-483c-6140-08d74bc52303
x-ms-traffictypediagnostic: BN7PR07MB4355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB4355B5B2286B0900187286B3DD9A0@BN7PR07MB4355.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(346002)(376002)(136003)(366004)(36092001)(189003)(199004)(76176011)(486006)(55016002)(54906003)(6436002)(7696005)(11346002)(186003)(446003)(9686003)(316002)(476003)(102836004)(6506007)(26005)(8936002)(4326008)(33656002)(6116002)(3846002)(66066001)(2906002)(99286004)(6916009)(107886003)(71190400001)(6246003)(71200400001)(74316002)(76116006)(66946007)(256004)(14454004)(25786009)(14444005)(52536014)(478600001)(66476007)(5660300002)(229853002)(81166006)(81156014)(86362001)(7736002)(66446008)(64756008)(66556008)(305945005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4355;H:BN7PR07MB4705.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPaadF2inKForCw8RI8Ms3FF2LdZ84qS/SnFyiAxIXPaiIOOM4RNc/RQ3Jwvw2n1gqZ8Go9Z0f6+HkaQ3ns/vAM6hyeD8s6fqFguxm6/dI0wCdPm0AfL/vTkFgf1wGLn+YOtNS7dt3OO6ETAhrUSurjG5TWeBno+YTp4sPlo/SX3L6xLBSpft7EbqJsPaFzxG2xtLd75mR90iU8GP7hYncEtkSzhZSmr2u1oKWumTQqceWqfLQB172o587f5bAxN88jc1wacieuYH3FVlCr/28kcfStgN/KneFWAJO/tNRRgABEhdxkSKO6k68l32ZUk+qfTG7YJNELjZCxCMxU4Vt07PHr9Ck+EHPjXCoBQyBahd76tpqd041rJAWvuS8A25gDjN+t4r26nExUsa7dtb11Yc8HvzOwXfLX0s48yFHo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b4b00e-7adf-483c-6140-08d74bc52303
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 07:57:16.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hnYp33QW1CtCD7M06oOqefmEZ9VlcgJhJgYxB3IiKNaBuQHESnGBy7GWynm3KSkQ8po29FruLcCGPEChskZqkuldwHpXu/MXurSzJQ4DwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4355
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>
>EXTERNAL MAIL
>
>
>On 19-10-07 07:39:11, Pawel Laszczak wrote:
>> Patch fixes issue with Halt Endnpoint Test observed
>
>%s/Endnpoint/Endpoint
>
>>
>> during using g_zero
>> driver as DUT. Bug occurred only on some testing board.
>
>g_zero is legacy, please use configfs function source_sink or loopback
>instead.

Yes, you are right, we are using both.=20
=20
>
>>
>> Endpoint can defer transition to Halted state if endpoint has pending
>> requests.
>
>The implementation of halt handling is a little complicated, you may
>consider return -EAGAIN for functional stall through usb_ep_set_halt
>from function driver if the requests are pending, it doesn't need to
>defer such kinds of functional stall.

Yes, I remember your suggestion regarding using EAGAIN, but f_mass_storage=
=20
Driver simple check the status and try to stall endpoint again after 100 ms=
.=20

What if Command Verifier ask for endpoint status before this time, or if=20
the transfer will not be finished on time ? Then the CV test may fail.=20

So solution from this patch should be more certain.=20

>
>Peter
>> Patch add additional condition that allows to return correct endpoint
>> status during Get Endpoint Status request even if the halting endpoint
>> is in progress.
>>
>> Reported-by: Rahul Kumar <kurahul@cadence.com>
>> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>> ---
>>  drivers/usb/cdns3/ep0.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
>> index 44f652e8b5a2..10ae03430f34 100644
>> --- a/drivers/usb/cdns3/ep0.c
>> +++ b/drivers/usb/cdns3/ep0.c
>> @@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct cdns3_d=
evice *priv_dev,
>>  static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>>  				    struct usb_ctrlrequest *ctrl)
>>  {
>> +	struct cdns3_endpoint *priv_ep;
>>  	__le16 *response_pkt;
>>  	u16 usb_status =3D 0;
>>  	u32 recip;
>> +	u8 index;
>>
>>  	recip =3D ctrl->bRequestType & USB_RECIP_MASK;
>>
>> @@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct cdns3_de=
vice *priv_dev,
>>  	case USB_RECIP_INTERFACE:
>>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>>  	case USB_RECIP_ENDPOINT:
>> -		/* check if endpoint is stalled */
>> +		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>> +		priv_ep =3D priv_dev->eps[index];
>> +
>> +		/* check if endpoint is stalled or stall is pending */
>>  		cdns3_select_ep(priv_dev, ctrl->wIndex);
>> -		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
>> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
>> +		    (priv_ep->flags & EP_STALL_PENDING))
>>  			usb_status =3D  BIT(USB_ENDPOINT_HALT);
>>  		break;
>>  	default:
>> --
>> 2.17.1
>>
>
>--
>
>Thanks,
>Peter Chen

Regards,
Pawel
