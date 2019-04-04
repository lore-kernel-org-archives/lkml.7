Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4423C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DFC206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XL5ljrhJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PYCG0e3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDDRJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:09:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41924 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbfDDRJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:09:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34H81gt012207;
        Thu, 4 Apr 2019 10:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jTEmRvU3yGYU7Q/a+UH/jAotaMPf82WXgBWPphpniHk=;
 b=XL5ljrhJCCjwCuQXY626yhQLyeR0P7ilBsUgAJbmGTi5/6o8UsdKKPdtmzM/Td45ChOm
 ufCHPxT9WCWdk6iiU6756i5UWQWmEGz6Nu/5XPTOqCsQHM/N9WP3WIpIp3eNzW0F+bh3
 LHZMP1Xol76cJro2lDa2hedvTJXrmg+XjZ4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnmfegdtg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 10:08:59 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 10:08:59 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 10:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTEmRvU3yGYU7Q/a+UH/jAotaMPf82WXgBWPphpniHk=;
 b=PYCG0e3RSRChNwDU7jN4Z3EqLaP8QA8K8hoL53wXA+vjOw2feiUP/9lt9tclPNXYEKfQaP9Gzb9MRJNFPpCpX7KKbNjEv7Q+AxcR8TIwzmhklFsoLCxTcNZy3VjkgvVw2h589q401640PiPAnqYJC7l3X7k/P53G7sluHOVSvLI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1309.namprd15.prod.outlook.com (10.175.3.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 17:08:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 17:08:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Thread-Topic: [BUG] perf: intel_pt won't display kernel function
Thread-Index: AQHU6irWpD85AOHzLkautxj0S1Vk3aYqhcaAgAAGHwCAABQngIAAJ/GAgAABOgCAAAFHAIAALxYAgAC/vgCAADVTAIAATy8A
Date:   Thu, 4 Apr 2019 17:08:55 +0000
Message-ID: <678C87FF-A33E-477C-94C1-533026400B95@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
 <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
 <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com> <20190404091438.GB31233@krava>
 <20190404122530.GC31233@krava>
In-Reply-To: <20190404122530.GC31233@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::3:a772]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a8dfe3b-cd85-4593-8778-08d6b92038b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1309;
x-ms-traffictypediagnostic: MWHPR15MB1309:
x-microsoft-antispam-prvs: <MWHPR15MB13096822041885EE22B17A83B3500@MWHPR15MB1309.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(189003)(199004)(7736002)(14454004)(33656002)(229853002)(6436002)(6246003)(81166006)(11346002)(476003)(2616005)(6486002)(8676002)(316002)(54906003)(82746002)(99286004)(478600001)(6916009)(5660300002)(93886005)(105586002)(81156014)(57306001)(446003)(86362001)(256004)(106356001)(8936002)(102836004)(486006)(6506007)(46003)(186003)(4326008)(76176011)(53546011)(6116002)(25786009)(71200400001)(36756003)(6512007)(68736007)(53936002)(71190400001)(305945005)(83716004)(50226002)(97736004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1309;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G/owWcj/j6w/SvxBiKGSYTf/BXF1EaHstWoI+cIvLk229TrnrGL2He+GoeAQjLRgZ3IKAw7s8DrUrUL3OXdChpytuG4beOJrHT0dWjpmaSMtFUriCCb/y0GkETZIdlQQp/+kPxMmjk2mtZ0/iioH9fw5SQAA3aYiCL+q/TZbBh1i+f6TighivqU4WaLeiKEqjumbt1U8YQDpDuNTferL6P+wwGvpn9eXWfxA6/2z6BdE+ukFSTj73BCrfBqPcbZ4s6I2cQtpV7TidB6v0s6JQKF5IMTAY5kJ6x6cZTNVgJ+BQd6x/b3je8196uXuTkSZZyNlD76uH2IuAgwXK5DC+9JpJxcbIhFpEfrJaszgZfOO07a0zJ4NYPW3GVxwVl7g0S+GoY2H+WrGdfu4JzsYYWISPwhtWo+Y/kHjtTB0HRo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79B68D7AA593E54C907727DF2CAD93EB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8dfe3b-cd85-4593-8778-08d6b92038b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 17:08:55.8428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1309
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 4, 2019, at 5:25 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 04, 2019 at 11:14:38AM +0200, Jiri Olsa wrote:
>=20
> SNIP
>=20
>> Program received signal SIGABRT, Aborted.
>> 0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
>> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6=
-29.fc30.x86_64 elfutils-libelf-0.176-1.fc30.x86_64 elfutils-libs-0.176-1.f=
c30.x86_64 libgcc-9.0.1-0.10.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libx=
crypt-4.4.4-2.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 perl-libs-5.28.=
1-434.fc30.x86_64 python2-libs-2.7.16-1.fc30.x86_64 slang-2.3.2-5.fc30.x86_=
64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
>> (gdb) bt
>> #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
>> #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
>> #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so=
.6
>> #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
>> #4  0x00000000004fc006 in refcount_sub_and_test (i=3D1, r=3D0x1224e88) a=
t /home/jolsa/linux/tools/include/linux/refcount.h:131
>> #5  refcount_dec_and_test (r=3D0x1224e88) at /home/jolsa/linux/tools/inc=
lude/linux/refcount.h:148
>> #6  map__put (map=3D0x1224df0) at util/map.c:299
>> #7  0x00000000004fdb95 in __maps__remove (map=3D0x1224df0, maps=3D0xb17d=
80) at util/map.c:953
>> #8  maps__remove (maps=3D0xb17d80, map=3D0x1224df0) at util/map.c:959
>> #9  0x00000000004f7d8a in map_groups__remove (map=3D<optimized out>, mg=
=3D<optimized out>) at util/map_groups.h:65
>> #10 machine__process_ksymbol_unregister (sample=3D<optimized out>, event=
=3D0x7ffff7279670, machine=3D<optimized out>) at util/machine.c:728
>> #11 machine__process_ksymbol (machine=3D<optimized out>, event=3D0x7ffff=
7279670, sample=3D<optimized out>) at util/machine.c:741
>> #12 0x00000000004fffbb in perf_session__deliver_event (session=3D0xb1139=
0, event=3D0x7ffff7279670, tool=3D0x7fffffffc7b0, file_offset=3D13936) at u=
til/session.c:1362
>> #13 0x00000000005039bb in do_flush (show_progress=3Dfalse, oe=3D0xb17e80=
) at util/ordered-events.c:243
>> #14 __ordered_events__flush (oe=3D0xb17e80, how=3DOE_FLUSH__ROUND, times=
tamp=3D<optimized out>) at util/ordered-events.c:322
>> #15 0x00000000005005e4 in perf_session__process_user_event (session=3Dse=
ssion@entry=3D0xb11390, event=3Devent@entry=3D0x7ffff72a4af8,
>>    file_offset=3Dfile_offset@entry=3D191224) at util/session.c:1402
>> #16 0x000000000050091e in perf_session__process_event (file_offset=3D191=
224, event=3D0x7ffff72a4af8, session=3D0xb11390) at util/session.c:1529
>> #17 process_simple (session=3Dsession@entry=3D0xb11390, event=3Devent@en=
try=3D0x7ffff72a4af8, file_offset=3Dfile_offset@entry=3D191224) at util/ses=
sion.c:1962
>> #18 0x0000000000501f44 in reader__process_events (prog=3D0x7fffffffc680,=
 session=3D0xb11390, rd=3D<synthetic pointer>) at util/session.c:1931
>> #19 __perf_session__process_events (session=3D0xb11390) at util/session.=
c:1985
>> #20 perf_session__process_events (session=3D0xb11390) at util/session.c:=
2018
>> #21 0x000000000045bb42 in __cmd_script (script=3D0x7fffffffc7b0) at buil=
tin-script.c:2429
>> #22 cmd_script (argc=3D<optimized out>, argv=3D<optimized out>) at built=
in-script.c:3770
>> #23 0x00000000004a65cb in run_builtin (p=3Dp@entry=3D0x994918 <commands+=
408>, argc=3Dargc@entry=3D4, argv=3Dargv@entry=3D0x7fffffffe160) at perf.c:=
303
>> #24 0x000000000042da1e in handle_internal_command (argv=3D0x7fffffffe160=
, argc=3D4) at perf.c:355
>> #25 run_argv (argcp=3D<synthetic pointer>, argv=3D<synthetic pointer>) a=
t perf.c:399
>> #26 main (argc=3D4, argv=3D0x7fffffffe160) at perf.c:521
>=20

For some reason, I cannot repro this issue. I tried to load two
bpf programs with same name, but that doesn't trigger it either.=20


>=20
> we dont increase the map's reference for same name,
> which we need to.. I assume we we re able to hit this
> path with bpf maps/dso with same name
>=20
> jirka

Does the following change fix the issue on your side?

Thanks,
Song

>=20
>=20
> ---
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 58ae5fc1f0e9..cdc49113ba38 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -929,10 +929,11 @@ static void __maps__insert_name(struct maps *maps, =
struct map *map)
> 		else if (rc  > 0)
> 			p =3D &(*p)->rb_right;
> 		else
> -			return;
> +			goto out;
> 	}
> 	rb_link_node(&map->rb_node_name, parent, p);
> 	rb_insert_color(&map->rb_node_name, &maps->names);
> +out:
> 	map__get(map);
> }
>=20

