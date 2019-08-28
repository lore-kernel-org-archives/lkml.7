Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EAFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1812189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NlG35BCP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UmJyLyQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfH1HXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:23:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42424 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbfH1HXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:23:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7S7IYOn014920;
        Wed, 28 Aug 2019 00:22:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CUrYqjotHUdwi56XN9Q3l57pdA+bviPOlvaEfk9NDpM=;
 b=NlG35BCP8YOFBHPhaemhhUbIk6dCM0pamAXywCscNyKfsURw7GYJl5A/HHMBxrk03iG+
 X162ZjSbTAb2lKM2f+qZKS8OPYfL7WyhufoZdByWdG8cD+YaJG3pLUgEmcSFLE2YMOMa
 478qHKMpXC+G/UJ8UYgO0MX2B/jNpBVujkk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2un2fm4nm8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 00:22:58 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 00:22:56 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 00:22:55 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 00:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxmT9Gjx4xjQ603yiF2eT8z44h6hKPStCoOhvF2ACp1/TT82W0K234SsnBimmy5o5oYxSrJN4mu/M0QoqZPfG+JATDrgnPkYPa+Ewb1dS9CWJZ/cAQdcXIwV4xbLMcLaDfqIsV0NP9ocssxIIEKpq4Zg5hAfv5MUdiwPize8+HLFon3/81MclMbJc8Ogn1m0cVkW6EBHtVpcqYwlmv9G8Z6cqBkwA1jgMd8+lY5xLBGLiLW8Lwr+y+6Su1BmxLS4dm6DrwNM2b5ZyZ2f/Ll/5PfclUlLJBAyuHE0U27Pa4huPvJhvIglVANhyKEp7ANvODoFLBVSmk5p7wItMPoTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUrYqjotHUdwi56XN9Q3l57pdA+bviPOlvaEfk9NDpM=;
 b=OzcM7poG+5tP613oCllBPqKg71Zi8zcSewTJ5Mzc1eUIMXH7IGZul0BSsHV9n90vjDvwRvIkQhhPJ1Wn+mRENt1YB5zGYSuNrrdTbPlM7WilDqgni1BlUkmy75m6OCfxQ055K9fiUcLr9gWB1rzNmhkI4HI1po85rm2mITyl978d4j3UjQt5dJoLwSIKhmiPMkLDRacZlC5EG1oMlxCFtLtVeU8IqbK0o/EaK18lwEAUc7WpXaQckv0nLND1BqqKeryZZuVjDgGthOOYltmuLuhsdkyyUL9n83otmOeyYsjdPjQ/6WtdjCcmPMMzm4rf2plbXW+xIaQLxjPx1cu2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUrYqjotHUdwi56XN9Q3l57pdA+bviPOlvaEfk9NDpM=;
 b=UmJyLyQDmXji7gpecfnaaX8aNaY4hk1Wl2fGX77nmcHcdIl+ukrz6Zd5nb0c0b8MX4kw17FGt9aHAgZ+JFFLV4W0PtE8vAzYahxQBGnbOpidfTlE06KaJ10TRhcfE0MHSis/mdhkhTDBPLU4kX8c4HcFs5rH+Xmt1HSw29rFpQE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1120.namprd15.prod.outlook.com (10.175.8.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 07:22:55 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 07:22:55 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/3] Rewrite x86/ftrace to use text_poke()
Thread-Topic: [PATCH 0/3] Rewrite x86/ftrace to use text_poke()
Thread-Index: AQHVXQMlnkvIjrPs2UaeUVMkMvxaqKcQKMoA
Date:   Wed, 28 Aug 2019 07:22:54 +0000
Message-ID: <78E88856-B048-448B-874F-20163A11B668@fb.com>
References: <20190827180622.159326993@infradead.org>
In-Reply-To: <20190827180622.159326993@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::3636]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c96ca34c-1fc5-42a8-f8f9-08d72b888b64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1120;
x-ms-traffictypediagnostic: MWHPR15MB1120:
x-microsoft-antispam-prvs: <MWHPR15MB112015622F2F1A90622C039FB3A30@MWHPR15MB1120.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(51914003)(189003)(199004)(4744005)(50226002)(8936002)(36756003)(256004)(76176011)(53936002)(316002)(81156014)(486006)(8676002)(81166006)(71190400001)(57306001)(33656002)(476003)(53546011)(6506007)(6916009)(6486002)(71200400001)(86362001)(102836004)(186003)(99286004)(446003)(6512007)(229853002)(6436002)(5660300002)(14454004)(11346002)(46003)(6116002)(7736002)(66556008)(66446008)(305945005)(64756008)(66476007)(66946007)(25786009)(2616005)(54906003)(4326008)(478600001)(6246003)(76116006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1120;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g2b6mTOyrABn6TrBzg7/HfPF1801C7kbnJF9icIqpDxCSZ3cZKtcz1nMSPVRbcuMUu2yqBVmomw6GhzbFbWrUJqWttx7WsoVWeA2/6BBU2VXA+qeMF0yMZHVYTbtTxPHQKwZBGuteKhrBZzYNlEoJ7LqoysP9sq31pkT4ir0B6ySiES6GH3E4roB6TU4cX8E/sRW8kKBuQ21F0tnSE69He1xBD/lPF+GNI5/N36giXC4kKbTFoTzWp/yZB/gR31VT7ci3KWJ0H+l1pOGHcZuqk+so4+iUSgZ5XwzZx/G+q1HRb9zobeXyOtabQjLDqbZ1mvZ0HOF8LWM5+ca6TC0hIN5t2w49sN4C8AVsgJT3n79uLKlXiIZfNpyM2lPdxOYt+QbWmJSV6n83mSWU5KHNeR62Yew8O7L+Vj7VpM3JOs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF35DA5A835D684BB723CBFED9B244B9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ca34c-1fc5-42a8-f8f9-08d72b888b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 07:22:54.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz81Dk6P5pgP+ukwyRpejjlnqud2JFMV1I4Hm6EwoztjdAeuBZv6+bcUmadX4zaafJ0lD3Aj3KfYFko4uq/Jnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-28_02:2019-08-27,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=955
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280076
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Aug 27, 2019, at 11:06 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> Ftrace was one of the last W^X violators; these patches move it over to t=
he
> generic text_poke() interface and thereby get rid of this oddity.
>=20
> The first patch has been posted before and was/is part of my (in-progress=
)
> static_call and jump_label/jmp8 patch series; but is equally needed here.
>=20
> The second patch cleans up the text_poke batching code, and the third con=
verts
> ftrace.

Thanks for the patch. It solves the kernel-text-PMD-split issue.=20

The only problem I found is, it is not easy to back port these patches to 5=
.2=20
based kernel. =20

Thanks,
Song

Tested-by: Song Liu <songliubraving@fb.com>

 =
