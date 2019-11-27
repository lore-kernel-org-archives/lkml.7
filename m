Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D5DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E815F2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtLJ7G9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0By0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:54:26 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:49638
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfK0By0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:54:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqBZfF+WRxDmetbb2R0fKO/8sP/chV/iJ6JdprqhUJc8obeKPLnII6SP1JMO7IR6lyRPmNprih6U316J/TbnwVc8DYEXCpByzZzD+ISnUThSOrBwJPSFqEGt+GqVJ+vZJfpTVYnmpvOUhplWfpa0rV/CBXXKnyKeuDjFQuvLcLfabbCxOzIbNtDYz91GlqK2gC5wnW6gZA99VGt6IWsyABUoZ6InRUg8MqzRiUOwQxVOttLe3LdvIbWZrnf/+433Rv67LHfTuaL93IBIeSWtp2rutuSemXuYzfMOLNGeSw5aoq7pRAEDcI4jaYgaBXcvAmD0sQdFL767SDqfZKtHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSAIsOB7R0CWb5FzViwn/PR+qgxibS+TTaC1NZAJiBk=;
 b=N/qJpIkPqkpPd+yseaaj4mQQOC81M78/XOr0eArYI3A7KbeCqtuSHkalH+MIMhKDGsZbkVs6eEon49TZsNBkeCZMRPMZevIXJ77t8MBnaWwOupbwEG1Q89Q3LXCFAJTUmogiUPTVRVA98GUuuZft7nne4qY4Bg5wRMBS79TnRgm6kxXpygvKgQzmnEpXnbgqCYrQrIDPvLoPY+qzw8I2scXCpklAnFuliJSnj3n1nPryKi0cjGBuzIJySFqdsofT8s9CuAydU9cITjNQ4iDKB6SrF0rwH3alJTDcho9fZajF474DK93I1yuJ6J6lhxeBWlf1Uvmh5PEZFFaLRZc5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSAIsOB7R0CWb5FzViwn/PR+qgxibS+TTaC1NZAJiBk=;
 b=gtLJ7G9G4fUlZra5UXQvoMy41/GW76N0htbrC03w9EXKdzaN0zMbbakDXOMPbdgA6JqEYRp1xLdpHuCAICickelhqP0d1MVqNvfAI5WO8EA/xadyxcAhbsKlLqGl/HVJIFhpthO5fu6YZgVzE+qZ5obWtzVnJj+zLgXGGBnAyEs=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6110.eurprd04.prod.outlook.com (20.179.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 27 Nov 2019 01:54:23 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 01:54:23 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Henry Lin <henryl@nvidia.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLqKGYVyVjGs0eFFEwrEIcffKebTxyAgAHGIQCAAAb9cIAAJQiAgAEJN3A=
Date:   Wed, 27 Nov 2019 01:54:22 +0000
Message-ID: <VI1PR04MB532730D2E1BA4108B37155D08B440@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
 <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <MN2PR12MB33894E3D1D9AC14B8C9E2966AC450@MN2PR12MB3389.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33894E3D1D9AC14B8C9E2966AC450@MN2PR12MB3389.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5b38d25-1370-4204-3d1f-08d772dcb9bd
x-ms-traffictypediagnostic: VI1PR04MB6110:
x-microsoft-antispam-prvs: <VI1PR04MB6110DB012526F87716FC80828B440@VI1PR04MB6110.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66446008)(256004)(64756008)(14444005)(86362001)(71200400001)(71190400001)(76116006)(66946007)(25786009)(66476007)(66556008)(316002)(54906003)(5660300002)(52536014)(33656002)(14454004)(478600001)(7736002)(4326008)(76176011)(7696005)(6246003)(186003)(4744005)(44832011)(66066001)(11346002)(305945005)(6506007)(74316002)(102836004)(26005)(446003)(81156014)(55016002)(229853002)(81166006)(2906002)(6436002)(8936002)(8676002)(6916009)(6116002)(99286004)(3846002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6110;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00kpsySjtbG1AB/llZMc8i1Cce/xXPBqc+XUypz3+QHkBb4j7oQAHDBsh2BBkdKIsYCKEEevMLKNIELtuxLZSJpmRXSetHId6t+8JGxzgTx/qNQQMBPm44tNd1AlscnkRcuDnlerDTZ8Jms0SnSL4X2QmAgAm2p4tb0owaGWpHK+tIYhlJ1NTfxUh/GA27WPS+F3pqLjm4EfOYfq7v05t1IOQUWz8LUeZdnfPpUQvNUA+OtKde01VuOVkzF8PXDcbj/QBJ/Wzsr6duN76VcaaMqErjbpBuwlBG2oeAwqS5ZtY/wPvXXFCWNbfiwVLV+0NERpFRFTMG747DoTLle4Q8tDRTd6jHuQctI5srLA8EVq3v1+iHmyLWV1DBiofqRYwbB2k/ZXM+Iugl/HTLsyDzSnjaJfnWzcnpwq6OmR55S7Sl1D/WJRT07XWyai00DK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b38d25-1370-4204-3d1f-08d772dcb9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 01:54:22.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rIMqjvMdKY20mN3plp57QiCrPl+hdsyshyTG9vT6L2E1vFtwPvDulFfoWsCy9lcFrgWPBKcvUvtYF9NYlVJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >Does your UDC driver call composite_disconnect when disconnect from the =
host?
> >It should set all desc to NULL at related function ->disable.
>=20
> For ECM case, if ecm_set_alt() gets called with alt =3D=3D 0, in_ep->desc=
 and out_ep-
> >desc will be set up. But these two ep will not be enabled as gether_conn=
ect() is not
> executed. During disconnect from the host, ecm_disable() gets called with=
 ep
> disabled. In this case, gether_disconnect() will not get called to set de=
sc to NULL.

Would you please share your test case? I use Linux host, and the host will =
always set alt for 1,
and doesn't have this issue.

Peter
