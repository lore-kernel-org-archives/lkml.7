Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1732EC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836592184E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eEW5GRpi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XcogKFpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbfGQSf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:35:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12040 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfGQSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563388525; x=1594924525;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=npA5ARj+GwXWJpeyBmWB7akT7BrpCPGMHSQgfAAUmDg=;
  b=eEW5GRpiBw7LbkI1s2lWU0uXCBT1NNXZGFSZRnCcoMpsJ/QABAej9Ymb
   FOxchBN5NigHZI9JnuRrC4IP1G9uFfr0dMJsb2cNJwH48UVmPE+VJ4NN8
   znfr/YHup1N4c/F9pcO8rn4/W4r8ZAmVOeEYknFTOEkoQIn+dq1YcDaeK
   3Yt8upPTbYVqY7LrQ5E2bHJx/PLAjBTBQfhk21E+f9RnUQl4NGgxA+A5H
   vjT1BE6uc3CXAtr212zRkniUMr/WAOK17/sjgzuxVLg5m5sjkZEu7GcaB
   oAtaXK9xGHvDZw4ho6FGp01V5UGhcQNyrmD2mPxB886UGcFj6sHnt2VA7
   Q==;
IronPort-SDR: mxhRoaSH9F/33v1ROF1+kpVhJRy8MwXt9lAO0/GbY6sEFRvCTTlp6G72uFGL13mnc9oNAvfypK
 zfGy08YzX+cUYP6u6CAfZJGrqIwdmxdaGMyMae/XFGzDLc8wRurZBQZu+o/AfGdQiDI/VsQQ5g
 X0y2KegfFJebyhb0uqVVIYWhj25LDUmE919458DBTc2gAECRjWsSNud51drdyVNjTh7mxiBGol
 dLK6zZpIcItkUXBz8iQxbihfg5AUadT9ReroVjIUfOkXlBjgx2Nf4XHdyhk6BfFwj2uf7byMRC
 8gE=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; 
   d="scan'208";a="219753321"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 02:35:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8pT8vZRLTeak2VCpboknKgj7N0MaOPN9Sn0LigWUY+cZuz1rhA/fXQIIvGxGWQRWJozHLycZDC1J6elY/3KNIzjiC1Bn6OBhydfLxPCYQwYZK9qBNayeBKN2gMETFs3DOB2nLKCbEWSeRxVzflPK2C1prxA+SAY3lD2dtcKfwpUpviE+HUs80khbBmzS0clIUghxvvCqk1OFeY1jEUUKeVhuh3Uw41dhuzOZJenVydKP6DtS/rqjOXCgYqKVBLzosFyx0tZo5XAJcJRAayHj6v0SGgBziLhYlU1p829FG/vgdaWdjuAVVCMU8Dt5hI8E9CePgQfRhYctJD+qQMdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npA5ARj+GwXWJpeyBmWB7akT7BrpCPGMHSQgfAAUmDg=;
 b=MA3AcBFx1+m89u9zrEMw70JxFLhvBfoDbwGuetAqBghKoaeHvrH0kMMTkfieMe8bnBLjPl7w0K+cdObGL+doJr2pJiXser3uQawDyvRuh+J5hZZbP63fSbQLLYyLrHn31mBPOc18rmls+ge5I85ieqIof7gFiex0z2hQijtVqb7uF74WS3vtoqcbP5w2AwWjlSNuf17HVYWrlSKwsI0YaA9085KqwpRCF9/9OihxY3FNnkinxY10GwC8kSOeDoZowAXCGs0vdglbaHf1U3ODCkzuF8EbV4g5oOeamGH9Sep+64IJz9p7U77+z8pa+QBcBt+kuyoWxlD78DLnmdZTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npA5ARj+GwXWJpeyBmWB7akT7BrpCPGMHSQgfAAUmDg=;
 b=XcogKFpg3m0IySu8Zj2EXRM9B4u2zc0k2FiivxwYu1hDJp34LWyPURH0LPYhQQtgkIT0EeW5MmfFlPreu18Ik1EMxHImKlEFeXFFWppFssXlLTaMK7mKsBRBi/fjZP/Lisq/oNNvcy5K848ju3Ih7f2okU+D73rZZGbT3/RZB40=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4775.namprd04.prod.outlook.com (52.135.240.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 18:35:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2094.011; Wed, 17 Jul 2019
 18:35:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet-file: fix nvmet_file_flush() always returning an
 error
Thread-Topic: [PATCH v2] nvmet-file: fix nvmet_file_flush() always returning
 an error
Thread-Index: AQHVO1sRlL6YpeqcQEOD+On3jfJuog==
Date:   Wed, 17 Jul 2019 18:35:22 +0000
Message-ID: <BYAPR04MB57492E5376FAAF29B70A46F786C90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190715221707.3265-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f552c421-7704-4c59-f8f4-08d70ae5874e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4775;
x-ms-traffictypediagnostic: BYAPR04MB4775:
x-microsoft-antispam-prvs: <BYAPR04MB4775149D2B214656FC84FC2A86C90@BYAPR04MB4775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(51914003)(199004)(189003)(6116002)(5660300002)(14454004)(3846002)(66476007)(66066001)(305945005)(25786009)(7736002)(4744005)(68736007)(74316002)(256004)(14444005)(7696005)(76116006)(316002)(6506007)(76176011)(66946007)(446003)(53546011)(110136005)(66556008)(66446008)(486006)(33656002)(229853002)(64756008)(102836004)(54906003)(99286004)(52536014)(186003)(26005)(9686003)(53936002)(81156014)(8936002)(71190400001)(55016002)(71200400001)(2906002)(81166006)(478600001)(2501003)(4326008)(6246003)(476003)(8676002)(86362001)(6436002)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4775;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gX7mnHsTLOD2jvm8sCU56K0XveoHIXpVN68Gi91jPGbh5mFXT/SzRrGWJh2/oy1rpSEJwnkdUDBAbSH1JclV5+OZw3QZroKX9mLd1qvgK2bpH7C5jr1xusve8RMdse4w6/iJyc05wa72aoj+8ULcCumZtrkMYYhnV0FIvDo3OyrLE72JCpfgBY2rS51IRZ6YTcC8ahL68wB8v9u5jFy8hk8P7ZGNUd1gumAR/kv/xkSR0qbBpNIuUXvffwdAVcpm26EZKq0VVQZVPKw3wJs4iVNkZZtgo5sBTMqM6ESb3ttdi9kJtf6lXjlDyneZlHYPSnKBFiV7sQQbS1sMN0eyK+ycYVF56fQkHemr0f4Wun5PY6+ycKt5O8ZRmhOy8jiVO5XmlVOxJ0rs2ZHjh42zuk6kxov7lYME22RwEgW4EOg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f552c421-7704-4c59-f8f4-08d70ae5874e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 18:35:22.9113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15/2019 03:17 PM, Logan Gunthorpe wrote:=0A=
> Presently, nvmet_file_flush() always returns a call to=0A=
> errno_to_nvme_status() but that helper doesn't take into account the=0A=
> case when errno=3D0. So nvmet_file_flush() always returns an error code.=
=0A=
>=0A=
> All other callers of errno_to_nvme_status() check for success before=0A=
> calling it.=0A=
>=0A=
> To fix this, ensure errno_to_nvme_status() returns success if the=0A=
> errno is zero. This should prevent future mistakes like this from=0A=
> happening.=0A=
>=0A=
> Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")=0A=
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Cc: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>=0A=
=0A=
Thanks for the fix Logan, errno_to_nvme_status() needs to be only called =
=0A=
in the case of error. Clearly bad example of calling function withing =0A=
function.=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
