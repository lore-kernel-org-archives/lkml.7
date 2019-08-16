Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F2B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h/LcWQjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHPNMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:12:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfHPNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:12:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GD8h3Z182173;
        Fri, 16 Aug 2019 13:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=XdgM3xcc9SUA+Zw1b6KHtdB/PkVRuj7m9FujaQZMHLk=;
 b=h/LcWQjZAg1u+DtntPx8biaWEAzOuirQmxwHm559QIQb7PHXu+LUSzQBoVqDEgG8RY7M
 3aParRz3aJT6+3bE60DuNWvxyL51J3AamTVzGh7KJIXPHzmHxiA5wmkZBqbLhA7RNECV
 OKs90CCj/d3b1/yHme38RpG/hLIrUXa9k02DeY3i2ULyCfN5NGn3rtopqG+FaYSuwloN
 RG8Bu3FEt7D0nkqU1UcKBGIuKberCUZeb0qLYPAjHQuJrNHpRgFx6tR7pxKPYMSGHlAg
 aPVH7UtqpLgEi4oMklT0BDJY2QtDXQd89SYxj2b17gZrePhzWawEwJ4qSN/IFO+tlyUv 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbu0e3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:12:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GD8el7019089;
        Fri, 16 Aug 2019 13:12:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2udgqg46ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:12:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7GDCBtl027537;
        Fri, 16 Aug 2019 13:12:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 06:12:10 -0700
Date:   Fri, 16 Aug 2019 16:12:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 10/15] drivers/acrn: add interrupt injection support
Message-ID: <20190816131203.GB3632@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-11-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-11-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:51AM +0800, Zhao Yakui wrote:
> +	case IC_VM_INTR_MONITOR: {
> +		struct page *page;
> +
> +		ret = get_user_pages_fast(ioctl_param, 1, 1, &page);
> +		if (unlikely(ret != 1) || !page) {
                                       ^^^^^^^^
Not required.

> +			pr_err("acrn-dev: failed to pin intr hdr buffer!\n");
> +			return -ENOMEM;
> +		}
> +
> +		ret = hcall_vm_intr_monitor(vm->vmid, page_to_phys(page));
> +		if (ret < 0) {
> +			pr_err("acrn-dev: monitor intr data err=%ld\n", ret);
> +			return -EFAULT;
> +		}
> +		break;
> +	}
> +

regards,
dan carpenter
