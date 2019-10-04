Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA100C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69031222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iyx4NprF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iyx4NprF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbfJDOdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:33:19 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:26305
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389081AbfJDOdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW3pBSJDcTPwwZCil2n1dfQN6Hz47RZy06NGmzqrXc8=;
 b=iyx4NprFhsJ5F8cSVXa953OkEMcqBCOF9Ddd7msjR1Ja0nD1BU0XeIKU6B1QctRz01Tgk+N5dStQBjR6xJx0jMwFlUqEHF8RE8yNTa+5ITCdFJTAvw1Nk82MvH9uMZlf6jNrp8xgei6GZZ2XxyqmOMd6COeCh5Tkif3szrAnjZk=
Received: from VI1PR08CA0216.eurprd08.prod.outlook.com (2603:10a6:802:15::25)
 by AM5PR0801MB2036.eurprd08.prod.outlook.com (2603:10a6:203:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Fri, 4 Oct
 2019 14:33:12 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0216.outlook.office365.com
 (2603:10a6:802:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.23 via Frontend
 Transport; Fri, 4 Oct 2019 14:33:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:33:10 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 04 Oct 2019 14:33:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8b912dba5c777bff
X-CR-MTA-TID: 64aa7808
Received: from dee72b5fddc7.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8C3529F-4AFD-48A6-BB2C-356788D0EB51.1;
        Fri, 04 Oct 2019 14:32:56 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dee72b5fddc7.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIatbTP6y9onINnKRQOl5c+lNuea//5un5M0thVigREP/UDUwlipUmk4IH8fv91INhucN5vvhqJhLZsSCF6DgWwVakVFj2R6GAhrPWZcSSTlZApdFePr6vTi5HEvkwPuO832ibqBB7KTlRBqKgY3QL26co4hL6JaTsc0QsvxxcWqxEY+lwNqsG0Dh7iD2fmHzHefzOeblQL0SRQ8iVXz+JVQ7Y5SZNbHUA6TGcqfQDh//Y1TImRUjHGhmT7APKOcPj3SKoQY4kegVqBRuqE7K3FgHY129WZHuyFSKWotOXmaJYWFHCXKImLe2Z7mzsnh0J0Ko1eowCwZIEW0UPDCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW3pBSJDcTPwwZCil2n1dfQN6Hz47RZy06NGmzqrXc8=;
 b=N5svdDPOZCfUYDgzm9kGa3ruVaNIajVb7bmy86t9PXdSp7O4g6grSkiH69CMaG32vSIptwGcthELuLF+Trxisb24etBPg0cqXX0HNVIpQEYlLnlu+yGGCRUd8G1Q1P/U3jeG7CYx+pQ2NgUoiWpm/pVg8Rgv4c57jEnb+WysBcTP/89ZuwWbxhdc6R0+BvejgD52KfPTG2JrPXKUp5H8N2qIFqTCymZfvKfZ5yNmkvnFw3Aju/vIqOKYmbOL7cAP+SgmvW48QfMSb3A/B3fhKZqjvRk0ORQltx2XHic+FC+Fe8C7ye/CLLqPl6IqduJj+zSppPMkoCvQgZGdOvc0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW3pBSJDcTPwwZCil2n1dfQN6Hz47RZy06NGmzqrXc8=;
 b=iyx4NprFhsJ5F8cSVXa953OkEMcqBCOF9Ddd7msjR1Ja0nD1BU0XeIKU6B1QctRz01Tgk+N5dStQBjR6xJx0jMwFlUqEHF8RE8yNTa+5ITCdFJTAvw1Nk82MvH9uMZlf6jNrp8xgei6GZZ2XxyqmOMd6COeCh5Tkif3szrAnjZk=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB4516.eurprd08.prod.outlook.com (20.179.33.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Fri, 4 Oct 2019 14:32:54 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::748f:576b:c962:6a46]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::748f:576b:c962:6a46%3]) with mapi id 15.20.2327.023; Fri, 4 Oct 2019
 14:32:54 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Raymond Smith <Raymond.Smith@arm.com>, nd <nd@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH v3] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH v3] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVer3HxoO2jRYwYkCqyNFFHsjE5qdKi7qA
Date:   Fri, 4 Oct 2019 14:32:54 +0000
Message-ID: <20191004143253.GA25948@arm.com>
References: <20191004141222.22337-1-ayan.halder@arm.com>
In-Reply-To: <20191004141222.22337-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 817cb14e-4cf8-4a84-50f8-08d748d7c848
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM0PR08MB4516:|AM0PR08MB4516:|AM5PR0801MB2036:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2036487AC82236C8C0872F04E49E0@AM5PR0801MB2036.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(36756003)(6436002)(305945005)(446003)(5660300002)(478600001)(6116002)(7736002)(66946007)(386003)(2906002)(11346002)(1076003)(66446008)(66476007)(66556008)(64756008)(33656002)(44832011)(316002)(186003)(6486002)(6512007)(26005)(6506007)(102836004)(110136005)(54906003)(6246003)(229853002)(52116002)(71200400001)(2201001)(71190400001)(86362001)(256004)(14444005)(76176011)(99286004)(14454004)(476003)(2501003)(486006)(81166006)(8676002)(81156014)(8936002)(66066001)(2616005)(3846002)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4516;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7H/oxKrINZi+BEY+Chx6EUIfxmQyzJwTvfkEDeEfDDihw4WLTekxhIRplSJDB/jZbNQkPXkCN8N5+kl09FX+KQMp/jqxpXH65zlcuBCivKslNkBxfrZtDjCMAKO1mAIjZABhcDbzqxANi5gun1aW5LQ8FeV4iBO0PD2weBPbGUX0eNhZxJOUbFxfjQN2nRZWhJT8+bfrGnjV5a8QVqhbRwTj7xITec/9tDrVs7NSO2EaI9UH2W8p1KTYBirvKB/vKbcKX4wu+LigC+17CjXpbFZ/cMj1HWtL0iQVGf5FUAI1Qn6BATtHXJtAdmrGeRDdIYh72gGdeSTmk9mADOkV0f7AzpWGCdSCh4FTPbAAKqWxMkY7HwWxX+gFGgrRMJ+sQdrw6jOInJ68VyHu3JGU0PrA7NPYYEvMc0bCq4/l/Qo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00F7C3F1F5BF814885CC73FA309B5C47@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4516
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(81156014)(70206006)(76176011)(8746002)(14454004)(107886003)(2501003)(26826003)(478600001)(1076003)(86362001)(70586007)(76130400001)(36756003)(2201001)(6246003)(110136005)(4326008)(14444005)(305945005)(25786009)(8936002)(46406003)(356004)(7736002)(81166006)(99286004)(2906002)(126002)(50466002)(486006)(47776003)(476003)(8676002)(97756001)(229853002)(66066001)(33656002)(54906003)(6486002)(186003)(336012)(23726003)(386003)(6506007)(316002)(36906005)(22756006)(26005)(3846002)(63350400001)(5660300002)(102836004)(6116002)(2616005)(446003)(6512007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB2036;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e3fca91-3a9d-492a-7a5b-08d748d7be74
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bc0wm9fXD/4p0iLm6uT6Hxif/G5SkHFFa3arGoCUXrD5q1Gs7dpn78H9A8leQxMztcBHrBiXFusaHr60GjIZwfvDwJjbmuIq/WnbsWTdSQ4Q2HFq8N3RZYndK4ZeJCjnOAk00CtsrBqpp/U19kHXuBxJEwXySvzvy8Y+toL7o+AqBJi6/lP3lq8Q32qOqDnffrzONYwb8aCa4hbxcq/ehTNgtl9mNvDRfHVIuoBk2mfGN4vRNUXJIz/mfCH1qfO1/AOcohVgDMiggvVcY/aINEmK18lkCxxyVzFSOGIbZcyxSCKtKEHyepFAYl7U0dOT/qU/ufXG9+3c511TrBbnq//I7gH1bwUMqCpM4OvGHGnVlClcqtES4i6OJ6U25zDNty8eYiaVM0TIxSV4UBn2sLlR4oYhEfuzRm8Hcrs7zpA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:33:10.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817cb14e-4cf8-4a84-50f8-08d748d7c848
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:12:38PM +0000, Ayan Halder wrote:
> From: Raymond Smith <raymond.smith@arm.com>
>=20
> Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> denote the 16x16 block u-interleaved format used in Arm Utgard and
> Midgard GPUs.
>=20
> Changes from v1:-
> 1. Reserved the upper four bits (out of the 56 bits assigned to each vend=
or)
> to denote the category of Arm specific modifiers. Currently, we have two
> categories ie AFBC and MISC.
>=20
> Changes from v2:-
> 1. Preserved Ray's authorship
> 2. Cleanups/changes suggested by Brian
> 3. Added r-bs of Brian and Qiang
>=20
> Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>

Pushed to drm-misc-next - ba2a1c8706151ac3234d2d020873feab498ab1bb
> ---
>  include/uapi/drm/drm_fourcc.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 3feeaa3f987a..2376d36ea573 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -648,7 +648,21 @@ extern "C" {
>   * Further information on the use of AFBC modifiers can be found in
>   * Documentation/gpu/afbc.rst
>   */
> -#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc=
_mode)
> +
> +/*
> + * The top 4 bits (out of the 56 bits alloted for specifying vendor spec=
ific
> + * modifiers) denote the category for modifiers. Currently we have only =
two
> + * categories of modifiers ie AFBC and MISC. We can have a maximum of si=
xteen
> + * different categories.
> + */
> +#define DRM_FORMAT_MOD_ARM_CODE(__type, __val) \
> +	fourcc_mod_code(ARM, ((__u64)(__type) << 52) | ((__val) & 0x000ffffffff=
fffffULL))
> +
> +#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
> +#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
> +
> +#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
> +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
> =20
>  /*
>   * AFBC superblock size
> @@ -742,6 +756,16 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> =20
> +/*
> + * Arm 16x16 Block U-Interleaved modifier
> + *
> + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the imag=
e
> + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pix=
els
> + * in the block are reordered.
> + */
> +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
> +
>  /*
>   * Allwinner tiled modifier
>   *
> --=20
> 2.23.0
