Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F89C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C613233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AMBd+UX6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lTSZVvMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfHWJkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:40:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13716 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731936AbfHWJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:40:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9bWnJ013150;
        Fri, 23 Aug 2019 02:40:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=de6bYNvCZ8OFOyVw6ph83ymUDju1tpAQl4LTUKTroSk=;
 b=AMBd+UX6izde/2uh5nISB3euhdi9/ucgGXpbuwX/zeJIQwBOI/vkhdWzAN57H1yve7VA
 5X+z4Uask3ecSDo8UXYw7tHxMpqXO588mwAktr9vUDyrKPYGOF2ZWmEozYfR1ZP9D6bs
 xilyQ+2iRFp5Zrc/c2HAkjNGIyi2eQRlSHFyUGZhADhJMm8bnbqvaopWkOuqcOIX/wOJ
 nwUCytCfWWo17DAzCqV66m6JUcZvX2mFamNZvhjBFHe0kahBO+t6cU+YFMb1YpCQZ9c4
 CT9XdzYTxhGMQoIZzUychlN9sdBhdX+KymsqRpUZtKVVO3g8r13fdujXMuH9OZ/7Gdou sw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2uhpep525n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 02:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oajsnXsM1Rmd4EhXngT2f9zXnK/01d5K/RL+IWWbDtsPbYUtk700UUYwHoAK2CCyosRT/1K1llVFuCBI/NtioRE15uOwMoewfPWY4319GRe6clhaa37EhAXI6xCYaYgZtnRP/aLEqBTQmrJ3B+agvUW5hphxVRscNLVqrBtJG0NkD9eV+B7RhsU5Q1WsukyU3zEZTkZsQeTWFEgQuqiIUvLgj+j5BuR2b7TmsjiHfUWYoCtdxaz6l2BwXzsyz9NccebIDMzO9oKiALTLRLiT83Dfrfu+mPRAfvEOFt/YFik6nW3IKvE04kZ4evgOfe2x3pb96Lhd95CEdTPRuL8pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de6bYNvCZ8OFOyVw6ph83ymUDju1tpAQl4LTUKTroSk=;
 b=QnZGfX34e8PrpQZKRUAu6RizuIG57o1k1FYdszNVjXvj8v3LfF5xOf6JL3xCmLDZXVUIlJPMbJ1oehdXdk0PdcCdQDNrlRjOxKm9VdcYNP4AZj3Go0wpMYuRhavZUN6ux/kh3tLfyR6ZZJGkLWA1oIsps6Y2mzY0HmC7o73Dn/GbmyNMbmM5AS5sxZFGrQZaRrPQhpeq7KDvFN9ctrDl5M9ti0wJpTfjGw+Dt9UsIp/nwh0mUBgu+epq/RZ0BFoK/PtWzUxz/7gl8ojEeaWJpxHhI1AtWoaxUGAH3AaygXNVeIwkyUKPw/ZA74JiTvL6jJ/eBKRqPFEAo1mqRCJhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de6bYNvCZ8OFOyVw6ph83ymUDju1tpAQl4LTUKTroSk=;
 b=lTSZVvMqE92H+I5yWmJos9yaYYbLEyPZDEsPxOMvbAxKDClUzb2xouQUJnSySGhCG1bmeyJWtKKEX5FT1GusYnHVmzvyqt5XpZztl+BVgnZ6bUCRXKcf62gHStUYt35/4Mokd5TDrGOePif7ECkmlvSzh5BAQ0F/EuaKtUtGTXA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4293.namprd07.prod.outlook.com (52.135.223.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 09:39:58 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 09:39:58 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHVP/LMLOdqGz4qV0qb+zFnj54Ok6cIoLCAgAALthA=
Date:   Fri, 23 Aug 2019 09:39:58 +0000
Message-ID: <BYAPR07MB4709B61C825DD2368E07FE22DDA40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <c5067780-9dfe-2a3e-3498-22f3c1dadb87@ti.com>
In-Reply-To: <c5067780-9dfe-2a3e-3498-22f3c1dadb87@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjVhNmNmNmUtYzU4OS0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGY1YTZjZjcwLWM1ODktMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjAxMSIgdD0iMTMyMTEwMjY3OTQ0Mjc4NTU0IiBoPSJjajlEZ05QbTNUb0swN2JTditjalFEYndnK0E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47e2f52-e52f-42c7-8ece-08d727addd01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB4293;
x-ms-traffictypediagnostic: BYAPR07MB4293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB42939EF2B247D84683A1B228DDA40@BYAPR07MB4293.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(36092001)(33656002)(76176011)(7696005)(64756008)(99286004)(2501003)(8676002)(81166006)(81156014)(14454004)(66476007)(86362001)(71190400001)(8936002)(66556008)(66946007)(478600001)(66066001)(446003)(76116006)(486006)(53936002)(6506007)(26005)(186003)(52536014)(4326008)(7736002)(11346002)(6246003)(107886003)(14444005)(74316002)(476003)(66446008)(25786009)(6116002)(55016002)(229853002)(5660300002)(9686003)(71200400001)(102836004)(305945005)(6436002)(256004)(3846002)(54906003)(316002)(110136005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4293;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cAV6RsgxF3DBYYDTFApsUILqMdo3dAjjCjkucJBAuZ3/QhAXF8BHD8qwY/uYeVXcelmnF2/i3sCuUmCAP7YBUkyxxtu2W8CXllGPYcXBBL49fwxX+dUcEf6uJvEMGbMYZU82UjGb7JpSpcpUI8tOLog82OpDki1MWhbyqyqVSk5nebGmsuFPEyWgAaiYM1HZR6VyZ/RFjBUgXtgj2mE8XnlA11puBc4A6wDYe4zxoDypdtHe0t5/ggDWFLzsUWuNg0LT9FY16JsHdZP09p+7ayXk1XWlq7SAgKNKhuSvdafCxbPElFYApN8oKVzn+3lcLK9iRDtz8BWNxbCOF0aCPt2yBobR3miZdeRC5wBXZVkF5hf+SlnRYZG3Jzsy6QD1nQtJCFlJ80Pg/4oN1qkv7aNgbs7amUvRfMCnoNdQPKk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47e2f52-e52f-42c7-8ece-08d727addd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 09:39:58.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ry4eBPVuDaTfDrO1ISlQcGEM6L8KJWiY8XgITM4FXoWFyW3D1BTGIU+WXHoy77btox8SPqPGN6wz5a7TibPxlY1YLnWYyCo6mqHdHVocXls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4293
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5IaSwNCj4NCj5PbiAyMi8wNy8xOSAxMjowMiBBTSwgUGF3ZWwgTGFzemN6YWsgd3Jv
dGU6DQo+PiArDQo+PiArLyoqDQo+PiArICogY2RuczNfcmVxX2VwMF9nZXRfc3RhdHVzIC0gSGFu
ZGxpbmcgb2YgR0VUX1NUQVRVUyBzdGFuZGFyZCBVU0IgcmVxdWVzdA0KPj4gKyAqIEBwcml2X2Rl
djogZXh0ZW5kZWQgZ2FkZ2V0IG9iamVjdA0KPj4gKyAqIEBjdHJsX3JlcTogcG9pbnRlciB0byBy
ZWNlaXZlZCBzZXR1cCBwYWNrZXQNCj4+ICsgKg0KPj4gKyAqIFJldHVybnMgMCBpZiBzdWNjZXNz
LCBlcnJvciBjb2RlIG9uIGVycm9yDQo+PiArICovDQo+PiArc3RhdGljIGludCBjZG5zM19yZXFf
ZXAwX2dldF9zdGF0dXMoc3RydWN0IGNkbnMzX2RldmljZSAqcHJpdl9kZXYsDQo+PiArCQkJCSAg
ICBzdHJ1Y3QgdXNiX2N0cmxyZXF1ZXN0ICpjdHJsKQ0KPj4gK3sNCj4+ICsJX19sZTE2ICpyZXNw
b25zZV9wa3Q7DQo+PiArCXUxNiB1c2Jfc3RhdHVzID0gMDsNCj4+ICsJdTMyIHJlY2lwOw0KPj4g
Kwl1MzIgcmVnOw0KPj4gKw0KPj4gKwlyZWNpcCA9IGN0cmwtPmJSZXF1ZXN0VHlwZSAmIFVTQl9S
RUNJUF9NQVNLOw0KPj4gKw0KPj4gKwlzd2l0Y2ggKHJlY2lwKSB7DQo+PiArCWNhc2UgVVNCX1JF
Q0lQX0RFVklDRToNCj4+ICsJCS8qIHNlbGYgcG93ZXJlZCAqLw0KPj4gKwkJaWYgKHByaXZfZGV2
LT5pc19zZWxmcG93ZXJlZCkNCj4+ICsJCQl1c2Jfc3RhdHVzID0gQklUKFVTQl9ERVZJQ0VfU0VM
Rl9QT1dFUkVEKTsNCj4+ICsNCj4+ICsJCWlmIChwcml2X2Rldi0+d2FrZV91cF9mbGFnKQ0KPj4g
KwkJCXVzYl9zdGF0dXMgfD0gQklUKFVTQl9ERVZJQ0VfUkVNT1RFX1dBS0VVUCk7DQo+PiArDQo+
PiArCQlpZiAocHJpdl9kZXYtPmdhZGdldC5zcGVlZCAhPSBVU0JfU1BFRURfU1VQRVIpDQo+PiAr
CQkJYnJlYWs7DQo+PiArDQo+PiArCQlyZWcgPSByZWFkbCgmcHJpdl9kZXYtPnJlZ3MtPnVzYl9z
dHMpOw0KPg0KPkkgc2VlIHVzYl9zdHMgaXMgcmVhZCwgYnV0IG5ldmVyIHVzZWQgaW4gdGhpcyBm
dW5jdGlvbj8NCg0KSXQncyB0cnVlLCBpdCdzIG5vdCB1c2VkLiANCg0KVGhhbmtzLg0KDQo+DQo+
PiArDQo+PiArCQlpZiAocHJpdl9kZXYtPnUxX2FsbG93ZWQpDQo+PiArCQkJdXNiX3N0YXR1cyB8
PSBCSVQoVVNCX0RFVl9TVEFUX1UxX0VOQUJMRUQpOw0KPj4gKw0KPj4gKwkJaWYgKHByaXZfZGV2
LT51Ml9hbGxvd2VkKQ0KPj4gKwkJCXVzYl9zdGF0dXMgfD0gQklUKFVTQl9ERVZfU1RBVF9VMl9F
TkFCTEVEKTsNCj4+ICsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIFVTQl9SRUNJUF9JTlRFUkZB
Q0U6DQo+PiArCQlyZXR1cm4gY2RuczNfZXAwX2RlbGVnYXRlX3JlcShwcml2X2RldiwgY3RybCk7
DQo+PiArCWNhc2UgVVNCX1JFQ0lQX0VORFBPSU5UOg0KPj4gKwkJLyogY2hlY2sgaWYgZW5kcG9p
bnQgaXMgc3RhbGxlZCAqLw0KPj4gKwkJY2RuczNfc2VsZWN0X2VwKHByaXZfZGV2LCBjdHJsLT53
SW5kZXgpOw0KPj4gKwkJaWYgKEVQX1NUU19TVEFMTChyZWFkbCgmcHJpdl9kZXYtPnJlZ3MtPmVw
X3N0cykpKQ0KPj4gKwkJCXVzYl9zdGF0dXMgPSAgQklUKFVTQl9FTkRQT0lOVF9IQUxUKTsNCj4+
ICsJCWJyZWFrOw0KPj4gKwlkZWZhdWx0Og0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCX0N
Cj4+ICsNCj4+ICsJcmVzcG9uc2VfcGt0ID0gKF9fbGUxNiAqKXByaXZfZGV2LT5zZXR1cF9idWY7
DQo+PiArCSpyZXNwb25zZV9wa3QgPSBjcHVfdG9fbGUxNih1c2Jfc3RhdHVzKTsNCj4+ICsNCj4+
ICsJY2RuczNfZXAwX3J1bl90cmFuc2Zlcihwcml2X2RldiwgcHJpdl9kZXYtPnNldHVwX2RtYSwN
Cj4+ICsJCQkgICAgICAgc2l6ZW9mKCpyZXNwb25zZV9wa3QpLCAxLCAwKTsNCj4+ICsJcmV0dXJu
IDA7DQo+PiArfQ0KPj4gKw0KPg0KLS0NCkNoZWVycw0KUGF3ZWxsDQoNCg==
