Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4DD20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R/jRvbrZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n5VYgVmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfGaXxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:53:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12586 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564617191; x=1596153191;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Gj+5nV1gonmrto+wYzGA6hOQ5M2UshwSuk9mLb2oaZ0=;
  b=R/jRvbrZXHnPODIkBHTx2bdEVoni/msUDvO2+wtf1icVnNilh8g3wQWR
   p5Q0duo6Q96pUWga+AfWaZKMvwqqKiIfs0WrliVfRMpJ8NOKsk+BYWvfL
   o+pSzXUpSUmJ3qSvZxJ/fnTFpIyBB+n/jqW/XE3Sj2gSq6oKVlOQt7TrZ
   nKqBGvGRTfWDbX/vV8uH2wFDgyJxm4Htc3z62UmosYJNSYO1ZTjE0vRhp
   CEGgCdl5FILrdVfd4NpdtgeCL9t+SVnCbENPgdNfd4FNE5tAKZHMwToul
   E/fB7uKNgIa6XnDD8PI3CE9Z7Yf+DMODZkjNasoWAv3tL5Ls+Qb6BDl8h
   A==;
IronPort-SDR: ZTdF8SKlYPR3k01bjhig8KcQn2X3mRzMxMpBNMJKq/5oyT9npbrxFEJWEC6jnU2CNACrntnGU/
 4IIIwxg5EFAWnKhI2X5nYjAnebmOqdpQD7ggB379K+ymc50VroXNZVjC6ZNwdggAynxtHpsKKa
 ByS7Sscn7KolkNxghQxYovELiW3Pw6AqLoMED0AlOyZa8KBx+J6yYSCdrcZxbJbvsCNC29rv5Q
 9xIYX4TE+lc9jyu/p5B4ELCH15/ajHshZQj1YY3PoBRlaCuL7JkCs5LTaZNH723cmlj1npaUEA
 VjQ=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="221114182"
Received: from mail-sn1nam01lp2054.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 07:53:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3knWKlMZwjjJ+Mdz3IwwckEH7uhlhP/echovsBRpoaH7mXqEfry1HFGg8hqcaCWqeIoMQ2ZD0EzubmQZEPlP87SpRBxp0clzCNj2MCbyXco5EGbYjP1Dr3ROwq7gK5j6Osly5wqnrGvTd2Xx2FjCUmkMLqNklM8dl5KPgAJrNo2n88aV5TgUN97H6ibyV9jB11t1EchW7q6mYRLvzKlphjV+4I5dS8V4CJThFAATbYsUUj4JTG7MgNjf92rXQ5FNMR2IUJ9g+MJAKzNZ06IIi5Cy5aYm2gjkj3/Ou+s4Ar8Rr/BYJgUn8WpSwJQHgB2sBZwNq79ZZzgAREKTqnP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHqu+jHyNHmaU89/0pPUoPfHbJUQHVPUGeEcpVTM03k=;
 b=cJLFL69N1HrxXQEOVFkMMenz6KGM6tdl3I/VhmN5Iy/QA2FHRANC6hCHUOHwt7ywVZieaiIq65M4n7LW8tfJDZ2QBXflnmOr8zb8ROXaTWyD26lomUAkr2Jts9xXpkB1Csu3IgpUQo17zM0E5i8N6Akdubi0NQjqwacCMqU0ARMwHL8vutb8noeKpJJR7QP5ZvmMI9NXTM5Kc+V9TA5IVy3MIESlielZ2R9TjgngTl6oqbBN6m/ERD/Nh939BKEfkt+Wo+MTcLQw/e7g3FzNm3J+19YkVHT7or+w5qFNfvj2E4TGjoEeA+JYMQqa+1KTCiyRXknj1ewLAFLBEXiIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHqu+jHyNHmaU89/0pPUoPfHbJUQHVPUGeEcpVTM03k=;
 b=n5VYgVmww+Xj4fijHSippbABR+obyxsD1SXkr5/AjMyJqPGb02Hb8CLm334VnBugpuebmpuFGQTYcmR1EROH2T91tkkaTAhpbuNoYD1l2Di0BWMxtqh7cvPkiR7jn1G2S6O6gqgBqmgqWMcCSlTjNvJPDBc0uNDiV9yXQHSjRnk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4455.namprd04.prod.outlook.com (52.135.237.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 31 Jul 2019 23:53:09 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:53:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v3 2/4] nvmet-loop: Flush nvme_delete_wq when removing the
 port
Thread-Topic: [PATCH v3 2/4] nvmet-loop: Flush nvme_delete_wq when removing
 the port
Thread-Index: AQHVR/iwlIUuBWVyrUKyRjod+n3jbw==
Date:   Wed, 31 Jul 2019 23:53:09 +0000
Message-ID: <BYAPR04MB5749933ACEC902B934CA212586DF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190731233534.4841-1-logang@deltatee.com>
 <20190731233534.4841-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6311538-a3ea-447a-3473-08d716123dc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4455;
x-ms-traffictypediagnostic: BYAPR04MB4455:
x-microsoft-antispam-prvs: <BYAPR04MB44558EB21D242728705FFF2E86DF0@BYAPR04MB4455.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(7696005)(71200400001)(446003)(316002)(6116002)(3846002)(74316002)(14444005)(26005)(71190400001)(66066001)(7736002)(14454004)(4326008)(53546011)(6246003)(2201001)(6506007)(486006)(186003)(305945005)(9686003)(229853002)(256004)(476003)(55016002)(8676002)(110136005)(33656002)(86362001)(8936002)(81156014)(5660300002)(81166006)(25786009)(54906003)(102836004)(66476007)(66556008)(53936002)(66946007)(2501003)(64756008)(66446008)(2906002)(99286004)(52536014)(68736007)(76116006)(478600001)(6436002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4455;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FjSTM+ScJEOxb47PukbneDk8efDvD0tJRifbeLcs8aUXEurDNo2cTxHwLS7OUTygZPKK0yFVEW5Mcs6G+/chZlkj/0NZ0rrHgzicZw1ATiT2f0YQbnTrD151r8Qy0E1OBZirGH2LsvBbi+mC02q6LxkTBrhQxubFw1CgNA7R4DHCrMyS/1ZOp5/+eJksZAG3aHkr5RWbdSq6rQVDPgOkRLfBL3XA25WVbwck4K9yNl/mNU/nzD9U/WNcj9SxoaHckXoJaBSvt/4qL6KlEuEe7Q+aoNBbK9TJfeDvkgsyOjgaJNSh/yhyf7zinz8freNkr1VcsrE2/Kq9z73vg0N0Car9prdiTHqbYCZGK9RdjyGbGdIIayPEO6Wgbdl+QbsHlXQ2274rsuPPYREnYGqSbLZlnKWGU5RZ/KcsVd4iHg4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6311538-a3ea-447a-3473-08d716123dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:53:09.6375
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
On 07/31/2019 04:35 PM, Logan Gunthorpe wrote:=0A=
> After calling nvme_loop_delete_ctrl(), the controllers will not=0A=
> yet be deleted because nvme_delete_ctrl() only schedules work=0A=
> to do the delete.=0A=
>=0A=
> This means a race can occur if a port is removed but there=0A=
> are still active controllers trying to access that memory.=0A=
>=0A=
> To fix this, flush the nvme_delete_wq before returning from=0A=
> nvme_loop_remove_port() so that any controllers that might=0A=
> be in the process of being deleted won't access a freed port.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>=0A=
> ---=0A=
>   drivers/nvme/target/loop.c | 8 ++++++++=0A=
>   1 file changed, 8 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c=0A=
> index b16dc3981c69..0940c5024a34 100644=0A=
> --- a/drivers/nvme/target/loop.c=0A=
> +++ b/drivers/nvme/target/loop.c=0A=
> @@ -654,6 +654,14 @@ static void nvme_loop_remove_port(struct nvmet_port =
*port)=0A=
>   	mutex_lock(&nvme_loop_ports_mutex);=0A=
>   	list_del_init(&port->entry);=0A=
>   	mutex_unlock(&nvme_loop_ports_mutex);=0A=
> +=0A=
> +	/*=0A=
> +	 * Ensure any ctrls that are in the process of being=0A=
> +	 * deleted are in fact deleted before we return=0A=
> +	 * and free the port. This is to prevent active=0A=
> +	 * ctrls from using a port after it's freed.=0A=
> +	 */=0A=
> +	flush_workqueue(nvme_delete_wq);=0A=
>   }=0A=
>=0A=
>   static const struct nvmet_fabrics_ops nvme_loop_ops =3D {=0A=
>=0A=
=0A=
