Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409D420874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mgxwO4W6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="FNdLqnvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfHZHyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:54:11 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:6248 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730155AbfHZHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:54:10 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7Q7qxC0005992;
        Mon, 26 Aug 2019 00:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=bUiQvRS1IUGy2yylR4tuv5s3vSLC9AqVMYdBVBCDw9o=;
 b=mgxwO4W6uTQNaeP2kVpWKfKG56BEzEsQMVup1bb5Vq/Toz/orKNjymD2l0a7U9wVojfh
 sC8lmqgcFEf9HbxygJ6fuzrGlVLQTSrMF8UneBR+RGDb5sDFTBGjLfGAihHJjo7bLgIL
 zd3Bjn02Bh5qQDf2FpbHp11S+C1YC+2SpHbkGa7qukX3SPsiiI3Lc3BonEGEtXAe2Q8k
 LLsgEze0QjsUodcMa3Gmi5Uo5dSdr5PNUR+Nw9DFuaajPlgl6cLRTQF2AoMGiUKxNbDQ
 1kmt4ALMUPMMVxmHaxY0tB+xYLCj1sBZt4zPk4XgnmqYJlxGfdKxMdyWFwNkLccw9n/A vg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2uk28kwbw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 00:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0QyAwYano2V/HYY9NXX7qzTOJxZ5/iMyR6aytMOpHGBnZLGPP7+RnjCX+UavHxwEnwTvz0W2BZwtccMPnxzoDT9QfvSwT3ObtddnA2ApCnU/V/Jja/rG5vGeK6TbmWmV/PwZggEqVE9b9mG5aYxlYYriUtfwJFH8y8G01cVv4nzjxm0pIghmn1EdF6pwLycjI0m4GSPO1qqk1dCRAS+UCbv21FHOJTTQm/Fdqjbvo3BgZz2yViAKdOO6PGv/Ya5bshyQFYe/axAXszxSv4HL3gGZPwlu6i54IsctPPr2hi5ZXdYybZ691rk4LjfFoJf9kOI84JykUxq+c/xd/sTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUiQvRS1IUGy2yylR4tuv5s3vSLC9AqVMYdBVBCDw9o=;
 b=Zmfr6FuC49Y23LmZc+7IozcOI+X8L9AKrMGhqk+dJSZUw6tFDtryBkGopta4Il8eHZqprWCsn8i1aXuF81iW5S8n2vdUbUxRXvTEwIEmSaFbzBvschxOh1IjUqM3qwlQJt6IfXTnu18ncDu9ApgTMPmxYk08WO9AvIZcJyBFjTsWOsyrtkOC4vuRrySQ05YLUMmrHmbPqXBYbHRgUrFosi+xmfWPH1U6nfsYRutkns2PCUmh1ygfxEMILoW1BUTiUCamUzJeACFWMqpQ18zHRR+YheXbx4lsVYA8ngYBCMncSFdcPzneYEQOSQ+aCiJuhzfkEotsoukOsjLe+j1rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUiQvRS1IUGy2yylR4tuv5s3vSLC9AqVMYdBVBCDw9o=;
 b=FNdLqnvs5horioQZ2dmycwLph+KPb6W5YYHHUQdBdoatCQYa+IAL+sRWPG/1xyc1Uo6IxiAQ4JRaQRR80pKDt167p6mKzvL7Ln/F34xFwuK4l3Zj/Bo+rYExFXxXkrUjXTN1n5w7eJ0gbBd92RgLdQbdKWVAdwVH7cnS64ukMGA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5558.namprd07.prod.outlook.com (20.177.231.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 07:53:59 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 07:53:59 +0000
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
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVP/LMLOdqGz4qV0qb+zFnj54Ok6cM6JaAgABX8NA=
Date:   Mon, 26 Aug 2019 07:53:59 +0000
Message-ID: <BYAPR07MB4709A7F198301B63CEB0DF6ADDA10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <20190826021331.whfm7edlnxvjss63@b29397-desktop>
In-Reply-To: <20190826021331.whfm7edlnxvjss63@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTc0YTAyNDgtYzdkNi0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGE3NGEwMjQ5LWM3ZDYtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzcxNSIgdD0iMTMyMTEyNzk2MzY1NTA1NjUyIiBoPSJjelV1ZjJ0dUk4djVxOFQyUUtEZjlHdVZJbkU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f42d0f0f-7d9d-44a6-44af-08d729fa8dc2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5558;
x-ms-traffictypediagnostic: BYAPR07MB5558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB5558E565F99271C54699F71ADDA10@BYAPR07MB5558.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36092001)(189003)(199004)(186003)(14454004)(6116002)(476003)(26005)(33656002)(9686003)(81156014)(8676002)(54906003)(81166006)(3846002)(6506007)(2906002)(102836004)(25786009)(52536014)(486006)(99286004)(478600001)(107886003)(11346002)(446003)(305945005)(76116006)(6246003)(6916009)(71190400001)(71200400001)(66446008)(66066001)(64756008)(66556008)(74316002)(7736002)(6436002)(5660300002)(8936002)(86362001)(53936002)(14444005)(256004)(4326008)(55016002)(316002)(66946007)(229853002)(7696005)(76176011)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5558;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /V/K6TaJQ97V7taOGNPzzKnzXv6vRA2BWCTSqDLhHjsQVhFNTEAFnAQpnXuObKxUTxL3yVIdIHJPXmPWG9lRLOcnAHuX9b3YnAqjttSaq/4uk2vevGxxcuO1kyn+VeEa0AJ1siaTo5R8JgV3bBKzPUm6Y+HpheDBpRU0nAAMsEpEB3iiqYbJEZSmjEVf1S8xe4bTGewvHAFCWyP+TVzL2y+d2FEj5O3KRVYxMN3g2TSt6J1xSaVkRNXcZJk/Pok7OfE6gKp1QqUeMvKJKYWkvRXDCl/wCBocQkRXgVZCo223oXs7EmhvVt5+52nGV0hNzBxSCJnUcQUBxAWyyhYCO/2ZpHvMmrcvN7Kvi/vW+hIPJmm60X0EylXRAZEV+7V6i/nv1BJLgDCx5rEapGHFsVS9JPD3lXJYvaiPOBBJkmc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42d0f0f-7d9d-44a6-44af-08d729fa8dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 07:53:59.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q//eyI/5MmW0EmZ4CdT/yok/xcpCHmXXUYdTfBM2gRU8c7RavEJIBe8I4lICN7k4x4Kv2eoBmg4KUTDdAGd7+3q8q5Wh8j2L/jLhpmpxY+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5558
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_05:2019-08-23,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=994 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908260087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

>
>On 19-07-21 19:32:18, Pawel Laszczak wrote:
>> This patch introduce new Cadence USBSS DRD driver to Linux kernel.
>>
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>>
>> The current driver has been validated with FPGA platform. We have
>> support for PCIe bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliant with XHCI
>> specification, so it works with standard XHCI Linux driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   46 +
>>  drivers/usb/cdns3/Makefile         |   17 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  203 +++
>>  drivers/usb/cdns3/core.c           |  554 +++++++
>>  drivers/usb/cdns3/core.h           |  109 ++
>>  drivers/usb/cdns3/debug.h          |  171 ++
>>  drivers/usb/cdns3/debugfs.c        |   87 ++
>>  drivers/usb/cdns3/drd.c            |  390 +++++
>>  drivers/usb/cdns3/drd.h            |  166 ++
>>  drivers/usb/cdns3/ep0.c            |  914 +++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 2338 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1321 ++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   71 +
>>  drivers/usb/cdns3/trace.c          |   11 +
>>  drivers/usb/cdns3/trace.h          |  493 ++++++
>>  19 files changed, 6951 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>  create mode 100644 drivers/usb/cdns3/Makefile
>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>  create mode 100644 drivers/usb/cdns3/debug.h
>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>  create mode 100644 drivers/usb/cdns3/drd.c
>>  create mode 100644 drivers/usb/cdns3/drd.h
>>  create mode 100644 drivers/usb/cdns3/ep0.c
>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>  create mode 100644 drivers/usb/cdns3/gadget.h
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>  create mode 100644 drivers/usb/cdns3/trace.c
>>  create mode 100644 drivers/usb/cdns3/trace.h
>>
>
>Pawel, one question duirng my debug, what's purpose
>for below code:
>function: cdns3_gadget_ep_dequeue
>
>	/* Update ring */
>	request =3D cdns3_next_request(&priv_ep->deferred_req_list);

If you have on mind this line, then yes it should be removed from here.=20

Driver only should allow controller to jump to next TRB in TR.=20
If it's last TRB in HW ring and there is next request on deferred_req_list =
then
new transfer will be started in TRBERR event.

I Will remove it,=20
Thanks Peter=20
=20
>	if (request) {
>		priv_req =3D to_cdns3_request(request);
>
>		link_trb->buffer =3D TRB_BUFFER(priv_ep->trb_pool_dma +
>					      (priv_req->start_trb * TRB_SIZE));
>		link_trb->control =3D (link_trb->control & TRB_CYCLE) |
>				    TRB_TYPE(TRB_LINK) | TRB_CHAIN | TRB_TOGGLE;
>	} else {
>		priv_ep->flags |=3D EP_UPDATE_EP_TRBADDR;
>	}
>
>Besides, would you please cc me when you send next version?
>Thanks,
>

I was always adding you. =20

<snip>
>> +
>> +#include <trace/define_trace.h>
>> --
>> 2.17.1
>>

Cheers,
Pawell

