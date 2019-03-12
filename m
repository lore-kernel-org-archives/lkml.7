Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87812C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nKk8w7is";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cUIp56No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfCLRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40990 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfCLRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:45 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CHKtWZ019732;
        Tue, 12 Mar 2019 10:33:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h1pdZCNPCNfLIW7B+3hWkUWc7aAcPj9FnMgzxDSWsxU=;
 b=nKk8w7isxQjZLD3Z3l1WM8lcPyeYlmg0+RieWDOueFgdfuPhB5r9TPkoLKG8uexe0FCY
 sd+yn/t3dSHYsnZ02mLRkWaWjVQkqrSXmssWEHcsptzaUmEx12HswQlswrQoON3Jd3y1
 fvQ4K6xgf2y2u9R39Nx1SocoBWESPGeACkw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6g3tgdbd-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 10:33:17 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 10:29:19 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 10:29:19 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 10:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1pdZCNPCNfLIW7B+3hWkUWc7aAcPj9FnMgzxDSWsxU=;
 b=cUIp56NoDIVMS5S5h7cFtTIXMVypE0ukVV2A2kfF0AEIUPjoqWe4TAFN/hrU20SX/t23H1pUsjUAhEP96uxHnPxFdL1Y4XP4AtW5pogoZFYj7VmVBDDkDvAkiaNG++2aV22Jw+/v5rTvPzE5Wa03XYFZNYrNnMKgqW4FjShlEfA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1872.namprd15.prod.outlook.com (10.174.255.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 17:29:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 17:29:03 +0000
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
Thread-Index: AQHU2JTq1ai9qoaEF0mXPn112Pnh46YIG0yAgAAAkwCAABOYAIAACxUAgAAGdoA=
Date:   Tue, 12 Mar 2019 17:29:03 +0000
Message-ID: <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org> <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
 <20190312170556.GJ4939@kernel.org>
In-Reply-To: <20190312170556.GJ4939@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::1:a1d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05b490d8-74ff-4835-ea29-08d6a7103912
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1872;
x-ms-traffictypediagnostic: MWHPR15MB1872:
x-microsoft-antispam-prvs: <MWHPR15MB1872D5AC651CC2B1EEF56E80B3490@MWHPR15MB1872.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(14444005)(5024004)(97736004)(6116002)(19627235002)(105586002)(106356001)(57306001)(50226002)(256004)(2616005)(33656002)(476003)(11346002)(446003)(93886005)(7416002)(186003)(6916009)(6246003)(46003)(54906003)(86362001)(8936002)(83716004)(486006)(316002)(71190400001)(25786009)(2906002)(71200400001)(82746002)(8676002)(102836004)(81156014)(81166006)(53546011)(5660300002)(68736007)(99286004)(53936002)(6506007)(7736002)(36756003)(305945005)(76176011)(14454004)(6486002)(4326008)(229853002)(478600001)(6436002)(6512007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1872;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KOv5ZuDDCX7ewdiJVvMvtSxo4oiV/N6bj2xhMuzLNFkQAokbgKKmqFvma6abhXkE7pBQxyf8pohidF0CsIyA99xUymWSgPRwri3pbWAsqS53ccilC9mZh0mXVI8EQhsUR2OGK7d06oxRofRCqKGDrYeicls5tbNusB+8CDvLnHzxroR31v+PSXJS6aRbRY+zmxWnuDFQtKnlC1xqLpDg3PExMIXs5VsysO3dUdI7B7V+JBk4dE5+7b3NGwAHSjvXkrCCRTFbozBEHhNR2rbve8qjpil+cUBCAx39+KbI3Ttkzz2kY0yXGSfEdnOWUDhcUVvWaC0NPC9H0KK1HBGLIMt64C11suMQVi/BpCUzFMzT+wfIeV0NGDwxZXF75IKU2L1R8+0aZyYE7x8MAGYqkgpYrIQEJZ4Lh6R/keiGY4o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF529D1466F3C148BB116F58212D07B6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b490d8-74ff-4835-ea29-08d6a7103912
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 17:29:03.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2019, at 10:05 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmai=
l.com> wrote:
>=20
> Em Tue, Mar 12, 2019 at 04:26:17PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Mar 12, 2019, at 8:16 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gma=
il.com> wrote:
>>>=20
>>> Em Tue, Mar 12, 2019 at 12:14:05PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>>>> Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
>>>>> +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
>>>>> +{
>>>>> +	struct perf_env *env =3D &ff->ph->env;
>>>>> +	struct rb_root *root;
>>>>> +	struct rb_node *next;
>>>>> +
>>>>> +	down_read(&env->bpf_progs.lock);
>>>>> +
>>>>> +	root =3D &env->bpf_progs.btfs;
>>>>> +	next =3D rb_first(root);
>>>>> +
>>>>> +	while (next) {
>>>>> +		struct btf_node *node;
>>>>> +
>>>>> +		node =3D rb_entry(next, struct btf_node, rb_node);
>>>>> +		next =3D rb_next(&node->rb_node);
>>>>> +		fprintf(fp, "# btf info of id %u\n", node->id);
>>>>=20
>>>> So, I couldn't get this to work right now, and I have BPF programs tha=
t
>>>> are loaded and that have BTF info:
>>>>=20
>>>> [root@quaco ~]# bpftool prog | tail -6
>>>> 208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
>>>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
>>>> 	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
>>>> 209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
>>>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
>>>> 	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
>>>> [root@quaco ~]#
>>>>=20
>>>>=20
>>>> [root@quaco ~]# bpftool map  | tail -6
>>>> 105: perf_event_array  name __augmented_sys  flags 0x0
>>>> 	key 4B  value 4B  max_entries 8  memlock 4096B
>>>> 106: array  name syscalls  flags 0x0
>>>> 	key 4B  value 1B  max_entries 512  memlock 8192B
>>>> 107: hash  name pids_filtered  flags 0x0
>>>> 	key 4B  value 1B  max_entries 64  memlock 8192B
>>>> [root@quaco ~]#
>>>>=20
>>>> [root@quaco ~]# bpftool map dump id 107
>>>> [{
>>>>       "key": 8104,
>>>>       "value": true
>>>>   },{
>>>>       "key": 18868,
>>>>       "value": true
>>>>   }
>>>> ]
>>>> [root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
>>>> 8104 pts/8    S+     0:07 trace -e recvmmsg
>>>> 18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
>>>> [root@quaco ~]#
>>>>=20
>>>> So I was expecting to see those btf lines there :-\
>>>>=20
>>>> All the patches up to this point I have already merged and tested in m=
y
>>>> local branch.
>>>>=20
>>>> Will continue right after lunch to try to figure out why this BTF info
>>>> isn't landing on this new header feature...
>>>=20
>>> I've pushed what I have to my git.kernel.org repo, branch
>>> tmp.perf/bpf-annotate.
>>>=20
>>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/b=
pf-annotate
>>>=20
>>> The HEAD is this cset.
>=20
>> I am not sure I fully understand the problem here.=20
>=20
> Trying to say it another way, when I start 'perf record', with the
> patches in your series up to this one ('[PATCH v9 perf,bpf 09/15] perf,
> bpf: save btf information as headers to perf.data'), and while there is
> a BPF program running, that has BTF attached to it as can be seen by
> using 'bpf map dump', 'perf report --header-only' isn't showing any line
> with 'btf' on it.
>=20
> So, using -v I notice that it is failing to get enable attr.bpf_event
> and attr.ksymbol, which makes me go get another coffee to check that the
> kernel was built from my 5.1 tree that has those events and not 5.0 that
> doesn't ;-\ Sorry for the noise, will get back here after I check all
> this :-)
>=20
> But to recap, the BPF events I was getting were the synthesized ones...

Yeah, to capture the short living BPF/BTF, we need patch 15/15 of the set.=
=20

Thanks,
Song

>=20
> [root@quaco ~]# perf record -vv
> Using CPUID GenuineIntel-6-8E-A
> intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
> nr_cblocks: 0
> affinity: SYS
> ------------------------------------------------------------
> perf_event_attr:
>  size                             112
>  { sample_period, sample_freq }   4000
>  sample_type                      IP|TID|TIME|CPU|PERIOD
>  read_format                      ID
>  disabled                         1
>  inherit                          1
>  mmap                             1
>  comm                             1
>  freq                             1
>  task                             1
>  precise_ip                       3
>  sample_id_all                    1
>  exclude_guest                    1
>  mmap2                            1
>  comm_exec                        1
>  ksymbol                          1
>  bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off bpf_event
> ------------------------------------------------------------
> perf_event_attr:
>  size                             112
>  { sample_period, sample_freq }   4000
>  sample_type                      IP|TID|TIME|CPU|PERIOD
>  read_format                      ID
>  disabled                         1
>  inherit                          1
>  mmap                             1
>  comm                             1
>  freq                             1
>  task                             1
>  precise_ip                       3
>  sample_id_all                    1
>  exclude_guest                    1
>  mmap2                            1
>  comm_exec                        1
>  ksymbol                          1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off ksymbol
> ------------------------------------------------------------
> perf_event_attr:
>  size                             112
>  { sample_period, sample_freq }   4000
>  sample_type                      IP|TID|TIME|CPU|PERIOD
>  read_format                      ID
>  disabled                         1
>  inherit                          1
>  mmap                             1
>  comm                             1
>  freq                             1
>  task                             1
>  precise_ip                       3
>  sample_id_all                    1
>  exclude_guest                    1
>  mmap2                            1
>  comm_exec                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 4
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 5
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 6
> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 =3D 7
> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 =3D 8
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 =3D 9
> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 =3D 10
> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 =3D 11
> mmap size 528384B
> perf event ring buffer mmapped per cpu
> Synthesizing TSC conversion information

