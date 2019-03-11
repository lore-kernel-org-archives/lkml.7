Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A06C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF80206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KPEXD3mz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="e82lqkks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfCKSFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:05:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbfCKSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:05:36 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BI2jln020265;
        Mon, 11 Mar 2019 11:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RLwKrC/voF+3rND48JyAOGO3PFc84l3SvAWoXb5wgrY=;
 b=KPEXD3mzBPwYSbMbkvxCzNCT+rxGZMc0lwGQ0NThdHp3WkrZL8/0YgmYoHOCPS71u/sN
 H2etAjPLbR5dr++BPkXPNeyJH9o79JxiPjDHL3zxchqWvOVscsE3uATXK2d3vWXCTABT
 x7prnoeug43vQ0n/eTGdtZKKIWfa/zB/Yms= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5ubf0b0d-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 11:05:05 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 11:04:42 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 11:04:41 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 11:04:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLwKrC/voF+3rND48JyAOGO3PFc84l3SvAWoXb5wgrY=;
 b=e82lqkksveQn2NrhJaEAWc6bEA7fY+KZhoN4KI07laI9GGBzZfdLn3vfNbYcZt3CoyDpmLCPCsCXoU0KBwRM50w+TNW+Fci1FeOnc5DLAUX/KhN3iRzEoojKBFUdB33gH9JL7UsK9VOehpKFdFoecFnalKEZ6/IUl7q1i1phP5Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1117.namprd15.prod.outlook.com (10.175.2.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 18:04:40 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:04:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v7 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Topic: [PATCH v7 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Thread-Index: AQHU1Q94d1kU5xxUhU2jOkg31L0NcKYGvXCAgAACOQA=
Date:   Mon, 11 Mar 2019 18:04:39 +0000
Message-ID: <C0126410-1B35-4A28-8DEC-67B2D737E1ED@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-13-songliubraving@fb.com>
 <20190311175641.GA19721@krava>
In-Reply-To: <20190311175641.GA19721@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e03e61-0b4b-4328-8543-08d6a64c07e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1117;
x-ms-traffictypediagnostic: MWHPR15MB1117:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1117;20:y2eezelV8xICAwyXZr22mTaRaxeVeay0zlzWoYZjRzz8mC5Zzw3SGHFbTjbd663Sq8pRnCppIDNybDz/ICRxlgzvW0/WwIe0ZmgUQuhpRzkShzfdvdpy1K5HYE46unP3EbanKHqLwFqVRfJMuYiHbj/1Ba7QvdCoS+E7Z51541A=
x-microsoft-antispam-prvs: <MWHPR15MB11173D5BA708CE6DDBF8C71DB3480@MWHPR15MB1117.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(6116002)(71190400001)(71200400001)(2616005)(54906003)(83716004)(486006)(36756003)(6512007)(476003)(478600001)(316002)(11346002)(68736007)(76176011)(2906002)(7416002)(46003)(82746002)(25786009)(6916009)(6246003)(86362001)(99286004)(7736002)(81166006)(81156014)(14454004)(8936002)(57306001)(4326008)(97736004)(6506007)(53546011)(50226002)(256004)(186003)(33656002)(8676002)(53936002)(229853002)(446003)(5660300002)(102836004)(305945005)(6436002)(106356001)(105586002)(6486002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1117;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kMPo5J6YU7CGD473fuKMLJdqiMc5PBGLTPJG9C71q1duv12PALMOS2EuRuAAvndWDjSzGHi0cbhnnEa5TKhVU6HrY0JgDvb4xNKUdHTzg+b4GfSKy5TMSmEWB4T37yx0eOa2Qy/ZVjLUHJEXC2yOJX/bVO9rDkcfTvXOwaW3ixcDkz4e2KqDNGMKcNBK4TXzTY7EKgTUIW2uQJGkuyTHmoXrt64NUYNK/EpYXEkDH7uUupJRjUo+Qq7yIuddyvbszbepr8qlPeJ7f0c9lKMQX59zbi1z7NG2tJQRDxVKLozX+sKNuqJYV9q4tRMj/OIC+r7r2CDhV2qo/BSXBwpoRTt1/gUPHgSyyJbW8zGEP/oZcs5Sf2ja+77ofe8LksXmwbWdtU+fbbqfsqcxEojfwGuHg6phwXcRLyqX4K6vA9c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8DD19081D31E14EAB5A359F40D8839E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e03e61-0b4b-4328-8543-08d6a64c07e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:04:39.8540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 10:56 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Mar 07, 2019 at 09:58:07AM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +		if (linfo && btf) {
>> +			srcline =3D btf__name_by_offset(btf, linfo->line_off);
>> +			nr_skip++;
>> +		} else
>> +			srcline =3D NULL;
>> +
>> +		fprintf(s, "\n");
>> +		prev_buf_size =3D buf_size;
>> +		fflush(s);
>> +
>> +		if (!opts->hide_src_code && srcline) {
>> +			args->offset =3D -1;
>> +			args->line =3D strdup(srcline);
>> +			args->line_nr =3D 0;
>> +			args->ms.sym  =3D sym;
>> +			dl =3D disasm_line__new(args);
>> +			if (dl) {
>> +				annotation_line__add(&dl->al,
>> +						     &notes->src->source);
>> +			}
>> +		}
>=20
> I still miss answer for why is the line added twice for
> !opts->hide_src_code && srcline ? code up and down
>=20
> jirka

The line above (under "!hide_src_code && srcline") is the src code=20
line; while the one below is the disassemble output. We only show the=20
source code when "!hide_src_code && srcline" is true.=20

Thanks,
Song

>> +
>> +		args->offset =3D pc;
>> +		args->line =3D buf + prev_buf_size;
>> +		args->line_nr =3D 0;
>> +		args->ms.sym  =3D sym;
>> +		dl =3D disasm_line__new(args);
>> +		if (dl)
>> +			annotation_line__add(&dl->al, &notes->src->source);
>> +
>> +		pc +=3D count;
>> +	} while (count > 0 && pc < len);
>=20
> SNIP

