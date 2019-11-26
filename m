Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A1C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A622075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OPNaXFjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKZHzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:55:16 -0500
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:23013
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfKZHzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 02:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEoTgE36TCsyNj6A4g1PbL/8viBcln1ZxXI4A/g/8ZcisHtsEiz+aHSwo2uLQXOb91HKEcRMWJCVEvM1IYoHcQVnubngb9eMfglTZsp1ZtpHNfG+LSdJ/79aQ2BIzv5k4b4zOP/meyo903CZUU/+80iYyQYNppMFRKCB2oDswdcTuZycbr8mEy6uCwGPc3vLJZUdiK+HM/wxEBqFysqnSt/KJyeZAo+zyjTiiXAmpRDsggNdBW9C9hg+Tis/lXJXgFtm9APADn4Xz39NGqb+gZa++XjpU1eLrm0d3vOzrLu6wEZqgvguWFr8SWc90qgL7RokELy+Qh92KWcWAz93Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuVlTLIDeFUaIH6ANBYK1hvGWCEfXdleRSKWI0f1xIU=;
 b=gSB8mr+XsTipk8oDVXdS3Z4e6go5afJ+zSczkooy6cFA05Nk5N37rC6/gc1SsZ66nTEcCBbiiHTwmYJUMqepCbqF/ReUM/V7CtuNQ5UP0hiFi9Ne2BWG7eeRpQxL+pNTagroMP0I0numz5TFi+Xz4PnaYwOneEtJJZLJj9i27l+yxCSUFMc0/4PlBsbdr8YXrfk317bG4XfTa/I910fGxWnHjafwAgG1QeIP6K7gaRqvzM4lC9kG4jDoqodDcZ5MWGJ8cKltMsZAZX0vhlJ1SsSojq7YBx5U/WJ60VnLNqAKAnF//FCs+XjFl8jeWFNKMFjLtKo4Ah4LJPXE6TBbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuVlTLIDeFUaIH6ANBYK1hvGWCEfXdleRSKWI0f1xIU=;
 b=OPNaXFjcF0cTJex40ljIhxqa9tA5gXutUYHQlflW574aPzFj1CpLWog74EJaPEco1pZzpZwKNVSRRDX54WraJC0/dblne8mZzP/ent7A8H5OmEt+r3qVt4fk7IaP1IG8AlIiYuq/VhSn2hdAj/9bCtDMMWqEHmZMSFFy54p3I4o=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5279.eurprd04.prod.outlook.com (20.177.52.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 07:55:12 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 07:55:12 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Henry Lin <henryl@nvidia.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLqKGYVyVjGs0eFFEwrEIcffKebTxyAgAHGIQCAAAb9cA==
Date:   Tue, 26 Nov 2019 07:55:12 +0000
Message-ID: <VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
 <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2916028-8203-4287-d5dd-08d77245f752
x-ms-traffictypediagnostic: VI1PR04MB5279:
x-microsoft-antispam-prvs: <VI1PR04MB52791FA00CA3945BFAF162C78B450@VI1PR04MB5279.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(76116006)(81156014)(81166006)(66946007)(66476007)(66446008)(86362001)(2906002)(52536014)(5660300002)(316002)(6116002)(71200400001)(3846002)(8936002)(6436002)(446003)(14454004)(99286004)(66066001)(11346002)(229853002)(25786009)(26005)(8676002)(256004)(4744005)(478600001)(54906003)(66556008)(71190400001)(64756008)(6916009)(6506007)(33656002)(4326008)(55016002)(76176011)(7736002)(102836004)(7696005)(186003)(74316002)(305945005)(9686003)(44832011)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5279;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lz1nNgXQ9x6HCvfr29cTapXrB0DzQo9mnW1BmxQyy0P4Hf1wGoEgBQEDdlzshPC9b//o9WZ8rnxf7uyC9tpgNqcfNoBjrFA6vR29MAS7kQkrt7Jq9AZ+5zknlzqRnyFuldGvCH11yuv2PcxrlhOmLOfhLWbZz9nwGbjcyvBFHcJOf9FB1ryWanMWYkWQTWIqPtrj3lm8fWfM0IxoB8dj6k2I+KHYiYs+b6MK6Na98hq2azcQysvWRm//WCPTxTK5CikGJgsS0xNwSaoOOHhJfkmDEn/QEHPRth0OKcgCczKzJ3dPqBAc0/eJYrPP27KxPKCnFrt5x/g/41ppMt6L/+4/Ei0YkAEWCQcx7PA3HyhGkQ3WNWhz/uXtHcMr5OxPqIHAtDJbQGWXWT3heer6jxaanTdJFujbmO8Ynq+OQeBHwW/4FcvGEI34MqVxztN3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2916028-8203-4287-d5dd-08d77245f752
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 07:55:12.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVFWEcIaZEwNM1xEH2g99l5XxotQWwmjMUTBYspgZIJ8Spf+uPWB3nDHBAOLvAXyGPOFv/x55lOmehc50L39nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >Would you please share the use case how to reproduce it?
> We checked again and found NCM gadget driver should not have this issue.
> Please ignore this patch.
>=20
> However, we still observe similar issue in ECM and RNDIS gadget driver. T=
ake
> ECM as example, if we plug ECM gadget in high-speed host port first. And,=
 the host
> only set interface with alternate setting !=3D 1 (alt !=3D 1 in ecm_set_a=
lt()) for ECM
> gadget. Then, if we unplug gadget from high-speed host port to another su=
per-
> speed host port afterwards, we will see both in_ep->desc and out_ep->desc=
 in ecm-
> >port keep values for high-speed endpoints. Although NCM's implementation=
 is
> similar to ECM in this part, NCM doesn't have same issue as it only does
> config_ep_by_speed() under if alt is 1.

Does your UDC driver call composite_disconnect when disconnect from the hos=
t?
It should set all desc to NULL at related function ->disable.

Peter
