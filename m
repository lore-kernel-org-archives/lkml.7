Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF6AC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D856720811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfDYKtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:49:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728944AbfDYKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:49:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PAf26R030566
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:49:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s39c6dtgs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:49:21 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 25 Apr 2019 11:49:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 11:49:17 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PAnGMs46792952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 10:49:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0525A5204F;
        Thu, 25 Apr 2019 10:49:16 +0000 (GMT)
Received: from localhost (unknown [9.152.212.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BACCA52051;
        Thu, 25 Apr 2019 10:49:15 +0000 (GMT)
Date:   Thu, 25 Apr 2019 12:49:14 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 26/27] debugfs: Restrict debugfs when the kernel is
 locked down
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <20190306235913.6631-27-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306235913.6631-27-matthewgarrett@google.com>
X-TM-AS-GCONF: 00
x-cbid: 19042510-0020-0000-0000-000003356F81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042510-0021-0000-0000-00002187DAA4
Message-Id: <your-ad-here.call-01556189354-ext-1943@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:59:12PM -0800, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
>  static int open_proxy_open(struct inode *inode, struct file *filp)
>  {
>  	struct dentry *dentry = F_DENTRY(filp);
> @@ -147,6 +166,11 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
>  		return r == -EIO ? -ENOENT : r;
>  
>  	real_fops = debugfs_real_fops(filp);
> +
> +	r = -EPERM;
> +	if (debugfs_is_locked_down(inode, filp, real_fops))
> +		goto out;
> +
>  	real_fops = fops_get(real_fops);
>  	if (!real_fops) {
>  		/* Huh? Module did not clean up after itself at exit? */
> @@ -272,6 +296,10 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
>  		return r == -EIO ? -ENOENT : r;
>  
>  	real_fops = debugfs_real_fops(filp);
> +	r = -EPERM;
> +	if (debugfs_is_locked_down(inode, filp, real_fops))
> +		goto out;
> +
>  	real_fops = fops_get(real_fops);
>  	if (!real_fops) {
>  		/* Huh? Module did not cleanup after itself at exit? */

Please be aware that this patch has been known to cause problems in
distributions which picked this patch series already:
ubuntu:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1807686
fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=1658675
as well as rhel 8.

I've sent around this potential fix which has been picked by the
distributions (offered via bugzillas), but went apparently unnoticed
at lkml:
https://lkml.org/lkml/2018/11/21/634
https://lkml.org/lkml/2018/11/21/635

"""
With "debugfs: Restrict debugfs when the kernel is locked down"
return code "r" is unconditionally set to -EPERM, which stays like that
until function return if no "open" file operation defined, effectivelly
resulting in "Operation not permitted" for all such files despite kernel
lock down status or CONFIG_LOCK_DOWN_KERNEL being enabled.
"""

I would appreciate if you consider that change, possibly just
squashing into yours.

