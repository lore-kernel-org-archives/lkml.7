Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEEC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A958C2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="euF94Y80";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jouz4J47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGELoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:44:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13808 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbfGELoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:44:54 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65BiQlb018260;
        Fri, 5 Jul 2019 04:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=qKtPKf2TElfESXIz9YSar0KvPQBGqIKAPPYAKgCppCY=;
 b=euF94Y8038gStwoXv5WBIyA7jlhfYy/7KgovnzAt7gvospT0PM9C0R873U9GaVOhwHCn
 03PUvzA/5DIqnl3al8RXf9RFoakwehkmSr5cYqKoDXc4RQqBuAKI7V0OGN9dUXVZW0Td
 Gx99sjFd25hbZgNO+S7TB/0C8JpfYLnEZM6/3X9wVIEi06bYFiLwTtvSCcCpQyp4FRJn
 Yr2VLS1UgEXjfaf0uC3EDicDSNffEKyfnvzmA3ISyPB91ripQJa1VPct9p1gRcBYknZK
 nwjUhKHkpZID8EERS/fpTbAujZVxfx0hVWcNwERyhL5S0l6HH/WXWAgO1cSNL4FRhQYX LA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tgwvj87b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 04:44:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKtPKf2TElfESXIz9YSar0KvPQBGqIKAPPYAKgCppCY=;
 b=Jouz4J47SzC2Qe7s8ORdF9Qu+od8dBaEk5o+rr3eltfcnkG3+sxywF7lSsntLyYpZohc1oUA78hv34k/n/RxwnJ6XV23XpYL6dYeKRWUOCECEAnBXOs+LWPX8yOoGLnsARiYEmhTaFWhF5RwCNoCIRnzb/WFu2RmDhFZ8xTL828=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5526.namprd07.prod.outlook.com (20.177.231.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 11:44:15 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 11:44:15 +0000
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
Subject: RE: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Index: AQHVMyB8KL4t/wzfvkK+3nlF+Rqn1Ka75lUAgAABDHA=
Date:   Fri, 5 Jul 2019 11:44:15 +0000
Message-ID: <BYAPR07MB4709964C1D0AA2A851BF2F55DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-3-git-send-email-pawell@cadence.com>
 <87tvc0lngz.fsf@linux.intel.com>
In-Reply-To: <87tvc0lngz.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzUzNDEwNDctOWYxYS0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDM1MzQxMDQ5LTlmMWEtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTg2NSIgdD0iMTMyMDY4MDA2NTMyMzIwNjE4IiBoPSJMQmNzbDhITWVzNjZ5ZWgvckovRy9GK1hBMnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4896cc75-f277-4bb8-5fef-08d7013e1b98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5526;
x-ms-traffictypediagnostic: BYAPR07MB5526:
x-microsoft-antispam-prvs: <BYAPR07MB552698EFF6A015481D693DD6DDF50@BYAPR07MB5526.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(36092001)(189003)(199004)(55016002)(76176011)(99286004)(478600001)(229853002)(7416002)(7696005)(2501003)(2906002)(110136005)(316002)(33656002)(66066001)(14454004)(66446008)(73956011)(66946007)(64756008)(76116006)(8936002)(68736007)(66556008)(86362001)(8676002)(52536014)(9686003)(66476007)(81156014)(81166006)(5660300002)(6116002)(3846002)(25786009)(6246003)(14444005)(256004)(102836004)(71190400001)(71200400001)(26005)(6506007)(486006)(53936002)(186003)(446003)(4326008)(6436002)(54906003)(7736002)(74316002)(305945005)(11346002)(476003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5526;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7zDfogEh4oCTn4ibVPpCwxY8TBB0VWRa1RXMc07SS2VcDm5x9JADLlN+zKqWyNloBdeDGBji1MbjzBVBSYY6ispz2moP4mgfusupbUdBgLcUvw8s6JWw31rdVMKdXv4Wqyr63MZYZdsbKSE9zEkGN0zSXqNYNdcqJB7xcXm5BOHEvx1aGVXWOWpCgH44Wp6ceMa3fS//YYFGiDfekZeAeQAZf0Iiv1KcAaE/obOdCU60MmtUYYaQ/yzORa9xqfo4cvRD5z6eS99L5BbWTEzC2jsDnjCxmC7rLGIKakmE60xQvKnBm1IsqIEckP3JabPc5tDBh+XrZv1CGkHDC5oqBYJYzLkPdqOEJIAoHfsL9Rg/g/L+lTFLZ4DksxsKZGAOETrdhNBZJAyyqrIGTMBFKvWbvrn3vYHC4MOl4Jt0xDI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896cc75-f277-4bb8-5fef-08d7013e1b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 11:44:15.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5526
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>EXTERNAL MAIL
>
>
>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>> diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
>> index da82606be605..d388a3a5ab7e 100644
>> --- a/include/linux/usb/ch9.h
>> +++ b/include/linux/usb/ch9.h
>> @@ -70,4 +70,29 @@ extern enum usb_device_speed usb_get_maximum_speed(st=
ruct device *dev);
>>   */
>>  extern const char *usb_state_string(enum usb_device_state state);
>>
>> +/**
>> + * usb_decode_ctrl - Returns human readable representation of control r=
equest.
>> + * @str: buffer to return a human-readable representation of control re=
quest.
>> + *       This buffer should have about 200 bytes.
>> + * @size: size of str buffer.
>> + * @bRequestType: matches the USB bmRequestType field
>> + * @bRequest: matches the USB bRequest field
>> + * @wValue: matches the USB wValue field (CPU byte order)
>> + * @wIndex: matches the USB wIndex field (CPU byte order)
>> + * @wLength: matches the USB wLength field (CPU byte order)
>> + *
>> + * Function returns decoded, formatted and human-readable description o=
f
>> + * control request packet.
>> + *
>> + * The usage scenario for this is for tracepoints, so function as a ret=
urn
>> + * use the same value as in parameters. This approach allows to use thi=
s
>> + * function in TP_printk
>> + *
>> + * Important: wValue, wIndex, wLength parameters before invoking this f=
unction
>> + * should be processed by le16_to_cpu macro.
>> + */
>> +extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bReques=
tType,
>> +				   __u8 bRequest, __u16 wValue, __u16 wIndex,
>> +				   __u16 wLength);
>> +
>
>where's the stub when !TRACING?

Right, I will add=20
#ifdef	CONFIG_TRACING=20
	.....
#endif=20
>
>--
>balbi
