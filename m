Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BCCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9252067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sf5JJTzs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Rc8Dvcqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfKANYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:24:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12600 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbfKANYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:24:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA1DOiqE012334;
        Fri, 1 Nov 2019 06:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZZXh0+SUa3bL+u29y19hfsgkqBs+Na9FYzOBeaqeBSA=;
 b=Sf5JJTzs7NdwBV4NmT9kkswnTrRXBHxHhHNhAbkplnbUVgaJihJ9Agkv++iKnQjyAGCH
 meCvOIIwInOEyfuZlqM4ty5p6UszGzML9E/wU+6msRDp8KlBt7KozrdZnsxcRrVRKqtz
 6AbcU+23XpP37AhHlUbNziQjGMTXqDuqcRQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w00t55v1p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Nov 2019 06:24:47 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Nov 2019 06:24:21 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Nov 2019 06:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG+xcZJPMQu5QvE5nsmtJk74gO8uBRfK5F4CyM4HyMfW/TKzyQc0unD8hWHv4Ay3Q7Ee8N27icEIWMQHggg/dQWpkdnOVpgP1Wb85Gv0ROaNB++ynbcw4oe94oJUQ7CUuHa9p0kXcePdsycQ1g4MK91MrxBcg1bOFoUjbChwG2ilkUR8UaWkQRLKIvLwlYjaPrmeWxrv9damMxsiA9WUtARYmE/vwjO0ImMgoG5J41HV5C2vVx6mytyvVa6rthuTxDYM652euU1w9NYN5tieMVEFPCN89gFBjYj1oUSMjV8vGg4W6CUE3IBZkLZK//yLrVg5m7QLhaJ/U90uWtk2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZXh0+SUa3bL+u29y19hfsgkqBs+Na9FYzOBeaqeBSA=;
 b=m23Ou0K5f+tcKMzG3b8oKGDNuTrUMZ4WNKQihmwPmKDwNU4OB8yRTVba68viZKw8+xggYKpVdpo0LKpRoCrVZ9ItmA206YbEktVhE7ZH4gN0nNjgF2N/YhESEgrhRwNlLu0esyTgmISeV1NHcT1yPBhKW0OVR5twvY43TaopgvBDtVgBvE3mMfvivIKecShJKe3/pv+DtJPE03AVG6vp+ZKsJT2BPxh+msOyAYBzYG3hSGUo/ExXz0bpXCRsBEZeaALYn4a1kQPfh9RDeTOnyHtbPYnPAJqvHgfng+NHCylNTLO6pc59D52Mp8RL6vSuq2bOaDEaMzoZYj3UDH9MVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZXh0+SUa3bL+u29y19hfsgkqBs+Na9FYzOBeaqeBSA=;
 b=Rc8Dvcqu1q9Ta8yoJ8KxG2byHbIrjJYTleuP7vfsZG+9Be0x6pgpx+vjnMIhEcaZe0w6fp3kLSJaWFyyXSX0PWGp2uGRrP6BaI1MsnMZZq92t/L39ijN4kcbZSNzWeSf3KMPOOU+xXRwNH7341rcycim4NUxBLHRriS46E7i+Ng=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.65.158) by
 SN6PR15MB2416.namprd15.prod.outlook.com (52.135.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 13:24:18 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 13:24:18 +0000
From:   Chris Mason <clm@fb.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Kyle McMartin <jkkm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
Thread-Topic: [PATCH] audit: set context->dummy even when audit is off
Thread-Index: AQHVkAncrhonQVVxy06vYxt2pY3gVKd1ZVQAgADp5wA=
Date:   Fri, 1 Nov 2019 13:24:17 +0000
Message-ID: <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20191031163931.1102669-1-clm@fb.com>
 <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
In-Reply-To: <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.10r5443)
x-clientproxiedby: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:24::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::f277]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 052d569e-46f3-4008-d9fd-08d75ececc2a
x-ms-traffictypediagnostic: SN6PR15MB2416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB2416612FB068C7EBA24F046FD3620@SN6PR15MB2416.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(51914003)(52116002)(8936002)(76176011)(66446008)(71200400001)(305945005)(6436002)(66556008)(33656002)(50226002)(7736002)(8676002)(81156014)(102836004)(81166006)(64756008)(66476007)(6486002)(71190400001)(478600001)(25786009)(46003)(5660300002)(14454004)(229853002)(256004)(386003)(476003)(99286004)(6246003)(14444005)(316002)(6506007)(2616005)(6916009)(53546011)(36756003)(54906003)(4326008)(186003)(66946007)(446003)(2906002)(11346002)(486006)(86362001)(6116002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2416;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtFpG6LdmOGnfTG7uxTYGsx70JDiRsg9OQ54e173gJU6zEGXBpDmjHRoWFyFHUNvmp4kaOdOa1M/vVnGx9b1XlgNlbwJLJ9RGVx93ByXPvTmOsJ7ZeygUViCl33sc36HR5vV4hr/TTF5GOW5YKrjYAe0uHJqnul73ORVZhN3fMlgo/uQbiXAOQEkH5n+dmEpX91XsO2SToGSAbqvIYwCSGqLQ96ne/NlxqmCmvbccUvfoadMUfUa3ydLTAyyoqv+RpiYJaH0KzelPyeNRxQ7n7uh1OrVMXhaksp+NJgqq6H86FL7us3AhrQU/kaG5HMqMQT+YRaFFfWDn3/gQTdqyz+VdNBGbOMAdhxxbHh6BZESSbVnXlov+n68VFbUnMllkUfBeksjNCbkialL5RJnOxtw4NWQiOda+UrMJvUR+s7e97mZkFLNicN/3Z6W/fDV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 052d569e-46f3-4008-d9fd-08d75ececc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:24:17.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcHSE22ZnOXuSo82ujCJVsVd6qzP5skPC9KtZWh8RsvH5FlYIqORIR1AJiOp7L+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_04:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 2019, at 19:27, Paul Moore wrote:

> On Thu, Oct 31, 2019 at 12:40 PM Chris Mason <clm@fb.com> wrote:
> [ ... ]
> Hi Chris,
>
> This is a rather hasty email as I'm at a conference right now, but I
> wanted to convey that I'm not opposed to making sure that the NTP
> records obey the audit configuration (that was the original intent
> after all), I think it is just that we are all a little confused as to
> why you are seeing the NTP records *and*only* the NTP records.

This part is harder to nail down because there's a window during boot=20
where journald has enabled audit but chef hasn't yet run in and turned=20
it off, so we get a lot of logs early and then mostly ntp after that.

I feel like the answer is that most of the places that actually log=20
audit records are also checking audit_enabled.  Poking a bit with=20
cscope, we're not using most of the places that rely only on=20
audit_dummy_context().

I grabbed the last week or so of audit: lines from netconsole, and most=20
of them (73%) were type 1130 from early in the boot.  These are the ones=20
turned off when chef runs.  Another big chunk were the one time audit=20
initialized message from boot, mostly reflecting our rollout of the new=20
kernel.  After that it was ntp and couple of random things like=20
fanotify.

>
> It's been a while, but I thought we suggested Dave try running
> 'auditctl -a never,task' to see if that would solve his problem and I
> believe his answer was no, which confused me a bit as the
> audit_filter_task() call in audit_alloc() should see that rule and
> return a state of AUDIT_DISABLED which not only prevents audit_alloc()
> from allocating an audit_context (and remember if the audit_context is
> NULL then audit_dummy_context() returns true), but it also clears the
> TIF_SYSCALL_AUDIT flag (which I'm guessing you also want).
>

Thanks for the reminder on this part, I meant to test it.  Yes, auditctl=20
-a never,task does stop the messages, even without my patch applied.

-chris
