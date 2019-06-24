Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D821C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB54F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vC2302H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfFXIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:40:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfFXIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:40:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O8dY5K123395;
        Mon, 24 Jun 2019 08:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=6ck8MBwXxLWycwZKvrYVSaIGF3TxSfLus7KSpoOIBjU=;
 b=vC2302H4F6dWabhAgytQ6Jo351FpiF16D8mZXPZBMgRXsl529QkM4ygIo8XSTSyqlh7J
 mhZSMu4lWjxzMYVpM/G/ndyL/7V4XXSLdDwvKZTTpYi3eEzdqOpIB1iENGdw2JpDxneE
 N3pp0EEjDYIgtXUegZ6CZzty9V3gtAZBx6XrBRB6SsK2sHR+7SrZeFWB+JLtaADrFw1Q
 T9kGUQc2e/3DS2GOKorK5ZRYCC+ji8BuggTWLQxnn3dsU2q0e27g6ADrcX0JrDZ7Bf/w
 B45/EUB/DMrWYzNhAJoQMftCLKuChGHHVeo9vbfcH4eyfXpzOx3/n1GTr2cPO8GPW0Yg pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brsw0gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 08:40:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O8dRBm050198;
        Mon, 24 Jun 2019 08:40:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acbctw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 08:40:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5O8e1gL028104;
        Mon, 24 Jun 2019 08:40:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 01:40:01 -0700
Date:   Mon, 24 Jun 2019 11:39:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        julia.lawall@lip6.fr, kernel-janitors@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jonathan.kim@amd.com
Subject: Re: [PATCH -next v3] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Message-ID: <20190624083952.GO18776@kadam>
References: <alpine.DEB.2.21.1906230809400.4961@hadrien>
 <20190624034532.135201-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624034532.135201-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:45:32AM +0800, Mao Wenan wrote:
> There is one warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret = 0;
>       ^
> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
> amdgpu_device_init()
> 	r = amdgpu_pmu_init(adev);
> 
> This patch is also to update the indenting on the arguments so they line up with the '('.
> 
> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>  amdgpu_pmu_init().
>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 0e6dba9..b702322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -252,8 +252,11 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>  	case CHIP_VEGA20:
>  		/* init df */
>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> -				       DF_V3_6_MAX_COUNTERS);
> +							   "DF", "amdgpu_df",
> +							   PERF_TYPE_AMDGPU_DF,
> +							   DF_V3_6_MAX_COUNTERS);
> +		if (ret)
> +			return ret;

No no.  Sorry, the original indenting was correct and lined up with the
'(' character in 'init_pmu_by_type(', that's the way it should be.  If
we were to remove the "ret = " then we'd have to pull the arguments back
as well.  I think this fix that Julia suggested is really the right so
leave the indenting alone.

It looks like you've right aligned the arguments.  That's not the right
way, the original was correct.

regards,
dan carpenter

