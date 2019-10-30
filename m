Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D8CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA70320856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NGRociia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJ3BPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:15:21 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:30725
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfJ3BPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzhF9xs+RLzdXLGKKa/IrPcI2NQRhXPcUFIz6OkkTwWKxiV0vPfY70qq0pfUunAB0IfcGYXGL0qqhLO+FZ6xLCjkbR3x9qNoqdYLEYNyg7rnW79xQpfMYm5ftlCnERjEr4RJ8PIMQx1UsVyy7ZBxL/mUVDyIMQgV+FzEwYtLEkWX6J+vMBnDpuFatJtcK9fvsk/szfCMDMURPQIDH2K/1ApnY0QkIBHizYkv0CpZJbGfR9dqV2sU1kmp/7s41Mrt9a7WzOCEQcnxBWU75aHTNUUUhPNE9zE7Rfs7PEZxZziAauy+tZ8UQRzYI5OvoBELjWOXqdeIamN4wmeuWIN/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUGPifLCn6bsyDm9Tyd3pA/5K+/MlveA4djzpNIYqII=;
 b=l8ne3uetq/FTBIp9MF/+jBCtnuciNFw59WnlwuXf5rxmdQQ9OB83gG/dQ+phahrxvPn7+0Xw7xB3c5F7xevYtbKmE7+FBxA2YzyBahkE8r/IJ0OrYRl/ukRKWuiqoxlhNfxKT/ObY5PEP08rmpWCmsprSSIxD9+FHyFu7SMYP7MAZnGDt9HelakRiwKUbj0DINELtNATS01fxLlG/fsMM7+SxL5LnuzEKgKb0V64STUFy6y/tHIcAmUdjkm7wyN/XThtp69fUePZbxzgfEj3yr+fMFEDCPMM3+tIHQQob/B1xhG8ob98gXNiTdxFTK6zA9BaYmzg4J+gDEvEhXQBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUGPifLCn6bsyDm9Tyd3pA/5K+/MlveA4djzpNIYqII=;
 b=NGRociia6sQOTu08DUF4K4nZA21fD3I7IcBo350av/mI8fXPv4w5Mv/Wp/FyJHMJxoRuDQrK/SXn2JKbV9uxsNG3/+8sGFegRIWpfIvFFrpZz+pAzeRddX1FTdx31930nLATu9AxHZ5+DXb+9poizW7/j+wwmHYI2b2mVfSgDNQ=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5582.eurprd04.prod.outlook.com (20.178.123.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 01:15:16 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Wed, 30 Oct 2019
 01:15:16 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Topic: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Index: AQHViYCigHhLS+QXN0CJz1D+9q4PbKdn8nSAgAK+9ICAAHFQgIAF16UAgABrmoCAAQX0gA==
Date:   Wed, 30 Oct 2019 01:15:16 +0000
Message-ID: <20191030011505.GB26815@b29397-desktop>
References: <20191023090232.27237-1-rogerq@ti.com>
 <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20191025031343.GA13392@b29397-desktop>
 <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
 <20191029031223.GA26815@b29397-desktop>
 <0c2c901c-a6f2-a81b-f5b1-e3f442d7c1ae@ti.com>
In-Reply-To: <0c2c901c-a6f2-a81b-f5b1-e3f442d7c1ae@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5092abc9-f471-4356-47b2-08d75cd69f93
x-ms-traffictypediagnostic: VI1PR04MB5582:
x-microsoft-antispam-prvs: <VI1PR04MB55828F0E2423720D86FC80E78B600@VI1PR04MB5582.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(2906002)(3846002)(66476007)(53546011)(66556008)(5660300002)(66446008)(8936002)(6246003)(33656002)(6506007)(316002)(76176011)(54906003)(64756008)(4326008)(14444005)(76116006)(256004)(102836004)(26005)(1076003)(66946007)(71200400001)(186003)(71190400001)(91956017)(25786009)(9686003)(86362001)(14454004)(7736002)(33716001)(44832011)(476003)(446003)(486006)(6486002)(478600001)(6512007)(305945005)(66066001)(6916009)(8676002)(99286004)(81156014)(81166006)(229853002)(11346002)(6436002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5582;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ambccwu2mWMmkD2Rj49i3tnPmMATT6G9eG6D5i33RU8GzAK5wSqM7hYWVE29R5swPcdIFTywo4FDRcVwErnhn+DziZNdMjCEWT4pKYu1gGfsvuq04yeT5rLF6pA+gp3dCge5mUiM2rG1YeAwqrzgc0kqMxeWOF+yE75OvCWmL2258Ku3t73bvyL3GeJrDDzCvlXkdzq91hoVq96vjn5Hf5M5iNRG1c0CH1YFrRUp+CbVujzet3uDeKMrHbZU2ZwoY0hGizIejCU/dICpJoFYqiHA784Pk87Y85vS3mjBlA9gnsdfKGh54XYId4gXlbAfjpQ5HwVPMC5WW7KA1Rne5f6LYbUaXKInZ4iFPvwp05vssW1FlX/8OF9GbDewsj6Z2KJapGDw6jnyV77nuge4GmfsXei7eGjPF0jdgbvVvqizw9zDuU2hsQjpzv6iQon/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB084D01F362324981827E965B9C7C7E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092abc9-f471-4356-47b2-08d75cd69f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 01:15:16.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beDBP8QifVANxz1VbMFyAWYnoY3nZ31QmiFCdL0ASahhLyYyO3JJISWj5wOX8ih00Tod8q2wweVqhGiv/3uW1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-29 11:37:31, Roger Quadros wrote:
>=20
>=20
> On 29/10/2019 05:12, Peter Chen wrote:
> > On 19-10-25 12:59:17, Roger Quadros wrote:
> > > Peter,
> > >=20
> > > On 25/10/2019 06:13, Peter Chen wrote:
> > > > On 19-10-23 09:17:45, Pawel Laszczak wrote:
> > > > > Hi,
> > > > >=20
> > > > > Reviewed-by: Pawel Laszczak <pawell@cadence.com>
> > > >=20
> > > > Hi Roger & Pawel,
> > > >=20
> > > > Assume gadget function has already enabled, if you switch host mode
> > > > to device mode, with your changes, where the device mode will be en=
abled
> > > > again?
> > >=20
> > > When it switches from device mode to host the UDC is removed. When we=
 switch
> > > back from host to device mode the UDC is added, so,
> > >=20
> > > usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
> > > udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()=
->
> > > gadget->ops->pullup()
> >=20
> > Thanks. I have another question how you decide when to store UDC name
> > to /sys/kernel/config/usb_gadget/g1/UDC? Do you have a user daemon prog=
ram
> > to monitor VBUS or external connector? At host mode, the store operatio=
n
> > will fail due to there is NO UDC.
> >=20
>=20
> Yes, user space needs to monitor /sys/class/usb_role/6000000.usb-role-swi=
tch/role
>=20
> When it becomes "device" the UDC is available and it can prepare to confi=
gure
> the UDC.
>=20
> Could you please give your Ack for this patch if it is OK? Thanks.
>=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
