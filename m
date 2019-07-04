Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9257218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QZAnvdij";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="a1JQwZH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGDIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:07:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34090 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfGDIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:07:27 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64829cK020557;
        Thu, 4 Jul 2019 01:07:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TruY0iE5bTN7MBnx0PzHnBM4nCKHO4VmLyK3JhX9qkE=;
 b=QZAnvdijTUCfTarE4S8P3+daSwzpbMJbkbJwOOfeRuy+C6Vl0fO8JEIgY2iER1CYmG5E
 5lmsRKRWJkvG106IVO2AByvrHB7UjJjN8nPP6OTYnZBdjtDQMXJWHSei8ZmQkRquArN2
 tqLYfs5zoHEEVVMwT+FF4DREBJzzj86CvxSdl1c/qkPNh6eh5TI8nnyIjDZJk+C6B123
 tnIZsQzhYzbPelJt67nrPaugyd6E80bOZZBfBMfRvdHXm8I9yY2IgmOSbYuDHbhhA5pR
 O2363aBRUHi2MpgFzeVbM43XUbful85/bVuEIWbJYP+JBI9Nx9wEJcU8yr8Cxql2+zC5 MQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2056.outbound.protection.outlook.com [104.47.34.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2thby2rdd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 01:07:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TruY0iE5bTN7MBnx0PzHnBM4nCKHO4VmLyK3JhX9qkE=;
 b=a1JQwZH60bjRjfiOqyqtCiiB0Uq+H7WdjHKKG1nAUlNFES0M05KSUTZTZiZzmUNYjSfXlsRrGGh4XRfzIiasjfyZgqp/CaEpT/EMF78jMb42R4VrRczeSx6abTncoJA6wY1BSCLpSvDf7vxJl2A02DPnhAtNZRfpRn2vcAnmyZM=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4871.namprd07.prod.outlook.com (52.135.205.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 08:07:06 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 08:07:06 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <balbi@kernel.org>, Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the usb and usb-gadget
 trees
Thread-Topic: linux-next: build failure after merge of the usb and usb-gadget
 trees
Thread-Index: AQHVMjKg7+jonhPbpUSjvye7Qm/1waa6B76AgAAICQCAAAlA8A==
Date:   Thu, 4 Jul 2019 08:07:06 +0000
Message-ID: <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
In-Reply-To: <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjRhMjhmYWUtOWUzMi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGI0YTI4ZmFmLTllMzItMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTMzMCIgdD0iMTMyMDY3MDEyMjM4MDY4NzQ2IiBoPSJnVXh3T2N5Y0t6Qi96Z0RHT0lBd251S2M0ZWM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb5fb3b-ca0c-41e9-fdf6-08d700569b3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4871;
x-ms-traffictypediagnostic: BYAPR07MB4871:
x-microsoft-antispam-prvs: <BYAPR07MB4871193D659617D68E9F8E9FDDFA0@BYAPR07MB4871.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(36092001)(53754006)(446003)(68736007)(11346002)(6246003)(8676002)(53936002)(476003)(14454004)(25786009)(7736002)(81166006)(81156014)(33656002)(305945005)(74316002)(6436002)(66066001)(256004)(2906002)(229853002)(55016002)(9686003)(478600001)(4326008)(71190400001)(71200400001)(486006)(186003)(6506007)(86362001)(102836004)(26005)(5660300002)(3846002)(110136005)(54906003)(52536014)(73956011)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(7696005)(99286004)(6116002)(76176011)(8936002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4871;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +WDUknoSHtIXUWOKlYJ8zdx3sBAL3p7BbRfFevrgVpYIz8Ynw+CVpG9m6DfS0HjwzJ2hwUIiLTRDoCPHRM3FE9m/oG4Dec9cQUdVmgwZtVLX2nf7DK5kllhpp1JaoNcbNK3ZeFVEUdMiB5ud3JrecA9/Vtpj33vE58XTf5h2zAMUp5Kj/C2lyDaXOsNWHk/qZ81ee1HLq6yXz21PBLB5TeWAJz2KZQUi+qRo24ktH3JBApAUEt+L4T40Sup0qEotoyUIXyWvxDZB8/M1kvxu9obYEXDh5/33IWzVZKRBNHnVbsmv654ZXUse8qsParzgVkMcIbWMY3xUaLVGM6AC5dntH4V3J7d8KDFUH2QF0HcCnKlJSr5yCiZ/xTc1r9A0vVnAxPfSmiP+uB9EiI9JOwamtplj12HGtMIBQT5E5U0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb5fb3b-ca0c-41e9-fdf6-08d700569b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:07:06.6048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4871
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=599 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPkhpLA0KPg0KPk9uIFRodSwgSnVsIDQsIDIwMTkgYXQgOTo1OSBBTSBHcmVnIEtIIDxncmVn
QGtyb2FoLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBKdWwgMDQsIDIwMTkgYXQgMDQ6MzQ6
NThQTSArMTAwMCwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4+ID4gSGkgYWxsLA0KPj4gPg0K
Pj4gPiBBZnRlciBtZXJnaW5nIHRoZSB1c2IgdHJlZSwgdG9kYXkncyBsaW51eC1uZXh0IGJ1aWxk
IChhcm0NCj4+ID4gbXVsdGlfdjdfZGVmY29uZmlnKSBmYWlsZWQgbGlrZSB0aGlzOg0KPj4gPg0K
Pj4gPiBhcm0tbGludXgtZ251ZWFiaS1sZDogZHJpdmVycy91c2IvZHdjMy90cmFjZS5vOiBpbiBm
dW5jdGlvbiBgdHJhY2VfcmF3X291dHB1dF9kd2MzX2xvZ19jdHJsJzoNCj4+ID4gdHJhY2UuYzoo
LnRleHQrMHgxMTljKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdXNiX2RlY29kZV9jdHJsJw0K
Pj4gPg0KPj4gPiBDYXVzZWQgYnkgY29tbWl0DQo+PiA+DQo+PiA+ICAgM2RiMWI2MzZjMDdlICgi
dXNiOmdhZGdldCBTZXBhcmF0ZWQgZGVjb2RpbmcgZnVuY3Rpb25zIGZyb20gZHdjMyBkcml2ZXIu
IikNCj4+ID4NCj4+ID4gSSBoYXZlIHVzZWQgdGhlIHVzYiB0cmVlIGZyb20gbmV4dC0yMDE5MDcw
MyBmb3IgdG9kYXkuDQo+PiA+DQo+PiA+IFRoaXMgYWxzbyBvY2N1cnMgaW4gdGhlIHVzYi1nYWRn
ZXQgdHJlZSBzbyBJIGhhdmUgdXNlZCB0aGUgdmVyc2lvbiBvZg0KPj4gPiB0aGF0IGZyb20gbmV4
dC0yMDE5MDcwMyBhcyB3ZWxsLg0KPj4NCj4+IE9kZCwgSSB0aG91Z2h0IEkgcHVsbGVkIHRoZSB1
c2ItZ2FkZ2V0IHRyZWUgaW50byBtaW5lLiAgRmVsaXBlLCBjYW4geW91DQo+PiB0YWtlIGEgbG9v
ayBhdCB0aGlzIHRvIHNlZSBpZiBJIG1lc3NlZCBzb21ldGhpbmcgdXA/DQo+DQo+VGhpcyBsb29r
cyBsaWtlIGl0IHdhcyBjYXVzZWQgYnkgUGF3ZWwncyBwYXRjaGVzLg0KPg0KPkknbGwgdHJ5IHRv
IHJlcHJvZHVjZSBoZXJlIGFuZCBzZWUgd2hhdCdzIGNhdXNpbmcgaXQuDQoNClByb2JsZW0gaXMg
aW4gbXkgUGF0Y2guIEkgcmVwcm9kdWNlZCBpdCwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkg
Y29tcGlsZXIgDQpjb21wbGFpbnMgYWJvdXQgdXNiX2RlY29kZV9jdHJsLiBJdCdzIGNvbXBpbGVk
IGludG8gbGliY29tcG9zaXRlLmtvIGFuZA0KZGVjbGFyYXRpb24gaXMgaW4gZHJpdmVycy91c2Iv
Z2FkZ2V0LmguIA0KDQo+DQo+LS0NCj5iYWxiaQ0K
