Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E507C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261952068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HCz9wHJ9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="k2xSirc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVSYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:24:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61326 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfKVSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:24:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xAMI3btD002763;
        Fri, 22 Nov 2019 10:23:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hkkCJoMaKkAtJbdv5mLpSqHauDXslEWxZLmwIltR1+o=;
 b=HCz9wHJ9STaY+E9p1HFgvqa61KO3ImUy0l1/1zxodNf+aQA8SLsTnNFXgfJ5oXKK9XSI
 bDJ0Vqn2M36BElOGoAxQiAozj9w4c+rrCBrimPUA2gCqokA2mMVhfRDLxrkuI+0Lnlhl
 elDPLWTLozw7rU3hqeM1xc6PooAnz9K4p04= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wdtbk7jk0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Nov 2019 10:23:01 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 10:23:00 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 10:23:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkdduoGUCo+YHQmQavqDVt+oYn0FpEOJZ0A6ajCX0s+cP+BvifBYaxNSjy5iTuFWMaKy1hFiNW+iexCb3rXdkktgpKdFIhRwr5o9TlrnrDLmZTkXq5oeptcp51ua0o9GnhT/6HTzhPA7GSPrzZU1eoO1DnwkTn1KX8xEl14pIZIA9kMkpULc/cIdH9Sfs4JvJGt+kvb1ZMwbFVFG7TjPZ+ls3WhtOk/xoGiG0quufSmT8OTvrflxy/4RY6JDgXfFdfxMgyZrxLa7yR7PYU9zHyP9BuS3QxGdicsMDz6iZPb40U3Itw8y/LFH6cspT6RftjkK9i68zGneke9ra7G6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkkCJoMaKkAtJbdv5mLpSqHauDXslEWxZLmwIltR1+o=;
 b=fMFII6M+Xa3a70IscM0L+UlVMtPmeYRVvo49Vnm1Wt9w35W8SKebDC8NY44Y1lWfCVYnvfM4eioPMLz3or4UhcO7gQ17K+zODHsUBzwgkWYt81IycoZFThHtzKzF8JyVbyle+cfD4AfwH7VPOHgP2pcx4b3tekbtHbJoT6rqq6xwDcpqnO+OPVT/YD5KZsUmgJ3tRr9L9XfsKCnb+76C2CJ3SkjXYlr5yo5w2zpbruoy1DUvcgogA8xSp2mpfo4iL8q3wonECaz34T8rsGxUvTyqsb/mNZ/fzlTDYL9TaMGoRCZU3ts6ulbpDqQCot0dv1SoqR6WPztGT9tij2Dklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkkCJoMaKkAtJbdv5mLpSqHauDXslEWxZLmwIltR1+o=;
 b=k2xSirc3Qt6OpT49hw4j9B68AbJ7IYRVpTBHueVCz4uqP4YRI3Jqg7ayuVFGKSFEOttQSRcf2czabUWDZYNE600mOSRntKB6534aAAmP6YqzvMsRZYupG5OjUunb9RPH82WY2r4QucpKNdbbUmgL8eIirPx8t7+TP16gWxyP22Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1695.namprd15.prod.outlook.com (10.175.142.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Fri, 22 Nov 2019 18:22:59 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 18:22:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     syzbot <syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Josef Bacik <jbacik@fb.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in perf_group_attach
Thread-Topic: WARNING in perf_group_attach
Thread-Index: AQHVoVH25/qmk/NwcEW4gb8ew/muWqeXgRcA
Date:   Fri, 22 Nov 2019 18:22:59 +0000
Message-ID: <0338F995-1B84-4825-A7C9-ADDC0076A5F2@fb.com>
References: <0000000000004c40290597f1e91e@google.com>
In-Reply-To: <0000000000004c40290597f1e91e@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::ec92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a1fd92-1bfc-440e-81b3-08d76f7900e7
x-ms-traffictypediagnostic: MWHPR15MB1695:
x-ms-exchange-purlcount: 8
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB16955890F5D19623916851ADB3490@MWHPR15MB1695.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:59;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(51914003)(2906002)(86362001)(81156014)(229853002)(6246003)(6512007)(81166006)(6436002)(6306002)(76116006)(8676002)(46003)(305945005)(7736002)(36756003)(966005)(50226002)(478600001)(66946007)(66476007)(8936002)(14454004)(6116002)(99286004)(7416002)(66446008)(64756008)(66556008)(53546011)(102836004)(71200400001)(54906003)(25786009)(186003)(6486002)(33656002)(316002)(6506007)(71190400001)(76176011)(4326008)(446003)(5660300002)(11346002)(256004)(2616005)(7116003)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1695;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfvGVGly+3hLS0uDS2FPYU1d+baURc8VC1+3e1u7/2quBKdhAOJ0GPoiW2H4t3rTKPlsHUb7Sstr14aiCJYxTX9xnG005g8se4/+eYzFrQEfGEJKewnwIqTrngt/GjoK1RXwjfhWZPo2kg+Dt5K92v8yvsGV8Kc3chiKLAK8SEv9buLnjPXyGDWhk4OQChYKii8Ae/y09Lp8TC15w4UblV+6JCzyojZM+QM5ULyS7qyI7uvllu+zp0pdHwY4paAa/DcN7ERNJGCA62KA265VgMW5T30aUpi31AHeh3QQu1fOzJzOGerBWrXw+9d2ifbbp4MouIoNayJgmh9TDq/bU1BPV01mk698jc+4TrtA66mi/wLfFuGDHPNal51Hmk6Lnm3hRsjn/CQCn1+fCqZ/zOnpnmWGwhACDfrB5wPY6bR1JCVDLYG+FFgSoEqRtJFrg8rUBoQSCp99yLNLsdrGYKPhcuCrQ4QLW6g38y3K1dIOZXKs266yjbU8eEQM7GMimSfJoqsYVHf8VON6yzY6CvAw/b/af71XQtGlRhJrKFE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2605F40DA10A744B88305CC30376015A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a1fd92-1bfc-440e-81b3-08d76f7900e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 18:22:59.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2AXkL7mC9B4HMGBrMotjEOpZh0B4w7BRJBD4lsdWqQGNeHHpOhSRJKvpGLzyXmzqWiuP9cqFPOH6qwyOTdKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=972 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2019, at 8:29 AM, syzbot <syzbot+23fe48cbe532abffa52e@syzkalle=
r.appspotmail.com> wrote:
>=20
> syzbot has bisected this bug to:
>=20
> commit 33ea4b24277b06dbc55d7f5772a46f029600255e
> Author: Song Liu <songliubraving@fb.com>
> Date:   Wed Dec 6 22:45:16 2017 +0000
>=20
>    perf/core: Implement the 'perf_uprobe' PMU
>=20
> bisection log:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sy=
zkaller.appspot.com_x_bisect.txt-3Fx-3D1038fecae00000&d=3DDwIBaQ&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o=
7mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM&s=3D3ABayY9CyfQkmQs0KgB2fcFws0p7utMNa=
7tcrLE0b4Y&e=3Dstart commit:   0072a0c1 Merge tag 'media/v4.20-4' of git://=
git.kernel.org..
> git tree:       upstream
> final crash:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sy=
zkaller.appspot.com_x_report.txt-3Fx-3D1238fecae00000&d=3DDwIBaQ&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o=
7mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM&s=3DCZ1NX6DT4kikiKc9qfHrpHrBGrPBNOzUU=
wcp-avrDlo&e=3Dconsole output: https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__syzkaller.appspot.com_x_log.txt-3Fx-3D1438fecae00000&d=3DDwIBa=
Q&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J=
4&m=3Dtwva4o7mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM&s=3DGbwfq2mU_2xkXjM2LVOht=
4iV94BqNlAVlldmf99YE2o&e=3Dkernel config:  https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__syzkaller.appspot.com_x_.config-3Fx-3Db9cc5a440391cb=
fd&d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjC=
E6S0spDTKL-J4&m=3Dtwva4o7mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM&s=3D80FYgyg5l=
xOA80Ae-t5h5madX7fI4JOulTaVL6A5OIE&e=3Ddashboard link: https://urldefense.p=
roofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.com_bug-3Fextid-3D23fe=
48cbe532abffa52e&d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHS=
IOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o7mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM=
&s=3DCLG4xu3n98RYL4iBP5vb_BVLur-IxZkzQf5KMgJKEBQ&e=3Dsyz repro:      https:=
//urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.com_x_re=
pro.syz-3Fx-3D135e93eb400000&d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3Di6Wo=
bKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o7mjqFOvS4tIPaO-5jjo-XAwT9=
qjmMqY7gRsLM&s=3DrE9GDnbBf2V3RMoW8TmNFJxPVfG2W27IzFAQ4534Yok&e=3DC reproduc=
er:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.apps=
pot.com_x_repro.c-3Fx-3D13189415400000&d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MU=
w&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o7mjqFOvS4tIPaO-=
5jjo-XAwT9qjmMqY7gRsLM&s=3Dzu43yb0MPn0VZeQKwG-EDUHqYYgHgJhJrRcYp6dl-dE&e=3D
> Reported-by: syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com
> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
>=20
> For information about bisection process see: https://urldefense.proofpoin=
t.com/v2/url?u=3Dhttps-3A__goo.gl_tpsmEJ-23bisection&d=3DDwIBaQ&c=3D5VD0RTt=
NlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3Dtwva4o7=
mjqFOvS4tIPaO-5jjo-XAwT9qjmMqY7gRsLM&s=3DYWXIJgdau0PZoF8t4mWq-2xQY88lKIzCF0=
JnR-ZM4Ao&e=3D


Thanks for the report. I will look into the fix.=20

Song=
