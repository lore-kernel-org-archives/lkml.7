Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701FC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327AB2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CpSDp4B6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bU0fiz1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLZIYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 03:24:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15473 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577348684; x=1608884684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cPuJw2yvarJ9pwQ8Yz1HzHwUzezhlGfR+jmUOR2hpZ4=;
  b=CpSDp4B6/ZwDCpJ96IyYWhSxMOLkysjwR9xQXj/B+TcptempUrmsLi3Z
   +ktwGmjc6ugprs2fWnIvMOO4ngyOsyamuo2RTWNmlmr31ha4x4nRVncEG
   W6Tyl0VHqQTO1Gbe8WAeHO/O+cbVuJ+P9d0Qmr/xOP5UvDEpIKNd/hnRq
   fHK/th4LpY32tO5AHw9tkDQwhaeXk848HSXoxcWi4+sp+GblONAoCWlFG
   FfY8QvRVM9W8gO1+gjsg1F2Hk4Znuxfi5ROQZ0Ydl90x0mN/mmRg6+gXi
   LcJzQ8dUnLmOD1m4VEmfbFgNHUdiMOX+YHhj5dKtMFVpv1MZuBAM4zQvd
   g==;
IronPort-SDR: 5pdf0nPJaxkT8CI0955nRiM410LWtwEJn+fcFamLnLM3bXQi0euRnJ1nDDjYOvu9TORlKcQxTb
 f9PVbQO5NYfrgIlsgv2bB0agR1mjJywUCq2oAnTYBcIUfvSf/6l2KoQkUYZYogNLJcKP2PMHZv
 lF8W+RWhhUTOBoWDKh+6XsXOBeBfOwAv5yn0e+/xsVBQqhhW5+66CLMwoAXD3jZ3tA00DWbKbg
 a7na+OehtUXc35aK+oZ5EvMdVtfpfzLYTPR9WB0Zki+VhkCEwf38VeNINJOhSmW/mtMpHdW6OS
 ylI=
X-IronPort-AV: E=Sophos;i="5.69,358,1571673600"; 
   d="scan'208";a="227816934"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 26 Dec 2019 16:24:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQpReVjNrLJyaL6YJmmb3lZFj6zjsOQts3Efty8Q7vH8u9coGr+f5+HXVkeW7WtGozx9C73AlIt/VnXnjGWCVr3SfL/lNBzLc9lMhocVBNuV8N2YLTZSiMlahj/FbzgGoeyW/AdCxpOsjblHFbx9Rj25aeWG52cH3YON0OPOMCZ7C0MH54LgkjpxCPQHm+Dd0+fXH5WmCNEM/YsSI8A7WIeMRr5CFZDPE7+gM8o8xTxCqAzGFj1NjM7wY1KbrWz1JQn/1mmL+WcgVGoMAIH7VxhclDsMB2UWP/4gFixttX+QwTLyMo7yjrsucC6Ln4WUfPntG2vDInnFrYdtYZI+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPuJw2yvarJ9pwQ8Yz1HzHwUzezhlGfR+jmUOR2hpZ4=;
 b=QvXN2nHfZhwUGsjrY6jMY49X4KvH/ggfGtH5JiFYWw/tvsdL7ULHUMWrrxiprmt0q+5gfRBG1HOCo+F1z01u10MP4flZ12Q1gFUNQwx+hYv3Wwi/JqfRME5+Sp4KzjzFZXUnmtG0PJYT+FJV2xgreOlpvlSIE8GTK8g7n0WhilGVaGcpCwKGeqNihhZcyEicYBlrjjNNBg2FA1JwIUA1B7VVPsuW8x5agXDJslAGYtAUxu/f02fjQ3XzXABTr2BH0CLLxWA8PHsM7P4NXCL57DhzWtSzniEOTuJpQlUESC3LrdH+lwOwvr5WbjrHp2tos43VA7hfuc7bOawQvg4eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPuJw2yvarJ9pwQ8Yz1HzHwUzezhlGfR+jmUOR2hpZ4=;
 b=bU0fiz1mhpNEkm6LFW/VSw/7YCu2OaG8iEQWghhjTvqiMfWGrIpIHAHAzPE07QfRX2Myv1OUD92ed8crRYBpLco/lUlzjcYUufUH/oiYIw3ZVZAd9cjVg7aXldAIjHCJGEANH9EpQiygJQEfOnoVPTFg09MMStS8aP6jmZTPvT0=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2220.namprd04.prod.outlook.com (10.166.204.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Thu, 26 Dec 2019 08:24:20 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::30f9:4a94:796:3014%12]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 08:24:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yuehaibing <yuehaibing@huawei.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Topic: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Thread-Index: AQHVulgQExCdjuBytUKA1yv69qLf+qfLyO2AgAAnP4CAACbggA==
Date:   Thu, 26 Dec 2019 08:24:20 +0000
Message-ID: <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
In-Reply-To: <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2e605b4-60a0-47bc-cd27-08d789dd01af
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB2220BE5D6F61DFED496A50C3ED2B0@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(51914003)(189003)(199004)(86362001)(91956017)(76116006)(2906002)(66476007)(66556008)(66446008)(64756008)(66946007)(26005)(53546011)(6506007)(186003)(44832011)(6916009)(6486002)(1076003)(81166006)(8676002)(8936002)(5660300002)(4744005)(81156014)(478600001)(71200400001)(316002)(4326008)(54906003)(6512007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2220;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8iG05Bl8xb2Zl/Ebhp0IxF7MsDo8oUDjjN+l//uw/YwFPoZd94W1C1+y6e+sT6zKzpYpoAWJbnkMKXPmlz80CKyia3eiQoPA0/sNkEv7//ZYpUlBzihlzpIPw2zRVWM9fh5+P9z6gpIff6LFZxL9m2A30a8QWYJlTm1XhWBKQG87iAaeLX/5e2KTbW7d2JclQfOZNBdHAX2O/ITmVAQgp96Un7T+6wgSU+XT41ABrYsjRX/1wFPhK4jzQnkwFYeSJMymqExje5z4LFOh8Z1rHfNVxZ+gMI5VLj+puQoLk9EoETGO7Mv5RMV0MO642Z0Ar6+E6E4U3pJvNBX/UO0MnfWHtbnLYN22PFZCO78Mf1TiZ58KfDUpk0U5aD18iSAmGm5XDu4Ew1UrPH0tOY09WT+eyR6VmBIdDJixRWbl9LZbZB6h3hw/BfKE5WDgZu0gQDs2uUqttQpgfl+G7TIfw16xy0cxissZyvyNmLy4VZ6EDNiTIioow4GYoYapxhE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3DB1CB9FF0F89428F2A8D83562F7903@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e605b4-60a0-47bc-cd27-08d789dd01af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 08:24:20.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvmm/CQhjlKjuA5XBjA+jvqfOhq++TuUUqdYjHCsXRaBnvag624YrF1ApeNK7MwQOGpglRQ7ckIPVWqiedIONQ99PV9hB4xgs5t8EyGhzus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 26, 2019 / 14:05, Yuehaibing wrote:
> On 2019/12/26 11:44, Chao Yu wrote:
> > On 2019/12/24 20:43, YueHaibing wrote:
> >> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> >> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used=
 [-Wunused-but-set-variable]
> >>
> >> It is never used since commit 362d8a920384 ("f2fs: Check
> >> write pointer consistency of open zones") , so remove it.
> >=20
> > Thanks for the fix!
> >=20
> > Do you mind merging this patch to original patch? as it's still
> > pending in dev branch.
>=20
> It's ok for me.
>

Thank you for this catch and the fix. Appreciated.

--
Best Regards,
Shin'ichiro Kawasaki=
