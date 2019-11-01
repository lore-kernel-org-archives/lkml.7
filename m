Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E51CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A13208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m9LpPqgI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m9LpPqgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfKAHSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:18:13 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:15155
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfKAHSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46CzLcWXD4HYYn+903EucSbZGVfkNKRZbANPHKz/d2M=;
 b=m9LpPqgICl9Qt4P7b8lQJ0HXHhDP6hcVvL5R8CwDQHcucArB6Rx3TTQ0eauZY2S/bupnlEDTvrcg/4OPuMCZJ0cihW8gCXYaV+ZK54sk12m8u5tLWSnjINHJgW5hlD98gLpo2JmeoRDEohU/539lNTO6mjjr3RkyBRMMfthDJ4c=
Received: from VI1PR08CA0132.eurprd08.prod.outlook.com (2603:10a6:800:d4::34)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 07:18:07 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0132.outlook.office365.com
 (2603:10a6:800:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.21 via Frontend
 Transport; Fri, 1 Nov 2019 07:18:07 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT064.mail.protection.outlook.com (10.152.17.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 07:18:06 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 01 Nov 2019 07:18:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8e478189bd47c151
X-CR-MTA-TID: 64aa7808
Received: from 1582ad77d078.2 (cr-mta-lb-1.cr-mta-net [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7F27E53C-A958-4144-A5A8-240BA3AD4358.1;
        Fri, 01 Nov 2019 07:18:01 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1582ad77d078.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 01 Nov 2019 07:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNwzd9ytvczzHQ8Z7QlMnuPlnycCyymaY55LwfiBLQ5tbNeuUcJDFMX3TY99mmO7Ok3oDB20JIK5c7UoqxB35rO1ia7snGpri8Udm7nKDixFEGpafuHsY2jdTgYAWgY5Sx79bM6pu+YpomzgrAOkKondJJ5+8zWMj8zXaOSffV6ZoJVCG2Dws2nzuHCPXL1oltAYb8hQ2V7MnT+X+8iVnBBQ55lA0Uiaj48f10EgK+iRUFl5131cUWK1bgHN7yA4bs2oCR8JimIPbxHePA50Boyqo+ZHn2DUp86cjvre/EYsOiccaT+GZu9jWRfdnIqr8Qngoq7xhh8aewVjQQisug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46CzLcWXD4HYYn+903EucSbZGVfkNKRZbANPHKz/d2M=;
 b=F6tvtyr1i8CqELNQ11ELDMq0NscHYYuxqonEoWIJXiZkunKsseFXe5lvLlaAwZ571q+NWWW35XeyqY35CWvfid4TcXSx8zs4IIj/KObB3X0pQDG7rAIFC83fa9L5Mkm+lQfRTUivraT8b65tHYVJMEnI2I7H93TdgPl2vi/w/NX5L/NY9N6Qty1Dz0WrpszASbCPW3IYS8ocT5CANoGXv4roQn7Q2c5FP78m27wfH54mRXwnW8/zRAxnr4hRr2jusfteDo5cS3rIf1E6zrTKD1eRLLIaAz0j9ah3ptzJjsbcafu2xVRKw4VKzUbM5GT3FKgy4xeIvzboNbFrbooE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46CzLcWXD4HYYn+903EucSbZGVfkNKRZbANPHKz/d2M=;
 b=m9LpPqgICl9Qt4P7b8lQJ0HXHhDP6hcVvL5R8CwDQHcucArB6Rx3TTQ0eauZY2S/bupnlEDTvrcg/4OPuMCZJ0cihW8gCXYaV+ZK54sk12m8u5tLWSnjINHJgW5hlD98gLpo2JmeoRDEohU/539lNTO6mjjr3RkyBRMMfthDJ4c=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4974.eurprd08.prod.outlook.com (10.255.158.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 07:17:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 07:17:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [4/5] drm/komeda: Add option to print WARN- and INFO-level IRQ
 events
Thread-Topic: [4/5] drm/komeda: Add option to print WARN- and INFO-level IRQ
 events
Thread-Index: AQHVkIR9MCG/HO2UX0CjwGVVCbb79Q==
Date:   Fri, 1 Nov 2019 07:17:58 +0000
Message-ID: <20191101071752.GA30286@jamwan02-TSP300>
References: <20191021164654.9642-5-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-5-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c472a3df-99c1-4db8-5755-08d75e9ba496
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:|VE1PR08MB4974:|AM6PR08MB3288:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB328872EB6AFD368A0D09CC22B3620@AM6PR08MB3288.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2657;OLM:2657;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(25786009)(8936002)(6486002)(6246003)(81166006)(229853002)(14444005)(7736002)(71190400001)(476003)(478600001)(5660300002)(486006)(256004)(8676002)(2906002)(3846002)(71200400001)(305945005)(81156014)(6116002)(64756008)(55236004)(66446008)(102836004)(66066001)(66556008)(86362001)(6506007)(4326008)(186003)(6512007)(66476007)(6436002)(316002)(386003)(6862004)(76176011)(99286004)(26005)(54906003)(14454004)(52116002)(33716001)(9686003)(446003)(11346002)(1076003)(58126008)(6636002)(33656002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4974;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gtTBy8asnB3Dj61F6rrpcIil3eM9mtJxemUgNi5BGKkzyCLDicOFcGVAet9QvmEM9fJm6fTByYKAttQXGAdXIrHOnVE3pNfPZQwpeiF8rWgJLlIKxgpZ/s9UM+34eMOezWGqzjrICcf6D56bJBSeL33WQW+Z0cS26xvqPsrjOw3h9vK2gFPLCWVMq/2E4TnRqiB9B8BHKXKsssCXEDcB6MwKTExZRGwb10vdIDXiaVsDtMP/OvpPcqrhmR3PlWywDrZATRCWehwofCPNQ0ocCKOQYEcYYgzzJJ3WJuj7rEo+3t6i9pHsiCXeQe8ZkPwI6rd+8js0A6MPqrBabzEw1x1vBRG8/MiEqk622IlzBxr92/Qq+d4Ypov7OuEha1BGpA9zUtppyaLEbb+t2hRpuah/j+utGTHIFMAuNWgqnuyFcJbrYaWY7INQ3XwbfN9B
Content-Type: text/plain; charset="us-ascii"
Content-ID: <092F577709399D4796000526588D0262@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4974
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(346002)(39860400002)(396003)(1110001)(339900001)(189003)(199004)(8746002)(3846002)(81166006)(36906005)(2906002)(446003)(476003)(11346002)(23726003)(6116002)(336012)(47776003)(66066001)(126002)(54906003)(22756006)(316002)(229853002)(486006)(97756001)(8676002)(102836004)(58126008)(4326008)(50466002)(6862004)(76176011)(46406003)(6246003)(99286004)(6506007)(386003)(107886003)(7736002)(305945005)(81156014)(9686003)(8936002)(6636002)(26005)(33656002)(1076003)(26826003)(6512007)(86362001)(186003)(105606002)(25786009)(356004)(478600001)(76130400001)(5660300002)(33716001)(70586007)(14454004)(70206006)(14444005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3288;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63318e00-aa30-46ea-daa9-08d75e9b9fb5
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thm0ITyfzBGYmFTPCRL9R5dzY28gGRNZc+jquOHRORXN25G+M7BC3MAc976/T5ju5j6eSiH6l7Cz8hP9sr+dnlmtY5l5+1SvlyFEl94Uasj9gIv5XxjJ1gJLvSJmbChM06tabR6eXZ139NK06FWsGExXF0yJ2J0RmQShhBKtwvkkZNE5twSimlCC3Hdx1XjCpUHHzkCNfIX1d1R9mIf5Lz6XgbOUE85/XvzRHDr18I+qacw4rIEHHUa9AWQyr0Z8VV+1pHCXuxk0GR/pKLT7zH3vqbSXZpxSOI0mEY/Ai8txFHeGsQqjcudLEdgedIk3juuKRTaxFO0yRF+K2COJKoRSYKEl2P6oR8TzyodWaBMP0yiC7qh9lxGhAKzah+1jUn9gmzcVaX5SZ82/16YjYgOV4HsSL9RnjTFFVcQbiOrVk4ePEKEL8or2oPP3yWL3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 07:18:06.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c472a3df-99c1-4db8-5755-08d75e9ba496
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:47:29PM +0000, Mihail Atanassov wrote:
> Extra detail (normally off) almost never hurts.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 11 +++++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c |  4 ++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 4809000c1efb..d9fc9c48859a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -51,6 +51,13 @@
> =20
>  #define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
> =20
> +#define KOMEDA_INFO_EVENTS ({0 \
> +			    | KOMEDA_EVENT_VSYNC \
> +			    | KOMEDA_EVENT_FLIP \
> +			    | KOMEDA_EVENT_EOW \
> +			    | KOMEDA_EVENT_MODE \
> +			    })
> +
>  /* malidp device id */
>  enum {
>  	MALI_D71 =3D 0,
> @@ -211,6 +218,10 @@ struct komeda_dev {
>  	u16 err_verbosity;
>  	/* Print a single line per error per frame with error events. */
>  #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
> +	/* Print a single line per warning per frame with error events. */
> +#define KOMEDA_DEV_PRINT_WARN_EVENTS BIT(1)
> +	/* Print a single line per info event per frame with error events. */
> +#define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
>  	/* Dump DRM state on an error or warning event. */
>  #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_event.c
> index 5da61e7d75d5..bf88463bb4d9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -124,6 +124,10 @@ void komeda_print_events(struct komeda_events *evts,=
 struct drm_device *dev)
> =20
>  	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
>  		print_evts |=3D KOMEDA_ERR_EVENTS;
> +	if (err_verbosity & KOMEDA_DEV_PRINT_WARN_EVENTS)
> +		print_evts |=3D KOMEDA_WARN_EVENTS;
> +	if (err_verbosity & KOMEDA_DEV_PRINT_INFO_EVENTS)
> +		print_evts |=3D KOMEDA_INFO_EVENTS;
> =20
>  	if (evts_mask & print_evts) {
>  		char msg[256];
