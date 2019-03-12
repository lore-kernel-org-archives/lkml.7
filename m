Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E262147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qb/121ay";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DuJXULSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCLQ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:27:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45090 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbfCLQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:27:04 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CGNRZx031821;
        Tue, 12 Mar 2019 09:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MYRh/aEL7gyS2ixL+Qwt8Jc7c/dSO1sZT0GOub5PQ2Q=;
 b=Qb/121ayoa+0DdUHWJruSwWk/Q2o7RvDH/itXbXQACqdVjN+qiXEiBL6cWD//e9H5GHu
 aN2U3WfpjtbdKIyVuNSuf80Ql/tLSudqkqeqNCJ57JULpzwC8ZJ1e8iND/uq4ZeWIR4y
 fh69nIN9xURoPLWXaH6029Incuh7apZmYI8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6g3tg1qs-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 09:26:37 -0700
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 09:26:20 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 09:26:20 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 09:26:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYRh/aEL7gyS2ixL+Qwt8Jc7c/dSO1sZT0GOub5PQ2Q=;
 b=DuJXULSqt/X4CT60aEo60Fsl5wqt+2hUNhhOR1iVE3WLdlPkhwBbTReVeV4BkmsIiw4DA4OZjxFKHR7XKkcPNOhl6GEXON64LmaoCCTvWUAaFO/WvAgw0FgthRGhYZBAWcEMiwFMBdOfJISC+3tEwSkKltBN1NoTtWPf2LFpYMI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1120.namprd15.prod.outlook.com (10.175.2.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Tue, 12 Mar 2019 16:26:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 16:26:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHU2JTq1ai9qoaEF0mXPn112Pnh46YIG0yAgAAAkwCAABOYAA==
Date:   Tue, 12 Mar 2019 16:26:17 +0000
Message-ID: <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org> <20190312151608.GH4939@kernel.org>
In-Reply-To: <20190312151608.GH4939@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::1:a1d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0ed5bb-1737-4c46-4a6d-08d6a707743e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1120;
x-ms-traffictypediagnostic: MWHPR15MB1120:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1120;20:2nUnE+vs6vX7Zf2yksswGbocgHzsGgDlZmAF8ro+1HUqnxq5nxZtCJwFz6Xoxs/UuoCH6kX4TP9GcOCs0uCT0t2oj7Gn9P2bUZfiwmknLDFSdN597rtKL4ufHOPUOmRFO29p3eZxeCyBFBgU2iQV+0Ajd3nhNXLA0xSMhSh8XuA=
x-microsoft-antispam-prvs: <MWHPR15MB112029C5C846097ACBC2E970B3490@MWHPR15MB1120.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(105586002)(106356001)(6916009)(93886005)(86362001)(54906003)(2906002)(6506007)(53546011)(316002)(305945005)(53936002)(8936002)(46003)(7736002)(57306001)(99286004)(76176011)(5660300002)(486006)(6246003)(14454004)(11346002)(102836004)(229853002)(2616005)(476003)(4326008)(6116002)(256004)(68736007)(186003)(7416002)(25786009)(6436002)(6486002)(50226002)(6512007)(82746002)(97736004)(71190400001)(83716004)(81166006)(81156014)(14444005)(8676002)(71200400001)(478600001)(33656002)(36756003)(446003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1120;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mP0lJEtdcrvDMeZoc741fQYRgmfhVEcoL7lDnQ9Z9GGis/nJGzymJKZ2tmet/+cn0Z6Sr0nZzeRLlgoQo+H2m6lhC7JaRXvC380NrtH/BwffF1yodTKd13tYa8mYFuGm7It8w/TokEbp6318qh7FGEzrHjwTGGuRgfKQwxf3YVfViwHNRExz63hVHsDRgxxNwjpYoft8i1Vj75991SxrXfJq//FB8ROHRQ841p2ooJcxoFt7rIPdpgSig8tj8tBds0hgHm1iexIANyxO77P9Vsjh3IBmeCvWIyP0SERPa9U4KrbO/rtdRSLwbnStsil0BvToUMeJEJqBHCFjbyLPl2z0raVNoqxzJ++l6caHQDVh88kpRC4Nq+su85z6ScjessCZHoelgKN5wmIyA6YHZN0rpf1zc1XQD3Ko74htqRk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53E94C517151074E80449361F929A160@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0ed5bb-1737-4c46-4a6d-08d6a707743e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 16:26:17.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2019, at 8:16 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Tue, Mar 12, 2019 at 12:14:05PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
>>> +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
>>> +{
>>> +	struct perf_env *env =3D &ff->ph->env;
>>> +	struct rb_root *root;
>>> +	struct rb_node *next;
>>> +
>>> +	down_read(&env->bpf_progs.lock);
>>> +
>>> +	root =3D &env->bpf_progs.btfs;
>>> +	next =3D rb_first(root);
>>> +
>>> +	while (next) {
>>> +		struct btf_node *node;
>>> +
>>> +		node =3D rb_entry(next, struct btf_node, rb_node);
>>> +		next =3D rb_next(&node->rb_node);
>>> +		fprintf(fp, "# btf info of id %u\n", node->id);
>>=20
>> So, I couldn't get this to work right now, and I have BPF programs that
>> are loaded and that have BTF info:
>>=20
>> [root@quaco ~]# bpftool prog | tail -6
>> 208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
>> 	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
>> 209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
>> 	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
>> [root@quaco ~]#
>>=20
>>=20
>> [root@quaco ~]# bpftool map  | tail -6
>> 105: perf_event_array  name __augmented_sys  flags 0x0
>> 	key 4B  value 4B  max_entries 8  memlock 4096B
>> 106: array  name syscalls  flags 0x0
>> 	key 4B  value 1B  max_entries 512  memlock 8192B
>> 107: hash  name pids_filtered  flags 0x0
>> 	key 4B  value 1B  max_entries 64  memlock 8192B
>> [root@quaco ~]#
>>=20
>> [root@quaco ~]# bpftool map dump id 107
>> [{
>>        "key": 8104,
>>        "value": true
>>    },{
>>        "key": 18868,
>>        "value": true
>>    }
>> ]
>> [root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
>> 8104 pts/8    S+     0:07 trace -e recvmmsg
>> 18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
>> [root@quaco ~]#
>>=20
>> So I was expecting to see those btf lines there :-\
>>=20
>> All the patches up to this point I have already merged and tested in my
>> local branch.
>>=20
>> Will continue right after lunch to try to figure out why this BTF info
>> isn't landing on this new header feature...
>=20
> I've pushed what I have to my git.kernel.org repo, branch
> tmp.perf/bpf-annotate.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/bpf=
-annotate
>=20
> The HEAD is this cset.
>=20
> - Arnaldo

I am not sure I fully understand the problem here.=20

I can get BTF information from this version:

# ~/perf report --header-only  | grep btf
# btf info of id 504

Thanks,
Song

