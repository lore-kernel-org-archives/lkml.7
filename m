Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25808C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7DB20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ElA/3A2J";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DzIA+gYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfGHLDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:03:03 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39436 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbfGHLDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:03:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68Audq5018348;
        Mon, 8 Jul 2019 03:59:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=elXWCnMgMiRYO8iDyFCDXPZvW8NVW4OljTSmIph/Im4=;
 b=ElA/3A2J8yXeOOj/SFqdD+bihwDAV/Droe5XSDYAnkWsZXlUOVxvF4lAYw74wfGPM40r
 PILts3ZT71CLShi/0XCshML02Ku8PlPL0oBefWUXIy+FbNNPaQormb8eEw9KiUrWthKE
 9ilRL8M2sl85Bo7vcqEbTbxLieIDuENnzeOolyg+utQZGQ5oQT+Qu9zWiljEOx52ZgSE
 SaVfdv/Cp8t++3S43tKnt71EK4Aj70LDOJt3rTTxaXnUJ4r68zmjezmCU56Nv0ZtRCgk
 EgL2FpvSNk1+dJ4HD2cT1VRH4tEXWB69CYvQhSN2WJoVVnY8/xrJetoeks4Mm8TvhO4H GA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2052.outbound.protection.outlook.com [104.47.34.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vepk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 03:59:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elXWCnMgMiRYO8iDyFCDXPZvW8NVW4OljTSmIph/Im4=;
 b=DzIA+gYufo60sMwNgIc22ddYNEPzpjjEFM/611PNzmVBXIR8ZWJr+knU1ZY9hKaHo7LxNEksZW1Eh6UooWWRFQ0aAQmAmxowtWZG8EJxHU4ODoq+PLKA7267EJR/CnOjm9ZHcfUSAobhfiUJeOaK9V2LBq5R8NNLN8laRfE7Qbs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5911.namprd07.prod.outlook.com (20.179.91.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 10:59:39 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 10:59:39 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAKa7g
Date:   Mon, 8 Jul 2019 10:59:39 +0000
Message-ID: <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
In-Reply-To: <87a7dpm442.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzcxMzA3MDAtYTE2Zi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDc3MTMwNzAxLWExNmYtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzI0MCIgdD0iMTMyMDcwNTcxNzMzMzExNjQ2IiBoPSJRSmxMa0lqaWFtMVM1Si92WGRKaXc2R01Wa2M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e959a19-ceca-4d68-52d9-08d703935f86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5911;
x-ms-traffictypediagnostic: BYAPR07MB5911:
x-microsoft-antispam-prvs: <BYAPR07MB59115A798E763A4120FE141ADDF60@BYAPR07MB5911.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(36092001)(8936002)(2501003)(76176011)(66066001)(71190400001)(71200400001)(7736002)(81166006)(102836004)(26005)(8676002)(256004)(81156014)(74316002)(9686003)(86362001)(107886003)(55016002)(186003)(14454004)(6506007)(7696005)(99286004)(6246003)(305945005)(53936002)(25786009)(229853002)(66476007)(66556008)(64756008)(66446008)(316002)(446003)(11346002)(7416002)(68736007)(5660300002)(6436002)(6116002)(3846002)(478600001)(4326008)(33656002)(486006)(66946007)(476003)(52536014)(110136005)(73956011)(2906002)(54906003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5911;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sc1DwfhDbb3RAeCJlNxO25wKBfHCjUqkZrP+1gVxJ9zd/S7hoIH7DF5SNq0es0/LUxm8zdmyoJl7O8wTKai0/f09ht4VHEA12g0kUl1561DAbY4p9+yfyfCEoFs/yryc8l3ya0czW0EEZUMfmfJGLfDG4sHRq3im2FassLKMYTLdSCZv3lkq+myba8CAvXRYNlTenfdQTpNV/WGLyR+JIqCYNL7WLeaXQ3XIoj050DrS/PiM2nH6YtBzZOgIO3OFCUrTr+jQ5hMpBrZZ7Np62xiCb9gbHF/Vh0gxxKtXwn7J5TudDzgTyRSZXGZJlsecGDwgMzZbuJhWaVNweJugeFtD4jSb2JW7YdTe8g1UDvyTB3fxgjpDmNUIgkRHp1YJqT3U4080ElIva3BMvpQDk16rKOALNGtjLSq9lI+mwvg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e959a19-ceca-4d68-52d9-08d703935f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 10:59:39.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5911
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe

Please look at the changes in drivers/usb/common/common.c file.=20
I'm going to add it as next patch to next version.
=20

>Pawel Laszczak <pawell@cadence.com> writes:
>>>> +void cdns3_role_stop(struct cdns3 *cdns)
>
>>>> +static const char *const cdns3_mode[] =3D {
>>>> +	[USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>> +	[USB_DR_MODE_OTG]		=3D "otg",
>>>> +	[USB_DR_MODE_HOST]		=3D "host",
>>>> +	[USB_DR_MODE_PERIPHERAL]	=3D "device",
>>>> +};
>>>
>>>don't we have a generic version of this under usb/common ?
>>>
>> Yes, there is a similar array, but it is defined also as static
>> and there is no function for converting value to string.
>> There is only function for converting string to value.
>
>right. You can add the missing interface generically instead of
>duplicating the enumeration.
>
>> There is also:
>> [USB_DR_MODE_UNKNOWN]		=3D "",
>> Instead of:
>> [USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>
>> So, for USB_DR_MODE_UNKNOWN user will not see anything information.
>
>But that's what "unknown" means :-) We don't know the information.
>

////// start
commit 607754c60fabc43408f4f2de82d3560c72870787 (HEAD)
Author: Pawel Laszczak <pawell@cadence.com>
Date:   Mon Jul 8 12:53:47 2019 +0200

    usb:common  Added usb_get_dr_mode_from_string and usb_dr_mode_to_string=
.

    Patch introduces new function usb_dr_mode_to_string for converting dual=
 role
    mod to string and removes static from usb_dr_mode_to_string definition.

    Both changes have made to avoid duplication of code by cdns3 driver.

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..ab59954deff8 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -118,13 +118,20 @@ static const char *const usb_dr_modes[] =3D {
        [USB_DR_MODE_OTG]               =3D "otg",
 };

-static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
+/**
+ * usb_get_dr_mode_from_string - Convert string to dual role mode.
+ * @str: Pointer to the given string
+ *
+ * The function gets string and returns the correspondig enum usb_dr_mode.
+ */
+enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
        int ret;

        ret =3D match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
        return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
+EXPORT_SYMBOL_GPL(usb_get_dr_mode_from_string);

 enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 {
@@ -139,6 +146,21 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);

+/**
+ * usb_dr_mode_to_string - Convert dual role mode to stringi.
+ * @dr_mode: Pointer to the given dual role mode
+ *
+ * The function gets enum usb_dr_mode, and returns the correspondig string=
.
+ */
+const *char usb_dr_mode_to_string(const enum usb_dr_mode dr_mode)
+{
+       if (dr_mode > USB_DR_MODE_UNKNOWN || dr_mode <=3D USB_DR_MODE_PERIP=
HERAL)
+               return usb_dr_modes[dr_mode];
+
+       return usb_dr_modes[USB_DR_MODE_UNKNOWN];
+}
+EXPORT_SYMBOL_GPL(usb_dr_mode_to_string);

///// end

What do you thing about it ?

Pawel


