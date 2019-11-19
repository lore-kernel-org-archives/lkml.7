Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8449C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A1E21850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I8CXyUdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKSHqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:46:19 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:10616 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKSHqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:46:19 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd39dc50000>; Tue, 19 Nov 2019 15:46:14 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 23:46:14 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 18 Nov 2019 23:46:14 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 07:46:13 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 19 Nov 2019 07:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTGtJfXlfCXf8lR31NadnqDzIvPyxCOxBUEzZpepLHUYpangzoWwQrehwrANYzQ160H5Jtaj7EnvM5UXew64YtlHiP9c+hEaU7ot7PUvY6a7fgykDMVEckpkV0CRlrwUAhWLr4bqNRpI4ab8QtCaHF2mPmPkG2WkpkrXf5r7fWNfQGxQe/KedoTuSI0npcddIwa53xFEtgCBhYzdBGgl535oX0r77O58KzyDpR+WW3oPdwTV7NTzeVxGfeuvCPhugnmhNgTb8m9v5gqeFVDrRLbW+TSCkjTIvFWLLM3CoGPlVMdD69PGYYyIuM2MpOvAcwoMgyVX5wB+f2PTTVLiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H0RmjhmDZEqAzHj76nXE65rznAHo2y1B6Tw1kcJ1SA=;
 b=d3XhjqM13NIu/TwUgp1kDMFbCsGkN6WRZk52z+SpQ2PxW2eWUQGHu52+7TVBZ87eI6rnLwq0PZKC6gYZm9MQGaPyno8KHbYNvBz03i05n34G6QwwqKl5MmGTi6pLTCpbbINdVm5XpAHIP6BQbFEjo63cR5+nVHWbAcMXEikTIQaz7X06krRglU2IBB3O2NyQpCjedaTk6orVhhiYEEKMct3YWkehqUkp2RPnwTTm6T0KXonABrhUnvSJw86ERvZpcooAYPhtuaTmwIT0L17yX5u/V+Q2RRPI8Yj42OdTKXWgK3nCCpGAB3vD5ywmJXop3zjk44UwQMVDqn44evwrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB3389.namprd12.prod.outlook.com (20.178.242.161) by
 MN2PR12MB3119.namprd12.prod.outlook.com (20.178.242.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 07:46:10 +0000
Received: from MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce]) by MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 07:46:09 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: xhci: only set D3hot for pci device
Thread-Topic: [PATCH v2] usb: xhci: only set D3hot for pci device
Thread-Index: AQHVmcS7lHXr9UykNUiPUbt28T8id6eMWLWAgAXK/Uw=
Date:   Tue, 19 Nov 2019 07:46:09 +0000
Message-ID: <MN2PR12MB338999B37136F467C04F147FAC4C0@MN2PR12MB3389.namprd12.prod.outlook.com>
References: <20191112071831.1043-1-henryl@nvidia.com>
 <20191113014927.11915-1-henryl@nvidia.com>,<7aa0d839-57f8-54af-4b55-b3e605ae20cc@linux.intel.com>
In-Reply-To: <7aa0d839-57f8-54af-4b55-b3e605ae20cc@linux.intel.com>
Accept-Language: en-US, zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=henryl@nvidia.com; 
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac2b2fe6-6868-42af-c36e-08d76cc48b1d
x-ms-traffictypediagnostic: MN2PR12MB3119:
x-microsoft-antispam-prvs: <MN2PR12MB311941AC6ECD8F1E27A60D53AC4C0@MN2PR12MB3119.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(43544003)(3846002)(186003)(99286004)(71200400001)(7736002)(74316002)(305945005)(76116006)(91956017)(6916009)(316002)(54906003)(66066001)(86362001)(52536014)(14454004)(26005)(25786009)(478600001)(6246003)(33656002)(4326008)(6116002)(229853002)(256004)(486006)(8936002)(81166006)(8676002)(66476007)(55016002)(66556008)(64756008)(66446008)(9686003)(71190400001)(81156014)(7696005)(476003)(11346002)(6436002)(5660300002)(76176011)(66946007)(446003)(6506007)(2906002)(102836004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3119;H:MN2PR12MB3389.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56tWWy8dktsHZLanOXT8QX0xWjYBhxM1oIcIApfOhstIsyJiXzoEV4tjcU4KAOssMB1SmdUKffBKkn5+dURFcgU1ORcDkE2Oakw36epeE3GrlwmmAp9+Ik+R8+wesjjRcD+cQP2e2C4PXmzS+8Zqy6E0oxx+8ItxfVBV1SRWsa2JVfy9JgRrY9BUcjmpOuiRP6Ws032PBpXY7S41wANQdHcD9OVsxuspuQgkKS1Be2X8IP1nVEiy/SW0GajC9bf1Xxw8lJ961WkUTVaxLrLmZOBK6cInfrFNQXm0JPZlAGwSShMUQxd14ap2oVrYcVAFUoaxwAp3jYoEosVmXSZGe5q6stxr7LhgybwOwGjLAcLjg45ojxrvqFtfifuZ/Y3K+Ycs9ViWlRrPI+VhBNaeGLeK9uStnMYeohowVaVhEl86L9D7EEStWr3EKZ0aHd8m
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b2fe6-6868-42af-c36e-08d76cc48b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 07:46:09.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQG6K6MiLmeKuyMWSlByDIUyJPSJf9S7FttUzIoJiK7+2AU/IMlLvhDHFrjiscK3lfUY6tigvIDGRayTmz2Biw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3119
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574149574; bh=5H0RmjhmDZEqAzHj76nXE65rznAHo2y1B6Tw1kcJ1SA=;
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
        b=I8CXyUdjyycJbRSFOgMLgh4R6vd3LqoAR2oEzhlr+WsB7hjCPr1WTMCDfzJZYMtrZ
         UjExEgpHJAkWWROG93IyPqdEpxz/klGb12D0qkjAm3y/dHQrcjM/0jpzWfvmkbRIT2
         lb4y1fe/MuTJokarkHXxFvfcrtvQnL400XEXwQD4y/YBUiNUJFMHh6KbdOFtpNSGFk
         3NzSFDzix0f7MjdUYNxfjTJjy3IJ7wIkTU/f2kPbo81EZPV4b0mJGnND2kkm831bls
         AHDABbeJc8qFYR1YtWFb+nd2mw94leZD3fgJReS0Bwq6NmfAMii5ivm8uQJY88HfKg
         IqC4CSPKD1/Rw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The XHCI_SPURIOUS_WAKEUP quirk both resets the controller at shutdown=0A=
> and sets it to PCI D3 at remove/shutdown.=0A=
=0A=
> Is it so that the NVIDIA Tegra xHC just needs to be reset at shutdown?=0A=
> The quirk is not set for Tegra xHC in current mainline kernel.=0A=
Some versions of NVIDIA Tegra xHC support VF on virtualization environment.=
 In that case, they need reset at shutdown. For now, Tegra xHC's VF support=
 has not been submitted to mainline kernel.=0A=
=0A=
> Agree that we shouldn't call PCI specific functions in the generic shutdo=
wn code.=0A=
> Would be better if we could move the PCI parts to xhci-pci.c or hcd-pci.c=
=0A=
=0A=
> Maybe we need to add a xhci_pci_shutdown() function for the xhci pci driv=
er=0A=
> that could take care of the pci related shutdown quirks before calling=0A=
> usb_hcd_pci_shutdown(), and call that instead of directly calling=0A=
> usb_hcd_pci_shutdown().=0A=
To keep original code sequence, I implemented this in a similar way to set =
xhci_pci_shutdown() as hc_driver.shutdown(). In xhci_pci_shutdown(), it cal=
ls xhci_shutdown() first and then does XHCI_SPURIOUS_WAKEUP quirk. Will pos=
t it as v3 patch.=
