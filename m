Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FEB20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="f5824T8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCSXSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:18:25 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:4221
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfCSXSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izcBs2hzVnuTrlWdwtG4mzAiI0ExusZxmkq/Wz+kO+0=;
 b=f5824T8AnAcmDnT1pIIK6ir8lbj/7DmiuWaBYEihRdZMNR+Enw+K1yQIUhuSyJQVXg4SPCrvaBMR4YVY8S2o/myLE5JTzXkzrc6wo4QF29P5CHvulNOjeHegTiAzPHdZo2izgnu3qH4kVeDfJJSqaDnlesbkTu3q6brC92aL+EE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1741.namprd22.prod.outlook.com (10.164.206.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 23:18:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:18:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hassan Naveed <hnaveed@wavecomp.com>
CC:     Paul Burton <pburton@wavecomp.com>, "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] MIPS: uasm: Add div, mul and sel instructions for
  mipsr6
Thread-Topic: [PATCH v2 1/3] MIPS: uasm: Add div, mul and sel instructions for
  mipsr6
Thread-Index: AQHU3qoKnky1nrL8HkiECGsISOYoxg==
Date:   Tue, 19 Mar 2019 23:18:20 +0000
Message-ID: <MWHPR2201MB12775596A8378F6FA7EFCDD0C1400@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190312224706.6121-1-hnaveed@wavecomp.com>
In-Reply-To: <20190312224706.6121-1-hnaveed@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3f6291e-bbcb-4418-1308-08d6acc12cde
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1741;
x-ms-traffictypediagnostic: MWHPR2201MB1741:
x-microsoft-antispam-prvs: <MWHPR2201MB17410E4C175FD4D8AB6BD552C1400@MWHPR2201MB1741.namprd22.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39850400004)(376002)(199004)(189003)(68736007)(446003)(316002)(105586002)(256004)(71190400001)(66066001)(7736002)(486006)(25786009)(97736004)(74316002)(54906003)(106356001)(71200400001)(52536014)(305945005)(4326008)(52116002)(6862004)(5660300002)(6506007)(33656002)(102836004)(11346002)(6436002)(2906002)(14454004)(4744005)(229853002)(7416002)(55016002)(6116002)(26005)(386003)(186003)(478600001)(99286004)(8676002)(3846002)(476003)(7696005)(44832011)(81156014)(76176011)(81166006)(8936002)(53936002)(9686003)(6246003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1741;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2iXll+a5JpuhvBaEvCfbkTtbTSAj2cYCDjqdxhh38MHVBl/ygusfkveBGL13njUrXdwlF9VYkAnzCiM/5p9znIeNLOwArAKQOQiWA/8cm9WVbDMzJpAvPRsuiZ9cMEdrZbUyNB3jiiRp9s9wkhB2l4Gca/KLet29n347QrPHZvRonzMfgVQd8lWgQiJwyPvbPki/KlWLQGZnDEdbCVaO7M6WlmwgsJo+mte2CMXkdV10iXSf/OZaO96v2i9yzyBdcjlfgMyzMXbHA29dmLdmfIVOr682B0AFH85z9W0B63XRSwhMu8hqeJOmCtQxVYtn6NiqwIjHzCVCQ6OZ3OyuKv+E5eCvUyBzKKgGIsz/28paVzYKVUck2I13/gjJuhe4/0lmmLb4bDF1RP5uj0UY+EX+AFEF9zJGIAC3n/yG6+U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f6291e-bbcb-4418-1308-08d6acc12cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:18:20.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hassan Naveed wrote:
> Add the following instructions for use by eBPF on mipsr6:
> insn_ddivu_r6, insn_divu_r6, insn_dmodu, insn_dmulu, insn_modu,
> insn_mulu, insn_seleqz, insn_selnez
>=20
> Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
> Reviewed-by: Paul Burton <paul.burton@mips.com>

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
