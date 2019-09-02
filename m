Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4283C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004721881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WxKbu6ff";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WH0SiF9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfIBP3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:29:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfIBP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:29:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82FQulE011103;
        Mon, 2 Sep 2019 08:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=xU6xKm4DfMgtfQAzn4da1GZiImBK9p9o8mM7PmckA1w=;
 b=WxKbu6ffAutWjVR8SZJrUkS4zyccecaDgpTfl6STTV2mxcYkL/tJdE+giIqf7vjroeZU
 CfvekwdN+qWNFIYugsAP9EV/FA0nHkWumz/dDW9VntDmY3Iyy9J7j+yKL7bE+F5fjtiu
 Oj4hHlddsMlB9IvzyrGsOxbwZQLL4IWEU8yPZZsnYrPpE9vA4IOI7KJO5lpAf2sWOIOu
 ue75feWimYqoE/5brLjynb+tqb83alRm7geo08GmeI/sYBkNXFeIJ1MhbdEwj2NScZKz
 9VmGhvSrrRxU60V4lGGCnG3NVsMz+/J3ee7EH1d1lw+O01CcabxUIlQWTlvGyAhu7ter bg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2uqnf27k6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 08:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2A5tAINBLFA5ZN+5x7IjXpekVvzoI5SICXOmHW8POL4btIYW5LC05/E3dVJfk2/EUvhUaf1qIskYjfObZg4FtFYlq0VBs8MKAQ6vqS5eZYhcSeqgNOvl2V8FTjg3KZCVa9w3UEDeqGRqUH5Ue7t96klaQwb4lp6WkrY0tNVqU/iVdDIP2CiiEuVeediI/jnU7kAGlA//baoEt0ZL25NZR1nk7VX6cFwB31x11dqJGwiUAGsM67v78/PR5fLnqLRyOdB73gFYaN4vgVfLcoZTpwB4XyUV8fw1NummZYqsf8sg94TWmjV/rdf2Id9zDVWqrJCrYfgID8ySznllOXGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU6xKm4DfMgtfQAzn4da1GZiImBK9p9o8mM7PmckA1w=;
 b=UZ9lp7It6sgGGJF6IuUHs6LdOH/jE6P9ffDT60xmGAKF/RO/vSIVIDaT35Tv+BbrZDejH9LPt3kSAgZ4Ceycq8toRDZTp1FcOxrmPnSkOPwi9noRR0KLy+O4Hg4EpINGIs2QxBtVzJwfsd/eza4lX0ppk3LPt6f52qM8O+0Tfxjvs+0JfsG1w5ZU/ecS3VM2rIOop/HS1bvdiY1TV15fU78l963qYzNhl/iZSZhnAghrvG6H0ZiBQ4lcw0fa1RNXj0f9kAwMyK/Zeq6+LcucnBVZM7sdO8wLlfdm7UYjptO2s/Y3qMLDDjN2bncqIb4IkC/F+Uv6p6NMdFVCLgh1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU6xKm4DfMgtfQAzn4da1GZiImBK9p9o8mM7PmckA1w=;
 b=WH0SiF9uKQZmBbunCxAFISyT4DD8bHFsCeM3HsqiiBPbOQ3bIz8vlaFCNCIW1A5d/irSTQI0Dqfq0L5/VAMv5CNkTVw8IHCPLYb09KrswxxaHTN4Wxl0VAF/H3DeZMDYLC0b02oToDumbMfEeBhEr5YhAYbliRe2PRpqUH52FIY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4982.namprd07.prod.outlook.com (52.135.238.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 2 Sep 2019 15:29:32 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 15:29:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][usb-next] usb: cdns3: fix missing assignment of ret
 before error check on ret
Thread-Topic: [PATCH][usb-next] usb: cdns3: fix missing assignment of ret
 before error check on ret
Thread-Index: AQHVYZ3KnTofVq3/tkKV7S4WfQAkHqcYgYMA
Date:   Mon, 2 Sep 2019 15:29:32 +0000
Message-ID: <BYAPR07MB4709DF377BFBD54FD6BF88B3DDBE0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190902145035.18200-1-colin.king@canonical.com>
In-Reply-To: <20190902145035.18200-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b11278-c569-4658-5864-08d72fba5aac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4982;
x-ms-traffictypediagnostic: BYAPR07MB4982:
x-microsoft-antispam-prvs: <BYAPR07MB49827CBF1726FF1FC407A172DDBE0@BYAPR07MB4982.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(36092001)(189003)(199004)(71200400001)(305945005)(71190400001)(8936002)(110136005)(5660300002)(64756008)(26005)(7736002)(6506007)(256004)(14444005)(52536014)(66446008)(478600001)(81166006)(66946007)(33656002)(53936002)(316002)(76116006)(6246003)(11346002)(9686003)(6436002)(76176011)(66556008)(54906003)(476003)(99286004)(8676002)(66476007)(7696005)(2906002)(486006)(14454004)(4326008)(55016002)(446003)(74316002)(66066001)(25786009)(86362001)(81156014)(102836004)(186003)(6116002)(2501003)(3846002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4982;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /sT6A65SbCojSce7nYZp1xHIa0mxFnER6pydg0Um14pq+tD8fjBJoCt2r66yZhPIXYB+1vbCkdZYYrgqU0MfkPVyLp6PCFr1SO8M2iENRYUZj+2HpPqXv7vBHc2x5HqA0THz3wJg5Gv2tPKzFMDmNu3uwyseTRahNi6iaJSit33NWNb7i3SSox8ECtDb0eY5VtKd0ptduMHvVgSa8v5mn9q6ZjruSg0O+aIhHT+UWp9Jx14aAFjeghqx8hUpo3c7UaoEVKrQKl4VDFmOGRrH9EuUVayzfwxoYWGgiSdSWywt53LQKdFmMt9aybZXHpEK/eXLa5O8PyzJaHcCjwsYVc9YPeitc9OZpLLi/azt2R61D2q1ea3bBNiubBaB3eNfZJlBbuMgJG/gjP95/bmCwEFOXg/tBLWeY+OYpKgxbto=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b11278-c569-4658-5864-08d72fba5aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 15:29:32.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6NPF/Su78Wo5mXjx/0zlB49+dtNaFqJ3Lxw0GVVi29osB48+wZJwGETMpnymtg0F8B4T5f7cNOD6tBUsPpxSjqud7EhWJXGgB/ZOZcv+kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4982
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_05:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909020173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4NCg0KPg0KPkZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+DQo+DQo+Q3VycmVudGx5IHRoZSBjaGVjayBvbiBhIG5vbi16ZXJvIHJldHVybiBjb2Rl
IGluIHJldCBpcyBmYWxzZSBiZWNhdXNlDQo+cmV0IGhhcyBiZWVuIGluaXRpYWxpemVkIHRvIHpl
cm8uICBJIGJlbGlldmUgdGhhdCByZXQgc2hvdWxkIGJlIGFzc2lnbmVkDQo+dG8gdGhlIHJldHVy
biBmcm9tIHRoZSBjYWxsIHRvIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMgYmVmb3JlIHRoZQ0K
PmNoZWNrIG9uIHJldC4gIFNpbmNlIHJldCBpcyBiZWluZyByZS1hc3NpbmdlZCB0aGUgb3JpZ2lu
YWwgaW5pdGlhbGl6YXRpb24NCj5vZiByZXQgdG8gemVybyBjYW4gYmUgcmVtb3ZlZC4NCg0KVGhh
bmtzIHlvdSBmb3IgbGV0dGluZyBtZSBrbm93LiANCkZvcnR1bmF0ZWx5IHRoYXQncyBub3QgYSBj
cml0aWNhbCBidWcgYW5kIGhhcyBubyBpbXBhY3QgZm9yIGRyaXZlci4gDQpJIHdpbGwgY29ycmVj
dCBpdC4gIA0KDQpDaGVlcnMNClBhd2VsbA0KDQo+DQo+QWRkcmVzc2VzLUNvdmVyaXR5OiAoIidD
b25zdGFudCcgdmFyaWFibGUgZ3VhcmRzIGRlYWQgY29kZSIpDQo+Rml4ZXM6IDc3MzNmNmMzMmUz
NiAoInVzYjogY2RuczM6IEFkZCBDYWRlbmNlIFVTQjMgRFJEIERyaXZlciIpDQo+U2lnbmVkLW9m
Zi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4tLS0NCj4g
ZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMgfCA2ICsrKy0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9jZG5zMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+aW5kZXgg
MzA5NGFkNjVmZmM5Li4wZWIzMDIyODM4ZDYgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy91c2IvY2Ru
czMvZ2FkZ2V0LmMNCj4rKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYw0KPkBAIC0yMTU0
LDcgKzIxNTQsNyBAQCBpbnQgX19jZG5zM19nYWRnZXRfZXBfY2xlYXJfaGFsdChzdHJ1Y3QgY2Ru
czNfZW5kcG9pbnQgKnByaXZfZXApDQo+IHsNCj4gCXN0cnVjdCBjZG5zM19kZXZpY2UgKnByaXZf
ZGV2ID0gcHJpdl9lcC0+Y2RuczNfZGV2Ow0KPiAJc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXF1ZXN0
Ow0KPi0JaW50IHJldCA9IDA7DQo+KwlpbnQgcmV0Ow0KPiAJaW50IHZhbDsNCj4NCj4gCXRyYWNl
X2NkbnMzX2hhbHQocHJpdl9lcCwgMCwgMCk7DQo+QEAgLTIxNjIsOCArMjE2Miw4IEBAIGludCBf
X2NkbnMzX2dhZGdldF9lcF9jbGVhcl9oYWx0KHN0cnVjdCBjZG5zM19lbmRwb2ludCAqcHJpdl9l
cCkNCj4gCXdyaXRlbChFUF9DTURfQ1NUQUxMIHwgRVBfQ01EX0VQUlNULCAmcHJpdl9kZXYtPnJl
Z3MtPmVwX2NtZCk7DQo+DQo+IAkvKiB3YWl0IGZvciBFUFJTVCBjbGVhcmVkICovDQo+LQlyZWFk
bF9wb2xsX3RpbWVvdXRfYXRvbWljKCZwcml2X2Rldi0+cmVncy0+ZXBfY21kLCB2YWwsDQo+LQkJ
CQkgICEodmFsICYgRVBfQ01EX0VQUlNUKSwgMSwgMTAwKTsNCj4rCXJldCA9IHJlYWRsX3BvbGxf
dGltZW91dF9hdG9taWMoJnByaXZfZGV2LT5yZWdzLT5lcF9jbWQsIHZhbCwNCj4rCQkJCQkhKHZh
bCAmIEVQX0NNRF9FUFJTVCksIDEsIDEwMCk7DQo+IAlpZiAocmV0KQ0KPiAJCXJldHVybiAtRUlO
VkFMOw0KPg0KDQo+LS0NCj4yLjIwLjENCg0K
