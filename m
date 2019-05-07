Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7477AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEED205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YHIxNHX0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mVNBml0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfEGRly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:41:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1358 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfEGRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557250913; x=1588786913;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Aqfv8bte4O2HcYt0lff9qDyZKmFB7VFpc9htTQrvi/o=;
  b=YHIxNHX0yflBfCQnTZCDEJMc0oUBxzg+Sof4TgncfZAC184MgP5LaqcC
   oRAgHLNdesoIZxNOnXxC7aR9bjcf0cRUDewtIWpuBm47r8Sf27mFB7emU
   CFMPfLf3xEsKuxXlQPfYDMyZzbxzDbryv9cfbiLuTg3ArPv/xsOuO5tJ6
   7pcF9looWc0TlA55N7rAqMdc3cesjlcOfQ8HYh60J15BSvTWuYX3ZYZ4V
   epQfc7iGo4TRFbGgfMuvLpNCe91X138dhXCqQZOwNOqUBVdibCh9hw1oN
   Yeqj7aq4wmSYItUMOYug98VRs7aiJbY5gozRDy+sLBjIgZdNv2WAkxFrf
   w==;
X-IronPort-AV: E=Sophos;i="5.60,442,1549900800"; 
   d="scan'208";a="213720204"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2019 01:41:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cw455upwGHUtAwzNgQ5TKUtUfYSxxp3STqZPa+xYtc=;
 b=mVNBml0DeDG1zAu1TJ7hJJHcr7zPSZsyw2ZRTHzJFNpOGqsxtgT366PJIyk51QK3acy32UDdRoyZ5ROBE2BnYs3hU7GvuyscC9hi6Gh376qfzvFf9Z+W0KQGEpep8ByZRRENiO+zpe8uznGrOyk1f53mofrfoiwMg/NuHBuO7BQ=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4158.namprd04.prod.outlook.com (52.135.71.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 17:41:51 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 17:41:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: mark expected switch fall-through
Thread-Topic: [PATCH] nvme-pci: mark expected switch fall-through
Thread-Index: AQHVBOB79kdJ84ToAkqBJNoy4OB4Dw==
Date:   Tue, 7 May 2019 17:41:51 +0000
Message-ID: <SN6PR04MB4527B0A6917F74B5C241FD0F86310@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190507142300.GA25717@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4afcc66-6e02-4829-e513-08d6d31349b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4158;
x-ms-traffictypediagnostic: SN6PR04MB4158:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4158841C38489E1FB46EA29486310@SN6PR04MB4158.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(68736007)(446003)(110136005)(86362001)(9686003)(8936002)(478600001)(81166006)(316002)(74316002)(72206003)(52536014)(14454004)(6436002)(54906003)(8676002)(55016002)(76176011)(7696005)(33656002)(229853002)(66066001)(81156014)(476003)(256004)(26005)(14444005)(53546011)(71190400001)(71200400001)(4326008)(305945005)(99286004)(53936002)(25786009)(186003)(6246003)(7736002)(102836004)(6506007)(5660300002)(73956011)(3846002)(2906002)(6116002)(91956017)(76116006)(486006)(66946007)(64756008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4158;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e7vRaO42a6cNTaLtSQ+rYa92Y8ync5EWwNlACo2pIuuXzekJI8fYh1B8PnsgfMLvU6pvag3kZXQZuBO3aIUqyr/k6RioeoTmLUGYWANgeXn2Lo7Nrkz1KbVYTSm/hx9vmx7kkBK5ovoP7LreIcBXYdIOkQRVA71qVYAhJdNxIYVjuoZ9SCKduLE11RAfxYvqGuj+4aky1Xltu1D9rbve1Ae4Qc9wtZWxtSoiZU8h/HtevZP4mAXRxgMV/pckFmJX3bR87mysboNquRrzw/r7xzY8qs+jc+9KxMF0W0ct/UHq+q81PIabSYZ8CiGbwE/q1NJCGZFnWh97R/DKhvgIobR/nQkZ8XwULcVr56fKwIn2+Flt1bfUMxFJVsLJqIU5HTuPS80WXvZx5gKJ9IWOkYd6zVfrbvQUyw9U/f7GDgA=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4afcc66-6e02-4829-e513-08d6d31349b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 17:41:51.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/7/19 7:23 AM, Gustavo A. R. Silva wrote:=0A=
> In preparation to enabling -Wimplicit-fallthrough, mark switch=0A=
> cases where we are expecting to fall through.=0A=
>=0A=
> This patch fixes the following warning:=0A=
>=0A=
> drivers/nvme/host/pci.c: In function =91nvme_timeout=92:=0A=
> drivers/nvme/host/pci.c:1298:12: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]=0A=
>    shutdown =3D true;=0A=
>    ~~~~~~~~~^~~~~~=0A=
> drivers/nvme/host/pci.c:1299:2: note: here=0A=
>   case NVME_CTRL_CONNECTING:=0A=
>   ^~~~=0A=
>=0A=
> Warning level 3 was used: -Wimplicit-fallthrough=3D3=0A=
>=0A=
> This patch is part of the ongoing efforts to enable=0A=
> -Wimplicit-fallthrough.=0A=
>=0A=
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>=0A=
> ---=0A=
>  drivers/nvme/host/pci.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 3e4fb891a95a..a12f992868c9 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -1296,6 +1296,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req, bool reserved)=0A=
>  	switch (dev->ctrl.state) {=0A=
>  	case NVME_CTRL_DELETING:=0A=
>  		shutdown =3D true;=0A=
> +		/* fall through */=0A=
>  	case NVME_CTRL_CONNECTING:=0A=
>  	case NVME_CTRL_RESETTING:=0A=
>  		dev_warn_ratelimited(dev->ctrl.device,=0A=
=0A=
=0A=
