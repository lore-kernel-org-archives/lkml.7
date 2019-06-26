Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDFC48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E520883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c2gm01Bh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AsG9IPzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFZAFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:05:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFZAFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:05:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5PNxAB8029198;
        Tue, 25 Jun 2019 17:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gJqK7WAwnppGNe+WaPuYdN7w6pmeK+qS5lDIC2cNwBg=;
 b=c2gm01BhQAbHk0SuF/XBkloY+GVjBo6IvnGWO/Blsv2+1BN8LCTsjke1kTxsFfeWUqnr
 hwADihpsPGC63IMMwE5jkPMAerDY7rSNFg2LOL4P2xfenp7GrnvHZ50cmAJwdCrMT0BE
 i9xMSEPaIZPfOsVYkVvAhnQ+HIJK+rUXlds= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2tbsw3gw01-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:03:19 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 25 Jun 2019 17:03:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Jun 2019 17:03:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJqK7WAwnppGNe+WaPuYdN7w6pmeK+qS5lDIC2cNwBg=;
 b=AsG9IPzoqGvnpL72ORyjIKmV362HWwZPyq2Tp0MbBaGVEAFg7XoRiYT7Wpg8GnlLDt1xLnsQYrRnyXXGgNYHB0LeazM5RwvD8ulhrO0mA2zZJyH/bVzK4mqoR0MkUPWfv1ehl0PIaLawSj7WGz5otf6C/VjpQSJxAuqatZeoWQo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1168.namprd15.prod.outlook.com (10.175.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 00:03:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 00:03:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Oleg Nesterov" <oleg@redhat.com>
CC:     Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v7 0/4] THP aware uprobe
Thread-Topic: [PATCH v7 0/4] THP aware uprobe
Thread-Index: AQHVK7E4lol1kVOHXUGEcao/g/n2faatDbOA
Date:   Wed, 26 Jun 2019 00:03:12 +0000
Message-ID: <0A9B714D-59D4-4F78-8625-831F76FB7797@fb.com>
References: <20190625235325.2096441-1-songliubraving@fb.com>
In-Reply-To: <20190625235325.2096441-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:8487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b71272-571f-4a31-ee80-08d6f9c9ae04
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1168;
x-ms-traffictypediagnostic: MWHPR15MB1168:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB11689A5FD5FFC06C2B7C7820B3E20@MWHPR15MB1168.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(36756003)(305945005)(54906003)(71200400001)(53546011)(71190400001)(6506007)(4744005)(316002)(7736002)(110136005)(6486002)(256004)(76176011)(99286004)(5660300002)(229853002)(6116002)(4326008)(57306001)(6306002)(476003)(46003)(11346002)(73956011)(66446008)(66556008)(2616005)(8936002)(66946007)(6246003)(64756008)(8676002)(14454004)(53936002)(76116006)(25786009)(81166006)(81156014)(86362001)(6512007)(486006)(186003)(102836004)(6436002)(2906002)(14444005)(966005)(5024004)(68736007)(446003)(478600001)(66476007)(50226002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1168;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nv9jKFYxRz9CLYqaMnVMgwyoHbB2/48fn66YCSD8woiuJTYDDQNHk4IDhsWBvCwgoqqLk3GNwD/TRq6Q8Eyq5jFiDv2ytdMWMECrIPcysblE4VygJLzsRlx4rL8DexxBab6imbKhQddy8ZKWwz74CvTUu/ue7k5W8gqUR0SDkVY/bVUymCsb3kCGXCg4xXP9FCm6ZRQ4aVJI8Vwcl5O73jz/nCp3V2jxRe7f4zaZ2oNrQaU/rYrHBDwWkI5Pm0a0sDDlpwF/wfGR+iYi2F6uA8QJ3W3aoSkpOf/3VSws8NS++4jDfV4Ky0dfk7Vp9Ztt+WFQPuCXAuk9JVw+XWP2Gs7WnY0cfJzPTY8CNsn1DMQ4pbcFCeBUw87E+TW/JUg6QiHBL72naLbCb2U66a170mkTTY21m/aHX+VRUNhan3c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8DE82D15AEF80409DB949920B7CFF6B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b71272-571f-4a31-ee80-08d6f9c9ae04
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 00:03:12.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250198
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,=20

> On Jun 25, 2019, at 4:53 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This set makes uprobe aware of THPs.
>=20
> Currently, when uprobe is attached to text on THP, the page is split by
> FOLL_SPLIT. As a result, uprobe eliminates the performance benefit of THP=
.
>=20
> This set makes uprobe THP-aware. Instead of FOLL_SPLIT, we introduces
> FOLL_SPLIT_PMD, which only split PMD for uprobe.
>=20
> TODO (temporarily removed in v7):
> After all uprobes within the THP are removed, regroup the PTE-mapped page=
s
> into huge PMD.
>=20
> This set (plus a few THP patches) is also available at
>=20
>   https://github.com/liu-song-6/linux/tree/uprobe-thp
>=20

Do you have further comments/suggestions on this work? If not, could you=20
please add your Acked-by or Reviewed-by?=20

Thanks,
Song
