Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE2C20644
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yIIQuX1/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yIIQuX1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIRIqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:46:05 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:30268
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbfIRIqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uozPW9wrGG1To1OhWRGdh4X8h8OqnA3+3yV9hyszeC8=;
 b=yIIQuX1/c7fgwh1rl3dAlSSKbCtYsFTL2kHpPZEdvEo1kXx3dcgiNrNnmXAX0yt7foTZYRquOURhgSUEG2U/LijSxXoHToPRoS/PqxbbejZ/zpvk1yPSdJlkmPqEjvoVzL8tl51qlljSIYhQCFJcYWKnmN4wGH0WvsZQtkAgw/4=
Received: from AM4PR08CA0070.eurprd08.prod.outlook.com (2603:10a6:205:2::41)
 by DB7PR08MB2987.eurprd08.prod.outlook.com (2603:10a6:5:1c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Wed, 18 Sep
 2019 08:45:58 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by AM4PR08CA0070.outlook.office365.com
 (2603:10a6:205:2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Wed, 18 Sep 2019 08:45:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Wed, 18 Sep 2019 08:45:56 +0000
Received: ("Tessian outbound 96594883d423:v31"); Wed, 18 Sep 2019 08:45:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 68d02fd94812b779
X-CR-MTA-TID: 64aa7808
Received: from d8a1bdaed9dc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A09BE950-8DEE-4FDC-886D-8D096D840428.1;
        Wed, 18 Sep 2019 08:45:47 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d8a1bdaed9dc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 18 Sep 2019 08:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc26Yb90ZZttYDX1xQruNJIui8+5rtS/FkJZ/Phrw/LjFrid87t4DOFiNgSNM9Mcew48b/fT0l2VrB2pK2Oi1q/aSWsvsfTAS8A/uilCW1PCzqKMawzXXX7qzwzgcl8VO1UC4nfNWXcKMn9CI4WtyrP/X3VDmOn7YEE9LOBF6aEQzzryd3AKb1pbdvEaF19AUOg+dWnc+nBEdAMokvHR7lsOXNDIsz+XbolxYXtVK2yR5Rn9JHVL0bfsOce31GeVKrZmSmS7nzyXRAwj8M1Q0btbwd6Hd/7osD1refrWGj4kFQiv3wdoCzsOzFxjG0VtkM+gyaohqcDZubAa+0t0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uozPW9wrGG1To1OhWRGdh4X8h8OqnA3+3yV9hyszeC8=;
 b=JCYuciJ/0wTm5IO2g+SpavU6n/MHS/LiXRg8oO4rgsnbL2/2/Mmw7delruklmAskRNENOHd3j+7iQyXqnYPpN55CCLWYJuoh5l4KC1vHuLS6OSUyTLi/3ySP4G9EJ7dbCdnDoJ1hJvGrIYsGwjr5hl3Us+yizjdbNl7SyUSRNB3ZoAJvevmrmbFgOAXMhGSWchZsxsupA/BBslJTXQAuKc97sSLt9uBew8wYj/VwxNawdtoiJPVQk4klDlhuTQ97lp+37MNuYU7ehAELLEuAIlwLdWSLmYGNqA/HjaKRn6I2ErGW4il5EElDVEpLrQ+OBm1JrQ/B3f21ArP11Xk9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uozPW9wrGG1To1OhWRGdh4X8h8OqnA3+3yV9hyszeC8=;
 b=yIIQuX1/c7fgwh1rl3dAlSSKbCtYsFTL2kHpPZEdvEo1kXx3dcgiNrNnmXAX0yt7foTZYRquOURhgSUEG2U/LijSxXoHToPRoS/PqxbbejZ/zpvk1yPSdJlkmPqEjvoVzL8tl51qlljSIYhQCFJcYWKnmN4wGH0WvsZQtkAgw/4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4861.eurprd08.prod.outlook.com (10.255.113.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 08:45:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 08:45:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Adds register dump support for gcu, lup and dou
Thread-Topic: drm/komeda: Adds register dump support for gcu, lup and dou
Thread-Index: AQHVbf12PeRzgf9iNUSXCU4D645PPw==
Date:   Wed, 18 Sep 2019 08:45:45 +0000
Message-ID: <20190918084538.GA21336@jamwan02-TSP300>
References: <20190917112525.25490-1-lowry.li@arm.com>
In-Reply-To: <20190917112525.25490-1-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8fe233-c7b3-4ccc-fcfb-08d73c149f69
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4861;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4861:|VE1PR08MB4861:|DB7PR08MB2987:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB2987387759385C5ABE0CA384B38E0@DB7PR08MB2987.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1332;OLM:1247;
x-forefront-prvs: 01644DCF4A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(189003)(199004)(6486002)(33656002)(66066001)(6636002)(446003)(305945005)(14454004)(7736002)(4326008)(25786009)(478600001)(54906003)(476003)(11346002)(26005)(58126008)(81166006)(81156014)(8936002)(3846002)(5660300002)(1076003)(186003)(33716001)(102836004)(6862004)(8676002)(6116002)(66446008)(66946007)(6246003)(2906002)(66476007)(486006)(316002)(86362001)(229853002)(66556008)(64756008)(256004)(55236004)(52116002)(9686003)(71200400001)(6512007)(71190400001)(99286004)(76176011)(386003)(6506007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4861;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: E7TbXTQn4YaHtDKgioczpfSCXq8zF63nQpJodZlhDsVhIoJluQs4BR3zosQHpweJiyJUoS1ky06N5SHOx5gPNSHaGT9zBCFRlcwRgF8oze3OvF6UY9ngAmBSEke1cH2spLvbWsQx58bPxsn1PHGdeiMgIbPJLBUFqA8CgOPKAQqRhK4fDF1KpdQi/wQ37Yq/UYYClZgpg9d1Ov63hYsYcLcWD3R2Rloc9iGuh+tC0rc+YvsHoQgqePX8EfVrlJd3kdthFZN++YUDtEiuGVU3V/sWrSDdzZJ8Vb4Hcn+fde2pz6QpWHAJTp4jypf7X+4I8nL3AXdpIXs2jZUBUeJKqb3KCl69DuBHB+6R9+yr7nROorKXH3vDgc+pPEOga5eyz4quvPinzsvl7AmUwqAvtUmHML3qnOH0uFA6uidyzGU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1DCF1D3733E0B4A9B27A4105951E9DC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4861
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(81156014)(1076003)(8676002)(50466002)(14454004)(6862004)(6636002)(86362001)(386003)(229853002)(99286004)(102836004)(186003)(6506007)(46406003)(6246003)(26005)(6486002)(8746002)(22756006)(9686003)(336012)(33716001)(126002)(63350400001)(6512007)(7736002)(11346002)(486006)(26826003)(478600001)(476003)(66066001)(23726003)(4326008)(6116002)(76176011)(97756001)(25786009)(8936002)(81166006)(47776003)(58126008)(5660300002)(76130400001)(446003)(70206006)(70586007)(316002)(2906002)(33656002)(54906003)(305945005)(36906005)(356004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2987;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aea5e035-1758-4759-73c1-08d73c149893
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB2987;
NoDisclaimer: True
X-Forefront-PRVS: 01644DCF4A
X-Microsoft-Antispam-Message-Info: iLYc0tHaJXnNaQxKoKyXjmuopTK73LRuNhEwlavsVuPIn/u2YnEqrefww5THvuFaI1e6KgtXN7F4brHiQ7Tj/3ldFvfhor43ZpWfLSjo1WzTdofArb22LcAf4S7nKWuPEUczMe2Nywd3EcaO42Z6FBW7O9j2Pc0vuIXzb94gxKMhUAfjhFrsltA9hRA7jCiFcHKz7zpW1Bz9BHzUPkkFtDX2bXG3Kk+97kfO1f/AePc3yX1n9QTX1dfR2SCcmsrRDE6emvBgGixaY9tQO0ccUo7xK5k2lQ8x7u2hf4PBoI/Op7DSXa0RpAD0UP8e2IMaxa8HV3Ui9wklfwU0OKuTACZbrubmTEQs5WqbFj96TQDtNvGYBEOAH9KwZ2+5IWC0XjLaNd5fitxLpWwKo2yUEx46dq59QcwJLW9Io6AcJzs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2019 08:45:56.7179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8fe233-c7b3-4ccc-fcfb-08d73c149f69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:25:44AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds to support register dump on lpu and dou of pipeline and gcu on D71
>=20
> Changes since v1:
> - For a constant format without additional arguments, use seq_puts()
> instead of seq_printf().
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 86 ++++++++++++++++++-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 23 ++---
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  2 +
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +
>  4 files changed, 101 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 4073a452e24a..7ba3c135142c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1206,6 +1206,90 @@ int d71_probe_block(struct d71_dev *d71,
>  	return err;
>  }
> =20
> +static void d71_gcu_dump(struct d71_dev *d71, struct seq_file *sf)
> +{
> +	u32 v[5];
> +
> +	seq_puts(sf, "\n------ GCU ------\n");
> +
> +	get_values_from_reg(d71->gcu_addr, 0, 3, v);
> +	seq_printf(sf, "GLB_ARCH_ID:\t\t0x%X\n", v[0]);
> +	seq_printf(sf, "GLB_CORE_ID:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "GLB_CORE_INFO:\t\t0x%X\n", v[2]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0x10, 1, v);
> +	seq_printf(sf, "GLB_IRQ_STATUS:\t\t0x%X\n", v[0]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0xA0, 5, v);
> +	seq_printf(sf, "GCU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "GCU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "GCU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "GCU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "GCU_STATUS:\t\t0x%X\n", v[4]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0xD0, 3, v);
> +	seq_printf(sf, "GCU_CONTROL:\t\t0x%X\n", v[0]);
> +	seq_printf(sf, "GCU_CONFIG_VALID0:\t0x%X\n", v[1]);
> +	seq_printf(sf, "GCU_CONFIG_VALID1:\t0x%X\n", v[2]);
> +}
> +
> +static void d71_lpu_dump(struct d71_pipeline *pipe, struct seq_file *sf)
> +{
> +	u32 v[6];
> +
> +	seq_printf(sf, "\n------ LPU%d ------\n", pipe->base.id);
> +
> +	dump_block_header(sf, pipe->lpu_addr);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xA0, 6, v);
> +	seq_printf(sf, "LPU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "LPU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "LPU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "LPU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "LPU_STATUS:\t\t0x%X\n", v[4]);
> +	seq_printf(sf, "LPU_TBU_STATUS:\t\t0x%X\n", v[5]);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xC0, 1, v);
> +	seq_printf(sf, "LPU_INFO:\t\t0x%X\n", v[0]);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xD0, 3, v);
> +	seq_printf(sf, "LPU_RAXI_CONTROL:\t0x%X\n", v[0]);
> +	seq_printf(sf, "LPU_WAXI_CONTROL:\t0x%X\n", v[1]);
> +	seq_printf(sf, "LPU_TBU_CONTROL:\t0x%X\n", v[2]);
> +}
> +
> +static void d71_dou_dump(struct d71_pipeline *pipe, struct seq_file *sf)
> +{
> +	u32 v[5];
> +
> +	seq_printf(sf, "\n------ DOU%d ------\n", pipe->base.id);
> +
> +	dump_block_header(sf, pipe->dou_addr);
> +
> +	get_values_from_reg(pipe->dou_addr, 0xA0, 5, v);
> +	seq_printf(sf, "DOU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "DOU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "DOU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "DOU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "DOU_STATUS:\t\t0x%X\n", v[4]);
> +}
> +
> +static void d71_pipeline_dump(struct komeda_pipeline *pipe, struct seq_f=
ile *sf)
> +{
> +	struct d71_pipeline *d71_pipe =3D to_d71_pipeline(pipe);
> +
> +	d71_lpu_dump(d71_pipe, sf);
> +	d71_dou_dump(d71_pipe, sf);
> +}
> +
>  const struct komeda_pipeline_funcs d71_pipeline_funcs =3D {
> -	.downscaling_clk_check =3D d71_downscaling_clk_check,
> +	.downscaling_clk_check	=3D d71_downscaling_clk_check,
> +	.dump_register		=3D d71_pipeline_dump,
>  };
> +
> +void d71_dump(struct komeda_dev *mdev, struct seq_file *sf)
> +{
> +	struct d71_dev *d71 =3D mdev->chip_data;
> +
> +	d71_gcu_dump(d71, sf);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index d567ab7ed314..0b763ea543ac 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -561,17 +561,18 @@ static int d71_disconnect_iommu(struct komeda_dev *=
mdev)
>  }
> =20
>  static const struct komeda_dev_funcs d71_chip_funcs =3D {
> -	.init_format_table =3D d71_init_fmt_tbl,
> -	.enum_resources	=3D d71_enum_resources,
> -	.cleanup	=3D d71_cleanup,
> -	.irq_handler	=3D d71_irq_handler,
> -	.enable_irq	=3D d71_enable_irq,
> -	.disable_irq	=3D d71_disable_irq,
> -	.on_off_vblank	=3D d71_on_off_vblank,
> -	.change_opmode	=3D d71_change_opmode,
> -	.flush		=3D d71_flush,
> -	.connect_iommu	=3D d71_connect_iommu,
> -	.disconnect_iommu =3D d71_disconnect_iommu,
> +	.init_format_table	=3D d71_init_fmt_tbl,
> +	.enum_resources		=3D d71_enum_resources,
> +	.cleanup		=3D d71_cleanup,
> +	.irq_handler		=3D d71_irq_handler,
> +	.enable_irq		=3D d71_enable_irq,
> +	.disable_irq		=3D d71_disable_irq,
> +	.on_off_vblank		=3D d71_on_off_vblank,
> +	.change_opmode		=3D d71_change_opmode,
> +	.flush			=3D d71_flush,
> +	.connect_iommu		=3D d71_connect_iommu,
> +	.disconnect_iommu	=3D d71_disconnect_iommu,
> +	.dump_register		=3D d71_dump,
>  };
> =20
>  const struct komeda_dev_funcs *
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.h
> index 84f1878b647d..c7357c2b9e62 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> @@ -49,4 +49,6 @@ int d71_probe_block(struct d71_dev *d71,
>  		    struct block_header *blk, u32 __iomem *reg);
>  void d71_read_block_header(u32 __iomem *reg, struct block_header *blk);
> =20
> +void d71_dump(struct komeda_dev *mdev, struct seq_file *sf);
> +
>  #endif /* !_D71_DEV_H_ */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 9d4d5075cc64..4aa324d46409 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -25,6 +25,8 @@ static int komeda_register_show(struct seq_file *sf, vo=
id *x)
>  	struct komeda_dev *mdev =3D sf->private;
>  	int i;
> =20
> +	seq_puts(sf, "\n=3D=3D=3D=3D=3D=3D Komeda register dump =3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
> +
>  	if (mdev->funcs->dump_register)
>  		mdev->funcs->dump_register(mdev, sf);
> =20

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

And I'll push it to drm-misc

Best Regards.
James

