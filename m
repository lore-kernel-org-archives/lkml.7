Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C21CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09909208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bpJzMIiy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bpJzMIiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfKAHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:17:20 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:16534
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfKAHRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7nUPmbf/5TwYW064wsEhUXruAzCIoVKDDCEmziHApg=;
 b=bpJzMIiyz6JCMLJZAuAl855Sisyje4inq+oCj7UiPf8GyZeeRPXgto+QNdU7FmPkFbjngVIt25iNLDjODEeHVRsIbFKY27hUyZgeMLtRfzPUi3B2u+RaKB7tpEcyb2lcaOQpf7IYpjqkYAMw5KMFgVVhKsSaebmvV4YBR+65cko=
Received: from VI1PR08CA0176.eurprd08.prod.outlook.com (2603:10a6:800:d1::30)
 by DB6PR08MB2933.eurprd08.prod.outlook.com (2603:10a6:6:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 07:17:13 +0000
Received: from VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0176.outlook.office365.com
 (2603:10a6:800:d1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 07:17:13 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT021.mail.protection.outlook.com (10.152.18.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 07:17:13 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 01 Nov 2019 07:17:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 29d78dff668dd3a0
X-CR-MTA-TID: 64aa7808
Received: from 144da546acf0.2 (cr-mta-lb-1.cr-mta-net [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 52E326CF-B048-4AFA-88C1-DD29D26F6648.1;
        Fri, 01 Nov 2019 07:17:07 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 144da546acf0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 01 Nov 2019 07:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaH1o/DISyR7t6WD3gppWzo/5XfpEK5lcWEgkVSul2MDEMHnKheqqPHRyUdX+FRQ6sp8ffw1DZUFUrvTDJSmCJvYdxixFJvjIy6qxR6yUPcztxJWWUhRKPkj0lomVbg3C0nn+i4gjLDw+/goRRuFfuYy88WRaWrIJlFbxH5nXWs5WAte4BuARPfEGgmVDRhcjySRDw/D42dAtZO8O6vXYhf9NfPfb8dmqLaoNoS4neW0KqFdMDHCR3R0HgpWH98J/mXS+ljgldWYKdQdhijaG/ATp76DzWESvO5mvvPzQk9p0rF0gO7DB4wKH8TdHbfPsmlWsVutFsU/LRxPPM/n9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7nUPmbf/5TwYW064wsEhUXruAzCIoVKDDCEmziHApg=;
 b=GZlesaLmISxT7vsmd6TsbVG2AiIiGEGhFBd9dVVtvzJmlM0be3Oz9QgAWCI36ORLl+eY+O+R3siYLaK0Qqsoix90Xyzp8oRlGYbbVK9h5fGIePeI+2SJ0VFoUsyTrW2A9nwEOQKXSs55Mvi4lCvL3sqLIBDDwYcwcCsgjK+omCgQTec42wDHrZ5UkIYVS1Xmlos6ZhZVdAv7csbn54lVkQoK1qZqwGyAtwcb84peGFYwIZn9ZYk8nmhYR16BJTddppqfOWTmaz/Sf01HKfy7iPWh8olwdCBWXFyFgNIZvp9ss14SYkeSNDtq6yDX7i4TEEe8AXU23IGOeSH5CurCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7nUPmbf/5TwYW064wsEhUXruAzCIoVKDDCEmziHApg=;
 b=bpJzMIiyz6JCMLJZAuAl855Sisyje4inq+oCj7UiPf8GyZeeRPXgto+QNdU7FmPkFbjngVIt25iNLDjODEeHVRsIbFKY27hUyZgeMLtRfzPUi3B2u+RaKB7tpEcyb2lcaOQpf7IYpjqkYAMw5KMFgVVhKsSaebmvV4YBR+65cko=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4974.eurprd08.prod.outlook.com (10.255.158.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 07:17:06 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 07:17:06 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [3/5] drm/komeda: Optionally dump DRM state on interrupts
Thread-Topic: [3/5] drm/komeda: Optionally dump DRM state on interrupts
Thread-Index: AQHVkIRdkRYOh8AuQkiwt0Vv1/Eykw==
Date:   Fri, 1 Nov 2019 07:17:06 +0000
Message-ID: <20191101071659.GA30189@jamwan02-TSP300>
References: <20191021164654.9642-4-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-4-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0068.apcprd03.prod.outlook.com
 (2603:1096:203:52::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1926b1f-cc71-4489-9310-08d75e9b84b7
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:|VE1PR08MB4974:|DB6PR08MB2933:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB293332E593806D1E25E8CFC6B3620@DB6PR08MB2933.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(25786009)(8936002)(6486002)(6246003)(81166006)(229853002)(14444005)(7736002)(71190400001)(476003)(478600001)(5660300002)(486006)(256004)(8676002)(2906002)(3846002)(71200400001)(305945005)(81156014)(6116002)(64756008)(55236004)(66446008)(102836004)(66066001)(66556008)(86362001)(6506007)(4326008)(186003)(6512007)(66476007)(6436002)(316002)(386003)(6862004)(76176011)(99286004)(26005)(54906003)(14454004)(52116002)(33716001)(9686003)(446003)(11346002)(1076003)(58126008)(6636002)(33656002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4974;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v8iB8w+gQYQTyhPc1S2KQy1aXfUF/eIdc41px5QGbTyugAX/N5rLybWgY6XhAM9cO3GnXmOsAjzT3ka03ifzjP4Sgqh0LUVjo/9gmnZTjuzBHksgdbeF5yyKmW9FKt0aCIpmGFfFJddIafgwksTmHtWXnyMhW0mdjAkfb9Wp3VGePet4OV0lQwREcOCu+qmjvEwlL6s8/BkAJhW6uWqWg+N9s+Dw63EvVq+syhlo86fKe2yx8Uik2OszthB08nI4ignNPMdcrrZ4xomfsLBQpptpgLAVNu83IQ3ju8pabmGjg0/c6IizmldvS2qIZ/HES8nWfQeqj1LUEFkpiMDiwNMLBILz0B7TZApifyYIAfjkLNPM+ei9x6oPByEGnlpOyXSNMFb51jFCbwtWWKlEmDG+58WgI+sDRmIUqAHmXkvE8S5o/4GAEEJ2NeZ7y4xB
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2C318B8364FB34CBE68D86FDE7FA9C2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4974
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(136003)(376002)(396003)(1110001)(339900001)(199004)(189003)(47776003)(54906003)(9686003)(186003)(26005)(66066001)(58126008)(316002)(33716001)(3846002)(26826003)(6116002)(86362001)(36906005)(2906002)(486006)(23726003)(25786009)(6246003)(102836004)(4326008)(76176011)(46406003)(6862004)(6506007)(386003)(107886003)(126002)(478600001)(105606002)(14454004)(446003)(97756001)(336012)(6486002)(11346002)(6512007)(476003)(50466002)(229853002)(8676002)(81166006)(76130400001)(81156014)(8936002)(8746002)(14444005)(33656002)(70206006)(70586007)(22756006)(5660300002)(99286004)(1076003)(7736002)(305945005)(6636002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2933;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 26127c99-a39f-4146-88bb-08d75e9b8028
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uionmm8hEXWFJaIdv7z7+no+hH86t+IE4VidWrA2sOFanJTWX9DhdW2OGWOHd2aLpSXQctLVCHeLYfPIPyUICpj+Gwbw+4G7srOu24ykl+YayTSkYwSolA9t1qJsdXOiS+/HB6oKAp7t3Ycl+dEngcYKqPFmPuFTYCr3DRIKWYkkYPP9HRP0CBvyRCzUrXzC3bagOvBgNkS1Tc7koVB/ul2kHLsBUW+5O2kQaWhboTNMsDrDuFByt5n2xQirQQVZCwHXNVbqC0KD/59MuIiLpLg4rgWoh7bDGVuKpq4/LYdw2EWd9rG8tIgwCPAFJ1JXsFISnprabyKqG+t/H4T8zsiOW4hnFJWrmqGTfnY6oJuZ+hmpKOIr63NbNfRHR0hj8UkBkLa8X6jUXsBrqVkUWthBGNecR1ksDz5n8j+t/KBfTLcVEbHAqtAxCXi89HSG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 07:17:13.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1926b1f-cc71-4489-9310-08d75e9b84b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:47:24PM +0000, Mihail Atanassov wrote:
> It's potentially useful information when diagnosing error/warn IRQs, so
> dump it to dmesg with a drm_info_printer. Hide this extra debug dumping
> behind another komeda_dev->err_verbosity bit.
>=20
> Note that there's not much sense in dumping it for INFO events,
> since the VSYNC event will swamp the log.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 5 ++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 831c375180f8..4809000c1efb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -205,11 +205,14 @@ struct komeda_dev {
>  	/**
>  	 * @err_verbosity: bitmask for how much extra info to print on error
>  	 *
> -	 * See KOMEDA_DEV_* macros for details.
> +	 * See KOMEDA_DEV_* macros for details. Low byte contains the debug
> +	 * level categories, the high byte contains extra debug options.
>  	 */
>  	u16 err_verbosity;
>  	/* Print a single line per error per frame with error events. */
>  #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
> +	/* Dump DRM state on an error or warning event. */
> +#define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
>  };
> =20
>  static inline bool
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_event.c
> index 575ed4df74ed..5da61e7d75d5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -4,6 +4,7 @@
>   * Author: James.Qian.Wang <james.qian.wang@arm.com>
>   *
>   */
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_print.h>
> =20
>  #include "komeda_dev.h"
> @@ -113,6 +114,7 @@ void komeda_print_events(struct komeda_events *evts, =
struct drm_device *dev)
>  	static bool en_print =3D true;
>  	struct komeda_dev *mdev =3D dev->dev_private;
>  	u16 const err_verbosity =3D mdev->err_verbosity;
> +	u64 evts_mask =3D evts->global | evts->pipes[0] | evts->pipes[1];
> =20
>  	/* reduce the same msg print, only print the first evt for one frame */
>  	if (evts->global || is_new_frame(evts))
> @@ -123,9 +125,10 @@ void komeda_print_events(struct komeda_events *evts,=
 struct drm_device *dev)
>  	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
>  		print_evts |=3D KOMEDA_ERR_EVENTS;
> =20
> -	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
> +	if (evts_mask & print_evts) {
>  		char msg[256];
>  		struct komeda_str str;
> +		struct drm_printer p =3D drm_info_printer(dev->dev);
> =20
>  		str.str =3D msg;
>  		str.sz  =3D sizeof(msg);
> @@ -139,6 +142,9 @@ void komeda_print_events(struct komeda_events *evts, =
struct drm_device *dev)
>  		evt_str(&str, evts->pipes[1]);
> =20
>  		DRM_ERROR("err detect: %s\n", msg);
> +		if ((err_verbosity & KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT)
> +		    && (evts_mask & (KOMEDA_ERR_EVENTS | KOMEDA_WARN_EVENTS)))
> +			drm_state_dump(dev, &p);
> =20
>  		en_print =3D false;
>  	}
