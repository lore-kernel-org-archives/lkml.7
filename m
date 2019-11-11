Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2132FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E011620818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h68qNZ6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKKRqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:46:38 -0500
Received: from mail-eopbgr690064.outbound.protection.outlook.com ([40.107.69.64]:13650
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfKKRqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:46:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jub1xkEj7F4y+itB8MgWxicwupoQuVVQZahDkgvDZaWmB/piVvZgePSHmsWujriIQ7Qxv3lngVcyt8vWZ0w2RfEh9zGb/Ke21nU7qHJ/WdmaCr3XoNvPb1Ngq9C50X9vvgRN8lhqfqYeFLQFdzI8QqnNFl+EM5XXAqbiCB5ibOIHNne15DBKo9xMSJGxHOx5dsj8r98Cs0XvaGt7NEXHvgzSedZ+gAXf5PMQGwFyxCd+O7951dcWP3NK7zK7ruBlzpfI5+iQDd8vLwiVzZaBHxYNAJs0DagcP3hGE/1QislMT86fhMjhNbrdRfmr92VYPpcDEiGLr6IXsuODeY/FAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIbKAVm2JC6RQW87vnC+3FtPjG3bn2AnpOwD1nBr24w=;
 b=HNhVf4X7ZNHufvSUfNWkj8moUkL2aTcZ5+44evAwSBMcDVJo/iB4BJGXfakNZA634ZLvNkyeIE6j0MCqTs10JQUYJ/CqhyILxTJ/XuKZCKCZi43qjOsa2bdWNJeJG+el+voEkfySk2Tg68PHFM0oCsUljP0UA3ADdeT/IdOYuibffmr0zy0O/7OxLZYVOVyBe3T+qiEzK6WTafzcJvbJxcHcwZq//DAstm1OPf8MaX85BTimQ+SiL8Bw6jeMq23Zbfe7pVDzjslQk6yDmQi/btZVh77naio0GNLl2k46hVPr17MFlnoPkvWHPAxyo8kaRccdyGov6aPFEdQz49Dxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIbKAVm2JC6RQW87vnC+3FtPjG3bn2AnpOwD1nBr24w=;
 b=h68qNZ6Y/mlWeJ190PRdcvVcMbW8Bm/prgdVUba2mxF7q/yN8Fhg9N/wqUJN1bigR0s5bG7gPFzlntjAyi0kXdhYJZCYrr9S60yFjNTOUgqCF2qVAZ2/+cBJGpVah8xROBieEvCPO8wjK2m8cpTcKZHjG5gLE6AeniB3JigGxrk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from BYAPR12MB3013.namprd12.prod.outlook.com (20.178.55.219) by
 BYAPR12MB2917.namprd12.prod.outlook.com (20.179.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 17:46:35 +0000
Received: from BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9]) by BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 17:46:35 +0000
Subject: Re: [PATCH] drm/amd/display: Fix unsigned variable compared to less
 than zero
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191111172543.GA31748@embeddedor>
From:   Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
Date:   Mon, 11 Nov 2019 12:46:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20191111172543.GA31748@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To BYAPR12MB3013.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::27)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b99bc0b-a7d5-403c-f522-08d766cf1898
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2917298B722196CB447A2B79E4740@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(53546011)(6506007)(6116002)(6636002)(2906002)(47776003)(65806001)(3846002)(65956001)(36756003)(31696002)(478600001)(66066001)(50466002)(6666004)(36916002)(23676004)(2486003)(76176011)(4326008)(2616005)(476003)(386003)(26005)(446003)(52116002)(14444005)(6246003)(11346002)(486006)(14454004)(186003)(25786009)(81156014)(66946007)(7736002)(66476007)(6512007)(66556008)(305945005)(6486002)(8936002)(81166006)(8676002)(316002)(229853002)(31686004)(5660300002)(58126008)(110136005)(6436002)(230700001)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2917;H:BYAPR12MB3013.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTn40hA3u6vgekTxohXck59iaHwOOiLy6gjnEgMLkrKg0j53Vzy6etmerbexw95ClPg08k8FhWBqpzdfhOkldYcFyn2RkaMBonMtC+m029s3ioOsP7SHFrfViOVkLckxOLL/Iho1W+VDs8G2zw22cgSGi43I2eBFZjsWaZ6zx0hciQ+VGFizYydgPQl65Z6q/r27IK1Fix0IVnk3FtsHU3P+aapPO1BdI1ODtFouPw064/uSOOOKpFUq7nZIsgBEDgvXqDaAL6pvk+tCSFbTt2e2iQrXoOv9FkVILEQJEdn5zzEaoBmprCMsgkTT0W+OGT1afVy53baqhLyBoRkCK+le+ExgEeYnjMcz4B9PrglMoaOG9FTeyKL88FttE8VtYaAgYKrdLbYFrleBtR777WXWJH0kNbhxF8H4JjAwJ7lZzCESZHkrm/zWIx33/Heq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b99bc0b-a7d5-403c-f522-08d766cf1898
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 17:46:35.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfSJwWWlOTV5LZudltTlSAqHKpSGjLNh/u0fOOoj9q+YxLq9W+t1Q4muJWTfkRGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for catching it!

Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>


On 11.11.2019 12:25, Gustavo A. R. Silva wrote:
> Currenly, the error check below on variable*vcpi_slots*  is always
> false because it is a uint64_t type variable, hence, the values
> this variable can hold are never less than zero:
> 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:
> 4870         if (dm_new_connector_state->vcpi_slots < 0) {
> 4871                 DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_stat     e->vcpi_slots);
> 4872                 return dm_new_connector_state->vcpi_slots;
> 4873         }
> 
> Fix this by making*vcpi_slots*  of int type
> 
> Addresses-Coverity: 1487838 ("Unsigned compared against 0")
> Fixes: b4c578f08378 ("drm/amd/display: Add MST atomic routines")
> Signed-off-by: Gustavo A. R. Silva<gustavo@embeddedor.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 6db07e9e33ab..a8fc90a927d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -403,7 +403,7 @@ struct dm_connector_state {
>   	bool underscan_enable;
>   	bool freesync_capable;
>   	uint8_t abm_level;
> -	uint64_t vcpi_slots;
> +	int vcpi_slots;
>   	uint64_t pbn;
>   };
>   
> -- 2.23.0

-- 
Thanks,
Mikita Lipski
Software Engineer, AMD
mikita.lipski@amd.com
