Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFB5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A526D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLaVosSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfFXJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:49:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:49:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O9hSNr092560;
        Mon, 24 Jun 2019 09:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=6KQBOb8kDteiRaAmKhWFG2uycaXZff/cbFNmgbb3afs=;
 b=gLaVosSKzNgFwu/dzLOasmWKAU6RF7pnKBJh3FK5PiQCiGGhiffmLidfxdqWVDhRMDy3
 C6Dct9zVB/I4MSRgjZwW+OhsHMZWZfFGYhWmW4fr3If6D8AAcdTWEDw6h7fzIAb9601c
 jPKXrzCF2prFGbdNckGXOEv2skGVfk0WmZZcTF+yNmw/OvyXHOd7ct7ct7UZZiMilx0k
 uEY86ICkgHjqzrKA0Ry7kHQdHIl9jND/UVd0uoURoG66XnxqIeffakJu16RNZizn2TOT
 J4BxzoEgLD4JKw0uvNHyEE8xl5jZj/F+GktoFBFGibp/+kBdeO3LaSfqxoC77DM2BNts 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pdc62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:49:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O9lmoQ083074;
        Mon, 24 Jun 2019 09:49:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t99f36a0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:49:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5O9mx5D002113;
        Mon, 24 Jun 2019 09:48:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 02:48:59 -0700
Date:   Mon, 24 Jun 2019 12:48:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     maowenan <maowenan@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        julia.lawall@lip6.fr, kernel-janitors@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jonathan.kim@amd.com, Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next v3] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Message-ID: <20190624094850.GQ18776@kadam>
References: <alpine.DEB.2.21.1906230809400.4961@hadrien>
 <20190624034532.135201-1-maowenan@huawei.com>
 <20190624083952.GO18776@kadam>
 <4795ba5c-8e41-e1e0-c96a-47fdda3995e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4795ba5c-8e41-e1e0-c96a-47fdda3995e3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:29:33PM +0800, maowenan wrote:
> 
> 
> On 2019/6/24 16:39, Dan Carpenter wrote:
> > On Mon, Jun 24, 2019 at 11:45:32AM +0800, Mao Wenan wrote:
> >> There is one warning:
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >>   int ret = 0;
> >>       ^
> >> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
> >> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
> >> amdgpu_device_init()
> >> 	r = amdgpu_pmu_init(adev);
> >>
> >> This patch is also to update the indenting on the arguments so they line up with the '('.
> >>
> >> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
> >>
> >> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> >> ---
> >>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
> >>  amdgpu_pmu_init().
> >>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
> >>
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> index 0e6dba9..b702322 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> @@ -252,8 +252,11 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> >>  	case CHIP_VEGA20:
> >>  		/* init df */
> >>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> >> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> >> -				       DF_V3_6_MAX_COUNTERS);
> >> +							   "DF", "amdgpu_df",
> >> +							   PERF_TYPE_AMDGPU_DF,
> >> +							   DF_V3_6_MAX_COUNTERS);
> >> +		if (ret)
> >> +			return ret;
> > 
> > No no.  Sorry, the original indenting was correct and lined up with the
> > '(' character in 'init_pmu_by_type(', that's the way it should be.  If
> > we were to remove the "ret = " then we'd have to pull the arguments back
> > as well.  I think this fix that Julia suggested is really the right so
> > leave the indenting alone.
> > 
> 
> > It looks like you've right aligned the arguments.  That's not the right
> > way, the original was correct.
> > 
> After using 8 character for tab(thanks to Joe), the aligned here is wrong, yes, the original was correct.
> 
> so my v4 is only to change ret, don't change the indenting?
> 

Yes, please.  Sorry for my confusing email earlier.

regards,
dan carpenter

