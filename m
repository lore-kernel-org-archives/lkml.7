Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B21C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ED0208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CIlJTyCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfLKKT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:19:59 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:50881
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbfLKKT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:19:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnOHf9LLwvn43vaw4sKksjmtle0Cc5DYXYHaQFD+eQVTBPZN5uTJXSCPUOpP2U2Wft8mpMNGbA9DpQyKcxamhLjGd63VHm+ZbpizZgLp6XEoz2iUMWx1XDxqNl8rAuX+dQJ2hST3PKrPJjCPoQVvQU6YSNZfBkSt3RmbiyU51Bg36VkDR8qdoISXFfLFB5r2rSnI/HGilUFsTCclUgIuOxeDoMFszPvNGu2/Tc/ojBsnMhXsl+jLObomL2dfMHoq980evfEsHlQ4FWrKaj8k1tvUQz7banF/mI+eqzBscfqLRESy0kvf3I3nOcbJ2kgqqdvFKppJAylKxpV7n2xxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfufeS59T+nyMFEN+B6hSKfqdty75siR46FOnsV+EJE=;
 b=mx0bVbdFPd5B66MLCnGaAiGX3R+9xgA775sijf8N82QnUEIzxLf6si8ILkkvPebOJaPgreKpuJZdm60IkmWGByqNkwQq7TBoklFRdIPGXJktk5zNl1RM55MCT254VqpHetcByRNa0jQgAdaX0nAVQMYfftftvSXQY2fZBu2jpsIv9tvIx5szm1vwKBIJOM205Dg4G1DcWodPkdhtXYqF55krn2mBJxtrKRCycUXYqCjBwkeOx5mSIMVsyS+FjNJAEE5r4Vwr4CAU1B/udoH+b0yJ1sdtLnGjfBrMOqCE6DE46bfz+Rruk+NV6+brGbc1XRcxdD+LWer1hlaQGJoorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfufeS59T+nyMFEN+B6hSKfqdty75siR46FOnsV+EJE=;
 b=CIlJTyCls5DXHPXty9I8zwY3uzUlfz6AFckYEIoehCb5MbvItEsLGeK8qKlMhjK/aol7A5n9BsjV9Rkn5HzmHBOlLeYHMn5w7sslaiZXLIxWAcFvsBdmtUoNDPBH7l1CrN1q31mMP3NqWO6liwxi/tIX5PG9xjVmAu/ZKMIL8gI=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB7071.namprd05.prod.outlook.com (52.135.39.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.9; Wed, 11 Dec 2019 10:19:55 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 10:19:55 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Thread-Topic: [PATCH] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Thread-Index: AQHVc1sNmr3ysv/LaEaIooNrIvLsMg==
Date:   Wed, 11 Dec 2019 10:19:55 +0000
Message-ID: <MN2PR05MB6141CA532CFFE7A8C519797FA15A0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20190925043800.726-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7033cad8-5390-45c7-4c97-08d77e23aae5
x-ms-traffictypediagnostic: MN2PR05MB7071:|MN2PR05MB7071:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB7071D100073ED55E2B93265CA15A0@MN2PR05MB7071.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(4744005)(6916009)(478600001)(91956017)(76116006)(6506007)(186003)(55016002)(86362001)(7696005)(5660300002)(52536014)(54906003)(66556008)(66946007)(64756008)(66446008)(66476007)(316002)(33656002)(8676002)(2906002)(81156014)(8936002)(71200400001)(81166006)(53546011)(26005)(4326008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB7071;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ST5WzQnSbTMMXPoy7CXejiTIrY0BZjId/obh0+OshlrZ19Y0DXQEPiVog+aHmnYilTZDc71Ocst/9xznlTwAssa8LnvaVEGgmjlhjMkcZ6oZMm+EkGAC+1DOT62pODjjyLQGBNZ+JEclTBApIQwq+U22yn3kaQf2/jbDL/Fmg3H07gcW5s5CmMAx5C5M0P8wxBdB3V1PpT9j1KhxkzpQXC5qlj/TXKboXnliEWi3/9T5VuuuwZAhJhoe1h2CEv/YUpCmAhpGZwXSbg3SBTum+nAw7L0BRppz0WcJmnFIw7U65KQy8CQ9+adZk4QmP75csEsoHt0ia22zH4MFW0dXnntZAB1OnGKZ6ctTrvbto++udLqxU+JPC5BUyQQgdxo555lGg20DjPkoANrfVv5aluOYNfH58+SkremaMyXa6e4AJcvAlH+KjHv1YzPQpscW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7033cad8-5390-45c7-4c97-08d77e23aae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 10:19:55.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGQx+3H7q7hhTU/cLXfYZ+S/TFTlIl6wW0h4oQiBTgsdnrnFb+cQvIKHyQOuD7xk0dZeI5s8VG0sZvTknHBGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 6:38 AM, Navid Emamdoost wrote:=0A=
> In vmw_cmdbuf_res_add if drm_ht_insert_item fails the allocated memory=0A=
> for cres should be released.=0A=
>=0A=
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>=0A=
> ---=0A=
>  drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +++-=0A=
>  1 file changed, 3 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_cmdbuf_res.c=0A=
> index 4ac55fc2bf97..44d858ce4ce7 100644=0A=
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c=0A=
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c=0A=
> @@ -209,8 +209,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager=
 *man,=0A=
>  =0A=
>  	cres->hash.key =3D user_key | (res_type << 24);=0A=
>  	ret =3D drm_ht_insert_item(&man->resources, &cres->hash);=0A=
> -	if (unlikely(ret !=3D 0))=0A=
> +	if (unlikely(ret !=3D 0)) {=0A=
> +		kfree(cres);=0A=
>  		goto out_invalid_key;=0A=
> +	}=0A=
>  =0A=
>  	cres->state =3D VMW_CMDBUF_RES_ADD;=0A=
>  	cres->res =3D vmw_resource_reference(res);=0A=
=0A=
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>=0A=
=0A=
Will be part of next vmwgfx-next pull.=0A=
=0A=
Thanks,=0A=
=0A=
Thomas=0A=
=0A=
=0A=
