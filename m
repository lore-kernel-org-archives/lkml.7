Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9AC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B5E218D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TSU67Rgf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dhzut4wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGEMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:04:23 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31352 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfGEMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:04:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65C20ux024796;
        Fri, 5 Jul 2019 05:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=E+2CRFbwtMJXmjMp4ntZdmmnIKzkR/9/f1cPxsSs6y0=;
 b=TSU67RgfoPtA9nHgHHfDpGU/f6Zn4abeb5Cp3NsdK+RHNMkgnQIxqyywobWj1Zk8y3Zh
 dbPfv+OAa47c+jCWwiMpVcAnAbC19IZBtHN2VkJWeQa1bP0vkIPD57zKI+7lj7qHZzjn
 J4A/4/uZ7XW5z60/VSaDXYCN6L517+riZSSk8K7nyYr/IdLNZCusniPbyVQb054VJ5r5
 duxKqFoYjJ/YMEdkhbCXY5vw94pwGqe1c3S1x/oYpGLXUHYehJojcFZZeSNzqg68LJYQ
 LmkciaRBF9U/pPOwIq6yuFJx9rIOXNr/UJZPhawiZqSZNPLKFWQxiP3yl8lbcwgwbOQ3 Zw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2thby2w7b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 05:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+2CRFbwtMJXmjMp4ntZdmmnIKzkR/9/f1cPxsSs6y0=;
 b=dhzut4wHrfk8M/1qJ3H3pW/bNlgW0Y8T1crQXQYpjN2eMh4gXJHX9WgY1m0SdbQqiHfpsGt2QDPodIMTk2I4bhbSPx9jXF8hwJ2uFdov63ubZ6SH0aYjWoRmY+5e4XgLgqahQ/hQsuL06Bszu3ShodlekJ+p1DfukVANHws8ZNI=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5813.namprd07.prod.outlook.com (20.179.90.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 12:03:40 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 12:03:40 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Index: AQHVMyB8KL4t/wzfvkK+3nlF+Rqn1Ka74vsAgAAAvUCAAAVZgIAAA+DQ
Date:   Fri, 5 Jul 2019 12:03:40 +0000
Message-ID: <BYAPR07MB47096E7B9383A300856A76D7DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-3-git-send-email-pawell@cadence.com>
 <20190705112724.GA4294@kroah.com>
 <BYAPR07MB4709AAF54E7C58B51FC26D20DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190705114911.GA31190@kroah.com>
In-Reply-To: <20190705114911.GA31190@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWJhMTgyYzgtOWYxYy0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGViYTE4MmNhLTlmMWMtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjYxOSIgdD0iMTMyMDY4MDE4MTgyODIxNDgzIiBoPSJqRWJKSGJ5aEoyWHZEVDhzSEZSUlNjd2dSczA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e909ef0-0402-47a7-4f68-08d70140d1f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5813;
x-ms-traffictypediagnostic: BYAPR07MB5813:
x-microsoft-antispam-prvs: <BYAPR07MB58138DECBBDE9CB183165254DDF50@BYAPR07MB5813.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(36092001)(189003)(199004)(6506007)(102836004)(26005)(6916009)(186003)(7416002)(76176011)(99286004)(7696005)(3846002)(6116002)(71190400001)(71200400001)(86362001)(107886003)(6246003)(55016002)(53936002)(478600001)(9686003)(54906003)(76116006)(68736007)(8676002)(33656002)(5660300002)(229853002)(81156014)(256004)(446003)(11346002)(305945005)(316002)(81166006)(2906002)(25786009)(8936002)(73956011)(476003)(66446008)(14454004)(486006)(4326008)(66066001)(52536014)(74316002)(6436002)(7736002)(66476007)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5813;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0QCXAcOxed+Xh2YeyhHhSzhvitM1xc/EizUJSDeTV/HJ8I1MhbBJKyEkZ/znOCwx47Vbkp/V5UFeMpZCuBFptlvjLx6WKxsLPqePw3Ct7GHXBUxW4P+8tCvC+g9xjjOy4Zxkpt1ByV+H7nXsRm5d4elvM5k/Oxcg2g+xM0wzEZRKXTQvrNXVEGb65v+hK1MLcSzD9HYSTTcialiQRfVzmyQBT1ZE03ZtLJxc3/L+Xjffy1eV3RaA7+oKK4HMmWYObVx1nmwQ3ZaQ8mwMgU4ggOXo93BwpeXT4DebvFTDN55lnPG2Wyrmq4p/UqxbVbeI2by+4h5GJYa+vS3qCFpwgsLAK5NnJKnwYsXYHrLddn3xoSQ0M83OKX7s0Bwznv0KgPrP0wJSQG1o5d8Xxeb/+qmTWqv9ZiKG0ldwtSocxbg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e909ef0-0402-47a7-4f68-08d70140d1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 12:03:40.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5813
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Fri, Jul 05, 2019 at 11:39:57AM +0000, Pawel Laszczak wrote:
>>
>> >On Fri, Jul 05, 2019 at 11:57:14AM +0100, Pawel Laszczak wrote:
>> >> Patch moves some decoding functions from driver/usb/dwc3/debug.h driv=
er
>> >> to driver/usb/gadget/debug.c file. These moved functions include:
>> >>     dwc3_decode_get_status
>> >>     dwc3_decode_set_clear_feature
>> >>     dwc3_decode_set_address
>> >>     dwc3_decode_get_set_descriptor
>> >>     dwc3_decode_get_configuration
>> >>     dwc3_decode_set_configuration
>> >>     dwc3_decode_get_intf
>> >>     dwc3_decode_set_intf
>> >>     dwc3_decode_synch_frame
>> >>     dwc3_decode_set_sel
>> >>     dwc3_decode_set_isoch_delay
>> >>     dwc3_decode_ctrl
>> >>
>> >> These functions are used also in inroduced cdns3 driver.
>> >>
>> >> All functions prefixes were changed from dwc3 to usb.
>> >> Also, function's parameters has been extended according to the name
>> >> of fields in standard SETUP packet.
>> >> Additionally, patch adds usb_decode_ctrl function to
>> >> include/linux/usb/gadget.h file.
>> >
>> >No it does not :(
>>
>> I've forgot about this :(
>>
>> It should be include/linux/usb/ch.9.h
>>
>> >
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> ---
>> >>  drivers/usb/common/Makefile |   5 +
>> >>  drivers/usb/common/debug.c  | 268 ++++++++++++++++++++++++++++++++++=
++
>> >>  drivers/usb/dwc3/debug.h    | 252 ---------------------------------
>> >>  drivers/usb/dwc3/trace.h    |   2 +-
>> >>  include/linux/usb/ch9.h     |  25 ++++
>> >>  5 files changed, 299 insertions(+), 253 deletions(-)
>> >>  create mode 100644 drivers/usb/common/debug.c
>> >>
>> >> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefil=
e
>> >> index 0a7c45e85481..cdc66b59a6f0 100644
>> >> --- a/drivers/usb/common/Makefile
>> >> +++ b/drivers/usb/common/Makefile
>> >> @@ -5,6 +5,11 @@
>> >>
>> >>  obj-$(CONFIG_USB_COMMON)	  +=3D usb-common.o
>> >>  usb-common-y			  +=3D common.o
>> >> +
>> >> +ifneq ($(CONFIG_TRACING),)
>> >> +	usb-common-y		  +=3D debug.o
>> >> +endif
>> >
>> >So only enable this if tracing is not emabled?  Or if enabled?  I'm
>> >confused, isn't there an easier way to write this?
>>
>> It's checks if CONFIG_TRACING is enable.
>> It's a common way checking if option is enabled in usb subsystem.
>
>Why not just write this as:
>	usb-common-$(CONFIG_TRACING)	+=3D debug.o
>?

Ok, I will do this in this way.

Thanks.
>
>thanks,
>
>greg k-h
