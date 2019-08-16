Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7897FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492C92064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHGVno8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfHPNGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:06:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHPNGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:06:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GD3bVU190836;
        Fri, 16 Aug 2019 13:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=67pOKecjpo97WLpPkKdW/nVnEGYMOXd1PrwE481gBPM=;
 b=MHGVno8yNc2zU1C4hqVBEr8N/UMexD6PdT2dGzN0+xWPIr6d49bndsRzNDbfq1q573Z9
 t2ku/JV1Kxu4YJkqwOZtdqAu5twsy+iPFeSBYb5h+VdlQC4Qa6A7ikdTFewWNdmKk2BK
 rU9//Ke785G7O+5IvW7a+eaMxjwIBsbI+BhfSl7csdPGd4zaEOExuqBdZlvbckPaPrtL
 wa6dUx22Pzp1u+cT/YIYfBPTL4jRh7Vrm6SepC2MjDWHWOhW9lqWBEnZd+egB41voxXh
 wipBIYUC1IzEYeiEzMg3s6Z2un5kZvJbrXrSrFAnBLsfwB9ZbFEtbgzIcxAOAH+Ydrxh 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjr0977-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:05:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GD34Lt027182;
        Fri, 16 Aug 2019 13:05:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ucs890utk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 13:05:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7GD5uEq023843;
        Fri, 16 Aug 2019 13:05:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 06:05:56 -0700
Date:   Fri, 16 Aug 2019 16:05:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Gao@osuosl.org,
        Shiqing <shiqing.gao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 09/15] drivers/acrn: add passthrough device support
Message-ID: <20190816130546.GA3632@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-10-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-10-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:50AM +0800, Zhao Yakui wrote:
> +	case IC_ASSIGN_PTDEV: {
> +		unsigned short bdf;
> +
> +		if (copy_from_user(&bdf, (void *)ioctl_param,

This casting is ugly and you also need a __user tag for Sparse.  Do
something like "void __user *p = ioctl_param;"

> +				   sizeof(unsigned short)))
> +			return -EFAULT;
> +
> +		ret = hcall_assign_ptdev(vm->vmid, bdf);
> +		if (ret < 0) {
> +			pr_err("acrn: failed to assign ptdev!\n");
> +			return -EFAULT;

Preserve the error code.  "return ret;".

> +		}
> +		break;
> +	}
> +	case IC_DEASSIGN_PTDEV: {
> +		unsigned short bdf;
> +
> +		if (copy_from_user(&bdf, (void *)ioctl_param,
> +				   sizeof(unsigned short)))
> +			return -EFAULT;
> +
> +		ret = hcall_deassign_ptdev(vm->vmid, bdf);
> +		if (ret < 0) {
> +			pr_err("acrn: failed to deassign ptdev!\n");
> +			return -EFAULT;
> +		}
> +		break;
> +	}
> +
> +	case IC_SET_PTDEV_INTR_INFO: {
> +		struct ic_ptdev_irq ic_pt_irq;
> +		struct hc_ptdev_irq *hc_pt_irq;
> +
> +		if (copy_from_user(&ic_pt_irq, (void *)ioctl_param,
> +				   sizeof(ic_pt_irq)))
> +			return -EFAULT;
> +
> +		hc_pt_irq = kmalloc(sizeof(*hc_pt_irq), GFP_KERNEL);
> +		if (!hc_pt_irq)
> +			return -ENOMEM;
> +
> +		memcpy(hc_pt_irq, &ic_pt_irq, sizeof(*hc_pt_irq));

Use memdup_user().

> +
> +		ret = hcall_set_ptdev_intr_info(vm->vmid,
> +						virt_to_phys(hc_pt_irq));
> +		kfree(hc_pt_irq);
> +		if (ret < 0) {
> +			pr_err("acrn: failed to set intr info for ptdev!\n");
> +			return -EFAULT;
> +		}
> +
> +		break;
> +	}

regards,
dan carpenter
