Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A13EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D142020656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oue6YP5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKKQ3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:29:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:23054 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbfKKQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:29:19 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xABGOcTX022487;
        Mon, 11 Nov 2019 10:27:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=LA4A7J6Ne2Y8iSl9rFw0dPXecqUpEhjzWKaWvos0f0o=;
 b=oue6YP5qiYN+D+UQarAK7G2NDFJrU0GWj2njbUpNUTSZQPDvteW6p0LWZuN7e/AJPSdX
 toGNXGDncHcU+c2Inmryf/ertpuoAgjtx4JMyXR1voAqWPpEJcey7CUBRIpuzmghz/+4
 3zKyx+uZaesjPpEYktk3++y5TLXKafvSQ+3Ftw71uz29OtUkNMvCXbb2oe1fQAF4lqiM
 n5XkZy279pC8Wqm94ZIEqMMbETDVUYEy/6ikGdMdJ/3M+u86FRe5j6mu4prOjXYttD5A
 4STv9XPSV8Z36StXpIpW9XfzsvhoqRkicf3u6QZs3sI9y4nUqYlssrJxvJUgg4/XvLxr Ew== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2w5ur2khbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Nov 2019 10:27:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 11 Nov
 2019 16:27:08 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 11 Nov 2019 16:27:08 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 696E82A1;
        Mon, 11 Nov 2019 16:27:08 +0000 (UTC)
Date:   Mon, 11 Nov 2019 16:27:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Michael Walle <michael@walle.cc>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: wm8904: configure sysclk/FLL automatically
Message-ID: <20191111162708.GC10439@ediswmail.ad.cirrus.com>
References: <20191108203152.19098-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191108203152.19098-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=579
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911110149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 09:31:52PM +0100, Michael Walle wrote:
> This adds a new mode WM8904_CLK_AUTO which automatically enables the FLL
> if a frequency different than the MCLK is set.
> 
> These additions make the codec work with the simple-card driver in
> general and especially in systems where the MCLK doesn't match the
> required clock.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
