Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165BC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF86214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j7vKzcLh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j7vKzcLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfIYJsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:48:31 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:5345
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729213AbfIYJsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT9TiMn8fCfYuFAz9/p8gjs8ol/FhfFwFX0TadnKOXA=;
 b=j7vKzcLhM1P5jDRL/PZD/Ef/GR1bUZmvB9TlNP2eInZCrPiDJEV2q8jjkmLobD52p04rMPpOqBrSmbkUhNU6+JGSzHf0J2T3PF5dgcyyU2PBVXj6fLExf45QABQY+KFG08flrttyH4XBDR+2jddm3VAtMRb1A5rWbu84PjEraOw=
Received: from VI1PR08CA0101.eurprd08.prod.outlook.com (2603:10a6:800:d3::27)
 by AM4PR0802MB2161.eurprd08.prod.outlook.com (2603:10a6:200:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Wed, 25 Sep
 2019 09:48:23 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR08CA0101.outlook.office365.com
 (2603:10a6:800:d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Wed, 25 Sep 2019 09:48:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Wed, 25 Sep 2019 09:48:21 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Wed, 25 Sep 2019 09:48:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e9612447dfafb14a
X-CR-MTA-TID: 64aa7808
Received: from 3951e8f2968b.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BFE2200B-9675-402D-A9F6-3130351B7EAF.1;
        Wed, 25 Sep 2019 09:48:14 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3951e8f2968b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 25 Sep 2019 09:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/Gdz61n16ZY9vFBqtkOEQnpwjj7zztpDuzNHRViFR4ODURrJelmoY7vGMLlyCShknlGMmvuqlp0eS9GASL4EfkOLBTcWfQVGaWVcSi/5NamAOP9ed0k8xjPDVOM9dKaEhP1Nl+3FcHE+QwAw8Ur/QOaW8+9N5DYlWD0WSBnkPmTq21jK57k9VncLphRKBl1/IIGH3pO5tH8qAgXkH7INFwlrcLC8jG8xY28tUpzBv484bTt1qn4QUN5NjAR1TXQ970kyl12UeqGZHa+B0cCSR68zrnag62PV1v6u9iDLk7OOomzGeqitF+P4lnWeMhKdjMKG1KlU74/1GdA6JlD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT9TiMn8fCfYuFAz9/p8gjs8ol/FhfFwFX0TadnKOXA=;
 b=Pk8TUc9KWsywUVrNr5I5SaH+ZtW31s+FTZ/kMf/coVkAX7vqwyKjFrIgzJfUOWLmXCVnSuJpK6tEVBMd8hnVJ/nAsBkWOS8HFFSfdw90zvsHniCl0ouC/IfEKEUXJ757vyRd5Tw1lb1RNx2XzgBxrT6vmicFE7y1ozvJtxN6GePyz28R9eFvDo3orpb5x7qyVBI7209SdHCe96LzUFCidVowK7cpa8rI8FUg7r7KLi7Of1fzN8NVGz30n+MwtAtmqYzt6r4bDliq9opubabK1jKqXbIiP2VMbdGVbi6SEayrFxpimbzrxeqxzAu4Gxg6F+6jgSZerXEosJbqrnW5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT9TiMn8fCfYuFAz9/p8gjs8ol/FhfFwFX0TadnKOXA=;
 b=j7vKzcLhM1P5jDRL/PZD/Ef/GR1bUZmvB9TlNP2eInZCrPiDJEV2q8jjkmLobD52p04rMPpOqBrSmbkUhNU6+JGSzHf0J2T3PF5dgcyyU2PBVXj6fLExf45QABQY+KFG08flrttyH4XBDR+2jddm3VAtMRb1A5rWbu84PjEraOw=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4231.eurprd08.prod.outlook.com (20.179.18.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 09:48:12 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 09:48:12 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5ICAAhFyAA==
Date:   Wed, 25 Sep 2019 09:48:11 +0000
Message-ID: <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
 <20190924021313.GA15776@jamwan02-TSP300>
In-Reply-To: <20190924021313.GA15776@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.32]
x-clientproxiedby: AM3PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:207:1::17) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e134c436-91da-40c7-9182-08d7419d807d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB4231;
X-MS-TrafficTypeDiagnostic: AM6PR08MB4231:|AM6PR08MB4231:|AM4PR0802MB2161:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2161BAF9BA690B758F5B3565F0870@AM4PR0802MB2161.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
x-forefront-prvs: 01713B2841
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(102836004)(6436002)(305945005)(486006)(6862004)(44832011)(6246003)(1076003)(7736002)(2906002)(14454004)(86362001)(476003)(229853002)(66446008)(81166006)(81156014)(8676002)(11346002)(446003)(8936002)(6486002)(64756008)(66066001)(58126008)(316002)(66556008)(66476007)(54906003)(9686003)(6512007)(66946007)(256004)(99286004)(4744005)(25786009)(4326008)(478600001)(26005)(186003)(3846002)(71200400001)(71190400001)(6116002)(386003)(6506007)(6636002)(5660300002)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4231;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: sDkKLmIQzTa44AB9zscpluNU4dhVKCTfuhMlcOgpqvaC4WsZHnxYw9whVJreYTq8707VCYArvGCZzYzj4RgJ56caHBj7nevRky8zl18u86mgwx/6XoDkvZVPX+XPmzLdtKqhWM/DEaosL60dH1sd9y9M2hTMLNuMSLu3naszfxaJvXW1cjNMJXALXcpXPfYMH1RSSwsyJD/7ClNuzDWVIfjCWKW4kzbjDOP4EdaeuBYFZ4rZtzZ4Yj9W1UalZ+Rlr0J1FmFYlrioOwHzUSwpBS1Lssr/Y7WTGXEzcNeOD9G6kXBQOqcLMQ+UiOk/FTxXhok2XpPvIDRCi5ioQL25qBh43EoMycJJwCaCzD6r/k5sloNBz3W7DmjLxQcec9zOLLsSK0CtXHEWPYHFocKPTTCABwt4gNpBD+5qR9xVFDM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD3FA5EF4B04414FA91BB47E413CA53A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4231
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(199004)(189003)(81166006)(58126008)(4744005)(2906002)(316002)(50466002)(23726003)(76176011)(99286004)(22756006)(63350400001)(14454004)(47776003)(229853002)(6486002)(25786009)(97756001)(478600001)(3846002)(66066001)(86362001)(476003)(486006)(81156014)(126002)(356004)(46406003)(7736002)(26826003)(5660300002)(8676002)(8746002)(305945005)(6862004)(26005)(6506007)(9686003)(6636002)(6246003)(6512007)(54906003)(186003)(76130400001)(6116002)(4326008)(336012)(70206006)(446003)(8936002)(1076003)(386003)(70586007)(102836004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2161;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79ba2cde-347d-4f03-34a0-08d7419d7a51
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2161;
NoDisclaimer: True
X-Forefront-PRVS: 01713B2841
X-Microsoft-Antispam-Message-Info: 9dfwUntRTQs7uznmJBIwQI5p6Wun2bPwMSs2kYozaA8PELwnj5DVOMtP1Li/GDb28gg97UleUmulSCwHjAXGqQnWbgw2HKAhVO9Xz+Bhx45Z6X4QmybMLIdc2avig219Y/qSdJnPvmnKSFfxdJXtfg2P6rqc/6MPWt6QkZORVr6RKaIW8s3/iiqvsYbM1nXqBOaEnpeNSNzhxSNgd0DGqPgn/UvpdXLmvYDoEns2TOffLo94JEsSJQ1r8fG2A5pD1lHSm8KeXUVS4x7MwkJiLZpYkvFAeCcDZDOGfse/g2dlPopJcL1fRGEsMMvnPyswcyrXUYDLhJWPSEq+Hhd2apdZDEuVi/dDDHEMY0sKyCsVMQplPF9rOLayCeDH0mNygPOe2wRMlSWmcVoKmn9J/dP3/bARvXotO7YKGN9f63w=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 09:48:21.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e134c436-91da-40c7-9182-08d7419d807d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Sep 24, 2019 at 02:13:27AM +0000, james qian wang (Arm Technology C=
hina) wrote:
>=20
> Hi Brian:
>=20
> Since one monitor can support mutiple color-formats, this DT property
> supply a way for user to select a specific one from this supported
> color-formats.

Modifying DT is a _really_ user-unfriendly way of specifying
preferences. If we want a user to be able to pick a preferred format,
then it should probably be via the atomic API as Ville mentioned.

Cheers,
-Brian
