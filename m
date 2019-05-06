Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E75B206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gycs3UYG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Za//pZ6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEFVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:46:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfEFVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:46:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46LjMhr002671;
        Mon, 6 May 2019 14:46:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ghD8Dktq2s7eS9Znzk1xc3bKUo2g+VQDFH/CDslyG0g=;
 b=Gycs3UYGDKdMfqHnxG1TC1gIZ1yVpQHk+5b3OoiZzaxMEt6lgZ9zEj7o2dsa0+SoeSLz
 9suNRFzqUb8z1CGRIuTuyTkApVP1tjfqhNCxYCXUvaen2Z4zCKymdzJzZil9/UZq3Y+/
 eOHhXwwkm5TphtZ4kxfo70KxXD6Jv3tIKBA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sansmhn01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 May 2019 14:46:05 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 6 May 2019 14:46:04 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 6 May 2019 14:46:04 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 6 May 2019 14:46:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghD8Dktq2s7eS9Znzk1xc3bKUo2g+VQDFH/CDslyG0g=;
 b=Za//pZ6MO/jjwCGOoPtbmFR3nZhD7SNlWfNGoTprY12R+UjbovM0Q4WNIFX4yfJpcxS1tDuDw9r92NR3YhYflXUHmGD3cm1zywt/sGqwd5H36Qs4BUMmm29zxYpzbjvMw0/WOrWOz22VovYx+TJgl4gGlTNqEpylt9H0yJMgdsE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 21:46:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 21:46:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv2 00/12] perf tools: Display eBPF code in intel_pt trace
Thread-Topic: [PATCHv2 00/12] perf tools: Display eBPF code in intel_pt trace
Thread-Index: AQHVAYjlbnBw6w52NEmN8lBTIT7OIKZepx+A
Date:   Mon, 6 May 2019 21:46:02 +0000
Message-ID: <6141A2E9-87CE-4989-B7F1-78B1462DF82C@fb.com>
References: <20190503081841.1908-1-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:f96e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 467950d8-5f5f-44b6-8afe-08d6d26c3c2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1437;
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-microsoft-antispam-prvs: <MWHPR15MB14371C42DA35A788AFDBF020B3300@MWHPR15MB1437.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(6916009)(6436002)(5660300002)(486006)(68736007)(229853002)(102836004)(6486002)(4326008)(86362001)(76176011)(6246003)(316002)(256004)(7736002)(54906003)(53936002)(53546011)(305945005)(82746002)(8936002)(81156014)(6506007)(478600001)(476003)(2906002)(14454004)(2616005)(6512007)(81166006)(57306001)(11346002)(66446008)(64756008)(25786009)(71200400001)(71190400001)(66556008)(446003)(46003)(6116002)(36756003)(66476007)(73956011)(66946007)(8676002)(76116006)(33656002)(83716004)(186003)(7416002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N5k7eiT9C9YyFGg3Cqx+j6eV8CqknmiIcBugiWPQFYwk9mqw5jNillHin8kNcJgtZzZcgR+ZDAMX0iw0a+/5ULPZ25hhePA2/kuWrPBYcW5Ta1XEOhfpkAaVmuYaISdHWDsfAHQEMmfxRVTWpHxpNgl99KtawrKxFWUCWkHJEqzqPqfnSogLW+zbfpOB9bTAeVzAatMjW5TOaghUTUPki2vh4cBLTxWd1ISBbjVNYmpfxWszIYPJviW0Yw6B91cls+7BA2lxJGTwp3WWGT775jKX01W599LZwUMZkOYrG1CenONrIdvnIsGT0PRZS4E5jFDMSOIKo4L9wBlAsoNSUAVZEFE0jJmFaNJ8aggXXOWaDS77Hlzk1tEnEZUFdp33pQvYv08PV57oiznNNTKjqf2yfGWZGbeEbEJoBiQYd5c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A12236604229046B321C91DA4182156@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 467950d8-5f5f-44b6-8afe-08d6d26c3c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 21:46:02.5946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2019, at 1:18 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> hi,
> this patchset adds dso support to read and display
> bpf code in intel_pt trace output. I had to change
> some of the kernel maps processing code, so hopefully
> I did not break too many things ;-)
>=20
> It's now possible to see bpf code flow via:
>=20
>  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
>  # perf-with-kcore script pt --insn-trace --xed
>  ...
>           sleep 36660 [016] 1057036.806464404:  ffffffff811dfba5 trace_ca=
ll_bpf+0x65 ([kernel.kallsyms])               nopl  %eax, (%rax,%rax,1)
>           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbaa trace_ca=
ll_bpf+0x6a ([kernel.kallsyms])               movq  0x30(%rbx), %rax
>           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbae trace_ca=
ll_bpf+0x6e ([kernel.kallsyms])               leaq  0x38(%rbx), %rsi
>           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb2 trace_ca=
ll_bpf+0x72 ([kernel.kallsyms])               mov %r13, %rdi
>           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb5 trace_ca=
ll_bpf+0x75 ([kernel.kallsyms])               callq  0xffffffff81c00c30
>           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c30 __x86_in=
direct_thunk_rax+0x0 ([kernel.kallsyms])              callq  0xffffffff81c0=
0c3c
>           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c3c __x86_in=
direct_thunk_rax+0xc ([kernel.kallsyms])              movq  %rax, (%rsp)
>           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c40 __x86_in=
direct_thunk_rax+0x10 ([kernel.kallsyms])             retq
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89ef bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x0 (bpf_prog_da4fe6b3d2c29b25_trace_return)=
           pushq  %rbp
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f0 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x1 (bpf_prog_da4fe6b3d2c29b25_trace_return)=
           mov %rsp, %rbp
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f3 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x4 (bpf_prog_da4fe6b3d2c29b25_trace_return)=
           sub $0x158, %rsp
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fa bpf_prog=
_da4fe6b3d2c29b25_trace_return+0xb (bpf_prog_da4fe6b3d2c29b25_trace_return)=
           sub $0x28, %rbp
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fe bpf_prog=
_da4fe6b3d2c29b25_trace_return+0xf (bpf_prog_da4fe6b3d2c29b25_trace_return)=
           movq  %rbx, (%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a02 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x13 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %r13, 0x8(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a06 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x17 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %r14, 0x10(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0a bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x1b (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %r15, 0x18(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0e bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x1f (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          xor %eax, %eax
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a10 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x21 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %rax, 0x20(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a14 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x25 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          mov %rdi, %rbx
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a17 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x28 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          callq  0xffffffff811fed50
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed50 bpf_get_=
current_pid_tgid+0x0 ([kernel.kallsyms])              nopl  %eax, (%rax,%ra=
x,1)
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed55 bpf_get_=
current_pid_tgid+0x5 ([kernel.kallsyms])              movq  %gs:0x15c00, %r=
dx
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed5e bpf_get_=
current_pid_tgid+0xe ([kernel.kallsyms])              test %rdx, %rdx
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed61 bpf_get_=
current_pid_tgid+0x11 ([kernel.kallsyms])             jz 0xffffffff811fed79
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed63 bpf_get_=
current_pid_tgid+0x13 ([kernel.kallsyms])             movsxdl  0x494(%rdx),=
 %rax
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed6a bpf_get_=
current_pid_tgid+0x1a ([kernel.kallsyms])             movsxdl  0x490(%rdx),=
 %rdx
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed71 bpf_get_=
current_pid_tgid+0x21 ([kernel.kallsyms])             shl $0x20, %rax
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed75 bpf_get_=
current_pid_tgid+0x25 ([kernel.kallsyms])             or %rdx, %rax
>           sleep 36660 [016] 1057036.806464725:  ffffffff811fed78 bpf_get_=
current_pid_tgid+0x28 ([kernel.kallsyms])             retq
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a1c bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x2d (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %rax, -0x8(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a20 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x31 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          xor %edi, %edi
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a22 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x33 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %rdi, -0x10(%rbp)
>           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a26 bpf_prog=
_da4fe6b3d2c29b25_trace_return+0x37 (bpf_prog_da4fe6b3d2c29b25_trace_return=
)          movq  %rdi, -0x18(%rbp)
>=20
>  # perf-core/perf-with-kcore script pt --call-trace
>  ...
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                kretprobe_perf_func
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                    trace_call_bpf
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                        __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]        =
               )                            __x86_indirect_thunk_rax
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_get_current_pid_tgid
>           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_ktime_get_ns
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]        =
               )                                    __x86_indirect_thunk_ra=
x
>           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]        =
               )                                        __x86_indirect_thun=
k_rax
>           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                __htab_map_lookup_elem
>           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]        =
               )                                    memcmp
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_probe_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                    probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                            check_stack_obj=
ect
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        copy_user_enhanced_=
fast_string
>           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_probe_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                    probe_kernel_read
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        __check_object_size
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                            check_stack_obj=
ect
>           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]        =
               )                                        copy_user_enhanced_=
fast_string
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_get_current_uid_gid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]        =
               )                                    from_kgid
>           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]        =
               )                                    from_kuid
>           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25=
_trace_return  )                                bpf_perf_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                    perf_event_output
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                        perf_prepare_sample
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                            perf_misc_flags
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                                __x86_indir=
ect_thunk_rax
>           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]        =
               )                                                    __x86_i=
ndirect_thunk_rax
>=20
>=20
> v2 changes:
>  - fix missing pthread_mutex_unlock [Stanislav Fomichev]
>  - removed eBPF dso reusing [Adrian Hunter]
>  - merge eBPF and kcore maps [Adrian Hunter]
>  - few patches already applied
>  - added some perf script helper options
>  - patches are rebased on top of Arnaldo's perf/core with perf/urgent mer=
ged in
>=20
> It's also available in here:
>  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>  perf/fixes
>=20
> thanks,
> jirka

Besides minor comments in a few patches, for the series:=20

Acked-by: Song Liu <songliubraving@fb.com>


>=20
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
> Jiri Olsa (12):
>      perf tools: Separate generic code in dso__data_file_size
>      perf tools: Separate generic code in dso_cache__read
>      perf tools: Simplify dso_cache__read function
>      perf tools: Add bpf dso read and size hooks
>      perf tools: Read also the end of the kernel
>      perf tools: Keep zero in pgoff bpf map
>      perf script: Pad dso name for --call-trace
>      perf tools: Preserve eBPF maps when loading kcore
>      perf tests: Add map_groups__merge_in test
>      perf script: Add --show-bpf-events to show eBPF related events
>      perf script: Remove superfluous bpf event titles
>      perf script: Add --show-all-events option
>=20
> tools/include/linux/kernel.h             |   1 +
> tools/lib/vsprintf.c                     |  19 +++++++++++++++++++
> tools/perf/Documentation/perf-script.txt |   6 ++++++
> tools/perf/builtin-script.c              |  56 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++
> tools/perf/tests/Build                   |   1 +
> tools/perf/tests/builtin-test.c          |   4 ++++
> tools/perf/tests/map_groups.c            | 120 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++
> tools/perf/tests/tests.h                 |   1 +
> tools/perf/util/dso.c                    | 125 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------=
------------------------
> tools/perf/util/event.c                  |   4 ++--
> tools/perf/util/machine.c                |  31 ++++++++++++++++++++------=
-----
> tools/perf/util/map.c                    |   6 ++++++
> tools/perf/util/map_groups.h             |   2 ++
> tools/perf/util/symbol.c                 |  97 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> tools/perf/util/symbol_conf.h            |   1 +
> 15 files changed, 421 insertions(+), 53 deletions(-)
> create mode 100644 tools/perf/tests/map_groups.c

