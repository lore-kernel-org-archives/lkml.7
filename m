Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B723C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5205221019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE2JFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:05:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48252 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbfE2JFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:05:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T956rG025894;
        Wed, 29 May 2019 04:05:06 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sq340mk59-1;
        Wed, 29 May 2019 04:05:05 -0500
Received: from EDIEX01.ad.cirrus.com (ediex01.ad.cirrus.com [198.61.84.80])
        by mail3.cirrus.com (Postfix) with ESMTP id 01503613E7A5;
        Wed, 29 May 2019 04:05:47 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 29 May
 2019 10:05:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 29 May 2019 10:05:04 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A17AE45;
        Wed, 29 May 2019 10:05:04 +0100 (BST)
Date:   Wed, 29 May 2019 10:05:04 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: arizona: Correct error handling on
 regmap_update_bits_check
Message-ID: <20190529090504.GG28362@ediswmail.ad.cirrus.com>
References: <CGME20190528165025epcas5p41d2a0c9b244532709135ab96da73e27c@epcas5p4.samsung.com>
 <20190528165020.10320-1-ckeepax@opensource.cirrus.com>
 <92a28c6f-9c58-d762-f635-f5a93e602843@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a28c6f-9c58-d762-f635-f5a93e602843@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:37:06PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 5. 29. 오전 1:50, Charles Keepax wrote:
> > Ensure the case when regmap_update_bits_check fails and the change
> > variable is not updated is handled correctly.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> >  				 ARIZONA_MICD_ENA, 0,
> 
> You better to check the return value as the part of this patch.
> 

Ok I will add it, I hadn't as it was kinda pointless the driver
is being unbound and if this doesn't work the regulator stuff
will flag the error anyway. But I guess one more error message to
make it even more clear where the issue is can't hurt.

Thanks,
Charles
