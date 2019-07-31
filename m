Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D299CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4382067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZPpFSDob";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VdTD4e+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfGaXwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:52:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24357 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564617129; x=1596153129;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0jugi6R6yt+JMn7B88Zg9DpVNRJL/2ijx9bu8ENLwCA=;
  b=ZPpFSDobfZ9lDsz8RF1mQaTb4dqF2WIF5vsKsEQjwIBpfFtfsK38HUh3
   GbRsYhF945toncfuGn7k542/VonRioyLOZGDXAKLTj0GL6PYOALy690f6
   dZIus1lwJV5nLcNLtFrAXqy7bNfQwWWqgqaHgOBvALHVYistsCHk+HIVS
   ThTMHpq26h6waaPMixoi+c9vESBNwyYHduGS+YpChS9UHgZBabHVk9ozy
   Q18X9TWPYctbCCShHT/++WI8Hw27Gu4HbzmQY5usJRzBBQjtT1EnS0X1E
   e6XuI+8R8HomfwjzwiF692z3E4/kWn5BulPoZZq30UOnqvoineGhmy1cp
   w==;
IronPort-SDR: UGDWHMxGWdhRT3JdA1QeW7lf46f0O7zb1jbYR9FDQ64+qszRmb79OkttOFmot3UBcMUJdGOKs5
 fOZyNYgiOwprXxYuByJWQmQirdy5/gbeDP70QYIoC4wnutlAMpozem5k7Vju2MWz3y8RtTqXSn
 EX5ic6u6tLO/0NM6kRHM3ZaPxdcU468+7M+cses3cWb0HRLBL/03p6T4GTWzUA3GW1roR7lU/V
 OEfCJOvMVYo2dwKWVKtQFF8vLIJWR6SsnUkck7i0gg+PF38kO/BXEslhpNdbEKZ6OSjHOqJGnI
 xPQ=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="114646344"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 07:52:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7B4c7c4U5j3jmuaUlXUsp0aYetVyXGSFE6aX14ZvOum++/z9xgGaGLqENTQswSJ+XmfjfVRfI0B/uNZNEMUHIvNIC3ThRY1c6uyRtZfSmKUSD/Cq+8NccRcTPimUDubpXHOw5rPiBwdP5hl+kjLg4r+EKLQCIqzjfp3t2LVJbXxPy/nskOxQX+fphSGrwLRk/MzUv327LHO0msk9KpxoFYTlM/zkPFj3zTSLWNB4/S1tqsX4t14XflZHeA+Ut4z8kJ10yAp5jQXY9ZN7nQa5H0tbQIdjFxlvteN5oua8SggUQHKYkUoTSG5xjiUJB7uHU9WQXHAAni0acStKU9j/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dCp6gT0TxqPtwu0PE3gMzoLyJxtC1OWFC1y1MLQRuc=;
 b=c5+pV7c2Ml9eBbwOw7YlYmZWiIU2UQlGEOmCbPkgpFt2vlJTRGH/NHr6fUJcUxzLgqXkRlD1PaySyTw1UwT/4LQKbJAqkeoXW5D8JUn8RLfhIpnRVbzH7v+SOo7bzuZKQIgXfrUYEBFH3T0YxfVZ41ih6AB+gGBfVDpHB/evsoXg6yFiP+r/NKWPg+pEMgzGUQQoKuFkS85cVsui+WV6C7tQC1acpKeL2AB7oUAllRC4hevfAlncG6gfrsPi2TFjpXa+1ZGZMBiFiE4YKgTV9aHOLJDCwFm61FdwLcZxK/sFMFiMrV9sxMIqNxwovBx6fvN2OsBSDgk3RIHDndqP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dCp6gT0TxqPtwu0PE3gMzoLyJxtC1OWFC1y1MLQRuc=;
 b=VdTD4e+C6JeTRYkHF39kcWhSl22i4qVS0g5pHEqmQPpuykil6cZCLmBPqqLOj79sCbWpir66anstnbeiZe5dmGL9aKsT5KPhZQlacToNV2i+68UetaYjNDRA7knTxExT1/B0rSjMAdepkg4f37jXoRw1Tk2igxrenFlyp8bBfGw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4455.namprd04.prod.outlook.com (52.135.237.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 23:52:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:52:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v3 1/4] nvmet: Fix use-after-free bug when a port is
 removed
Thread-Topic: [PATCH v3 1/4] nvmet: Fix use-after-free bug when a port is
 removed
Thread-Index: AQHVR/i8tpJRykRFFUC6z3IaFYfMVA==
Date:   Wed, 31 Jul 2019 23:52:06 +0000
Message-ID: <BYAPR04MB5749D4309C95D1318BEC505B86DF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190731233534.4841-1-logang@deltatee.com>
 <20190731233534.4841-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c1521fe-60df-4ed3-ba22-08d716121827
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4455;
x-ms-traffictypediagnostic: BYAPR04MB4455:
x-microsoft-antispam-prvs: <BYAPR04MB4455C4E6DBC68D39CFF65B4186DF0@BYAPR04MB4455.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(7696005)(71200400001)(446003)(316002)(6116002)(3846002)(74316002)(14444005)(26005)(71190400001)(66066001)(7736002)(14454004)(4326008)(53546011)(6246003)(2201001)(6506007)(486006)(186003)(305945005)(9686003)(229853002)(256004)(476003)(55016002)(8676002)(110136005)(33656002)(86362001)(8936002)(81156014)(5660300002)(81166006)(25786009)(54906003)(102836004)(66476007)(66556008)(53936002)(66946007)(2501003)(64756008)(66446008)(2906002)(99286004)(52536014)(68736007)(76116006)(478600001)(6436002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4455;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yOvbmTTwqEr7ipbaBd5UQCgYxnXk8BpOR/S6edKdqdND+vQ8di6xhApNpn+40L+ieR9BZkttm6VptBF2vHymHavv5o4OGZo+T1/dHim3FrwqJEZ4Q/n/MU0hSMeE3BE2kvjEzUSjWLolrdouEMZorZhTtxaHYTXJ3EHqQ4mAa08zO8uBKIvQXh2a91sgAVlp++fdHbvlTOGDVQ5TwSikcTH68+RmPYlzSL+vIbG4s54H8CweMvDpIZ7HEZbH3WlOFP5iZ4h7kFxgUf0OmjZgK4hA3FGGWwexhsTvEwBIYFhAQGH3YbbHEFIHMIHWRM8L9EY/qi1YdVVK6r/jK6nqjCBxdM6smblJhfag0X19Mi1J2Na8/FzVGTI6kmAx5OMnFe01njrip1exS7Q1kXkvMxxXkeD4ZQ+7glaL+VlSd7Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1521fe-60df-4ed3-ba22-08d716121827
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:52:06.4804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 07/31/2019 04:36 PM, Logan Gunthorpe wrote:=0A=
> When a port is removed through configfs, any connected controllers=0A=
> are still active and can still send commands. This causes a=0A=
> use-after-free bug which is detected by KASAN for any admin command=0A=
> that dereferences req->port (like in nvmet_execute_identify_ctrl).=0A=
>=0A=
> To fix this, disconnect all active controllers when a subsystem is=0A=
> removed from a port. This ensures there are no active controllers=0A=
> when the port is eventually removed.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>=0A=
> ---=0A=
>   drivers/nvme/target/configfs.c |  1 +=0A=
>   drivers/nvme/target/core.c     | 12 ++++++++++++=0A=
>   drivers/nvme/target/nvmet.h    |  3 +++=0A=
>   3 files changed, 16 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c=0A=
> index cd52b9f15376..98613a45bd3b 100644=0A=
> --- a/drivers/nvme/target/configfs.c=0A=
> +++ b/drivers/nvme/target/configfs.c=0A=
> @@ -675,6 +675,7 @@ static void nvmet_port_subsys_drop_link(struct config=
_item *parent,=0A=
>=0A=
>   found:=0A=
>   	list_del(&p->entry);=0A=
> +	nvmet_port_del_ctrls(port, subsys);=0A=
>   	nvmet_port_disc_changed(port, subsys);=0A=
>=0A=
>   	if (list_empty(&port->subsystems))=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index dad0243c7c96..b86a23aa9020 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -280,6 +280,18 @@ void nvmet_unregister_transport(const struct nvmet_f=
abrics_ops *ops)=0A=
>   }=0A=
>   EXPORT_SYMBOL_GPL(nvmet_unregister_transport);=0A=
>=0A=
> +void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *=
subsys)=0A=
> +{=0A=
> +	struct nvmet_ctrl *ctrl;=0A=
> +=0A=
> +	mutex_lock(&subsys->lock);=0A=
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {=0A=
> +		if (ctrl->port =3D=3D port)=0A=
> +			ctrl->ops->delete_ctrl(ctrl);=0A=
> +	}=0A=
> +	mutex_unlock(&subsys->lock);=0A=
> +}=0A=
> +=0A=
>   int nvmet_enable_port(struct nvmet_port *port)=0A=
>   {=0A=
>   	const struct nvmet_fabrics_ops *ops;=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 6ee66c610739..c51f8dd01dc4 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -418,6 +418,9 @@ void nvmet_port_send_ana_event(struct nvmet_port *por=
t);=0A=
>   int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);=0A=
>   void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);=
=0A=
>=0A=
> +void nvmet_port_del_ctrls(struct nvmet_port *port,=0A=
> +			  struct nvmet_subsys *subsys);=0A=
> +=0A=
>   int nvmet_enable_port(struct nvmet_port *port);=0A=
>   void nvmet_disable_port(struct nvmet_port *port);=0A=
>=0A=
>=0A=
=0A=
