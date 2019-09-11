Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B09C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1421479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FFE/sT1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfIKKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:32:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:12632 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbfIKKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:32:16 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BAVb3B015973;
        Wed, 11 Sep 2019 03:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=tLK6mq8+jPwD8iiIe9QesdNafwxSCFi6gv/K1ZHAG3M=;
 b=FFE/sT1Q0kZKPHEuiGQV8fEMDb2jOZgSHtLtOh3oNuDr1uX1YeANsTn9vd72KqW6BuUP
 yXQeUBdlIKgg+5EFWuGYZFKgdynQt0DwYHkPd9vTAP25z8MbAMMJ5EhDpkG3bTckZavL
 iesTY5p+5U5BPs+3QA7JX0Ch677ooKJmkFT+g+9ZeSQcEeO5wUcbMJ8MPqRdIIVhgY8a
 VkoeGynYdFitX0+KcXmaavVw9sScEYiromF4GSqc93J0KebQofVwfQcFKbtykiP4deFP
 IEa5ECcRVtvHj2e1jcXnwE/23ijOx+8Gfyf7MBKWm9P+gDFTzYPFYpKRLNVXshUbVv8d jQ== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uvc3y07qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 03:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0tjQWllK3pkbkuQboFETCZUME5bNlQcwm4n5weSm+b3d5YhKVV41Z5J9XXDljebV6xHGcOhnHuhuHNgk1IzFaNyH4VSNxQLENuBTAylTRL07WK4B4KcaGeozvHxailz7bt1rmVmviiIzMZmqtDiYHHG6ha4ICrYcQEEtLDp+hneMcZAWYOBmTHD1tsYueV4OBegJ61D+IVwTQvkj6HkPkS8fSiPLnPND3FVgEcvIZh3j6sFEiIUBccOjLLBrXomVz6HNDCgJjffBCkGtvWgnCCcTca7ENYNF1TQDO11icqV2hjedrfXUO6bAoX/SxpJidHebIVflztRq0uz2DdUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLK6mq8+jPwD8iiIe9QesdNafwxSCFi6gv/K1ZHAG3M=;
 b=Cnievq5S0ImkSdPN6IZHPCTPsg4ZoNBGcz7w/ezl3SIHQyLKsFgqk8jyufHmCfy3vddWPgRZcO1pFbsml4uT+yU6bnachTKplQEBJUTCFdhIcfvTGwWR9wf8UIbIouvfzNLQWASuygZcxjvR2mbK9tU14BqgmhXqZzeZKkW7lfMBlvLzFfAMv7RJnoByHEEcfFL1iUit/0ME93tnL+/ReC//jPBScl5fUrqiTs78MoPuaItajQLVGurmJFqdAKg9tW2v4bzHXofPz05K6Ct4ij3CeZDJSg6UYgDG6JodUULGk52BNHEsTU0quay2fXPEZ8jSk5grL2X6nM1KDP1lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3524.namprd02.prod.outlook.com (52.132.103.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 10:32:08 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 10:32:08 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Thread-Topic: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Thread-Index: AQHVYki3Tm9nzAyXjk2sNXBveXCZqacb/poAgApVIAA=
Date:   Wed, 11 Sep 2019 10:32:08 +0000
Message-ID: <faf26ea1-ce58-2490-2b26-c31e7e6cc05c@nutanix.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
 <20190903111342.17731-2-florian.schmidt@nutanix.com>
 <20190904204446.kceqzrg4zmnw3mm6@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20190904204446.kceqzrg4zmnw3mm6@ca-dmjordan1.us.oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0038.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::15) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b16c23-0f45-4ab2-7496-08d736a34c0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3524;
x-ms-traffictypediagnostic: CY4PR0201MB3524:
x-microsoft-antispam-prvs: <CY4PR0201MB3524ABF35655AFDB728B2826F7B10@CY4PR0201MB3524.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(51914003)(5660300002)(2906002)(6916009)(26005)(81166006)(81156014)(15650500001)(8676002)(54906003)(66946007)(2616005)(36756003)(11346002)(53936002)(478600001)(476003)(6436002)(256004)(14444005)(71190400001)(71200400001)(31696002)(53546011)(316002)(52116002)(6512007)(102836004)(4744005)(305945005)(76176011)(99286004)(6116002)(3846002)(66556008)(66446008)(66476007)(446003)(64756008)(86362001)(7736002)(386003)(6506007)(6246003)(186003)(31686004)(6486002)(8936002)(229853002)(14454004)(44832011)(486006)(25786009)(4326008)(66066001)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3524;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erIphi9v79fjfH6Xr9hzERqgyzHERTKBId1EmgH/VI40VueTOp8j5PLmbb/gZWlK65Qya8plFB6JBCI28WvnaVOK0XTPrz+SofhV3797FXPO0fkaknX99hjXpFLDd5pLQ/GOatP5HzxjR8DJ3YJUwcFBovj3fpdB/aI9UGbOhDxeGBJbZ6q1CnNmZ3XxipvFO1/d6gImJKyphSQ5RzY18LWTinZczZ7lJpfAKc74osqY0gyL7UnwdAYQQq+NkjCvUiRFXwt2KLazkyNgtcZ2sKnU/SjeY2ufkKZ1wqwbiHsngIF3bKSaAOP+lE+4wbWG0mai/6MPZHEJaI03ATBkqcr7N7sXNg0f+y3PZlMYVUHlEB7LAi+mDpdxBtG84w4wvB5/4BgcSDQ2Ac6swOy5kU0dvc31BxIXVvTIC6fd8BQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45901FA9AB66F74A993CFDF67B62F2C7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b16c23-0f45-4ab2-7496-08d736a34c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 10:32:08.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgOMDPmGCjotFCABj3u50DbmYv0M9LB4tmib1GBKBw8g2sK1HeRMSNkY0l4Ly8Zbb/OjlH5+W0KvH9iFxHgTtGI4+Jvv2JoBNa1+V9/S4YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_07:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiAwNC8wOS8yMDE5IDIxOjQ0LCBEYW5pZWwgSm9yZGFuIHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAwMywgMjAxOSBhdCAxMToxNDoxMkFNICswMDAwLCBGbG9yaWFuIFNjaG1p
ZHQgd3JvdGU6DQo+PiBtbV92bXNjYW5fe2RpcmVjdF9yZWNsYWltX2JlZ2luLHdha2V1cF9rc3dh
cGQsbHJ1X2lzb2xhdGUsbHJ1X3Nocmlua19hY3RpdmV9DQo+PiBjaGFuZ2VkIHRoZWlyIG91dHB1
dCB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIHNjcmlwdCB0aHJvd3Mgd2FybmluZ3MgYW5kDQo+PiBl
cnJvcnMuIFVwZGF0ZSBpdCB0byBiZSBwcm9wZXJseSBpbiBsaW5lIHdpdGggdGhvc2UgY2hhbmdl
cy4NCj4gDQo+IENvdWxkIHVzZSB0aGUgYXBwcm9wcmlhdGUgRml4ZXMgdGFncyBoZXJlLg0KDQpH
b29kIHBvaW50LCBJJ2xsIGFkZA0KDQpGaXhlczogMzQ4MWMzN2ZmYTFkICgibW0vdm1zY2FuOiBk
cm9wIG1heV93cml0ZXBhZ2UgYW5kIGNsYXNzem9uZV9pZHggDQpmcm9tIGRpcmVjdCByZWNsYWlt
IGJlZ2luIHRlbXBsYXRlIikNCkZpeGVzOiAzYjc3NTk5OGVjYTcgKCJpbmNsdWRlL3RyYWNlL2V2
ZW50cy92bXNjYW4uaDogZHJvcCB6b25lIGlkIGZyb20gDQprc3dhcGQgdHJhY2Vwb2ludHMiKQ0K
DQppbiB2Mi4NCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssDQpGbG9yaWFuDQo=
