Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A0C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 02:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ECD2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 02:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="brWeMyLD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DO5iNocv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJBCBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 22:01:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfJBCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 22:01:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x921tfBZ020542;
        Tue, 1 Oct 2019 19:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iGzTiQTbUnMvbH+R4GW5eQ9XjhcqwWqo8nOkULnR/n4=;
 b=brWeMyLD+AFFXwwd525/vuhE0+aG/MlH5oKENtjrO8wqrLFshY8h2oD0Am8zQ+WlaG3C
 1cCIEF/IdCpPJ5+TSuBnaOnbitBt5epz1McT0Unjqz76M1RC2CdFDXOOL8TXzYBJRV+e
 btzMDRbIVUEKduR3M/VWprodUVyiG9mHOlc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vcasbadju-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 19:01:10 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 1 Oct 2019 19:01:09 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Oct 2019 19:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMqiNOaDs3LEt4d9PEVI8KTj1p2XPrRD0wK6WSlYijIjob1zIjuJBcxtFonIqGxtv8i0HHpQW3xioMJq5k7NgBr74edHlteWyP0xtR3YLQDWWopP8nBMTmQ7mSu/FUxOnBuerGfD3fmGpmSFP7tbWJCaOeysBFLq7F3cKfUfE0mkJodhiL72PpX2dkwCyGGssmv+NDdB0GwcwZxAIV0HXkVAj2UIew9bDQ/eTVs4Kg29GRQRbpV5eZw+vKsWhfJ9ZOuHfnlRnmgDmWnfo5NwVXL+ihKmaU7hRc/8rJQN9+9LCrCY0lnwVzomoIkktLQQhi0KDR30b7f4XPYwd7bJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGzTiQTbUnMvbH+R4GW5eQ9XjhcqwWqo8nOkULnR/n4=;
 b=kCnyS45JgYnQygbz1ePtciZyYesUYl9q5mxYKwFk/s7D6nsVq91YM93mOvov325H+Jp0tQ4KEH6Vb8XbMSU3KBOGTV0gBu9YglAJlGo3njZJS2dj8ofJdRe+yA5RAF+SD+yPYBCsyWUjjTdzd0+jqhFzdkscBEJHz/n43CBU3l8ssA9NcffSG20rT02LZThHTaQVctRJyljlRr94MtsMPgbYpZq11DHO4XNhhuZUb4PZJlQz9BBNsdPMqHNoRwPdKyu4PJ7C3tyDiy5YSc39lr8L4DdGHdMXD1iKP9RZgOFxII6r6eT9Qt4BIo/Mxo+QuzltKaqkEdlwvrBSMBokwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGzTiQTbUnMvbH+R4GW5eQ9XjhcqwWqo8nOkULnR/n4=;
 b=DO5iNocvSEYY/wodw1Isi0PyWjZpyCHJjiuwUDmAC1YIlhEX1+6gc7RBWNyy79BFLyvcYjJETCTlyAxxuqZou4DJaNXiOyi3aW2ldYp/gd0KaEhJUxrvq4dQYhxGSPg1kFUxWGkpMVGgosMw0jpSWIxdMZgTXaphIvMl02EJOAs=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3268.namprd15.prod.outlook.com (20.179.76.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 02:01:07 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 02:01:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bruce Ashfield <bruce.ashfield@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Topic: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Index: AQHVeHNRdeEItaYf7UK2FXG2TrAmk6dGmZIA
Date:   Wed, 2 Oct 2019 02:01:06 +0000
Message-ID: <20191002020100.GA6436@castle.dhcp.thefacebook.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
In-Reply-To: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::dca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16cc2908-24ba-4f3b-49f5-08d746dc62bb
x-ms-traffictypediagnostic: BN8PR15MB3268:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR15MB32684611AFB69CC84EFA1341BE9C0@BN8PR15MB3268.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(53754006)(71200400001)(99286004)(71190400001)(446003)(11346002)(8936002)(1076003)(478600001)(476003)(6916009)(66446008)(64756008)(66476007)(66556008)(66946007)(256004)(14444005)(52116002)(6306002)(102836004)(81166006)(33656002)(8676002)(81156014)(14454004)(6512007)(9686003)(6506007)(386003)(6116002)(7736002)(6486002)(5660300002)(966005)(6436002)(305945005)(229853002)(186003)(54906003)(25786009)(486006)(6246003)(46003)(76176011)(316002)(86362001)(4326008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3268;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i84sJvExZrg0ZooCzrISyXgXtwgZ5Ez3ZaVguuQs0XjNs4qZccxu/l8cUIxTLvjUrnzjQtkyp0JhCkghwwCFD3YL128EdJyjhbdlbZs3oe4zHQfJGd3RIUZ2rWLtQcTZ3PZxTHiZfK1nJ5MjOAQTet1CabfC93WRndQvD+A1HEl+l+Toz4BumN3injb6am2vKvF1OhehwWTQ2PhI69QHbkihcM9XMhostyhh1hcWlmFAtc+8b0p65O6TFkBimLJmrGtKYT6Imln6MqBI4VBPiPdd81LjQG5fVXOth8IvL2Z5K4wh8mohD7F4Qp2ZN6weWmzkD/q6w0h11XpROQpZ+oU6k2I9aqtwcFDlD2ebiqueAT6iiyyA00w5vP2PfqzHxg1lXRoZOrlymC12gQUxiwyZbeMGW9BQRc3KA1X0U18N2Dxd3NBZjPldxUx8c/yMYP0RQt6i42wRoA2KQAmjxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0E2973C5D1D5E4CA46170E77B1FA33B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cc2908-24ba-4f3b-49f5-08d746dc62bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 02:01:06.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRuswW+Qla5nOKtNZimuS+F1KEr3NC9nhjWuYtweop2wXmaxt7OuJ6O4ZV3sVSQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3268
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_01:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020016
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> Hi all,
>

Hi Bruce!

> The Yocto project has an upcoming release this fall, and I've been trying=
 to
> sort through some issues that are happening with kernel 5.2+ .. although
> there is a specific yocto kernel, I'm testing and seeing this with
> normal / vanilla
> mainline kernels as well.
>=20
> I'm running into an issue that is *very* similar to the one discussed in =
the
> [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
> thread from this past may: https://lkml.org/lkml/2019/5/12/272
>=20
> I can confirm that I have the proposed fix for the initial regression rep=
ort in
> my build (05b2892637 [signal: unconditionally leave the frozen state
> in ptrace_stop()]),
> but yet I'm still seeing 3 or 4 minute runtimes on a test that used to ta=
ke 3 or
> 4 seconds.

So, the problem is that you're experiencing a severe performance regression
in some test, right?

>=20
> This isn't my normal area of kernel hacking, so I've so far come up empty
> at either fixing it myself, or figuring out a viable workaround. (well, I=
 can
> "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
> but obviously,
> that is just me trying to figure out what could be causing the issue).
>=20
> As part of the release, we run tests that come with various applications.=
 The
> ptrace test that is causing us issues can be boiled down to this:
>=20
> $ cd /usr/lib/strace/ptest/tests
> $ time ../strace -o log -qq -esignal=3Dnone -e/clock ./printpath-umovestr=
>ttt
>=20
> (I can provide as many details as needed, but I wanted to keep this initi=
al
> email relatively short).
>=20
> I'll continue to debug and attempt to fix this myself, but I grabbed the
> email list from the regression report in May to see if anyone has any ide=
as
> or angles that I haven't covered in my search for a fix.

I'm definitely happy to help, but it's a bit hard to say anything from what
you've provided. I'm not aware of any open issues with the freezer except
some spurious cgroup frozen<->not frozen transitions which can happen in so=
me
cases. If you'll describe how can I reproduce the issue, and I'll try to ta=
ke
a look asap.

Roman
