Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD8C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3715D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nfBksAXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfDWRwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:52:13 -0400
Received: from mail-eopbgr790113.outbound.protection.outlook.com ([40.107.79.113]:2304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfDWRwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XiugHCmrQRiF7RFBG1yjeLPURULlzrMoP/GGJ/HpEQ=;
 b=nfBksAXk5bRqeIDoQp32abuIFRBGK0McgU7QlHPddaYA1lmrOIE1E40M4sJBHrczx1TUkfS78mvNVgq5skCu+jEi7WakElDEI+JpdEy0Bg6zOswK1733VG5HK+zaGkgnZIi8k7l3EtTjpvulkUjm1dCxuopNEiD4pl9HE/5i5A8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1087.namprd22.prod.outlook.com (10.174.169.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Tue, 23 Apr 2019 17:52:06 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 17:52:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "Vadim V . Vlasov" <vadim.vlasov@t-platforms.ru>
Subject: Re: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Thread-Topic: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Thread-Index: AQHU+dCYLc0FOHZW+USx3qmHwO4wf6ZKBuCA
Date:   Tue, 23 Apr 2019 17:52:06 +0000
Message-ID: <20190423175201.z7qfs2r5znx6uq5t@pburton-laptop>
References: <20190423123122.32573-1-fancer.lancer@gmail.com>
In-Reply-To: <20190423123122.32573-1-fancer.lancer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a8da22b-6082-49d4-d03e-08d6c814667a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1087;
x-ms-traffictypediagnostic: MWHPR2201MB1087:
x-microsoft-antispam-prvs: <MWHPR2201MB1087472F1291AE7923D8FA38C1230@MWHPR2201MB1087.namprd22.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(396003)(39850400004)(136003)(376002)(199004)(189003)(33716001)(6486002)(2906002)(8676002)(478600001)(66066001)(76176011)(81156014)(1076003)(229853002)(68736007)(52116002)(26005)(53936002)(81166006)(6436002)(97736004)(66946007)(25786009)(66476007)(6512007)(9686003)(73956011)(66556008)(64756008)(66446008)(186003)(42882007)(44832011)(54906003)(71190400001)(305945005)(486006)(316002)(71200400001)(6506007)(386003)(58126008)(4326008)(11346002)(7416002)(476003)(446003)(6916009)(14454004)(7736002)(8936002)(14444005)(256004)(99286004)(6246003)(6116002)(102836004)(5660300002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1087;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1czuyezDR7T1C6d/jTufLOT/VKC5noPwi+SxbR7g3Cm5fAGug7rcKGTrAClirWgPEpKmPJmvDqOu+UgRHLtKeB4Qm25XvpoDLbM5SBLWQ6El1KKloZZ9QSjKbrrWHijaFudX8hYkF+87P5XBPHtEqC38Ja9efaDSHayw3HXtBDh0XyACwPZ0ylt11Syueb5R29vua8H9vfVo2gXhnx3khie4RnooHkcJs58FI1Rq17ZHx7Fmd9uHwKI2D5cXrv0TYct6tI1iX1sEmohPYBS2N9+YuuOTOo60it0j8ySsDrnuIrM1/Cm9rtiBE7Pg4jeCwWVpAvDrmTFW05+JALr9jiv3h5G930v8xCeg70Xq2mf9fge4gr6yyLa9LUAtnp1g7YhVOGh52eV9O1k55UhaEJoZ+Pg1Hm/gI+jXDiN/HL4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <075AA6938F3D3945A0C8201A14729658@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8da22b-6082-49d4-d03e-08d6c814667a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 17:52:06.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Tue, Apr 23, 2019 at 03:31:22PM +0300, Serge Semin wrote:
> Since commit 4b050ba7a66c ("MIPS: pgtable.h: Implement the
> pgprot_writecombine function for MIPS") and commit c4687b15a848 ("MIPS: F=
ix
> definition of pgprot_writecombine()") write-combine vma mapping is
> available to be used by kernel subsystems for MIPS. In particular the
> uncached accelerated attribute is requested to be set by ioremap_wc()
> method and by generic PCI memory pages/ranges mapping methods. The same
> is done by the drm_io_prot()/ttm_io_prot() functions in case if
> write-combine flag is set for vma's passed for mapping. But for some
> reason the pgprot_writecombine() method calling is ifdefed to be a
> platform-specific with MIPS system being marked as lacking of one. At the
> very least it doesn't reflect the current MIPS platform implementation.
> So in order to improve the DRM subsystem performance on MIPS with UCA
> mapping enabled, we need to have pgprot_writecombine() called for buffers=
,
> which need store operations being combined. In case if particular MIPS
> chip doesn't support the UCA attribute, the mapping will fall back to
> noncached.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Vadim V. Vlasov <vadim.vlasov@t-platforms.ru>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/gpu/drm/drm_vm.c          | 5 +++--
>  drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Looks good to me:

    Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
