Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B5920644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sbTI5GJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbfFMQcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50090 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbfFMIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:14:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D8DfAM085841;
        Thu, 13 Jun 2019 08:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XWdgxTdniwntkEIDG2SNziPX1t3Vu0D1U5JGNb+EuBs=;
 b=sbTI5GJvuNfhg+vQQX93BC3rr5+LeVu+HtdQCRpT6KUFsNzMYFyYfSulOJnK8BLOvIdN
 9TbbR+fhcBsihhhbl27k+jgrC4MaR7EFmJM8bRBwLq3FdelgrJBRJv9ZfgW8Ca6aK73m
 X033eS14x6vpcygJ+POCRb5yq2o0eQJsF0vZks29ygQqIK9Dio+twQvGcDHqFVgMJ744
 Q5uqJBtChxFcFkkJIcJTGKp99+9FsKrTVfadOCtPou4eiYGcCR5b4wWyWBNcbXn29oa6
 gl9+2NJUhdJXX7uko787YvsrqrJ86WuvfyTGhIHUt4QB54VT6+U8BNLuhPrMaA41kvdd 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqywkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 08:14:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D8DA6s066457;
        Thu, 13 Jun 2019 08:14:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t1jpje2vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 08:14:30 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5D8EStP004671;
        Thu, 13 Jun 2019 08:14:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 01:14:28 -0700
Date:   Thu, 13 Jun 2019 11:14:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coresight: potential uninitialized variable in probe()
Message-ID: <20190613081419.GG1893@kadam>
References: <20190613065815.GF16334@mwanda>
 <20190613074922.GB21113@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613074922.GB21113@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:49:22PM +0800, Leo Yan wrote:
> Hi Dan,
> 
> On Wed, Jun 12, 2019 at 11:58:15PM -0700, Dan Carpenter wrote:
> > The "drvdata->atclk" clock is optional, but if it gets set to an error
> > pointer then we're accidentally return an uninitialized variable instead
> > of success.
> 
> You are right, thanks a lot for pointing out.
> 
> I'd like to initialize 'ret = 0' at the head of function, so we can
> has the same fashion with other CoreSight drivers (e.g. replicator).
> 
>  static int funnel_probe(struct device *dev, struct resource *res)
>  {
> -	int ret;
> +	int ret = 0;
> 
> If you agree, could you send a new patch for this?

Obviously that's an option I considered...  The reason I didn't go with
that is that a common bug that I see is:

	int ret = 0;

	p = kmalloc();
	if (!p)
		goto free_whatever;

In my experience it's better to initialize the return as late as
possible so that you get static checker warnings when you forget to set
the error code.

Also I think my way is more readable.  I like to make the success path
as explicit as possible.  I hate when people do things like:

	if (!ret)
		return ret;

About 10% of the time when you see this it is a bug, but it's hard to
tell because it's not readable like it would be if people did:

	if (!ret)
		return 0;

Or sometimes you see things like:

	if (corner_case)
		goto free; /* success path */

Without the "/* success path */ comment explaining why we're returning
zero most readers will assume it's a mistake.

regards,
dan carpenter
