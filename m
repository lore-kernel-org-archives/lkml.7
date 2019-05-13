Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5865C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C95A20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MKclIm69";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XRvugWw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfEMREF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:04:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730002AbfEMREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:04:04 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DH41bV030117;
        Mon, 13 May 2019 10:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=j3j/rn2fnUQSGulhq+o5BZic2pM4QFoMHBCIdragw48=;
 b=MKclIm69VpeaX3QJSNz0xCi+IaoEaVP4xnE+/Dvpb91utRu87VG8sdV3PTcpYDv/mCS4
 cIJRt7+on5srfa6PARxWcxboBfHFHyLZUQxz1OOOCTpjlulVwfmMsjEEMoIye9hANjAu
 FOj9rCmjJwPbnwaRQjNRJ4mccBrkJD/RI2w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfafbgja1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 10:04:02 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 May 2019 10:04:00 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 13 May 2019 10:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3j/rn2fnUQSGulhq+o5BZic2pM4QFoMHBCIdragw48=;
 b=XRvugWw1fv0A3BZ0LPxKZ3tMrVSBMWg/tccFZ4fLdKEK2TnxCIHNjf1FK08AWqdyiHISi1beN5uh/AnlkXLjUbKQHdGf12ajyC36ADpSMp14AFB9Cn2KS7kGjWs6q6AegLl2iCfJj+kfx3+WKIXs/yP45dIZSazCyxKhnDYDzD8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 17:03:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 17:03:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer"
 (76f969e)
Thread-Topic: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer"
 (76f969e)
Thread-Index: AQHVCSoMi3vTppklSEy7VGeoXNz2TaZpSV2A
Date:   Mon, 13 May 2019 17:03:58 +0000
Message-ID: <20190513170354.GB10982@tower.DHCP.thefacebook.com>
References: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
In-Reply-To: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0020.namprd22.prod.outlook.com
 (2603:10b6:301:28::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b4b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c25e417-6857-4fca-279c-08d6d7c4fd41
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2631;
x-ms-traffictypediagnostic: BYAPR15MB2631:
x-microsoft-antispam-prvs: <BYAPR15MB26316498BA25259C4174EFA2BE0F0@BYAPR15MB2631.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(52314003)(68736007)(186003)(102836004)(6512007)(9686003)(14454004)(99286004)(486006)(76176011)(478600001)(52116002)(476003)(54906003)(6506007)(46003)(11346002)(446003)(33656002)(386003)(81166006)(8676002)(81156014)(66476007)(66556008)(64756008)(66446008)(6916009)(2906002)(66946007)(6436002)(305945005)(6116002)(73956011)(229853002)(6486002)(7736002)(25786009)(8936002)(1076003)(5660300002)(71200400001)(71190400001)(4326008)(53936002)(6246003)(86362001)(256004)(14444005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2631;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z5ItmpqZph8pWofrf3C5wlAKRXWRu0dvHNIRH/U/dX7lqEflXObiXnAJ6UN5x3OQaULNggAwHNPnKv46gAcH5KF4ZBWO2tx0NaPFzqxrsggcIJMkxUko4aapU9FkYobD7Bl14j+NPgDyRJnisrHTNscan7sTF5ETJrMV+/KH70UoD/1fvrR1Hno8uSsdOnNC3ALiPpgRIuB3V1lEakQOOC4w0afcq0i+gpJr4xeVfLucWcCdm0DvqycK9XpnmPZ3FcSPQ0Nxzc0znPVZGqhi/osuiJIq6b/9N4JXGkxx6asA2RqcrQWQF7HUYvvwCDlGvgidpls/rWAHrGukRA8NxKUhZAW26kciB/KOWQ8rt/ivs2W+xAIIsswMMM09E70TxKGrNoK/wuJ5Eg9QuCc+RPFVuEuR9QBfnOrxh4aAp0o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0ED03F7E52C8449B40B9AB3EED8246B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c25e417-6857-4fca-279c-08d6d7c4fd41
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 17:03:58.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2631
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex!

Thank you for the report!
It's super clear, and contains all the details, so it took me 30s
to reproduce the issue. Really appreciate your effort!



On Sun, May 12, 2019 at 09:20:12PM -0400, Alex Xu (Hello71) wrote:
> Hi,
>=20
> I was trying to use strace recently and found that it exhibited some=20
> strange behavior. I produced this minimal test case:
>=20
> #include <unistd.h>
>=20
> int main() {
>     write(1, "a", 1);
>     return 0;
> }
>=20
> which, when run using "gcc test.c && strace ./a.out" produces this=20
> strace output:
>=20
> [ pre-main omitted ]
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> [ repeats forever ]
>=20
> The correct result is of course:
>=20
> [ pre-main omitted ]
> write(1, "a", 1)                        =3D 1
> exit_group(0)                           =3D ?
> +++ exited with 0 +++
>=20
> Strangely, this only occurs when outputting to a tty-like output.=20
> Running "strace ./a.out" from a native Linux x86 console or a terminal=20
> emulator causes the abnormal behavior. However, the following commands=20
> work correctly:
>=20
> - strace ./a.out >/dev/null
> - strace ./a.out >/tmp/a # /tmp is a standard tmpfs
> - strace ./a.out >&- # causes -1 EBADF (Bad file descriptor)
>=20
> "strace -o /tmp/a ./a.out" hangs and produces the above (infinite)=20
> output to /tmp/a.
>=20
> I bisected this to 76f969e, "cgroup: cgroup v2 freezer". I reverted the=20
> entire patchset (reverting only that one caused a conflict), which=20
> resolved the issue. I skimmed the patch and came up with this=20
> workaround, which also resolves the issue. I am not at all clear on the=20
> technical workings of the patchset, but it seems to me like a process's=20
> frozen status is supposed to be "suspended" when a frozen process is=20
> ptraced, and "unsuspended" when ptracing ends. Therefore, it seems=20
> suspicious to always "enter frozen" whether or not the cgroup is=20
> actually frozen. It seems like the code should instead check if the=20
> cgroup is actually frozen, and if so, restore the frozen status.

So, the thing is that when the freezer tries to freeze all tasks
in the cgroup, some tasks may sleep (e.g. being SIGSTOPPed),
and the freezer can't get them out of this state and put them back correctl=
y
after unfreezing. So instead it leaves such tasks in the original state
and treats them as frozen. This is why we need this unconditional
cgroup_enter_frozen(). It's not the problem.

Anyway, I'm sure that with great help from Oleg we'll be able
to fix the issue very soon (I already posted a preliminary patch).

Once again, thank you for the report!

Roman
