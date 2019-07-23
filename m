Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC748C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD34227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YEuBtZQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfGWJPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:15:32 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52728 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730465AbfGWJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:15:32 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6N9EXwM026652;
        Tue, 23 Jul 2019 04:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ZOi1S9tzJScdZvmwSZab3gVbroEdWfMG/QqlF3Yz3yo=;
 b=YEuBtZQpG7PSxB6t6Sk+NK+SsSWGZhiFWi3AdCwp+V/Ejlmj/5jhecD2MnpFjNjSdLSs
 Ly/EaipnuwUYL6OiqmURw90hik4FG6X5UT2VPRNAIZuaOvxCfgFYYp4Sw0YUdBk5Q436
 w/ACZ2Cp52mC2V8n2UYCAPCoHeRP7H2T1vxx+vX8BoccLg0pcXiVIaE8qU51KM+4DfJg
 cEiMLqKVnkYvokLQJkOl5/XI5mafjaiENoS9x0cMB5oNfk25grjIGgbuJdjnO7J8+O2M
 pAxtQAHTj7yqDysK1/70joQ9HZkY16qyrcNRc1Ny/f4c6PQQl126h4hNrl3Rec38FAjx iA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2twm3qrtg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jul 2019 04:15:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 23 Jul
 2019 10:15:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 23 Jul 2019 10:15:05 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 752D845;
        Tue, 23 Jul 2019 10:15:05 +0100 (BST)
Date:   Tue, 23 Jul 2019 10:15:05 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Wenwen Wang <wenwen@cs.uga.edu>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: fix a memory leak bug
Message-ID: <20190723091505.GN54126@ediswmail.ad.cirrus.com>
References: <1563803864-2809-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1563803864-2809-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 mlxlogscore=944 suspectscore=2 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1904300001 definitions=main-1907230087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:57:44AM -0500, Wenwen Wang wrote:
> From: Wenwen Wang <wenwen@cs.uga.edu>
> 
> In snd_soc_dapm_new_control_unlocked(), a kernel buffer is allocated in
> dapm_cnew_widget() to hold the new dapm widget. Then, different actions are
> taken according to the id of the widget, i.e., 'w->id'. If any failure
> occurs during this process, snd_soc_dapm_new_control_unlocked() should be
> terminated by going to the 'request_failed' label. However, the allocated
> kernel buffer is not freed on this code path, leading to a memory leak bug.
> 
> To fix the above issue, free the buffer before returning from
> snd_soc_dapm_new_control_unlocked() through the 'request_failed' label.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
