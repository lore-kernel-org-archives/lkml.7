Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A600A214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Whz1nIlR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O1RdZikZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfCKVYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:24:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbfCKVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:24:00 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BLJRTC020525;
        Mon, 11 Mar 2019 14:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TudZDC57UbbAsp5MTChf8gWDM4qRAZR+/Yj53v/x36w=;
 b=Whz1nIlRT6wyi6vkYC79rEVJNafmhs8bp2sqx9Edej2sr3l5dqLB64Yc0Jk7vi+D0lVu
 QKN8AedNSR8S6+ivw8mROMGunZF4Q6DmYFy6eCF+puNBTQaJZMWtV6ody8fMR0tFPFBr
 /hWMYf5wz6uT6wH7nLYjyNFOTC4mHtrTqzk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5xupg5kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:23:32 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:22:40 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TudZDC57UbbAsp5MTChf8gWDM4qRAZR+/Yj53v/x36w=;
 b=O1RdZikZsR9k5VYZ7ll7Zd1v7KIej+bLUwYDlQNRWgUVDGTvL9lAR9+RKmgiPWnQ2GXuq6f2u3vcuGKJoJyF+Q2wHqCF/nZ0JIJJCNghlDoAmKLEnvRPq+n+3HslNL515rISdErTR/DTsvmLKM1rKGcaWw9mpCGLGhk8EUbeJmM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1533.namprd15.prod.outlook.com (10.173.235.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Mon, 11 Mar 2019 21:22:38 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:22:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Topic: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Thread-Index: AQHU2ESEhUo7NOm9yEuQuJ5Kxn1dHqYG4EAAgAAKfoCAAADugIAAAPIAgAAC5ICAAAEOgA==
Date:   Mon, 11 Mar 2019 21:22:37 +0000
Message-ID: <9AC47385-896A-4F85-857B-C6FA686BD985@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311202414.GA3078@redhat.com>
 <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
 <20190311210507.GF10690@kernel.org>
 <944EE4E6-FD71-4D41-ABE1-279C6950EB11@fb.com>
 <20190311211851.GB4939@kernel.org>
In-Reply-To: <20190311211851.GB4939@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bacd56d9-bb39-4430-4b3c-08d6a667afc9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1533;
x-ms-traffictypediagnostic: MWHPR15MB1533:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1533;20:CiGGs2YE+vkwolEhh3dLumip29Q7K4yZTTxmlLePe/seBSdfSj7r83brbBfUImjbLv/noyuW+5mtBCsiP99JWWZT2Nab8/I7wlCWA9j3o730i3z/aLR/bjYvFqWoGANL44SyY2DKMajm2Imb5uIKfVXa0T4RZIPa0XMxBaP4QLY=
x-microsoft-antispam-prvs: <MWHPR15MB1533C3CED3D68A188E6531F9B3480@MWHPR15MB1533.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(476003)(8676002)(97736004)(81166006)(71190400001)(71200400001)(105586002)(6512007)(46003)(106356001)(83716004)(53936002)(4326008)(76176011)(2906002)(68736007)(102836004)(53546011)(86362001)(25786009)(6506007)(6246003)(50226002)(57306001)(8936002)(478600001)(99286004)(186003)(36756003)(54906003)(256004)(14454004)(316002)(305945005)(7416002)(229853002)(82746002)(7736002)(11346002)(2616005)(446003)(33656002)(6436002)(81156014)(6486002)(5660300002)(486006)(93886005)(6116002)(6916009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1533;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHKKkbCd26mhc/l52dHOBc1xI4svOnOhXRCSPbXJlll+dRNFE8cEc2h3TpiwG4zZ43011BOdar32SucuuVm3HQm4OKxEfgGyu2sPiKPlXpSSGliuHO0s18rDtJVwU5BMH1/hmcLdBGCiyCdW7NLJZuib9LDmq8UEB/fuEM7YpGOCu3a57Qn2yBzCaL/F3T7KLU7AxxcSilHGIKfmM5i4ENREosbEj/+DC7oPCgTo2T07efzVDUYPa05sKVtqMjbAmQAiWhsy9WJ0RTj2V2j4RJiS5hi0N8fFwjDjbEN9MsMiYkcRPWisDdiw7b9uG/ynBjKU40gzl3919C6BTS0Bj60gq6uPZHrfvE1ykY+qIlZz/PFEMwWgUiPVezlxlzKHIODtEtFxm34UNLcFUBkIidqy6mFqyLPCo448pWlLL8k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <635CDA5C45136A4F82EB7C0747F56EC7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bacd56d9-bb39-4430-4b3c-08d6a667afc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:22:37.9139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1533
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 2:18 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Mon, Mar 11, 2019 at 09:08:31PM +0000, Song Liu escreveu:
>>> On Mar 11, 2019, at 2:05 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gma=
il.com> wrote:
>>> Em Mon, Mar 11, 2019 at 09:01:48PM +0000, Song Liu escreveu:
>>>>> On Mar 11, 2019, at 1:24 PM, Arnaldo Carvalho de Melo <acme@redhat.co=
m> wrote:
>>>>> These csets are already upstream, i.e. already hit torvalds/master, i=
.e.
>>>>> will be in 5.1, can you check that we still need doing this
>>>>> cherry-picking?
>=20
>>>> I just checked that 02-15 of the set could apply to torvalds/master (w=
ith=20
>>>> some minor conflicts), and it works as expected.=20
>=20
>>> So no need to cherrypick, just use torvalds/master as a base, ok.
>=20
>> Do you want me to resend the set with the conflict resolved?=20
>=20
> No need for today, I think Jiri is looking at that branch I saw you guys
> chatting today, so if he has some new comments, you can then address and
> repost, fixing the conflicts then.
>=20
> - Arnaldo

Got it. I will include the --bpf-event option change and repost later.=20

Thanks,
Song=
