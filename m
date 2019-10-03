Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE885C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DB52133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WNR7kSjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfJCJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:16:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54400 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728769AbfJCJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:16:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x939F9Ri018996;
        Thu, 3 Oct 2019 04:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=32tst5POj7PScFdPdfx0Z/MiaN40vsOvfcG/uNUm0qc=;
 b=WNR7kSjriWXCBCBs8t9F6A+fPAvds2TeTUrWSgybGgSnxZBG+8d5OuuopBY3Fw4ECdEn
 kPdOGWdu4NHexpB1obJXdQyIlXwIpgpQk03zRRuQDbTP3F1EUnIev13nvg8c9oMTDw5X
 +sPflv8Jigp8BAS9gr2s+YdKhfonIuG5Qw3B9/NEQ8mVU3CRNd+IoU8KXyc1v2/lE4yg
 dlRqOVtbTVhDGL1r/6ypW3c/Ay7oovyay7+kpH6M240YbaExar6f0To7oji9UpPzZrMl
 hDYFeGLb6SPYZm1h+YrdGhgmKIlODE/Wo//GNdb1v89AG3iSrfkmvDUXy4oxe9MTXuAW qg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4r3nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Oct 2019 04:16:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 3 Oct
 2019 10:15:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 3 Oct 2019 10:15:59 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1FCBA2A1;
        Thu,  3 Oct 2019 09:15:59 +0000 (UTC)
Date:   Thu, 3 Oct 2019 09:15:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: arizona: switch to using devm_gpiod_get()
Message-ID: <20191003091559.GU10204@ediswmail.ad.cirrus.com>
References: <20191003002832.GA13466@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191003002832.GA13466@dtor-ws>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=807
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:28:32PM -0700, Dmitry Torokhov wrote:
> Now that gpiolib recognizes wlf,reset legacy GPIO and will handle it
> even if DTS uses it without -gpio[s] suffix, we can switch to more
> standard devm_gpiod_get() and later remove devm_gpiod_get_from_of_node().
> 
> Note that we will lose "arizona /RESET" custom GPIO label, but since we
> do not set such custom label when using the modern binding, I opted to
> not having it here either.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
