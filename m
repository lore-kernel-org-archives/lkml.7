Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F8E20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ZH0UsiIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfC1Sgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:36:31 -0400
Received: from mail-eopbgr810117.outbound.protection.outlook.com ([40.107.81.117]:6468
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfC1Sgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vylG/maNRT5Vk4kMiOPmKTyOvQgEO673l7CMQbi+Qos=;
 b=ZH0UsiIi87+CrbV5gcbE8XA4rfj1iJ1T23o4YHNZvjRqgR50Us3v7WT4v/T0xUGRIbKSODgLyh5sOlquV4FhsE31VPZjsCJy/Vtml/ZXRooqNViQnhzJnc7vKrtOGbhEXT+69cegeRe8DLzzkedwFQ5W18Uirgo6Oqk/EHcfhVE=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1398.namprd22.prod.outlook.com (10.171.210.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 28 Mar 2019 18:36:27 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039%11]) with mapi id 15.20.1730.019; Thu, 28 Mar
 2019 18:36:27 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Chong Qiao <qiaochong@loongson.cn>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QiaoChong <qiaochong@loongson.cn>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
Thread-Topic: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
Thread-Index: AQHU5PH9J8Dd0gxRcUm1uZa7cgDoXaYhYGeA
Date:   Thu, 28 Mar 2019 18:36:27 +0000
Message-ID: <CY4PR2201MB1272AF54E406FAF07A6FAAFFC1590@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190327230801.3650-1-qiaochong@loongson.cn>
In-Reply-To: <20190327230801.3650-1-qiaochong@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::30) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:6e::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ce52ca1-af10-44a8-0c34-08d6b3ac49ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1398;
x-ms-traffictypediagnostic: CY4PR2201MB1398:
x-microsoft-antispam-prvs: <CY4PR2201MB1398FB4036D6B219B3A9DA02C1590@CY4PR2201MB1398.namprd22.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39840400004)(199004)(189003)(33656002)(6246003)(11346002)(46003)(102836004)(4326008)(446003)(386003)(6506007)(186003)(256004)(105586002)(53936002)(106356001)(42882007)(4744005)(9686003)(81166006)(81156014)(316002)(76176011)(68736007)(97736004)(54906003)(8676002)(55016002)(44832011)(229853002)(7696005)(71190400001)(99286004)(71200400001)(52116002)(8936002)(14454004)(6116002)(478600001)(7736002)(5660300002)(52536014)(74316002)(25786009)(476003)(6436002)(2906002)(486006)(305945005)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1398;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cw3aYGirKt5coaijuR8O3+JWBumie1f9NsXYGp0VzfE5SdXcQU3lEcInzW3HGfVsDEidPyDAPZD0N0cuP2P91xaDfOzaWU6X+cU7vnX2OqUp190yrTQm9rDFtu+YC9CMT4a+pg/uATbAG/HajiXTiAV2FGb1cUFv2qopf6DvJ6nkaokW1cVNwWHHIKRyVTfLzo+9QtCSOBRpVLLZgPORUM9hk6YdPubIUuWtwdzA8TpJ6Z7imjNoucrjTLNL8pw5dYbbFaZnC/7pxlVjvtu8BHV7L4GRQHs6hSwFufOqbl8YWM0bHEvE0e2t+mGIMMJkSFz7SZ5IIxhQvJCB540BBpwKBgdTJ06h4rcQc8HCsh7vGqpI/0TaGd03Vk0BkegVujDygc8x2fxGlDKf2vPsyfbwP25JCNvGa7qLjZr8KnQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce52ca1-af10-44a8-0c34-08d6b3ac49ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 18:36:27.5470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chong Qiao wrote:
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
> handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
> to kgdb_cpu_enter.
>=20
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
