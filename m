Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B862147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HpfEKEGH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zj3KqAoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfCKVIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:08:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58176 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbfCKVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:08:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BL5xgE014739;
        Mon, 11 Mar 2019 14:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4j4QWybr7DJ05K6Z1nzQSSIN5bBKoGD4rriqHhpDcVE=;
 b=HpfEKEGHY7UNNIpiRhcchWoOVPUwGVjmups4Pye6k33rCM9qJGMskt0luigu9v0JMgjT
 jiEs+RGY9UipI4eM+lFtHs2cXDrLD1eygDRDms8ELAAHEysh4qcQimAhybwpcTFhom9h
 mJXxrGk35iOaCjmu4nrUxFAAci7tcRjDh9k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5w3srfsv-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:07:54 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:07:22 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j4QWybr7DJ05K6Z1nzQSSIN5bBKoGD4rriqHhpDcVE=;
 b=Zj3KqAoq9Dn5DUkaCE2VGJIbeQs+tid3SPBeqGkFqelTIU3rmZr1LCmDMuNXC+lfZSJv1yHQrwqnzWN9vEctZ2D+WSK9weMahFJIU+cQ1/oE5RV4BOKqOh9V+YNOu7TkIVu3Ma2iqdugBqh1LWMZI/fKBFrtm2MWThgi0ddqNwg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1888.namprd15.prod.outlook.com (10.174.100.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 21:07:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:07:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 10/15] perf-top: add option --no-bpf-event
Thread-Topic: [PATCH v8 perf,bpf 10/15] perf-top: add option --no-bpf-event
Thread-Index: AQHU2EShDF9NwauXz0Ol5cObQ7QoIqYG7EmA
Date:   Mon, 11 Mar 2019 21:07:20 +0000
Message-ID: <B1C5BA9A-20FB-46BA-A4D8-759CBA1C9ABD@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311195555.889995-11-songliubraving@fb.com>
In-Reply-To: <20190311195555.889995-11-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:e2c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a296df23-440a-4797-bfe8-08d6a6658cb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1888;
x-ms-traffictypediagnostic: MWHPR15MB1888:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1888;20:0Q1KwYq2rO+AYqwL1yTp/DepjTWNLESsTJrQ8r4A5XzOui4u0zgGB7z4mvCjIKU9M5mDbjIpbSFMwG5gOil69HxnexLZ2rj9m/NTQiOlrsm3KKEqb6lV2Xl9pk2XsYTjdSiSvui+i6qIIchxlTJPU6pinnRdVIAAwqCZjDD6aG0=
x-microsoft-antispam-prvs: <MWHPR15MB1888E6D0AEA53DE3243EEBA6B3480@MWHPR15MB1888.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(2906002)(50226002)(71190400001)(71200400001)(2501003)(8936002)(110136005)(478600001)(6486002)(4326008)(6116002)(229853002)(54906003)(57306001)(86362001)(97736004)(83716004)(14454004)(316002)(256004)(14444005)(25786009)(82746002)(186003)(99286004)(486006)(7416002)(102836004)(6512007)(6246003)(33656002)(2616005)(476003)(11346002)(7736002)(6436002)(76176011)(53546011)(36756003)(105586002)(305945005)(8676002)(68736007)(81166006)(5660300002)(81156014)(446003)(53936002)(46003)(6506007)(106356001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1888;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4iU0uaN8rf61UFlg2BaqYlaH6lDcaLLOoGexb6DUH6Vt8Jpv0/AS5bQgpxOmwyzpUJnFox7p5BxOj2cxWymLV+8y9/nYHxxd9ijqIK67r9OUDDkW1bw9CyIe7Y6rQeDzJ9J4aRKzlotIxS+lmv3PHSqbl8r7OTA1oUnxpz7S10zZYINt4WR48p8jq0sE1u8zRTVa40uP44X/jqiZdkthL11Ys7738c3vm4uTqqYcGqpSUhRDToS79NZCVoTxo05w+fsAAZnx27ScFgyWmsvAwo2/DHEefr2h2v7Ir5QUDD3u+ZKoq7hQNPMed4HOk/ODuiN86luTMJONHPH+spDFPljMbvSGPFf99LZtnHh7VLBYNH8X5tgCLin/OB1rt3SrwFoSH75yKptU1kf23NyE8vrgsFEmBq+0DLmXnsE2+v4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B77048A9FEF3E9439EDBA741DF544601@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a296df23-440a-4797-bfe8-08d6a6658cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:07:20.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 12:55 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> bpf events should be tracked by default for perf-top. This patch makes it
> on by default, and adds option to disable bpf events.
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
> tools/perf/builtin-top.c | 3 +++
> tools/perf/util/top.h    | 1 +
> 2 files changed, 4 insertions(+)
>=20
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 27d8d42e0a4d..ccdf5689452f 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
> 		    "Display raw encoding of assembly instructions (default)"),
> 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> 		    "Enable kernel symbol demangling"),
> +	OPT_BOOLEAN(0, "no-bpf-event", &top.no_bpf_event, "do not record bpf ev=
ents"),
> 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
> 		    "objdump binary to use for disassembly and annotations"),
> 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_=
style, "disassembler style",
> @@ -1651,6 +1652,8 @@ int cmd_top(int argc, const char **argv)
> 		signal(SIGWINCH, winch_sig);
> 	}
>=20
> +	top.record_opts.bpf_event =3D !top.no_bpf_event;
> +
> 	status =3D __cmd_top(&top);
>=20
> out_delete_evlist:
> diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> index 19f95eaf75c8..862a37bd27ea 100644
> --- a/tools/perf/util/top.h
> +++ b/tools/perf/util/top.h
> @@ -32,6 +32,7 @@ struct perf_top {
> 	bool		   use_tui, use_stdio;
> 	bool		   vmlinux_warned;
> 	bool		   dump_symtab;
> +	bool		   no_bpf_event;
> 	struct hist_entry  *sym_filter_entry;
> 	struct perf_evsel  *sym_evsel;
> 	struct perf_session *session;
> --=20
> 2.17.1
>=20

Hi Arnaldo,=20

Currently, we have bpf-event default OFF for perf-record, with option to=20
turn it ON; while bpf-event is default ON for perf-top, with option to=20
turn if OFF. I think this is a little confusing.=20

How about we set them both to default ON, and add option to turn it OFF?
I think we still have time to make the change.=20

Thanks,
Song



