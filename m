Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891A22075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YoS3YtXw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CUz5aKON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfCZOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:46:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52740 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553611618; x=1585147618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+yJTnse08eEvjb1BN2i1f3/CyXc/IDZi7/5d/nYz5gs=;
  b=YoS3YtXw9W4Kic/MtpqcbWLhDIRmIRidRHo2F5pZYcYX63dW1k94L3oh
   ngojSKlWIl1v4VM6ceThSm7CrRj4JLGRuQLvepyskC1/QY645a4S/ckh/
   5/2gId0YPS323JOx64R9WZGlm5IKNF7Vc2FwGYoXAqpRMrFOo39/GFad/
   +dvJU4N8TSFNovd9mmqUklu9ko6FuAYXoA8nyjQLidn4wzJbC2yy0+D8f
   oW3PKo8AeSXtq9V69DEou9xGqNW+x3rx76QyMLL73wnp7cl4Yw0R+OYdI
   tuLr2W1kHJBjmaue2XpYl3vac0T+lfZCrXZBFSEb+O66WKayp1nIRh+Gb
   g==;
X-IronPort-AV: E=Sophos;i="5.60,271,1549900800"; 
   d="scan'208";a="203010702"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2019 22:48:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUv3wIAAda+s+twyZfuvkzfpQX88/iPNTAePOOXiB6c=;
 b=CUz5aKONskD5tVDLeJTXmFAjSpjdg+noIfbDHm9sle1/b2/33qlHQjFc745ObH/MA5v8w1VxEPjl6cr5O6ApPETmxBb6mXgGCa+U8osT62F9cP7/oA2mctfePwOiD/ouzdtW7S5lMdgpAX3loi/437r46MAFfhWB5xGPlYMHXHU=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4973.namprd04.prod.outlook.com (52.135.114.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 14:46:45 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 14:46:45 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Check for return value of
 create_singlethread_workqueue
Thread-Topic: [PATCH] scsi: ufs: Check for return value of
 create_singlethread_workqueue
Thread-Index: AQHU3gaDl8WQlrHHhES1ZI3FpgE6x6YeBO6g
Date:   Tue, 26 Mar 2019 14:46:45 +0000
Message-ID: <SN6PR04MB4925D262CF042EAE14E38F59FC5F0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190319034732.19559-1-pakki001@umn.edu>
In-Reply-To: <20190319034732.19559-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 877c7142-afe2-45ea-2131-08d6b1f9de7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4973;
x-ms-traffictypediagnostic: SN6PR04MB4973:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB497321E7BC1C35D8D69F0AFBFC5F0@SN6PR04MB4973.namprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(7416002)(229853002)(7736002)(6436002)(68736007)(2906002)(66066001)(74316002)(76176011)(26005)(186003)(102836004)(6506007)(106356001)(8936002)(7696005)(105586002)(316002)(81166006)(52536014)(6116002)(3846002)(33656002)(478600001)(305945005)(81156014)(25786009)(8676002)(55016002)(9686003)(6246003)(4326008)(72206003)(53936002)(6916009)(5660300002)(2171002)(14454004)(97736004)(71190400001)(4744005)(476003)(71200400001)(99286004)(54906003)(256004)(86362001)(446003)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4973;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X88Xf5/5Ei8hvyJ4FpP0NeBincWLJLidqdOG3OcaS7SzS/v4c7nP+4kw/BAT4UrGjT7JyZcvRCA3L7tXpT8/J+5jfSeUgyn76QGbFQ2LcrumC+TVzoc1YK9esIGMa5wEZEVIzdZxWhF/rHo85d8ERt9ctj0zVIQ45E7ZWGiX/A4BT1rgqpn2NwTyKveVvjq2VaH726uw0/ir06hypLQY6dT4gd4atIIYtXqizKnv3029VMIPmtQJwH39R0/m4c5VHObzNKzMxZFb638NuydhgGzum5ZjHXwq9Wm1Kk9DJok7dVbpeITOqgNlRmCiZtMbkCl7gGSPbmwPVMlIQyF4kUyB2pmWfW8I7ATrI3mUb3m66X//ZMlZIn+jpcEB3QaR64MzeS32h/lvmWQ+1gndbkGH72YnNiUVi5wI8v0TlZk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877c7142-afe2-45ea-2131-08d6b1f9de7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 14:46:45.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
>=20
> In case create_singlethread_workqueue fails in ufshcd_init_scaling, the
> patch returns the error upstream.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---


>  out_remove_scsi_host:
>  	scsi_remove_host(hba->host);
> -exit_gating:
> +exit_scaling:
>  	ufshcd_exit_clk_scaling(hba);
> +exit_gating:
>  	ufshcd_exit_clk_gating(hba);
There are calls to exit_gating which expects clk_scaling cleanup as well.

Thanks,
Avri

>  out_disable:
>  	hba->is_irq_enabled =3D false;
> --
> 2.17.1

