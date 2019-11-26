Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E542C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1692071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oxgkS2Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKZH0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:26:12 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:41506 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfKZH0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 02:26:12 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddcd3900000>; Tue, 26 Nov 2019 15:26:08 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Nov 2019 23:26:07 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 25 Nov 2019 23:26:07 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Nov
 2019 07:26:07 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Nov 2019 07:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtcsbaOGrUh03dJoJNTUPDMuUBeyM0HvzVUgO4+PwqRegKLGYfetIAafjsHsfx6Eb9eoPwFo1huBaVG7AeTO7qEeiiXVLFULWYeBoJ/8z/S2vTPwvZC9BqcUaYZ4ZBu87UaOy7l47Zv2JN+YJrL8C85WCn5H0t7TfOVAUUwCy+nzjomTPAUXxS1wyLYrHw3BB4lziNM3XyDkwJwK6W58ihe+VsVfNn+weywnx814uUB2gkMb7G10DlwYgZ0kNk6Yj7geOoAPMV5qza8F63fKCTsKeKUN9kNZrVfti7sbwPdNVM2PZdolyQgllSigXvWK0r4ny0AN583nO4RU7zF6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gp6zW+NaBmbIi1NFGcoQjm/ADfNEqxNBsYcBTjlduE=;
 b=ejGtgumQx1aFfsClKUY23oawWd09YV0xcfx5u3HY1BRqrxGBS5Qk5odJMF4RRGB0MZBynJNWDnxMRkQPxrCpjAVtFNY2FmybU1x5ou9rtgw1Shjgj4HzPe136s9RiJBdLoR+5Oi3/6yaFn8G5jDRGf2UwfhIgm0MQqOMZzimqVdI+kxXsHkGRTyDnSDu7G/kSkC6r/spMikRzafkKaVEhHUxyGLtWxTstglWYat8cFlnvpq3fDNAtwY9Wge78bO6e+4mIwyaRl63xCnurkhtrBGQlvUsJ5DFCvM7KmO311ludG6pUnG4MEBG88H78WHePK17paBw/9Ya4px2Qle9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB3389.namprd12.prod.outlook.com (20.178.242.161) by
 MN2PR12MB3102.namprd12.prod.outlook.com (20.178.241.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 07:26:03 +0000
Received: from MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce]) by MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 07:26:02 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLus26pLsIkukm9vcuV6VVAeqebTyAAgAG/7Wo=
Date:   Tue, 26 Nov 2019 07:26:02 +0000
Message-ID: <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
In-Reply-To: <20191125042039.GA10953@b29397-desktop>
Accept-Language: en-US, zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=henryl@nvidia.com; 
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa798a3-82bb-44da-ca5c-08d77241e497
x-ms-traffictypediagnostic: MN2PR12MB3102:
x-microsoft-antispam-prvs: <MN2PR12MB3102A2EB1817903E9E62C0F2AC450@MN2PR12MB3102.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(256004)(54906003)(4744005)(316002)(7736002)(7696005)(102836004)(6506007)(5660300002)(26005)(11346002)(76116006)(99286004)(66446008)(186003)(76176011)(64756008)(66556008)(14454004)(305945005)(74316002)(478600001)(446003)(86362001)(229853002)(8676002)(9686003)(55016002)(81166006)(52536014)(6436002)(6916009)(66476007)(91956017)(66946007)(2906002)(25786009)(6246003)(8936002)(3846002)(4326008)(6116002)(66066001)(71190400001)(71200400001)(33656002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3102;H:MN2PR12MB3389.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFe/HObJ1WnDE/vBxcZjV3/xEs321+fHBegOysytA/PAA6EjO3+hPmvFYR7Lyx7tdR9rb1Pz/xZdHKBbUDxhFdfPtG1IK35cBHrIscEwVLxANseEKPx632NDWuHuLJXQpc60Po0gwoJQ5R0dWFRe3NpW+Mnq5yA+C69oNmubgiJw5RfAy/JqYrUm6SrGiVJgrDTwHExDsHGTyuYomR7o7RFG38wVmxOw7vROEqEklF/NBvG9ejGTWWApR38dKbQawWHMt4XpLUgBGHQiVKCRiBzk7cqbX/Umss2AgjFQazl6laebPeoHPZKykjV/BHfDRbx1JKLgANaNaFfWuQC8tRn85vMCrXaD3mE6ywLwcz6DflbVuTZQ7v0hn07FETS033xjZDEm3eS76IkbD1MeRGWP5N/1i2hykpfrICxGRGxJok+por2uvtNF+73rcCmX
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa798a3-82bb-44da-ca5c-08d77241e497
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 07:26:02.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqdbUPtX2lRZOnjmKZTy0y7TGjUAo73FK/RcNlSFMbE7lGLvgG7onGPm8bIr5b+VKL9RwpWRFknzaOrmjLFT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574753168; bh=3gp6zW+NaBmbIi1NFGcoQjm/ADfNEqxNBsYcBTjlduE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=oxgkS2RccjRaVBQHLBmICVMMPIAiRpqjFZLv77LfyBCFh4PsXDbRmf85l8J0UPGOU
         pfLdr4x0cPtrNQd48LbANM30wHQfOp/JIQed2bsqLbe/NHG4l+eN6emYckDBZMEtdX
         5BnlUKnrPZMMjU2Qzcf4ZMOWf+z7pJ7iII5KNkADnYA95cOMJNyhMU3Y24pkRaA46F
         6AQUW9I8wFYMckgxc/1O7BbXr/C5D8k+JEWEwqsux+32fWORCDZ4lbUwSN01g32FdI
         MMgCJXAnwgSkzMZvWRLDR6mfWQw8XX69BzLQRc/aG12DJFNwUMwTXlLch/+yh0vmMu
         YFMc3AwVZaGRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Gadget driver should always use config_ep_by_speed() to initialize=0A=
>> usb_ep struct according to usb device's operating speed. Otherwise,=0A=
>> usb_ep struct may be wrong if usb devcie's operating speed is changed.=
=0A=
>>=0A=
=0A=
>Would you please share the use case how to reproduce it?=0A=
We checked again and found NCM gadget driver should not have this issue.=0A=
Please ignore this patch.=0A=
=0A=
However, we still observe similar issue in ECM and RNDIS gadget driver. Tak=
e=0A=
ECM as example, if we plug ECM gadget in high-speed host port first. And,=
=0A=
the host only set interface with alternate setting !=3D 1 (alt !=3D 1 in ec=
m_set_alt())=0A=
for ECM gadget. Then, if we unplug gadget from high-speed host port to=0A=
another super-speed host port afterwards, we will see both in_ep->desc and=
=0A=
out_ep->desc in ecm->port keep values for high-speed endpoints. Although=0A=
NCM's implementation is similar to ECM in this part, NCM doesn't have same=
=0A=
issue as it only does config_ep_by_speed() under if alt is 1.=0A=
