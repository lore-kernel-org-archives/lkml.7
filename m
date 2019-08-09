Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC13C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A854D208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dbpdOFsv";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dbpdOFsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405676AbfHIGbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:31:49 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:17127
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405592AbfHIGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJVvsrYriM6vX5vpnDCPV+c6fnuOb1vgTSkgAP7bjI=;
 b=dbpdOFsv2BeQhRrT7NoH6jl8EV0Q7NeCGAx+IOV+pZrgf0F0xpoVRjCgVtgJ2LJQXYLrEw0Ll3O/96qHkUO/xeJZVYf/7Afz/TuWcB6nPZswR49D9XzzayaH93SRTZkYHKOHdqToGDzJPCz5dlpz7bzX/LeZTW2EB9QiA9Dzcgc=
Received: from VI1PR08CA0239.eurprd08.prod.outlook.com (2603:10a6:802:15::48)
 by VI1PR0802MB2608.eurprd08.prod.outlook.com (2603:10a6:800:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Fri, 9 Aug
 2019 06:31:01 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0239.outlook.office365.com
 (2603:10a6:802:15::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.18 via Frontend
 Transport; Fri, 9 Aug 2019 06:31:01 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 9 Aug 2019 06:31:00 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Fri, 09 Aug 2019 06:30:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8e49e633699c8c43
X-CR-MTA-TID: 64aa7808
Received: from d7d30ac0c16c.1 (cr-mta-lb-1.cr-mta-net [104.47.8.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0190F177-C97E-467A-A271-BCF1B32D4269.1;
        Fri, 09 Aug 2019 06:30:50 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d7d30ac0c16c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 09 Aug 2019 06:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMJspDqMxB2mAlesh1L3z1tAhfyXjghNaS2mj/aclHz5HrS9ftE9oh+U96dLhjBa+MQznn4lZ0JR9PuMg0qksxxYHl5YkuLSAFt1c8XlCzGycOVKmeomH/Az1NXyLdn6rUjpYAgdojR7sYurLzciALgyIdfNR3QlTtKiiml5kSYm2EyVZXf1mSx8pZrWV/q7R28D19ixRXA5JMDtbQD7rZ8jA6tUVafVRb43J7S6yF43vYIfdhRJZMiryFg7G724iC0caVILEf4UAfgzfV2FJ8ODEKHsBHsFb+mInmrIAD31rv5k1eAxqI1GjRawhgzDeMe+gA8umHMGdOvKYjRG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJVvsrYriM6vX5vpnDCPV+c6fnuOb1vgTSkgAP7bjI=;
 b=cMLDpj6fyXSAoWYZW9WYAVZHLP+Yp8VFNfto782Z7gcOxa7ivQiYljasnDBJkP/77/SPkYQ14ecSRoVD5z+QSXqVROscizMxc3P0r0Kqv9fTSDA2tfiXpLWjfES+e6JQU47ZnLd2/l2oLcjqy0GaMe+ulkzKbAcILaHmfa4ClrgGg1NSkCAbjPg6XdUqf32fAJaXxBXPeV/D6eW+Q88U7VdC0U30rMuUfD6vP5f7sVG8whPCTEr29wIeT6H08ssARliAcOGbdfeNP7ZdD2tc2MDpyKxtsfCjl9g2b1LCG+pudIXtRtlGPNIP+Lg4sEcsRfVZcm9Z8ci0keF+7FpQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJVvsrYriM6vX5vpnDCPV+c6fnuOb1vgTSkgAP7bjI=;
 b=dbpdOFsv2BeQhRrT7NoH6jl8EV0Q7NeCGAx+IOV+pZrgf0F0xpoVRjCgVtgJ2LJQXYLrEw0Ll3O/96qHkUO/xeJZVYf/7Afz/TuWcB6nPZswR49D9XzzayaH93SRTZkYHKOHdqToGDzJPCz5dlpz7bzX/LeZTW2EB9QiA9Dzcgc=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5200.eurprd08.prod.outlook.com (20.179.31.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Fri, 9 Aug 2019 06:30:48 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 06:30:48 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Initialize and enable output polling on Komeda
Thread-Topic: drm/komeda: Initialize and enable output polling on Komeda
Thread-Index: AQHVTnv7tNBLsk0CHUyRBWgRU7wKgg==
Date:   Fri, 9 Aug 2019 06:30:48 +0000
Message-ID: <20190809063041.GA31698@jamwan02-TSP300>
References: <1564733249-24329-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1564733249-24329-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:2e::33) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a6d9569e-eded-4dab-409b-08d71c9324fb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5200;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5200:|VI1PR0802MB2608:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2608AAB4E099148C071592DDB3D60@VI1PR0802MB2608.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:747;OLM:747;
x-forefront-prvs: 01244308DF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(9686003)(102836004)(229853002)(6512007)(11346002)(5660300002)(476003)(86362001)(6246003)(25786009)(55236004)(52116002)(6116002)(6506007)(3846002)(66066001)(58126008)(99286004)(26005)(4326008)(5024004)(316002)(478600001)(186003)(6436002)(66446008)(64756008)(6486002)(66556008)(14454004)(446003)(66476007)(386003)(6862004)(76176011)(81156014)(66946007)(53936002)(8676002)(71190400001)(256004)(54906003)(81166006)(33656002)(33716001)(6636002)(2906002)(305945005)(7736002)(8936002)(486006)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5200;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: AJRC527uFqFvUGwcpdAiXM3ZMPhfP6BKZUbf5TcLlWsUxx+Zh5by1BtDJ2p6watJnHExAKZ8yb1x1uhWShlEhGAckv2E54FMSlwdWUbnrFUjufEw6CvgCiTslUWjfq/I348yBqACIMMiAViLTihPzAukJCHWQgzW1bQleMvShuFvIQpK4/BNKgj11D4O3TBt7GKVmwWW8q0aGIifNRpaVUAIPP283d2PzSKhzzGx7Zn1DPujAqC2+Q14FldXdLHZ6GpHvT13jgGUHXj/ReNXgFtXfS2j/oOLQL0pOX4DjX4bQrSqtKuFLowwQUKp3QxfQUmzVV23eEyZZIxDjeb5EG7BbL/+ViqnqHnDUzHcLQoRcmL6BP5KbiCjcLcka2vLe9tB190iXPvum6no+K0BuNR+Yjuziv7cKsvlzxnJet0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <907FD6867C61C443B84FC7734BBC5303@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5200
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(189003)(199004)(23726003)(6116002)(3846002)(86362001)(46406003)(33656002)(8676002)(81156014)(81166006)(2906002)(22756006)(229853002)(6486002)(1076003)(356004)(6636002)(33716001)(70206006)(70586007)(76130400001)(50466002)(446003)(9686003)(6512007)(5660300002)(8936002)(54906003)(8746002)(4326008)(336012)(478600001)(14454004)(66066001)(316002)(36906005)(6862004)(11346002)(486006)(99286004)(126002)(25786009)(476003)(6246003)(58126008)(97756001)(63350400001)(63370400001)(47776003)(7736002)(26005)(76176011)(26826003)(6506007)(186003)(102836004)(305945005)(386003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2608;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c07abc46-569a-4e12-133b-08d71c931d99
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0802MB2608;
NoDisclaimer: True
X-Forefront-PRVS: 01244308DF
X-Microsoft-Antispam-Message-Info: KrbeS0zn8gOc0RcNtvktR/NO6IXl4XZlh2FkwOaXWonhp0EIlC6ILFyGgfto5UqeEnljl7O6MTngB1w1XssmOvM6nJR1XODrem8dT4DT1LkzrKVE8FPFjmNKUTjKxOuc8ahz/8mV87Q/fWH3VsBSXsbKvVkbegf+/MSS2sMA/PWtB9r4/MLrlHxuts4SzmeO4DmHU+1efNaGxoNLNW6vAOwPx8Vp4fjn292u9majCB7jRPhBvrHzOO+zHz3cOE5OS7jBKjG2XxZFTqdTeBM8LwJsk0PlZuN0KmG/BA5Gvy/iDT8S+1UYdRbfPCTBiqOKizEOflJD9+ZFBTTtwmEPQTS0z+XRliEc0lCebS7cAO1svJp8+7+S4uJXBHWPMNI8v8gVJnY66ifxaZMXBYtbR2vk1r7uua69tc6B6pC+Ysg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 06:31:00.1660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d9569e-eded-4dab-409b-08d71c9324fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:07:52AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Initialize and enable output polling on Komeda.
>=20
> Changes since v1:
> 1. Enable the polling before registering the driver;
> 2. Disable the polling after unregistering the driver.
>=20
> Changes since v2:
> 1. If driver register failed, disable the polling.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 419a8b0..d50e75f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_probe_helper.h>
> =20
>  #include "komeda_dev.h"
>  #include "komeda_framebuffer.h"
> @@ -315,6 +316,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
> =20
>  	drm->irq_enabled =3D true;
> =20
> +	drm_kms_helper_poll_init(drm);
> +
>  	err =3D drm_dev_register(drm, 0);
>  	if (err)
>  		goto cleanup_mode_config;
> @@ -322,6 +325,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
>  	return kms;
> =20
>  cleanup_mode_config:
> +	drm_kms_helper_poll_fini(drm);
>  	drm->irq_enabled =3D false;
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
> @@ -338,6 +342,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	drm->irq_enabled =3D false;
>  	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
> +	drm_kms_helper_poll_fini(drm);
>  	component_unbind_all(mdev->dev, drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  	drm_mode_config_cleanup(drm);

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
