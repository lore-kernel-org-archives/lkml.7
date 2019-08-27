Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A77206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ITOZ/8p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfH0Jbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:31:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2175 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfH0Jbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:31:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8720000>; Tue, 27 Aug 2019 02:31:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:31:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 02:31:29 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:31:29 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:31:29 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TubOp/hnROE+rAKySz0nJFKwgfCWXeZEHyR/nQGVB8hqzxiyuZyBzZ4ijS8ZIC2iCyQFAWHyQS+hCJGdpNMYB1s5S/z3dAxhP9faWTAM7iuaDrUxRmWd7kMm5OROhpu32r4EWQnRbXicuFsLD6JPR8mMUgOaJDANBgTxg/4KKK/2Ou0vEakCWd+x6pwB1eUtFZZoh30CwxpNeV2BW9S8pGVbfIPSKBf/ixwgB3MUP5aVgrhzyHRZFEc7zcgztEOtr/SO2cMSM/OQ/bfJWcWvV0aCRVDpl5P9rlkUvDx7FrrtReUmuYHw2naUjPUXE5VONVXeEcHWSIYEmGV6MAODgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enp9Rz/kjKvztJe+oeJWWZ2THs4IodYau4WR/QWitlw=;
 b=MtYxeHbi7Qa5BtwsZRtPHgMm1lbkGaP4w4eqYY51N4UlXrwKDpS1gNF8FmpW7WhUkUnyDe0vIieMlqVAS3ocmPLxpFEZpXzLEykaQt97e3DsrnitNTnVo5T2KLBvWlO11IxAQDW4ACJ6GE4GUNDATuFyjFmaCtIPO91aQkcTztzcZYAHdTnxL5D75S3m9fBgUHSMo5o+mvYOaOtOu3ZA1GPRJpSIQ5IHk/gXM4ijNhrCSpRbtwLtvHIWZE8Ru+CSKOafQ8BEnJFHv+YmSDNdrtUpjHoSLDBpZmR6Mu5Lsayhq/yVErQXzk9e/nAlIAelskLx2KaSZ/ixEIJH480Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:31:27 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:31:27 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
Thread-Topic: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
Thread-Index: AQHVUQE5pE0kRSjJY0O4MxONu3ZQb6b44KgAgAGNrRA=
Date:   Tue, 27 Aug 2019 09:31:27 +0000
Message-ID: <SN6PR12MB27349055DDF3C324B49E148EC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-12-git-send-email-kyarlagadda@nvidia.com>
 <20190813102448.GO1137@ulmo>
In-Reply-To: <20190813102448.GO1137@ulmo>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:31:25.6899313Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=395a149a-cb88-4e20-aa9a-8b3e5e6dbe59;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c52c16f1-ecce-46ed-8cd7-08d72ad1563e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2831;
x-ms-traffictypediagnostic: SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28316B475E3AEFD002123CD9C3A00@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39850400004)(136003)(199004)(189003)(13464003)(486006)(86362001)(55016002)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(186003)(66946007)(229853002)(66066001)(478600001)(54906003)(81156014)(81166006)(8676002)(8936002)(102836004)(71200400001)(53546011)(7736002)(3846002)(14454004)(6116002)(305945005)(74316002)(71190400001)(25786009)(52536014)(4326008)(446003)(5660300002)(11346002)(6246003)(55236004)(76176011)(6916009)(316002)(256004)(9686003)(2906002)(476003)(53936002)(7696005)(6436002)(99286004)(6506007)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OJt/uKn5WuMz98iwygqIRUHmtHxTSpIp2DK/LcRf9opdUDFlROwoEDOR0YtsWMS4co3fPVfezSC15flCtuX6lnkrr8919dLbf7LH/arE/HUD5FQ4f3BQEM0eSiVqYsEGZcBfCDywCfBlrjjg1ukewxO7ZjVFmNC7e+7cMYgQzWORRxvhMlnmtJkwwGohaq1pRSedUSHVhMG36XrX04DFjw4V8L3gR88XGuh9aLTlIGVwOm+slSaDN1f5amC5ZEXtASQr8rt/oIKi/GBmSgNhSBvWS7P9MdTSvtMTCWWeNatSaeSjCuXUTdun9sFJv7vtPi89JGw5CKW680NUM2lu74e8Mp8T7Ij6KJ60YxfwTjQUAFwc5TuvCB73gy8DaoBa4B4KM8lgaLm5x7pk0oe/KEgc10zDyGttHIWGKt89Xn0=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c52c16f1-ecce-46ed-8cd7-08d72ad1563e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:31:27.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAl2NXKIFkgtLjrYahdfSQlJ7GGIhhwQlp6VF96ykN1nQcGmX6ZgPciTv531/VgJy5nczIL4J4xOvDuPb6QPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898291; bh=Enp9Rz/kjKvztJe+oeJWWZ2THs4IodYau4WR/QWitlw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=ITOZ/8p5jTwwQcFDE3ECdcB2E/AeukhaeNdqEQndaRD4oL0xbEdWRYQrSJWAR0BVg
         Ixs+uo/UngWyuzNOqcHo+nh0/KAEvGN4wlrqJXioWY+BZQzgFf7BbZrx1J3OCQASMU
         Kcwh/CbUsVLR2VE0j02+Av8KGCqz1ZuzobyqLkqiADs2sa4PmDZ3lbvxOpwcTcFSSY
         lzKf9Tv8ajoUirE2Xc70U90zs3Rx7jxBriTWQYvnnVqvPVH9eUGNTgP8m1ljWhjfKZ
         wWhAvVDNcKTfKfxGzoJNH32dPkuHbAEbr+wxD8g2yWAy7Ksbo8lbVrg+kJutwesij3
         uUo2G2OeQd/Sw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:55 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
>=20
> On Mon, Aug 12, 2019 at 04:58:20PM +0530, Krishna Yarlagadda wrote:
> > Tegra186 chip has a hardware issue resulting in frame errors when
> > tolerance level for baud rate is negative. Provided entries to adjust
> > baud rate to be within acceptable range and work with devices that can
> > send negative baud rate. Also report error when baud rate set is out
> > of tolerance range of controller updated in device tree.
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  .../bindings/serial/nvidia,tegra20-hsuart.txt      | 32
> ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > index 187ec78..1ce3fd4 100644
> > ---
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.t
> > +++ xt
> > @@ -20,6 +20,37 @@ Required properties:
> >  Optional properties:
> >  - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be
> enable
> >  		only if all 8 lines of UART controller are pinmuxed.
> > +- nvidia,adjust-baud-rates: List of entries providing percentage of
> > +baud rate
> > +  adjustment within a range.
> > +  Each entry contains sets of 3 values. Range low/high and adjusted ra=
te.
> > +  <range_low range_high adjusted_rate>
> > +  When baud rate set on controller falls within the range mentioned
> > +in this
> > +  field, baud rate will be adjusted by percentage mentioned here.
> > +  Ex: <9600 115200 200>
> > +  Increase baud rate by 2% when set baud rate falls within range 9600
> > +to 115200
> > +
> > +Baud Rate tolerance:
> > +  Standard UART devices are expected to have tolerance for baud rate
> > +error by
> > +  -4 to +4 %. All Tegra devices till Tegra210 had this support.
> > +However,
> > +  Tegra186 chip has a known hardware issue. UART Rx baud rate
> > +tolerance level
> > +  is 0% to +4% in 1-stop config. Otherwise, the received data will
> > +have
> > +  corruption/invalid framing errors. Parker errata suggests adjusting
> > +baud
> > +  rate to be higher than the deviations observed in Tx.
>=20
> The above sounds like the tolerance deviation is a characteristic of the
> Tegra186 chip. If the board design does not influence the deviation, why
> can't we encode this in the driver? Why do we need a description of this =
in
> device tree?
>=20
> Thierry
>=20
Tolerance is chip specific and info regarding this is part of chip data.
Explained it here to set context for adjusting baud rates based on slave de=
vice
as below. Slave device clock might not be accurate and if the actual clock =
of
slave device would end up out of tolernace range then we will see frame err=
ors.

KY
> > +
> > +  Tx deviation of connected device can be captured over scope (or
> > + noted from  its spec) for valid range and Tegra baud rate has to be
> > + set above actual  Tx baud rate observed. To do this we use
> > + nvidia,adjust-baud-rates
> > +
> > +  As an example, consider there is deviation observed in Tx for baud
> > + rates as  listed below.
> > +  0 to 9600 has 1% deviation
> > +  9600 to 115200 2% deviation
> > +  This slight deviation is expcted and Tegra UART is expected to
> > + handle it. Due  to the issue stated above, baud rate on Tegra UART
> > + should be set equal to or  above deviation observed for avoiding fram=
e
> errors.
> > +  Property should be set like this
> > +  nvidia,adjust-baud-rates =3D <0 9600 100>,
> > +  			     <9600 115200 200>;
> >
> >  Example:
> >
> > @@ -34,4 +65,5 @@ serial@70006000 {
> >  	reset-names =3D "serial";
> >  	dmas =3D <&apbdma 8>, <&apbdma 8>;
> >  	dma-names =3D "rx", "tx";
> > +	nvidia,adjust-baud-rates =3D <1000000 4000000 136>; /* 1.36% shift */
> >  };
> > --
> > 2.7.4
> >
