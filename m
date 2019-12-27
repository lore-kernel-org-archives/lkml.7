Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C2C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8847206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aS3i/HmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfL0Ipm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 03:45:42 -0500
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:38843
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfL0Ipm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 03:45:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcWgjYf5BTXh8XILjZEjPIkdyvc7soVvhnl3xkQmMhrR0XBbp5D9bXO7b7LAWMFVPMgDS5nwYJq2xASmYXs+ziUXSntBeYwiyu+GZtGjwtImXwUZgRRskN2rufV0f4pA8Kn8m0AVJ5dk0tiF9l4a22WPBTq+2JUMWUz2q1zFVK4PArTVRnc3PuKf4Oim71DP/O2YMS/lmoxA3lt0nJgXOkE4mHkwk9bf23G7yozvXo8yYzITT8vdmw02UgRO99pAQe2L9ulXZtHP/nbo2/qWD8NL808X5UeWFcgx3keaJxc+DAOLHLRo1hHeYrMaPdH00KQ0RwRNsmTBHrIG8HcjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moxbnkuzm36SKORRIAlEDPOnnoswSx85vIcFD73UJqw=;
 b=ZUOjDhlP99BRGufpIU4ilrRc7YfYe/scfvdhs0AC8HbLDrPiIjw+Of7LdyCZH6eTftUCa1Lmzl9dF4sAN0koItmMMUzRt0O/8CGWoskcJEILJ7o5/9ou7+YNOjEcEPiZTvcZUuYZLUdFKo8LrqQNuTvetaXOf/Dc0h81w2NpnLExtxyb1b4FWVYO5qAevPrIMh01mkCjvR6ErBEG3B6J0Rn6gMh0XeuNSbY1vsh1Sd4J+qVr/jAPN27DERz+wUMwsSLQKaeDmy+vEmvZDasKKN5rF2pY4OrujVdAdATFK7Fjd5JKWUfjeDefY7FHM9wgqbxlaSuJUzU0V/xY6ky6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moxbnkuzm36SKORRIAlEDPOnnoswSx85vIcFD73UJqw=;
 b=aS3i/HmNbOKCeU2cXasCM7pf4oOEmKkPsQdvzJhUOA8RZmzkc4N1nkZBTdq0hOBvZruSvUaz7XkepuMX6RHTLrprKDN8O1XEXUb5xXbz7NINSE9GygsxNXwBLlShBbiEl6STZr4aohDjhJECtltaJbEj+u8O7VWseRDWAtxYfjM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3549.namprd12.prod.outlook.com (20.179.83.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 27 Dec 2019 08:44:58 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 08:44:57 +0000
Date:   Fri, 27 Dec 2019 16:44:47 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, zhengbin13@huawei.com,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/radeon: remove three set but not used variable
Message-ID: <20191227084444.GA3041@jenkins-Celadon-RN>
References: <20191226120750.15106-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226120750.15106-1-yukuai3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by HK2PR06CA0024.apcprd06.prod.outlook.com (2603:1096:202:2e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 08:44:54 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb3287eb-23bb-4df7-1f75-08d78aa90d74
X-MS-TrafficTypeDiagnostic: MN2PR12MB3549:|MN2PR12MB3549:|MN2PR12MB3549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3549DFCF0657456D6C6EBA99EC2A0@MN2PR12MB3549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 0264FEA5C3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(6666004)(86362001)(81156014)(33656002)(9686003)(26005)(55016002)(66476007)(66556008)(66946007)(45080400002)(966005)(478600001)(6496006)(81166006)(52116002)(66574012)(8936002)(316002)(1076003)(8676002)(4326008)(6862004)(186003)(5660300002)(956004)(2906002)(33716001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3549;H:MN2PR12MB3309.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiIjMsqeT3Sx8L/DRchrdt29xAjx9OSSEX6G4zNhVu0E9msG2q5GPUoFcm1e8wDS+xi/wGCXEa8V2J5akR4sGQO7jfiapfuD5+SUWZz16mXkvtFWUMvJwOrjyXIMBdjRfpvc7TqcHyNKWMDTg6tcZ/NCW+WVy6uxqd2RGRfohcA+6TBkjk3zi4pq41ju1dzsYoWf6ArwlZQF97In+NFx4mCcpCcYnPK5y1giLb69Hq1TKIKus0sOIXPbB6/UaGEuev2jZfZjbNUUbBJu51JErKiRlb0SCJLMD5KgiOzE3profh8BYNBDkrMukTzgb/VkomG4nVDwgYurQ3q5DSqJvOCS6Mojoxx3bZCmRWVk3FeqhvjUlIBxp0LCfAOB4fyOmE1qW/ceQMViBcDuR7lr5qnWx+QdeKp4XIC6t3CZvIGpDj5R8Gh8yDmtpXj8vG6KVrPuXYR5gVXwt1qTQx+b+lZcUVb7FWy8r1JnbDvMXy4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3287eb-23bb-4df7-1f75-08d78aa90d74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 08:44:57.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0UIVhuJWHOFvPZG1Gvvx31kaKrkJLXFg1NrflQ16Y2uR0JlHHQD0yHx5/SZHjvnEpjY50DpsJySOFBbqSEBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 08:07:50PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/radeon/radeon_atombios.c: In function
> ¡®radeon_get_atom_connector_info_from_object_table¡¯:
> drivers/gpu/drm/radeon/radeon_atombios.c:651:26: warning: variable
> ¡®grph_obj_num¡¯ set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/radeon/radeon_atombios.c:651:13: warning: variable
> ¡®grph_obj_id¡¯ set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/radeon/radeon_atombios.c:573:37: warning: variable
> ¡®con_obj_type¡¯ set but not used [-Wunused-but-set-variable]
> 
> They are never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Thanks!

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
> index 072e6daedf7a..848ef68d9086 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -570,7 +570,7 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
>  		path_size += le16_to_cpu(path->usSize);
>  
>  		if (device_support & le16_to_cpu(path->usDeviceTag)) {
> -			uint8_t con_obj_id, con_obj_num, con_obj_type;
> +			uint8_t con_obj_id, con_obj_num;
>  
>  			con_obj_id =
>  			    (le16_to_cpu(path->usConnObjectId) & OBJECT_ID_MASK)
> @@ -578,9 +578,6 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
>  			con_obj_num =
>  			    (le16_to_cpu(path->usConnObjectId) & ENUM_ID_MASK)
>  			    >> ENUM_ID_SHIFT;
> -			con_obj_type =
> -			    (le16_to_cpu(path->usConnObjectId) &
> -			     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
>  
>  			/* TODO CV support */
>  			if (le16_to_cpu(path->usDeviceTag) ==
> @@ -648,15 +645,7 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
>  			router.ddc_valid = false;
>  			router.cd_valid = false;
>  			for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
> -				uint8_t grph_obj_id, grph_obj_num, grph_obj_type;
> -
> -				grph_obj_id =
> -				    (le16_to_cpu(path->usGraphicObjIds[j]) &
> -				     OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
> -				grph_obj_num =
> -				    (le16_to_cpu(path->usGraphicObjIds[j]) &
> -				     ENUM_ID_MASK) >> ENUM_ID_SHIFT;
> -				grph_obj_type =
> +				uint8_t grph_obj_type =
>  				    (le16_to_cpu(path->usGraphicObjIds[j]) &
>  				     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
>  
> -- 
> 2.17.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C8d9d146eebca472e5e5908d78a10933f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637129676103813665&amp;sdata=0xRhHO2UOIbfEzYV8HTGtSTHFw%2F8R66Tfy44YviKpmQ%3D&amp;reserved=0
