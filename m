Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9320823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfC1RFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:05:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbfC1RFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:05:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SH2pfK121606
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:05:17 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh17xbmc4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:05:17 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <arbab@linux.ibm.com>;
        Thu, 28 Mar 2019 17:05:16 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 17:05:11 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SH59Vk17760432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 17:05:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE0B22806A;
        Thu, 28 Mar 2019 17:05:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB3328059;
        Thu, 28 Mar 2019 17:05:09 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.179.210])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 17:05:09 +0000 (GMT)
Received: from arbab-laptop.localdomain (arbab-laptop.localdomain [IPv6:::1])
        by arbab-laptop.localdomain (Postfix) with ESMTP id 285874606B5;
        Thu, 28 Mar 2019 12:05:08 -0500 (CDT)
Date:   Thu, 28 Mar 2019 12:05:08 -0500
From:   Reza Arbab <arbab@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Tarasov <tutankhamen@chromium.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wzabolot@elektron.elka.pw.edu.pl, Pavel Machek <pavel@ucw.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/fb-helper: Do not scale depth down to 0
References: <1553288173-10845-1-git-send-email-arbab@linux.ibm.com>
 <1553288173-10845-3-git-send-email-arbab@linux.ibm.com>
 <CACRpkdb0i1foVhKcNiKJzrA8DYjheb8yQ1RQ3_VGniZrMiUvqQ@mail.gmail.com>
 <20190328165230.dez2op5vijx6ildl@arbab-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328165230.dez2op5vijx6ildl@arbab-laptop.localdomain>
Organization: IBM Linux Technology Center
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19032817-0072-0000-0000-00000411B9DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010829; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01180965; UDB=6.00618075; IPR=6.00961684;
 MB=3.00026196; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 17:05:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032817-0073-0000-0000-00004BA24A0E
Message-Id: <20190328170507.u5cd7svhspolu2t7@arbab-laptop.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:52:30AM -0500, Reza Arbab wrote:
>On Thu, Mar 28, 2019 at 05:33:31PM +0100, Linus Walleij wrote:
>>This makes perfect sense, but Dave Airlie already sent a similar
>>patch some two weeks ago, I wonder what happened with it?
>>Subject "avoid setting 0 depth".
>
>Argh, that he did! I'm not subscribed to dri-devel so I didn't see that.
>
>Did this get lost? The other patch from that series has been applied; 
>8f3b487685b2 ("drm/udl: use drm_gem_object_put_unlocked.")

Never mind. It's in the drm-fixes tree. Looks like both of my patches 
got beaten to the punch there:

a51143001d9e ("drm/udl: Refactor edid retrieving in UDL driver (v2)")
b6a36e5ddf84 ("drm/fb: avoid setting 0 depth.")

-- 
Reza Arbab

