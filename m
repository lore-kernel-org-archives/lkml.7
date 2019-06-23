Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D204AC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 06:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1232073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 06:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u8cYt3D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFWGAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 02:00:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFWGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 02:00:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5N5xPkZ118818;
        Sun, 23 Jun 2019 06:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3Tqxh9oXL076ygce3iRd3OSDhwc/AqTWDgGWjKB7jzU=;
 b=u8cYt3D8fx4rByZ8Kowuln3CYMbi9ubjwSQCfykl6KCupJN4TmO8X4Xyamx66n0/GydA
 ytg04soBoG1ilu6pSYSxPRe2BCkQGAoqG9y5NK8DtchGm9MjdepTcOto6qhLDQZmaeGb
 IniAnXDyUxnleyorU24VOxoEPkPFX+2mMm8Njz6w8uzqpSWFuN5Ci+UfbbrYZ//HzF41
 8BbVBOSZKEsoxuMciqS8dxc//wH8b4wDL3ENvDin9bZySNmWZPcvqsi3RVmRFBxLGMVu
 ErEjGc8izlBubGhubeD1afYvBFlg2i0PoKP6/6p/Qz1NAcWLm6r1noOnQT5PHLKHmhUl KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brst328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jun 2019 06:00:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5N5xqJX142593;
        Sun, 23 Jun 2019 06:00:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t9x1ej6sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jun 2019 06:00:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5N60aku021412;
        Sun, 23 Jun 2019 06:00:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Jun 2019 23:00:35 -0700
Date:   Sun, 23 Jun 2019 09:00:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
Message-ID: <20190623060027.GU28859@kadam>
References: <20190622030314.169640-1-maowenan@huawei.com>
 <20190622104318.GT28859@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622104318.GT28859@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9296 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906230052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9296 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906230052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 01:43:19PM +0300, Dan Carpenter wrote:
> On Sat, Jun 22, 2019 at 11:03:14AM +0800, Mao Wenan wrote:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > index 0e6dba9..0bf4dd9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
> >  /* init amdgpu_pmu */
> >  int amdgpu_pmu_init(struct amdgpu_device *adev)
> >  {
> > -	int ret = 0;
> > -
> >  	switch (adev->asic_type) {
> >  	case CHIP_VEGA20:
> >  		/* init df */
> > -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> > +		init_pmu_by_type(adev, df_v3_6_attr_groups,
> >  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> >  				       DF_V3_6_MAX_COUNTERS);
> 
> 
> You're resending this for other reasons, but don't forget to update the
> indenting on the arguments so they still line up with the '('.
> 

Sorry, I was unclear.  If you pull the init_pmu_by_type( back 6
characters then you also need to pull the "DF" back 6 characters.

		init_pmu_by_type(adev, df_v3_6_attr_groups, "DF", "amdgpu_df",
				 PERF_TYPE_AMDGPU_DF, DF_V3_6_MAX_COUNTERS);

You can actually fit it into two lines afterwards.

regards,
dan carpenter

