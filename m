Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE03C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1C5206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0l2uECg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:29:28 -0500
Received: from mail-eopbgr700046.outbound.protection.outlook.com ([40.107.70.46]:7488
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:29:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9BldcFotPPUB4ZpUFpwl4yfTyaSJXaydggXxNCIYbAF7lGQ5G1HEDeTq3YaumRbnLMXtUOGEde0r04HL4qrPcC9FoGj22xoeAj1gq4VnkAodzo3ppB+L9qXbe91saWithr6r+rMCCE9Oy/z9F37dpoao8CegV4ACp4rZ/RukwoFJ00QYutT+SoL/kMkqMbUDrkknGaMT3Lmhb4mlVdjXNkMqnhGBAwMIwlXxtd4Ba564ttiSbHDW8TiI1b0QAdtplwe1mwYwrsXBgyENIVVV6ldeqqlRcVVEOR6k4JcNU/VvxPF0SWJwfwbUM7sefz2atWqRqwDnmxGQ8+VO3xQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpHkabajkqsegHg+V3wq6OqFh6NE7ovvQWHcTB3BHJ8=;
 b=lfmK1jK56DOWkH7C3bwirE7+IjLW0PKfJlNomRldMiLBoswHFlHLbj89XeASAeSuC+y01RMHtPZJ61MBBP+XBXCY3RJOUWlb/4EmdDPHV6YdjoFE6ajxdF4JqyjDINkry8mEweuA0Gi0NKxlcBG5W7EUxBlikI1tL/RglZ7yNw1ziVIqV6CYUZP4cFDi+9lG4JvQhiV98EyCgVmtReHRJJKHyWXM9ANCD4+O6HQCFy3CwZeWDtBzUubc1PNDjIk7QzjE2EdHCp/jvR1DKC3LdQ4Dz8u1aMWwAHaMr6v8IVvQ+Mdt4+0h0a6LP51nJf5EmLk7cLsIn+QI54pYccXX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpHkabajkqsegHg+V3wq6OqFh6NE7ovvQWHcTB3BHJ8=;
 b=0l2uECg3C4N614mByDOEVT1dCqyBQGI0g3J8FIwX50be3BipPrRGr1Q/nj3WulX7vpD+Zum1uitX4SGGWO7r7A/chW51U8ppZCYNiAfPwkdJ6f2iKA80AVXLnW0NmuGasVLWBO2P0jaweIV/qZrflc9B2maZ3NB6zHY4rPAn8e8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from BYAPR12MB3013.namprd12.prod.outlook.com (20.178.55.219) by
 BYAPR12MB3541.namprd12.prod.outlook.com (20.179.94.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 16:29:23 +0000
Received: from BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::ed87:95bf:7c40:3fa5]) by BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::ed87:95bf:7c40:3fa5%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 16:29:23 +0000
Subject: Re: [PATCH] drm/amd/display: replace BUG_ON with WARN_ON
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191218161505.13416-1-pakki001@umn.edu>
From:   Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <d963ed6f-4ced-cc9d-6612-8720ed9d2c41@amd.com>
Date:   Thu, 19 Dec 2019 11:29:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191218161505.13416-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To BYAPR12MB3013.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::27)
MIME-Version: 1.0
Received: from [172.29.224.72] (165.204.55.250) by YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 19 Dec 2019 16:29:21 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f492abc0-00b1-45a1-bbec-08d784a09af8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3541:|BYAPR12MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35418EC26550320BFD0B489CE4520@BYAPR12MB3541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(189003)(199004)(51914003)(31686004)(26005)(8936002)(2616005)(36916002)(81166006)(81156014)(6486002)(36756003)(186003)(16526019)(53546011)(66476007)(66556008)(66946007)(52116002)(6916009)(956004)(316002)(4326008)(31696002)(16576012)(54906003)(478600001)(2906002)(8676002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3541;H:BYAPR12MB3013.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUvqrrzvNClRF8l+ppCuu3/0XCfKYm3/9F9Qale9EZy6XZQL2H1Hj28RJFlrYE07G1H1jyZCo66KE3OKcN/1tK+i0dHNcdXTSISGyWHDlVnff+U8vfPU2AbnMPY8Z4cGFnYFnBeo6lYfGp/30bMiNy0tjujMub5lEv1OtIxZKsU9E3u+Kw2OL3PGJB7EvV8oAgmKef8nbRPCzvn4w1mDyNcLJRwsoUgbfEfCv8QNc3GuYP/7OZeZ07gyPRgbt7EqKWwpzPynVMYuDoj0tzioH5kwpZzahmwoj/8ncRTs0kq/kHVpFqooMGP+wXJ13RYLzFPq0vF1ZbdfxIWEIwPAKZEnfZTZpHuhs3UQM6y6wwfnriXcRvUbgmP5ubb2v4Il9oHorgW+jniOA7JEcliBadfHJ4xW1FJjgeKsQLYFUlUgtpHPTu2ZoGOPAiy6MXGSBB4BZhs7rl6ZhKLS8IgkgrbVApMyJfsswk3azvVC11SsKvXAh03X9eHyLetbYGya
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f492abc0-00b1-45a1-bbec-08d784a09af8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 16:29:22.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB/HtzVUFAWqLSEmG7M6/E2A6c72fffqRiLCCpy/HxU8YGivSum9ODZn2ZrQ1ivV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/19 11:15 AM, Aditya Pakki wrote:
> In skip_modeset label within dm_update_crtc_state(), the dc stream
> cannot be NULL. Using BUG_ON as an assertion is not required and
> can be removed. The patch replaces the check with a WARN_ON in case
> dm_new_crtc_state->stream is NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7aac9568d3be..03cb30913c20 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7012,7 +7012,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	 * 3. Is currently active and enabled.
>   	 * => The dc stream state currently exists.
>   	 */
> -	BUG_ON(dm_new_crtc_state->stream == NULL);
> +	WARN_ON(!dm_new_crtc_state->stream);
>   

Thanks for the patch, but this is NAK from me since it doesn't really do 
anything to prevent it or fix it.

If the stream is NULL and it passed this far in the function then 
something really wrong has happened and the process should be stopped.

I'm currently dealing with an issue where dm_new_crtc_state->stream is 
NULL. One of the scenarios could be that driver creates stream for a 
fake sink instead of failing, that is connected over MST, and calls 
dm_update_crtc_state to enable CRTC.

>   	/* Scaling or underscan settings */
>   	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state))
> 

-- 
Thanks,
Mikita Lipski
Software Engineer, AMD
mikita.lipski@amd.com
