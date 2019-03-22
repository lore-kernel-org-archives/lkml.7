Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211112190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfCVRDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:03:47 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42472 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbfCVRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:03:47 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MGmxm2013963;
        Fri, 22 Mar 2019 12:03:36 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ratnq73b1-1;
        Fri, 22 Mar 2019 12:03:36 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id CFF0B60D9775;
        Fri, 22 Mar 2019 12:03:35 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 17:03:35 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x2MH3XRg024118;        Fri, 22 Mar 2019 17:03:34 GMT
Date:   Fri, 22 Mar 2019 17:03:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Lee Jones <lee.jones@linaro.org>,
        <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>,
        Colin Ian King <colin.king@canonical.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: arizona: fix undefined behavior
Message-ID: <20190322170333.GD46536@ediswmail.ad.cirrus.com>
References: <20190322143345.1208144-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190322143345.1208144-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=636 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:33:37PM +0100, Arnd Bergmann wrote:
> When the driver is used with a subdevice that is disabled in the
> kernel configuration, clang gets a little confused about the
> control flow and fails to notice that n_subdevs is only
> uninitialized when subdevs is NULL, and we check for that,
> leading to a false-positive warning:
> 
> drivers/mfd/arizona-core.c:1423:19: error: variable 'n_subdevs' is uninitialized when used here
>       [-Werror,-Wuninitialized]
>                               subdevs, n_subdevs, NULL, 0, NULL);
>                                        ^~~~~~~~~
> drivers/mfd/arizona-core.c:999:15: note: initialize the variable 'n_subdevs' to silence this warning
>         int n_subdevs, ret, i;
>                      ^
>                       = 0
> 
> Ideally, we would rearrange the code to avoid all those early
> initializations and have an explicit exit in each disabled case,
> but it's much easier to chicken out and add one more initialization
> here to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
