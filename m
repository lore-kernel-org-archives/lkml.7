Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEF3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B620883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Tp1UdnP9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VRz/hWGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDHHMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:12:20 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58606 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbfDHHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:12:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38790Qu013491;
        Mon, 8 Apr 2019 00:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=FnVzLmF8WIyoc0rcsxgl+y1puPDjhWyEP2VBal/AThA=;
 b=Tp1UdnP9Al9IMDtHESlMrVtZ+RkghsSPING28i8BYPRGiX5mGGForRAMV5bfVijp2bn1
 +fG51sBp2715tgsDx2NUDm45nGOy+ngEBnoAqxjt6pp2kI+R8S7JfDETMtgm8YkRwsBi
 3IeAaEwu9HWXlTzdE1UhIC8R2FoSVi3a0QbNH25QzSas271eMaSYZ6TrfznfocakCFGP
 reOtNYzIHB+/yob7xSvVZwNTQwFyD5tNdJmMKPoPwLSMvACQy+SQz3Bp0bT5RE5HW0zh
 T2FxW/bOcDEqlCdGoqTkw991SLn2V3R07UAyHTUDWh83mlXmedvEB/cPksKlV7Rljp/R Ew== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rpqpt7jr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 00:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnVzLmF8WIyoc0rcsxgl+y1puPDjhWyEP2VBal/AThA=;
 b=VRz/hWGhZQYH3005/wiqF6kAIlWVBWNR+EQ0QRcQTGZM7rCQbpNehMRAK4oH3rxb6ERLT8UACDFWin7Hd8PD6TymX3XvRvJucLAeeDNvg1sixnYdFBOCKttIpNY3WfrOsg1xb4vgpb1H7fJ2dRICiCfWQNMbK2x8S+FwIyppC6Y=
Received: from CY1PR07MB2521.namprd07.prod.outlook.com (10.167.16.12) by
 CY1PR07MB2652.namprd07.prod.outlook.com (10.167.16.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 07:12:03 +0000
Received: from CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::74e1:243f:458d:9e61]) by CY1PR07MB2521.namprd07.prod.outlook.com
 ([fe80::74e1:243f:458d:9e61%5]) with mapi id 15.20.1771.014; Mon, 8 Apr 2019
 07:12:03 +0000
From:   Jan Kotas <jank@cadence.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     Jan Kotas <jank@cadence.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: fix pm_runtime_get_sync return code checks
Thread-Topic: [PATCH] soundwire: fix pm_runtime_get_sync return code checks
Thread-Index: AQHU64EG18DSyeFoH06Vz3NnjCWS9aYtqsQAgAQy9AA=
Date:   Mon, 8 Apr 2019 07:12:03 +0000
Message-ID: <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
References: <20190405072655.25995-1-jank@cadence.com>
 <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
In-Reply-To: <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56d19c66-bcfe-407b-ec1e-08d6bbf1803b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY1PR07MB2652;
x-ms-traffictypediagnostic: CY1PR07MB2652:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY1PR07MB265255AC6C2D769F8F951E9AD02C0@CY1PR07MB2652.namprd07.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(136003)(346002)(36092001)(189003)(199004)(97736004)(26005)(6116002)(66066001)(3846002)(4326008)(25786009)(8676002)(2906002)(68736007)(33656002)(486006)(8936002)(6246003)(76176011)(81156014)(81166006)(446003)(476003)(11346002)(7736002)(305945005)(186003)(14454004)(53546011)(54906003)(316002)(106356001)(99286004)(71200400001)(102836004)(86362001)(6506007)(966005)(83716004)(71190400001)(6436002)(6512007)(478600001)(5660300002)(6306002)(256004)(53936002)(6916009)(6486002)(105586002)(4744005)(82746002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2652;H:CY1PR07MB2521.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: adqTsfHnqmjpCUkO6mC63WvKd9r9gc8cdWHabhpP68KNenU5cxOPgU6rf8ZCy6Vs2f6qEwg1kJnkCBmMW8rrV2ZH+L7wYShmgzDyhvCwQmkvXxkHFKev0um3leaALesOxNRMvhOpAL5szgKMSzvX/ehJJzhcPKI7hXrgK07jTYn0qcohze9Z764UHuqGFc5cNRFbVRxEwgV2zWf5VuamzfYWz8zPAOS1uRxE2fKHIXwuDwI3iMxwyhO0gzYXGtIrGv0g+ajGM94bc3hLtoCRsaGpVN0Nf5HxcY6Buod5khoTZcCwPr7qS7NxU0DgROKDHiav8L4JSXscMkseJp0z6ojXlwXvQTNnTFL9IAhEw5P6i7+0kr4sStw3SEpekRaZ9tMiDpDWHY9cnzB9sN6UDb5kwzVDDa3bwh6jk4l7AIQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0FA97D6FAC454499E72DEAB5204999D@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d19c66-bcfe-407b-ec1e-08d6bbf1803b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 07:12:03.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2652
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 5 Apr 2019, at 17:04, Pierre-Louis Bossart <pierre-louis.bossart@linux=
.intel.com> wrote:
>=20
> On 4/5/19 2:26 AM, Jan Kotas wrote:
>>=20
>> =20
>>  	ret =3D pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> +	if (ret < 0 && ret !=3D -EACCES)
>>=20
> There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested =
an alternate solution for exactly the same code.
>=20
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret =3D pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
>=20
> I am far from an expert on pm_runtime but Srinivas' solution looks more e=
legant to me.

Hello Pierre,

Please take a look at this patch, that was my inspiration:
https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

I also took a look, and it seems the value returned by=20
pm_runtime_get_syncis simply ignored in a lot of places,=20
so checking its value may be excessive.

Regards,
Jan=
