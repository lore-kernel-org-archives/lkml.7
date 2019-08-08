Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D70C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546E2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="INeZ5rUh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CVs7HpaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbfHHNmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:42:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16124 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733087AbfHHNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:42:35 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78DdIRu027306;
        Thu, 8 Aug 2019 06:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iGLtjQG+xP5uJAoKeLR4X19liX/fHkP+1VDu90XXCiQ=;
 b=INeZ5rUhjT3LLhnJrSNO02/H4waeah7Ne/QS715QYQbZZNSqQ5CbiDrZLWYg741VK7ZN
 Mtli4VJaNcD5Ufm62muNnJpuDphgXk7D/y+HAfDPpdMNbeDHH516FtOtSkrynE8DUK62
 4K0IR8448/Ry3cNOangPz3LDnqag6pJWfy4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8mpbr13c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 06:40:30 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 06:40:28 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 06:40:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 06:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqfiW1XXxA4Yg2azrefyWKYJ3drsGzbCFLLbd5zNFudZYOigentUoDcb5dutXqD7KvYx5R8r9H9RDaKmoJbKtCwdqT6zgalvT50rooCyDyFoWGLQnSqiFLnhsfSHwXu/QLhtRpKCbG77d+GWW0IYHGYWT0/MWlJ6/qrtjHjZsXCbXNL6P6mu0WoOmLvSzgx9/Vn1LJDO0J6XAGL+jrfRgRsTMtEC7v3Ar8mLKh1wnjZho1TiFMcxN0KiozWEchBgnnglhQPRa9uqMAYp3A/Oiz6FAuHWDKHaHYtel8Pc+IG0dx+NckOXyseDgANcQ49MAPYWOBBkTWzrdKY14JJq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGLtjQG+xP5uJAoKeLR4X19liX/fHkP+1VDu90XXCiQ=;
 b=WRj8uFnzzNvZ60lrD4xLJRh6WMgfPiMu7Ygw+NVO3erVxyx/dbMOdT0Dl5wImrgU/UYckQoIpzps6huVyIsk1IEHrPO932Z6QJqy8qmxCRenAJUXJPBQAmZqr4kDn3ZvgCQpqzq2Ef2LBL7aFJ1XpgCPmsjZQDyZa3gde0qS2nqBHeuItPjWfuxyQ/P/JqH0vy81qGr6+t84I6G+9JxGdjxzQrTLA2QOt3orG4AKRKleiImnxI4166IqJ76KgkQDp2gofoj3oy878y3/inHaQhbO3LKD2lrPztqVU/eQhlXNC7l7C+8I+vqGEOtLCd+udAFnt1VJgL+392o31kaaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGLtjQG+xP5uJAoKeLR4X19liX/fHkP+1VDu90XXCiQ=;
 b=CVs7HpaFU6Pimsb5pOZzW60u3WLsf7IqbBajm/zkMBguw7bNlNRUa85hR8IYcAMLxx82+q28SSRB9rYgcsdarwG+G4RygayhU/OtvEn8zTiiWF1aXrKVqKaOFOTf/guCYhIT2Zd9hdICeZbfflXEy3yuHuh3pZg1YfQCkhwoLwU=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB2775.namprd15.prod.outlook.com (20.179.158.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 13:40:10 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4531:ecb8:acf6:5802]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4531:ecb8:acf6:5802%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 13:40:10 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH resend v2] lib: scatterlist: Fix to support no mapped sg
Thread-Topic: [PATCH resend v2] lib: scatterlist: Fix to support no mapped sg
Thread-Index: AQHVQdP8JOxRHT7X/kmJb2XJ2A3JkKbg2sKAgBB/KoA=
Date:   Thu, 8 Aug 2019 13:40:09 +0000
Message-ID: <ba094177-6dc5-e1f6-d256-8e21d119729e@fb.com>
References: <1563940463-95597-1-git-send-email-wangzhou1@hisilicon.com>
 <5D3E4F91.4020605@hisilicon.com>
In-Reply-To: <5D3E4F91.4020605@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2605:e000:100e:83a1:186c:3a47:dc97:3ed1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7babad-7380-4c3b-fd24-08d71c05ee1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2775;
x-ms-traffictypediagnostic: BYAPR15MB2775:
x-microsoft-antispam-prvs: <BYAPR15MB27753487D653C540E25742C4C0D70@BYAPR15MB2775.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(186003)(99286004)(386003)(71200400001)(2906002)(86362001)(71190400001)(46003)(25786009)(256004)(52116002)(36756003)(6506007)(11346002)(76176011)(446003)(316002)(53546011)(53936002)(14444005)(54906003)(486006)(102836004)(2616005)(110136005)(2201001)(476003)(2501003)(4326008)(7736002)(6116002)(5660300002)(6436002)(81156014)(81166006)(31696002)(8676002)(305945005)(8936002)(66556008)(6246003)(64756008)(6512007)(66446008)(478600001)(31686004)(66946007)(6486002)(66476007)(229853002)(14454004)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2775;H:BYAPR15MB2790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wbFEY21/BFUOfJGnPqtcTwt4rRiGB0OiJS/9TTiw2zRa7RCjagNJT43JTrwxrNK65awU6xHPX/WINE5Ye3HhSBlzKnQSJLUvVYZz6/5lkH5TAvX431OpugaToXetLdVVTNVw/H+ZsoH04DFZ3qDyw+BO+dGDrhHig67gHfHJMnY9+QNErvGUXuKg/Q6zKXkLytx5nmGc/JnZYQ61Sr1U4+m2RJuZl36REdag5+QD/BD/7iSXwaq+EjuC2cfBEg7V1h2HccYurfIFykw9lIYACq4BsgDAxO5usfCbb9h1U+ecawRi8mvgOTOA3QDiqvt2rFAI6aRFaKcJjl/smcLCUlzIsX5esokPElrS/DWSYK098BCCEICLTkBVJMpJowE8g1+RaZGPdpTiEMXtScLtP7RXG1bvFOtVAsHYopXhQlA=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9CFDBF448E87D749A2A2B97DF83C0153@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7babad-7380-4c3b-fd24-08d71c05ee1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 13:40:10.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L12mRMOaSVNwVtmTH5yKYEaqo881V9kn07y91XYKL1BXu5zGaTiWG79iT9e+hZ72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2775
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 6:44 PM, Zhou Wang wrote:
> On 2019/7/24 11:54, Zhou Wang wrote:
>> In function sg_split, the second sg_calculate_split will return -EINVAL
>> when in_mapped_nents is 0.
>>
>> Indeed there is no need to do second sg_calculate_split and sg_split_map=
ped
>> when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry =
in
>> original sgl.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>> v2: Just add Acked-by from Robert.
>>
>>   lib/sg_split.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/sg_split.c b/lib/sg_split.c
>> index 9982c63..60a0bab 100644
>> --- a/lib/sg_split.c
>> +++ b/lib/sg_split.c
>> @@ -176,11 +176,13 @@ int sg_split(struct scatterlist *in, const int in_=
mapped_nents,
>>   	 * The order of these 3 calls is important and should be kept.
>>   	 */
>>   	sg_split_phys(splitters, nb_splits);
>> -	ret =3D sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
>> -				 split_sizes, splitters, true);
>> -	if (ret < 0)
>> -		goto err;
>> -	sg_split_mapped(splitters, nb_splits);
>> +	if (in_mapped_nents) {
>> +		ret =3D sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
>> +					 split_sizes, splitters, true);
>> +		if (ret < 0)
>> +			goto err;
>> +		sg_split_mapped(splitters, nb_splits);
>> +	}
>>  =20
>>   	for (i =3D 0; i < nb_splits; i++) {
>>   		out[i] =3D splitters[i].out_sg;
>>
>=20
> Hi Jens,
>=20
> I saw you are the committer of sg_splite.c, could you help to take this p=
atch?

Yes, I can take it for 5.4, it looks fine to me.=20

--=20
Jens Axboe

