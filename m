Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA62053B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4hcyRY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLZVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:54:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:54:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBQLsX3v177502;
        Thu, 26 Dec 2019 21:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=71+yLHXaaKx31W+eL5+aS24elM+JNkc3yBB8kz/sz+8=;
 b=M4hcyRY1dMlEvCFXcp/4HcD4hg7A3Qb+nEBY1PQVYlIdLOEErqdN/DRqC1SL7+xzGh40
 raevVb1zx14cGHrP/Bbr1o6mPNT77sAFS8bEWhBp3Tlwp2HUaVP/6o0oqVN1S2hRuIg7
 2Mn8SX8Bvv3uWGxlo4bbe0aFSUeHc54pxPP/7Uyqx2k14gd7LQ9IQrE32/jFZkENIAAA
 JJIPrXIdhjJ++tMLN5A6mg+KYCqvdOamQhddmpOlXdahPv5kbVPLDW0qNRflMpjeT+Dm
 YuZjKkLSfBrnnRSS68nViZT1q5fdGKyTtQKHnOiOAg3KjHSK4Jc3P+fBwwU2le0RoWF0 JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2x1attucsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Dec 2019 21:54:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBQLmMhm178145;
        Thu, 26 Dec 2019 21:54:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2x4t3yt9vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Dec 2019 21:54:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBQLsQu3003301;
        Thu, 26 Dec 2019 21:54:26 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Dec 2019 13:54:26 -0800
Date:   Fri, 27 Dec 2019 00:54:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: huawei-wmi: Fix a possible NULL deref
Message-ID: <20191226215418.GA3889@kadam>
References: <20191225235841.14393-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225235841.14393-1-ayman.bagabas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9482 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912260192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9482 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912260193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 06:58:38PM -0500, Ayman Bagabas wrote:
> We're iterating over a NULL terminated array.

This changelog is kind of messed up.  This is how it looks in context:
https://marc.info/?l=linux-kernel&m=157731837511760&w=2
The subject and the commit message are far apart.  What's wrong with
iterating over a NULL terminated array?  The changelog doesn't say which
variable is NULL.

> 
> Fixes: 1ac9abeb2e5b ("platform/x86: huawei-wmi: Move to platform driver")
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  drivers/platform/x86/huawei-wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index a2d846c4a7ee..42d461eeeff4 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -784,13 +784,13 @@ static const struct wmi_device_id huawei_wmi_events_id_table[] = {
>  static int huawei_wmi_probe(struct platform_device *pdev)
>  {
>  	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
> +	struct input_dev *idev = *huawei_wmi->idev;

This line seems like an unrelated change.  I'm still not sure the
justification for this.  I really hate puzzling over patches to try
figure out why a patch is making changes.

regards,
dan carpenter


