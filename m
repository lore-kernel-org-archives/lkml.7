Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F555C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D512183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfC1Qwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:52:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfC1Qwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:52:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SGmljU050990
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:52:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh233r8b2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:52:37 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <arbab@linux.ibm.com>;
        Thu, 28 Mar 2019 16:52:36 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 16:52:33 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SGqW2Q15663306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:52:32 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 908C5BE056;
        Thu, 28 Mar 2019 16:52:32 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 697ABBE05D;
        Thu, 28 Mar 2019 16:52:32 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.179.210])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 16:52:32 +0000 (GMT)
Received: from arbab-laptop.localdomain (arbab-laptop.localdomain [IPv6:::1])
        by arbab-laptop.localdomain (Postfix) with ESMTP id BB2534606B5;
        Thu, 28 Mar 2019 11:52:30 -0500 (CDT)
Date:   Thu, 28 Mar 2019 11:52:30 -0500
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACRpkdb0i1foVhKcNiKJzrA8DYjheb8yQ1RQ3_VGniZrMiUvqQ@mail.gmail.com>
Organization: IBM Linux Technology Center
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19032816-0016-0000-0000-000009985C4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010829; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01180961; UDB=6.00618072; IPR=6.00961679;
 MB=3.00026196; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 16:52:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032816-0017-0000-0000-0000429D24FB
Message-Id: <20190328165230.dez2op5vijx6ildl@arbab-laptop.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 05:33:31PM +0100, Linus Walleij wrote:
>This makes perfect sense, but Dave Airlie already sent a similar
>patch some two weeks ago, I wonder what happened with it?
>Subject "avoid setting 0 depth".

Argh, that he did! I'm not subscribed to dri-devel so I didn't see that.

Did this get lost? The other patch from that series has been applied; 
8f3b487685b2 ("drm/udl: use drm_gem_object_put_unlocked.")

-- 
Reza Arbab

