Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76575C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174D21734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EqOFYdYb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WFP2o57u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfGZRTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:19:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19948 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfGZRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:19:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QHI41Z025672;
        Fri, 26 Jul 2019 10:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1cLO6UUuGLLv6igO8cDwpB0zGPxu6plc0KFr9CFZsXY=;
 b=EqOFYdYbpEcsJqra6B2AwMpBzEm3gbSn+zUlAICcIRYezg3kwKpod0QWwMChAPfNVcyJ
 3e7fwomI7lg9qSa/91jyw96odZB+q6y0oroV19ryTT3DYOpqDv5crGt/oJlB5LBdw61D
 hBsdUBWUfbleNIIongplQ4om1OV0siNqNFk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u006ah9h2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 10:18:13 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Jul 2019 10:18:10 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 26 Jul 2019 10:18:10 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Jul 2019 10:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOKCTmvRQAVsRBS3iGO6JpoTYQbooYNkD03OhfaMPAU97luubJQVlk0V5sacbBV9gZciI/GQ8CmDV7LnEmisIptVWqTm6QBiQcXOJTLmTeoZMRoE4m1tArWbF0o5JsEWG07GjHD8lkKbMq9rXVX437HWj5EVIEJ3lF8/RlVrWpLurZ1JlLDsj7pwWqHmhw0tjjKqoBXuDNKBDehWP3zkXFcj99Q5RIoF4tyConxtHo6/y8Dv3hTLMgtLrW2B4Lp9B0sUjLNN5votOxISVzzvac17eHwVBm4LtQHdXyDySHf6r0j6STMAc/BF29WS1+q5m4vuJReM8v7SY5BZohs/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cLO6UUuGLLv6igO8cDwpB0zGPxu6plc0KFr9CFZsXY=;
 b=iB1Q2SCMfsfPDobs5FmJ4rawRdzQdFzZU3pjBnJUnzSR4Nb5BAn8HMlWemL72d5/HL7XsxIq1Wf75bkrxS6y+1r9+G7Qy33bwu6efFzAVLov3BBQ41+IyX0sc1T1Wxrw4yG0ULR0kz4O97xoDd+p5vFdm+1W0gRVh5J4oRXqzm6h+xSgy1Gj1RIFBfPnSALjlQmgr33+F7QRkBK+njGINZ5aBhnOeNu4Q7oDGLbumOMa2fITpaHlYKgUALWMDH0K1cLwVhGVdulqkjuEGDy3cAIWC2APr48uCY67RR3pm0F1x4yE7ty6CI4yta2jDTGV7jcfJ2h6RmiSsUDIiY0RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cLO6UUuGLLv6igO8cDwpB0zGPxu6plc0KFr9CFZsXY=;
 b=WFP2o57uVSSaJRID9rINw5np4jQkufgpz6QPX+qGxHBsWb/+gDk/HcBJ3f5/UckmDLHgEwNRRfhgZ9VRMQ6PnWWfLLUbRwNiz94Vagw6n8w8N29+qOzzFBmj7DRddpkEccBm1IndP0Pp80PBR+ugBAqRApDT8DbNP7pY2wK60FM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1407.namprd15.prod.outlook.com (10.173.235.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 17:18:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 17:18:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Shaohua Li <shli@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] md: Convert to use int_pow()
Thread-Topic: [PATCH v1] md: Convert to use int_pow()
Thread-Index: AQHVQ9ICPoM25vwzBkyUooybG4mzI6bdJIyA
Date:   Fri, 26 Jul 2019 17:18:09 +0000
Message-ID: <F7CF9393-B366-4810-B127-876C6D5A72A1@fb.com>
References: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
 <20190726164823.GB9224@smile.fi.intel.com>
In-Reply-To: <20190726164823.GB9224@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:bb04]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ea9c54-f8b3-488e-540b-08d711ed3b55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1407;
x-ms-traffictypediagnostic: MWHPR15MB1407:
x-microsoft-antispam-prvs: <MWHPR15MB14071F04C01A60D5BD2CFFE0B3C00@MWHPR15MB1407.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(6512007)(4326008)(57306001)(81156014)(66476007)(64756008)(5660300002)(76116006)(91956017)(53936002)(66556008)(8676002)(81166006)(50226002)(66446008)(6916009)(66946007)(486006)(6246003)(2906002)(229853002)(14454004)(6436002)(68736007)(33656002)(316002)(99286004)(478600001)(86362001)(2616005)(6116002)(11346002)(25786009)(46003)(8936002)(76176011)(186003)(446003)(54906003)(6506007)(53546011)(102836004)(476003)(7736002)(36756003)(71190400001)(71200400001)(256004)(305945005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1407;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o3zZfEvv81jbGodjYv7u6uHfUrjaIvS0+PdEFIw0olXn3RlfLe+H3NHTosrlaw/U3uKyoPPg0n3/cFxuc+Y/ft9qrE1TBJs5pM+nibcEottLUtPcNTsXlcpQUnb8uVTqqjHnpbiks/W2yvX9R4TEGZl/RCTpfPzgpYlyrmE4sFbbayr2Hzb4o1Ucz7pkgWWHqqPGNBV4dm7kBctRyaWUCd2cmBTOeAEE0nU+qzbeFQf0FmVhCd+dAm8k+zDLHwk9a3inqKtfMPHFXbyeBXQKWWJmxi6u6ZoVH/WuXhoKNvYRf461Jocq4NtFlaTR/7muaDZjPQRLzGWXCNag4Bs4lgkbdVVZnt9kZ/bkK7jwdcaJod9Evih2zg0uNR3AqLYOAQq/0v+dnNYebnsRpIb+Sc8sFJHgDCV0ZphZ71H9roE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAD09523AB061648A24EB869500B7D81@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ea9c54-f8b3-488e-540b-08d711ed3b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 17:18:09.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260209
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2019, at 9:48 AM, Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> wrote:
>=20
> On Tue, Jul 23, 2019 at 11:41:55PM +0300, Andy Shevchenko wrote:
>> Instead of linear approach to calculate power of 10, use generic int_pow=
()
>> which does it better.
>=20
> I took into Cc drivers/dm guys as they might have known something about m=
d raid
> state of affairs. Sorry if I mistakenly added somebody.
>=20
> Who is doing this?
> Should it be orphaned?
>=20
> (I got a bounce from Shaohua address)

I process the patch. Sorry for the delay.

Song

>=20
>>=20
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> drivers/md/md.c | 6 +-----
>> 1 file changed, 1 insertion(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 24638ccedce4..3f1252440ad0 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -3664,11 +3664,7 @@ int strict_strtoul_scaled(const char *cp, unsigne=
d long *res, int scale)
>> 		return -EINVAL;
>> 	if (decimals < 0)
>> 		decimals =3D 0;
>> -	while (decimals < scale) {
>> -		result *=3D 10;
>> -		decimals ++;
>> -	}
>> -	*res =3D result;
>> +	*res =3D result * int_pow(10, scale - decimals);
>> 	return 0;
>> }
>>=20
>> --=20
>> 2.20.1
>>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

