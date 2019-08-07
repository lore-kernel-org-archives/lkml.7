Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02864C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83B221BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xldBu8e+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xldBu8e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbfHGNCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:02:15 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:16709
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387799AbfHGNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADut284OVWUEh6Izue7rL7Aiei8du+CnAdVhHUfHNdM=;
 b=xldBu8e+n2s2/Magqa2WoeLaSEExJBlbPGHdE3KuB3MUJF7rV5k/eIkoELkCcrdbtjA0vY/TlwfK16MV5vd+9/bjjxh9jWGrYUTTy9nLkr3eUlauscdVv22NGHMgb/YH+yPzGb2YlkcaMf4I080TMjjsgrT6ds3zuIs0Z8rpBLc=
Received: from AM6PR08CA0013.eurprd08.prod.outlook.com (2603:10a6:20b:b2::25)
 by HE1PR0802MB2603.eurprd08.prod.outlook.com (2603:10a6:3:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Wed, 7 Aug
 2019 13:02:08 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by AM6PR08CA0013.outlook.office365.com
 (2603:10a6:20b:b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Wed, 7 Aug 2019 13:02:08 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Wed, 7 Aug 2019 13:02:07 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Wed, 07 Aug 2019 13:02:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96e378cc31b538be
X-CR-MTA-TID: 64aa7808
Received: from 19201584f193.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB1F90DE-1876-4BD6-A3E4-24487EB2E126.1;
        Wed, 07 Aug 2019 13:01:57 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 19201584f193.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Aug 2019 13:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiQAfhIfs9pTahG2oLcctccLPL+9YychkYe6JWa0h2nikVHt+UFkwTaN2wkqu5Uz9O6BLUXCYgrVZ4jvrQJjgRza3XVDa6SVY9rS33JKGAQ13OPlGmVSkEZcu7MAe0ihZdXxjUbO54jA6SUJyBdI2RZws5mXxMfsoMS4Xh0M9SNvxkXVYaUJ3KFPATiRREM07v3A5D05XVFVmaGJ53N15kRaiUeuIRRJJaIH6kRYxBG+7qI/hdPb4/pC6L2FH8fMscHOZ4IyBxUaqod/Vn0l4Tpe2tsY8WQxQAffcE6ex0536ZxLriRKW9ms5K5ULfyBv9eYkx9mdNaKg1sYpDKDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADut284OVWUEh6Izue7rL7Aiei8du+CnAdVhHUfHNdM=;
 b=EGwiBvIW8/4TqVL7HreD3R416PXDg+u9keHK7zHqFpf1seKPTj8nJVe18N8X8Y85cN/9vVTiGfERB1OhihWld1Q3cn0E2Qatrqv8NQO5jTGjCiX//Dtq9lN/LF7hXZofbZqW5CPdXGMLLktXOu6A+HBwiCZGhORQXuF0WsLe1xbsB3l9LNDtoX38eP090NAvUasz8Mt08bu6eTiYMH19pk7ADA8BHU9ViKJiV93xBg+Dg1cRl27KUgR3QMqph06lURSaABdPjGcsxGsgUQViesgLAPPpkgxI4aMy8vBI5uEkNUnJfaYkgq57t2GF/pXyPYXOYIhdb7zXlBzMp+qS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADut284OVWUEh6Izue7rL7Aiei8du+CnAdVhHUfHNdM=;
 b=xldBu8e+n2s2/Magqa2WoeLaSEExJBlbPGHdE3KuB3MUJF7rV5k/eIkoELkCcrdbtjA0vY/TlwfK16MV5vd+9/bjjxh9jWGrYUTTy9nLkr3eUlauscdVv22NGHMgb/YH+yPzGb2YlkcaMf4I080TMjjsgrT6ds3zuIs0Z8rpBLc=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB3364.eurprd08.prod.outlook.com (20.177.111.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 13:01:54 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 13:01:54 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Thread-Topic: [PATCH v3] drm/crc-debugfs: Add notes about CRC<->commit
 interactions
Thread-Index: AQHVTFT7ihsXP7Ei2UuXxQIneDOlZKbvp+eA
Date:   Wed, 7 Aug 2019 13:01:54 +0000
Message-ID: <20190807130153.GA19148@arm.com>
References: <20190806124622.28399-1-brian.starkey@arm.com>
In-Reply-To: <20190806124622.28399-1-brian.starkey@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::28) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bbedee6b-6ac7-4f60-a11f-08d71b377395
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3364;
X-MS-TrafficTypeDiagnostic: AM0PR08MB3364:|HE1PR0802MB2603:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2603A6823F052925F794FC9EE4D40@HE1PR0802MB2603.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01221E3973
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(37006003)(81156014)(14444005)(446003)(478600001)(86362001)(99286004)(66556008)(6246003)(54906003)(6306002)(66476007)(6486002)(26005)(71190400001)(71200400001)(66946007)(64756008)(8936002)(81166006)(8676002)(5660300002)(14454004)(6862004)(6636002)(256004)(186003)(25786009)(229853002)(6512007)(6436002)(305945005)(7736002)(966005)(316002)(3846002)(76176011)(2906002)(1076003)(53936002)(476003)(486006)(102836004)(386003)(66446008)(68736007)(11346002)(66066001)(44832011)(36756003)(2616005)(33656002)(4326008)(52116002)(6116002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3364;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: JJ1Pq42seOHHfYl5b7kDKgmXq7LjlJHa3BmOd3F8C+GubQ6TGkQ08aLFF6pinfqaQyYCiqHrv00WpPx7iuArsMSyPgL9+lAm3biwuNgSFY/uSezXwthh3OJ+NRT12HpEEUpZ98AZZZdmwW61ffQwzFNhWrXMC7evyfMCWngMDvk7MLao9Kqtz2zhc8n961k6D70WCNzFX62fFggfDJ93UrMk3OOBNvBpjsqK1CC++12B/lBEb+5GGs0+ND23V2jko1PCTi5nFxry0G89cfa+LEFNV/WYEffYrrwSRnPTTaMRtvu7U+UW+UoaBeKXpVSy8+A+uFunwRj4ARJwjbH1HMzT3FqAFeajfhV1FRGd8GCxfTc3f7vIi/tVoTCITzfKqCmZ701ecxkaL5vGoTePn/l5tJLJi9neKwMQbHhCPb0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5DB0A77B9F2C440AEA925901CE30C52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3364
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(189003)(199004)(6636002)(316002)(966005)(37006003)(86362001)(36756003)(54906003)(2906002)(102836004)(46406003)(3846002)(6116002)(23726003)(26826003)(47776003)(81156014)(446003)(63370400001)(63350400001)(336012)(476003)(6512007)(126002)(2616005)(97756001)(5660300002)(486006)(7736002)(11346002)(8746002)(81166006)(8936002)(6862004)(70586007)(22756006)(186003)(6306002)(70206006)(229853002)(33656002)(26005)(6486002)(6506007)(99286004)(14444005)(8676002)(66066001)(25786009)(386003)(14454004)(1076003)(76130400001)(76176011)(4326008)(50466002)(478600001)(6246003)(356004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2603;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a6dbb654-4797-4148-0aea-08d71b376bc6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0802MB2603;
NoDisclaimer: True
X-Forefront-PRVS: 01221E3973
X-Microsoft-Antispam-Message-Info: S1mtB4A76TKRWPWCEcYXkfcURpSkYjv3HZr234ebgoB12eoqokDRAGx3FQeJo8TafvRmweTTsGSFYXIiPmdgMyyi3aepBfgmJHjo5YJxYR+ELeG6Qctv87y6kWeyx0i09LO2N/yLeE3s11K4XoDMqRzd2zt2UUTYkgVDVrb/a780pRGrNP/ad4NSwxCFqDEihsBKdv3XXvH3OR1O3tWWNBCNkGG2uLhoNBVIwEkewA1M62H3Q3BNaUqbH80fM8vmDV/3jZRa1Clq1Z+VBzm0h0va4jF97FLqOuc9LzAFTN6f/AcNA7ohV5g9vjUMgiCZR3mGmZnALLi+A6RJvlXv0SFbLdlQFj7JaLaFpa7YRWAZDXJKS9orpqleiWwt/FJtHd94AGvlmDhSOiCx9CFchAkhXKwRf3cUZjZaIfJFST4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 13:02:07.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbedee6b-6ac7-4f60-a11f-08d71b377395
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:46:22PM +0100, Brian Starkey wrote:
> CRC generation can be impacted by commits coming from userspace, and
> enabling CRC generation may itself trigger a commit. Add notes about
> this to the kerneldoc.
>=20
> Changes since v1:
>  - Clarified that anything that would disable CRCs counts as a full
>    modeset, and so userspace needs to reconfigure after full modesets
>=20
> Changes since v2:
>  - Add these notes
>  - Rebase onto drm-misc-next (trivial conflict in comment)
>=20
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_debugfs_crc.c | 9 +++++++++
>  include/drm/drm_crtc.h            | 4 ++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debu=
gfs_crc.c
> index 6604ed223160..be1b7ba92ffe 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -69,6 +69,15 @@
>   * implement &drm_crtc_funcs.set_crc_source and &drm_crtc_funcs.verify_c=
rc_source.
>   * The debugfs files are automatically set up if those vfuncs are set. C=
RC samples
>   * need to be captured in the driver by calling drm_crtc_add_crc_entry()=
.
> + * Depending on the driver and HW requirements, &drm_crtc_funcs.set_crc_=
source
> + * may result in a commit (even a full modeset).
> + *
> + * CRC results must be reliable across non-full-modeset atomic commits, =
so if a
> + * commit via DRM_IOCTL_MODE_ATOMIC would disable or otherwise interfere=
 with
> + * CRC generation, then the driver must mark that commit as a full modes=
et
> + * (drm_atomic_crtc_needs_modeset() should return true). As a result, to=
 ensure
> + * consistent results, generic userspace must re-setup CRC generation af=
ter a
> + * legacy SETCRTC or an atomic commit with DRM_MODE_ATOMIC_ALLOW_MODESET=
.
>   */
> =20
>  static int crc_control_show(struct seq_file *m, void *data)
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 128d8b210621..7d14c11bdc0a 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -756,6 +756,9 @@ struct drm_crtc_funcs {
>  	 * provided from the configured source. Drivers must accept an "auto"
>  	 * source name that will select a default source for this CRTC.
>  	 *
> +	 * This may trigger an atomic modeset commit if necessary, to enable CR=
C
> +	 * generation.
> +	 *
>  	 * Note that "auto" can depend upon the current modeset configuration,
>  	 * e.g. it could pick an encoder or output specific CRC sampling point.
>  	 *
> @@ -767,6 +770,7 @@ struct drm_crtc_funcs {
>  	 * 0 on success or a negative error code on failure.
>  	 */
>  	int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
> +
>  	/**
>  	 * @verify_crc_source:
>  	 *
> --=20
> 2.17.1
>=20

Pushed to drm-misc-next.
Commit id :- 178e5f3a5bc1d67d1248a74c0abab41040abe7c4

-Ayan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
