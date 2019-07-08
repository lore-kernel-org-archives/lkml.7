Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9936C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF820861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="s4gaGqos";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fi5K8PMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfGHLqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:46:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727286AbfGHLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:46:47 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68BhcP5018657;
        Mon, 8 Jul 2019 04:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=aW40cqTtiVMJC5+4vOZB02W9O7+KjFyUKvbDQSAcrSg=;
 b=s4gaGqosmFNs08C4JzADR6A5Z0MgNSfbZgQDDjHCorwIEyDvt79M44hefG3FCkGZgbQI
 4JiHi9biKPIzIl7Y4+RLVCHzrTUmsT+PYqoGaSGRh0oDRRAAmkFcQWMEQeq6YA0EDLeH
 dJLoVTjrg6zkhY5qcww9YQvUJ/t3Mh84xsxKzh/nv3l79mDfAkbVxvm34lddkWfRRaHf
 bWjo7HF70BH+KNnJEepuvBijJIxDyqthQT5P77Rmdcp+BQp2CIZEFJCqUB6fc2mknvhR
 xDUal3l5QiILt3C3OCp+7BYlrAAsFU6kWEqfKCwOZ8lxbIxpyvoTVJ0AEVKXFpwwGLC4 gw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tjq7wf3qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 04:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=SVJLyg7FVH/8tQDEwM89hXKTwVx7BwHZN9f91vvWiuJ4dEghFnXZIHt/DTI8ULu/82BXwYa2hxrQF6knqCUifZKWvlaaC8j2Naau0rmIm3HvhjWmf2ucybx73U1dGpCcu2X5ImAEAOZcWt/Q5kchYcjDAvsNZPcqMDvH9bW4egg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW40cqTtiVMJC5+4vOZB02W9O7+KjFyUKvbDQSAcrSg=;
 b=ZgrhcmXrDMTch+7YPVU9Q/3eRyJFDw+WU2jFXjUGiJ7PXc0QXXTP5BU90dVnxKRmPdv3gVKAwh56cNyb3ZfZLKM8qHySsocrLGz+fDD1izl307Jq36XVgpaDomn0L7ujcRQmVB8gj/ompNhQu836G8hvOINVCXabiVagh5fHAIU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW40cqTtiVMJC5+4vOZB02W9O7+KjFyUKvbDQSAcrSg=;
 b=fi5K8PMBS6t9I30Q2TgS6ZXUw5MOL3hzgI9NTzntOK0CvHSGMbv9wClIi7q/Os/5ttk6lHXProIi1PVSkDCilAygQpjLLME29h2phYzN4DdsG35wRDlTGOqbzRkLFPn0cLQiIKpFurT8th4UY010qnQfjsCGxsaEcD4AgMZ/KzY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4471.namprd07.prod.outlook.com (52.135.225.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Mon, 8 Jul 2019 11:45:48 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 11:45:48 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAKa7ggAAmawCAAAZysA==
Date:   Mon, 8 Jul 2019 11:45:47 +0000
Message-ID: <BYAPR07MB47097C3C2A2BBA2AA63C65DEDDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
 <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <874l3wn5ep.fsf@linux.intel.com>
In-Reply-To: <874l3wn5ep.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWFjMmE3ODgtYTE3NS0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGVhYzJhNzhhLWExNzUtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjc5MSIgdD0iMTMyMDcwNTk5NDQzNjcyODQzIiBoPSJjVXBqM0taclMzaFBwMXYvMGpRMXMrakRZWDg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6828216a-aa06-40a4-3c92-08d70399d1c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4471;
x-ms-traffictypediagnostic: BYAPR07MB4471:
x-microsoft-antispam-prvs: <BYAPR07MB44719F910A397BB628AAC688DDF60@BYAPR07MB4471.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(36092001)(86362001)(2501003)(5660300002)(99286004)(74316002)(3846002)(6116002)(256004)(76176011)(110136005)(71190400001)(7736002)(446003)(305945005)(68736007)(54906003)(229853002)(52536014)(186003)(7696005)(6436002)(316002)(55016002)(7416002)(478600001)(102836004)(107886003)(9686003)(53936002)(26005)(25786009)(14454004)(476003)(11346002)(2906002)(486006)(81166006)(66066001)(81156014)(66476007)(66556008)(64756008)(66446008)(66946007)(73956011)(6506007)(8676002)(6246003)(33656002)(71200400001)(4326008)(76116006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4471;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6aeuDetNiXSasConqVQ4l/dbAntUJBTf5gMabGPS0qD/FUyUJ4sMjd/HTEDg8M636Zd/e4kmlvwJSk1jRjpVrPZCAbBVi6gLII7uZmtWcLtgXTZg1pwrh3Nc85dZERFXVa5c1IcutFvH9iiMeDGlnQ1NDgNW9iLmGMSn6ttuOTpDDjieAycFzWiTy+lAJYm+jubcpit0kHNf8tvaPpy5Jsvzf4c1qdOSavdAUAooubffkchoz29XtRd9u71nZqVf4IefLn5n09AoxE7NUkoeR8+gOOe76U40Q8kdnb2dylkCTFm6y26xAx4QN8ZInrAdnc8RM6J1ux6ZLXiRJD58bgfut591L7XkXV+qlrMdGk9ZyvTCaair20aVHHarrrGUNKA6VcbgDStmz2tystMrUeedaiuRhVodtQz1hUEIY+g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6828216a-aa06-40a4-3c92-08d70399d1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 11:45:47.6974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4471
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
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>> Please look at the changes in drivers/usb/common/common.c file.
>> I'm going to add it as next patch to next version.
>>
>>
>>>Pawel Laszczak <pawell@cadence.com> writes:
>>>>>> +void cdns3_role_stop(struct cdns3 *cdns)
>>>
>>>>>> +static const char *const cdns3_mode[] =3D {
>>>>>> +	[USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>>>> +	[USB_DR_MODE_OTG]		=3D "otg",
>>>>>> +	[USB_DR_MODE_HOST]		=3D "host",
>>>>>> +	[USB_DR_MODE_PERIPHERAL]	=3D "device",
>>>>>> +};
>>>>>
>>>>>don't we have a generic version of this under usb/common ?
>>>>>
>>>> Yes, there is a similar array, but it is defined also as static
>>>> and there is no function for converting value to string.
>>>> There is only function for converting string to value.
>>>
>>>right. You can add the missing interface generically instead of
>>>duplicating the enumeration.
>>>
>>>> There is also:
>>>> [USB_DR_MODE_UNKNOWN]		=3D "",
>>>> Instead of:
>>>> [USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>>
>>>> So, for USB_DR_MODE_UNKNOWN user will not see anything information.
>>>
>>>But that's what "unknown" means :-) We don't know the information.
>>>
>>
>> ////// start
>> commit 607754c60fabc43408f4f2de82d3560c72870787 (HEAD)
>> Author: Pawel Laszczak <pawell@cadence.com>
>> Date:   Mon Jul 8 12:53:47 2019 +0200
>>
>>     usb:common  Added usb_get_dr_mode_from_string and usb_dr_mode_to_str=
ing.
>
>This would read better as:
>
>      usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_stri=
ng.
>
>>
>>     Patch introduces new function usb_dr_mode_to_string for converting d=
ual role
>>     mod to string and removes static from usb_dr_mode_to_string definiti=
on.
>>
>>     Both changes have made to avoid duplication of code by cdns3 driver.
>>
>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>> index 18f5dcf58b0d..ab59954deff8 100644
>> --- a/drivers/usb/common/common.c
>> +++ b/drivers/usb/common/common.c
>> @@ -118,13 +118,20 @@ static const char *const usb_dr_modes[] =3D {
>>         [USB_DR_MODE_OTG]               =3D "otg",
>>  };
>>
>> -static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
>> +/**
>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>> + * @str: Pointer to the given string
>> + *
>> + * The function gets string and returns the correspondig enum usb_dr_mo=
de.
>> + */
>> +enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
>>  {
>>         int ret;
>>
>>         ret =3D match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str=
);
>>         return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
>>  }
>> +EXPORT_SYMBOL_GPL(usb_get_dr_mode_from_string);
>>
>>  enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>>  {
>> @@ -139,6 +146,21 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev=
)
>>  }
>>  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
>>
>> +/**
>> + * usb_dr_mode_to_string - Convert dual role mode to stringi.
>
>s/stringi/string
>
>> + * @dr_mode: Pointer to the given dual role mode
>> + *
>> + * The function gets enum usb_dr_mode, and returns the correspondig str=
ing.
>> + */
>> +const *char usb_dr_mode_to_string(const enum usb_dr_mode dr_mode)
>> +{
>> +       if (dr_mode > USB_DR_MODE_UNKNOWN || dr_mode <=3D USB_DR_MODE_PE=
RIPHERAL)
>> +               return usb_dr_modes[dr_mode];
>> +
>> +       return usb_dr_modes[USB_DR_MODE_UNKNOWN];
>> +}
>> +EXPORT_SYMBOL_GPL(usb_dr_mode_to_string);
>
>missing prototype in a header file.
>

The prototype was added , but not all text was past. Sorry for that. =20

Fixed version:  with your changes.

///// v2 corrected=20
commit 4553d48dd0500085d90c8280e28714072279c3dd (HEAD)
Author: Pawel Laszczak <pawell@cadence.com>
Date:   Mon Jul 8 12:53:47 2019 +0200

    usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_string.

    Patch introduces new function usb_dr_mode_to_string for converting dual=
 role
    mod to string and removes static from usb_dr_mode_to_string definition.

    Both changes have made to avoid duplication of code by cdns3 driver.

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..76634b8e92db 100644
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
+ * usb_dr_mode_to_string - Convert dual role mode to string.
+ * @dr_mode: Pointer to the given dual role mode
+ *
+ * The function gets enum usb_dr_mode, and returns the correspondig string=
.
+ */
+const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode)
+{
+       if (dr_mode > USB_DR_MODE_UNKNOWN || dr_mode <=3D USB_DR_MODE_PERIP=
HERAL)
+               return usb_dr_modes[dr_mode];
+
+       return usb_dr_modes[USB_DR_MODE_UNKNOWN];
+}
+EXPORT_SYMBOL_GPL(usb_dr_mode_to_string);
+
 #ifdef CONFIG_OF
 /**
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller devic=
e
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 69f1b6328532..c156817672c4 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -129,4 +129,20 @@ enum usb_dr_mode {
  */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);

+/**
+ * usb_get_dr_mode_from_string - Convert string to dual role mode.
+ * @str: Pointer to the given string
+ *
+ * The function gets string and returns the correspondig enum usb_dr_mode.
+ */
+extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
+
+/**
+ * usb_dr_mode_to_string - Convert dual role mode to string.
+ * @dr_mode: Pointer to the given dual role mode
+ *
+ * The function gets enum usb_dr_mode, and returns the correspondig string=
.
+ */
+extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode);
+
 #endif /* __LINUX_USB_OTG_H */

////////////////
>--
>balbi
