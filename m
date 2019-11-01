Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728EFCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357102080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3KahQf0q";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3KahQf0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfKAHPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:15:01 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:4682
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729817AbfKAHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9mg3aQVUXkDo8mZsNdIYAcLjUb0uzG2g5GjzDw7CJQ=;
 b=3KahQf0qeJxQx7AWu684eZo4BYVkidfX2YayXQBLA25k3nFW9GvnHDVF2hsWXJGgtoAkCCd9lSAZpUY8us11d3vIY8K8Py/c5VpCAbMcJpMRh25t68E8u7QqfuqjvqChB9UfB92LmJkau3XVA33+K8kDnp8+Gpj6vnJo7vYC+A4=
Received: from VI1PR0802CA0010.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::20) by DB8PR08MB4121.eurprd08.prod.outlook.com
 (2603:10a6:10:aa::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 07:14:54 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR0802CA0010.outlook.office365.com
 (2603:10a6:800:aa::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 07:14:54 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 07:14:54 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 01 Nov 2019 07:14:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1b0c57a1d05c6cef
X-CR-MTA-TID: 64aa7808
Received: from 1ef925b322fd.2 (cr-mta-lb-1.cr-mta-net [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id ED496886-E030-4AC5-BA1F-32BD6D033626.1;
        Fri, 01 Nov 2019 07:14:48 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1ef925b322fd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Nov 2019 07:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9U5OiSaQaTprGn72YmonCgQW+I//htMNQTXh6cJSGqXEQNK223gkjyLFyskQLctMw+z5dHaJ1RzCOdEJ7taALWOeCcTrOabro/vKFW6z2BZSTVlwGAViPcOsHqhdP0yZowq05nNONxfCs3fEyCXbBAkhhVlJzD9niFKgJ76t9AJjAgAluvBQBjOxIcMqhfp5pLsXW9379DwgPf/f/4B6XVTnCuTcNnINx9+gwPBkJfmsD8yaWTS9XgoMcXZ8A3Xip+z8RUAEAzyl2/HWbyAB5D8npzpBD0DEYTKvhd/M9qPhTU3NyUPbuXLkOKVv45rJNprymYeQfpqrSHHhbNnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9mg3aQVUXkDo8mZsNdIYAcLjUb0uzG2g5GjzDw7CJQ=;
 b=kdiQdMkL2QIj3g0SPHlgwGVabHu5AFE92mTpDQjCjxP+WDd2JlqqY3qzQJddXV9YUK1eUXb0hexajje++kt4BiN46Mxlyd0/jBNw/UnbaBePHiXN6VQZ92ZYuXraFw8GskqUb8dMO/u8TzJHO+X7/HGYFi/aGgOuwjK1Ccxc8UaDmYWOFjDb1gLCFAtX0zKVX0bhvK1Tp1oAZJu/Bg24E39eor03FzCjoC/XpzpmYgGCxZ0YG6vPiPOF13xTMgpaOqSDWH5Iw1yKNCSyhNt6KW+46rKY29W0tlj/Tx5rSO1xQHMj7u0eiuOqYPCQA4eYGMCtG4KnHuDZkER9w3xZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9mg3aQVUXkDo8mZsNdIYAcLjUb0uzG2g5GjzDw7CJQ=;
 b=3KahQf0qeJxQx7AWu684eZo4BYVkidfX2YayXQBLA25k3nFW9GvnHDVF2hsWXJGgtoAkCCd9lSAZpUY8us11d3vIY8K8Py/c5VpCAbMcJpMRh25t68E8u7QqfuqjvqChB9UfB92LmJkau3XVA33+K8kDnp8+Gpj6vnJo7vYC+A4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4974.eurprd08.prod.outlook.com (10.255.158.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 07:14:37 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 07:14:37 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [1/5] drm/komeda: Add debugfs node to control error verbosity
Thread-Topic: [1/5] drm/komeda: Add debugfs node to control error verbosity
Thread-Index: AQHVkIQFrGO7Zbh2NUqSZ/aQ+92y+Q==
Date:   Fri, 1 Nov 2019 07:14:37 +0000
Message-ID: <20191101071429.GA29928@jamwan02-TSP300>
References: <20191021164654.9642-2-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-2-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2e48e95-3493-4126-a5df-08d75e9b3195
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:|VE1PR08MB4974:|DB8PR08MB4121:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB41212E8C5515565ED83BB5B2B3620@DB8PR08MB4121.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(25786009)(8936002)(6486002)(6246003)(81166006)(229853002)(7736002)(71190400001)(476003)(478600001)(5660300002)(486006)(256004)(8676002)(2906002)(3846002)(71200400001)(305945005)(81156014)(6116002)(64756008)(55236004)(66446008)(102836004)(66066001)(66556008)(86362001)(6506007)(4326008)(186003)(6512007)(66476007)(6436002)(316002)(386003)(6862004)(76176011)(99286004)(26005)(54906003)(14454004)(52116002)(33716001)(9686003)(446003)(11346002)(1076003)(58126008)(6636002)(33656002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4974;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: U5y2bMdlAgl1ikUr5igZ/yGKwJFG4fTz5RufrK3Xsg57syHS3O6bpnuKtQw7xoXDQkZEloKA9203GGks7ppQcURUAlGrzaBNA6FOqzK+eq9uqLdLxtajpmMnq2SenHZLZhH5j0WPnET5eS7/eUZFZz8iudXL15UKf8U4ppRcTgzcexE75ZpZnaUAlVppjHL0+pscwZ9ci/6nlu3zFBOTc7v9GGBWB6yOAoRT3SNTdDJ+3upLOC+y6hIbkCvvgGIqtYqL+A51lAf0lDRswDL1uIxzrqq6TrAWzJN/5pZBKUYJimGqN73AVU1YfjYCOOO3wuPlcX8onzwI6N2ngxUsGmWlT8SxmYvHqIAZyvfzw8J35C6nrS+zHvbXSzXswzgn/vYsPmGndyvJMO9upSj9wY5qSQHcpplgzJFmEI3YQjWRX9oU5Se/axF7umY7YJVd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A84F4C6716ADC846926F4EA01B30D87A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4974
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(39860400002)(376002)(396003)(136003)(1110001)(339900001)(199004)(189003)(6636002)(26005)(99286004)(6246003)(11346002)(6512007)(6116002)(9686003)(3846002)(70206006)(23726003)(25786009)(22756006)(33656002)(70586007)(97756001)(446003)(186003)(26826003)(33716001)(4326008)(316002)(54906003)(86362001)(58126008)(36906005)(1076003)(305945005)(14454004)(478600001)(107886003)(76176011)(6862004)(105606002)(486006)(476003)(76130400001)(336012)(126002)(5660300002)(50466002)(8936002)(46406003)(386003)(6506007)(229853002)(81156014)(6486002)(8676002)(8746002)(102836004)(2906002)(81166006)(47776003)(7736002)(356004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4121;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 446c4ff2-ca15-4ad7-82d7-08d75e9b279a
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkkRwmbtuwC0EgIqX0joW2z6gUI8lv1bKj7YRTrbe9qM8nmtWZ03Z5cLd0r8O7zccXxHKv+EDNC7ZBgqYbFVoIC7HJq1rWS2RHIYMZQAyMGjQ/8pgtAfV3i+dUrTtmeEIuNkhFzh8eJ7U2sTz4QGzRJ3V1VmG5glDH7pihH/op1oWFoBNdxHnEk9OC/bIqVV0ugOOlvf62hoynyGkVnhOARehWlruyYZM6AMgOgTun5A942Q0je9o9gwhe9VWvi923d8aW7d8I2DgiWXKJ6ssJoTYKusCx+w4KuIGY0DwA030X1ToeqG1K3e/62Sq4tcZHFolun9V7i3QQhTn7TTvCE41hIJ8n0nDe4Wllh7cgI6HXBxhiNK2HXf9zFnLPQ5gRYsWkKgA6eI5TDKge4m4HRaXPErcXPJKtzbDVrPNUvi0wCUw0YXyV7PVRIT12+3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 07:14:54.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e48e95-3493-4126-a5df-08d75e9b3195
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:47:14PM +0000, Mihail Atanassov wrote:
> Named 'err_verbosity', currently with only 1 active bit in that
> replicates the existing level - print error events once per flip.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 ++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 14 ++++++++++++--
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c |  9 +++++++--
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
>  4 files changed, 24 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 937a6d4c4865..82230c0ddec3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -58,6 +58,8 @@ static void komeda_debugfs_init(struct komeda_dev *mdev=
)
>  	mdev->debugfs_root =3D debugfs_create_dir("komeda", NULL);
>  	debugfs_create_file("register", 0444, mdev->debugfs_root,
>  			    mdev, &komeda_register_fops);
> +	debugfs_create_x16("err_verbosity", 0664, mdev->debugfs_root,
> +			   &mdev->err_verbosity);
>  }
>  #endif
> =20
> @@ -280,6 +282,8 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
>  		goto err_cleanup;
>  	}
> =20
> +	mdev->err_verbosity =3D KOMEDA_DEV_PRINT_ERR_EVENTS;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	komeda_debugfs_init(mdev);
>  #endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 414200233b64..b5bd3d5898ee 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -202,6 +202,14 @@ struct komeda_dev {
> =20
>  	/** @debugfs_root: root directory of komeda debugfs */
>  	struct dentry *debugfs_root;
> +	/**
> +	 * @err_verbosity: bitmask for how much extra info to print on error
> +	 *
> +	 * See KOMEDA_DEV_* macros for details.
> +	 */
> +	u16 err_verbosity;
> +	/* Print a single line per error per frame with error events. */
> +#define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
>  };
> =20
>  static inline bool
> @@ -219,9 +227,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
>  struct komeda_dev *dev_to_mdev(struct device *dev);
> =20
>  #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> -void komeda_print_events(struct komeda_events *evts);
> +void komeda_print_events(struct komeda_events *evts, struct drm_device *=
dev);
>  #else
> -static inline void komeda_print_events(struct komeda_events *evts) {}
> +static inline void komeda_print_events(struct komeda_events *evts,
> +				       struct drm_device *dev)
> +{}
>  #endif
> =20
>  int komeda_dev_resume(struct komeda_dev *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_event.c
> index a36fb86cc054..575ed4df74ed 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -107,10 +107,12 @@ static bool is_new_frame(struct komeda_events *a)
>  	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
>  }
> =20
> -void komeda_print_events(struct komeda_events *evts)
> +void komeda_print_events(struct komeda_events *evts, struct drm_device *=
dev)
>  {
> -	u64 print_evts =3D KOMEDA_ERR_EVENTS;
> +	u64 print_evts =3D 0;
>  	static bool en_print =3D true;
> +	struct komeda_dev *mdev =3D dev->dev_private;
> +	u16 const err_verbosity =3D mdev->err_verbosity;
> =20
>  	/* reduce the same msg print, only print the first evt for one frame */
>  	if (evts->global || is_new_frame(evts))
> @@ -118,6 +120,9 @@ void komeda_print_events(struct komeda_events *evts)
>  	if (!en_print)
>  		return;
> =20
> +	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
> +		print_evts |=3D KOMEDA_ERR_EVENTS;
> +
>  	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
>  		char msg[256];
>  		struct komeda_str str;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index d49772de93e0..e30a5b43caa9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -48,7 +48,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void=
 *data)
>  	memset(&evts, 0, sizeof(evts));
>  	status =3D mdev->funcs->irq_handler(mdev, &evts);
> =20
> -	komeda_print_events(&evts);
> +	komeda_print_events(&evts, drm);
> =20
>  	/* Notify the crtc to handle the events */
>  	for (i =3D 0; i < kms->n_crtcs; i++)

thank you for the patch, looks good to me.

BTW: for you question:=20
 | These patches are overall quite tiny, and I was considering just
 | squashing them into one, but I opted to keep them separate for an easier
 | review experience; please let me know whether you prefer a single patch.

I like the current single patch. :)

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
