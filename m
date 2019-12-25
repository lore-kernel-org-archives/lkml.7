Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955BFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555142075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="A8fWj9Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLYJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:46:38 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:17565
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:46:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrmLkqn+4BR6a2sIFfh1ji6LVW1uot84iyPqntgLJLyaZB6DJ9Ieezy3qyGt23CHNAzzJBJoZeqpIE2ImNOFW8YdpKGxg9kwWzBBQRPhPs1F2V1DnrPLiDlNOMVRGndBxRWAwNm6LzWQRGM/7L27j8X8aaUTROKzJQHgSlcmMNYlTqvRegX1aeFxoTB22dGhdRfKnyGJZWnyxwZ1dWV8Oku/qiu19KXR7otvZGdw7aSwvTNSOwOLwG3CoZBWkwU1CJ4l0jNvD1yRyK7RejXzFL/0rLRKYOzaH1N2P3NnvCNRZijydQ8H/E0/cue5dCqPUyrqwpWo5nFstfPZirKyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TqOMncd1vfU0rllJ6s8uoTsr9k6wCFQtQn38evfM4o=;
 b=jWZiciXg8lxer9W4YXyKehEPWqotQtOGxCGX0iO2zjJ5rLH9OE7W1VNxEUPFVJibbPU4+qPcx9zBDtZTZQl4o2P6hizsaVncyPMKniSdCNRQza9hAMuBZcZIAVl2BYWa9W4nvWrU8ipvZc8Wo5PeO+jYXqVcYb5dhVmosCq9DqSJARXqRDPe+s8ugjhj8dokLeX5dzHMgp+34hO3UXnc5aaTzWiIzp+A4RETExin5p2ko240Xy3IOOuI3b/9s/lHfq2QaeZvvSX6RJs+xz7B7MlKrdpQWtcyuA78wRfzGZjrEhk7K2EbF+t/BVt4AjfS5zeGaSCWFewHsJmr6oyAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TqOMncd1vfU0rllJ6s8uoTsr9k6wCFQtQn38evfM4o=;
 b=A8fWj9IlaEoJOJ2IPfLfRFq5D0uJbJRLd7ul9VskpaYmrt5NtbnuqI84/3TEBcQyKuyL0HUt3ZaKybaoscH22hgM3G3M5/6LpIzkywlY9eSTGV6vAni9wuYdrRzu+qEtjK5QsS3Tln16QeeDvomSTsuxrZlBRibZ7Mqg+ThmAVo=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4213.namprd03.prod.outlook.com (20.177.185.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 09:46:35 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 09:46:35 +0000
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0125.jpnprd01.prod.outlook.com (2603:1096:404:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 09:46:30 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Thread-Topic: [PATCH v7 1/3] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Thread-Index: AQHVuweSj3f0oMePuk6TgrRxmwYaVafKlliA
Date:   Wed, 25 Dec 2019 09:46:35 +0000
Message-ID: <20191225173219.4f9db436@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225172752.70be1dc1@xhacker.debian>
In-Reply-To: <20191225172752.70be1dc1@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::17) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed5490c-1162-42e7-cb88-08d7891f544d
x-ms-traffictypediagnostic: BYAPR03MB4213:
x-microsoft-antispam-prvs: <BYAPR03MB42131697C319F42A7FC2481DED280@BYAPR03MB4213.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(43544003)(9686003)(1076003)(5660300002)(86362001)(55016002)(66476007)(956004)(66946007)(66556008)(64756008)(81156014)(8936002)(81166006)(8676002)(66446008)(16526019)(71200400001)(2906002)(26005)(966005)(186003)(52116002)(7696005)(7416002)(6506007)(4326008)(316002)(54906003)(110136005)(478600001)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4213;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnRFQVUuUZRaT/zjuNDGY8Tm35lnzZxbWyKBFUn0aAzriZXPCz6INhB5QecP/Sk9MFv70DdZ4O3uvgY7Q2us7EHuGTLkUF4IZZOeGITsltHk4i2ATHy7Ns6q9e0wxQRwPFXJEhwEpI7SdYHBTz0rVXRzVWwDCkcIFc0pjy2SxhJV3KU4fB5pRrBGIJoR0QywuGWj8qKueY/f5EBX/fBHL447ik6cN5A2Ghxk2JR4af0nxcxgtjAxhULyuS6ZZRWMfCD0Ypz+vC7sIx4dqjtisnUSlhwFzieHGOxLzLjFuE3VXn9lrMBet7f5F1/8WPYBAdPwjDD31BGuoH7DAH4X0s5um6l25TXs/ROH8c8LgWSY4I00quhjshTPUTlZyhkYoA7y6bcu/qEIxFjNihEuO2jlTaimMWprYc7VWdLCT/pKDqw/xRZaZeBKWJXbggv5NYSADVbjH4NxvvrgkU3WUmq/gOtY1hPTlGyqOLgq7sH+JogZcO4Gyb3KOBvFKwHXUqLlZO4BduPKUsM/nCGZybirlFXud6JLjWASUchPQfCDGmwah6ghFJOvuWe6XyO6n/Oa690yML9N7J1Y5XgXn2eSJoMmi3vbud+BSxDKeXw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5B2FE87FEB60E41A195114D4D37126D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed5490c-1162-42e7-cb88-08d7891f544d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 09:46:35.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/Lwn3bbWU2FnnKwyXMgZXVAsjNRpsJ4XygQXaBfh+VPQXwyi/qVOxQxuMtP+HAjSF6Zw6UUrmV1p4MDWj7VYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019 09:42:07 +0000 Jisheng Zhang wrote:
>=20

oops, I missed "From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>"

I will take care this point when posting new version.


> Ftrace location could include more than a single instruction in case
> of some architectures (powerpc64, for now). In this case, kprobe is
> permitted on any of those instructions, and uses ftrace infrastructure
> for functioning.
>=20
> However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
> up ftrace filter IP. This won't work if the address points to any
> instruction apart from the one that has a branch to _mcount(). To
> resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
> identify the filter IP.
>=20
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 53534aa258a6..5c630b424e3a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -986,9 +986,10 @@ static int prepare_kprobe(struct kprobe *p)
>  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>                                int *cnt)
>  {
> +       unsigned long ftrace_ip =3D ftrace_location((unsigned long)p->add=
r);
>         int ret =3D 0;
>=20
> -       ret =3D ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
> +       ret =3D ftrace_set_filter_ip(ops, ftrace_ip, 0, 0);
>         if (ret) {
>                 pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
>                          p->addr, ret);
> @@ -1011,7 +1012,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, st=
ruct ftrace_ops *ops,
>          * At this point, sinec ops is not registered, we should be sefe =
from
>          * registering empty filter.
>          */
> -       ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
> +       ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>         return ret;
>  }
>=20
> @@ -1028,6 +1029,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *o=
ps,
>                                   int *cnt)
>  {
> +       unsigned long ftrace_ip =3D ftrace_location((unsigned long)p->add=
r);
>         int ret =3D 0;
>=20
>         if (*cnt =3D=3D 1) {
> @@ -1038,7 +1040,7 @@ static int __disarm_kprobe_ftrace(struct kprobe *p,=
 struct ftrace_ops *ops,
>=20
>         (*cnt)--;
>=20
> -       ret =3D ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
> +       ret =3D ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
>         WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n"=
,
>                   p->addr, ret);
>         return ret;
> --
> 2.24.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org=
_mailman_listinfo_linux-2Darm-2Dkernel&d=3DDwICAg&c=3D7dfBJ8cXbWjhc0BhImu8w=
Q&r=3DwlaKTGoVCDxOzHc2QUzpzGEf9oY3eidXlAe3OF1omvo&m=3DBG5GowWc97yveg-i3gFbh=
3N7PDT3S3FwcxnpOSRpvIs&s=3DplWeJUToTNi5CWx998a_VbVx3eFc-MNhUNv4fLpmyiU&e=3D

