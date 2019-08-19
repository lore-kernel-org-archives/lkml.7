Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667CC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798732082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZtMfH7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHSKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:34:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfHSKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:34:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JAXe1I143126;
        Mon, 19 Aug 2019 10:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=+EL2o1Lhk5KY87l4wQICeVkEfT8XHCgRxPSVWeOEdC8=;
 b=DZtMfH7jDzDQtx3nDUNg7fH70qL/cugfKVkYjTNe1a1H121eeipPM+KWxEpG0d1tByxz
 Ke7AuVrOThZTP1QYl0a21NtZa+ARfIvWdUhaHySCS6FtCaZJ+GiLcbsM+zByawtDE0tl
 NhwZ/4Nj9oV++jBtprbidJKOjKK8njCnITq0lqMabiC+YCqeQI8Aq/SgQ+qXzF1B3Dx5
 62t/tz/L5Vfy2bizy3wO1Ji7FQ8a3wKAOISjjkZCidAcpoWCBWnXgiSPsQoAPl53csqT
 ukerk1XJu2pMMIXHh29o604WSDcHIzkL1ofS4V239QMpUY2bgcTVOCbY+R/QuRKloSTu QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uea7qegv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 10:34:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JAYIuB115126;
        Mon, 19 Aug 2019 10:34:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ue6qec980-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 10:34:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7JAYQkT009012;
        Mon, 19 Aug 2019 10:34:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 03:34:26 -0700
Date:   Mon, 19 Aug 2019 13:34:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 15/15] drivers/acrn: add the support of offline SOS
 cpu
Message-ID: <20190819103417.GD4451@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-16-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-16-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:56AM +0800, Zhao Yakui wrote:
> diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
> index 0602125..6868003 100644
> --- a/drivers/staging/acrn/acrn_dev.c
> +++ b/drivers/staging/acrn/acrn_dev.c
> @@ -588,6 +588,41 @@ static const struct file_operations fops = {
>  #define SUPPORT_HV_API_VERSION_MAJOR	1
>  #define SUPPORT_HV_API_VERSION_MINOR	0
>  
> +static ssize_t
> +offline_cpu_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +#ifdef CONFIG_X86
> +	u64 cpu, lapicid;
> +
> +	if (kstrtoull(buf, 0, &cpu) < 0)
> +		return -EINVAL;

Preserve the error code.

	ret = kstrtoull(buf, 0, &cpu);
	if (ret)
		return ret;

> +
> +	if (cpu_possible(cpu)) {

You can't pass unchecked cpu values to cpu_possible() or it results in
an out of bounds read if cpu is >= than nr_cpu_ids.

regards,
dan carpenter

