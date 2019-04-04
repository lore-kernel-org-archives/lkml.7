Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4C8206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bhdqKUN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfDDSae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:30:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:30:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34ITN8B020224;
        Thu, 4 Apr 2019 18:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YOSgKawQbJ2vNpQpNCCdqDDQihrGtpjIkwq7F+qx4Lw=;
 b=bhdqKUN7BOCGezrb4osx0UDISWDcaDHTbFCl+JtEqA+TuJtv8Uq48E10yE54YMFORwdD
 RPufG3MuEA4v1f0EhJcnb4XAZwsHiVp+cKVtxBR/tgySYUsLZk+lgKO+kWENSgz3dyj2
 d+OqxL7UviAHWULi57Az/4HX2m9vA0JIyQTVYsIPuZKwgConM4p08PnpSFyNXGQrGgG0
 47t8nZoAHJQrPcQ+pljfm6t31RXx5Xa/PASD5K7WTNUvrGDkPOFwajbGT5ktLwWRaYpU
 dYYKCgoRe5FTwb9DiYhdyPPoEMGkMxFsNuCedZEgiERnMTGNS1gUq3I7UAOCvkctz0SH 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwydh2m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 18:30:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34IUFYx088857;
        Thu, 4 Apr 2019 18:30:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rm8f5u9tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 18:30:19 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x34IUDpo011057;
        Thu, 4 Apr 2019 18:30:13 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 11:30:12 -0700
Date:   Thu, 4 Apr 2019 14:30:39 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove extra cgroup_migrate_finish() call
Message-ID: <20190404183039.ynhstolbzdeq2tpp@ca-dmjordan1.us.oracle.com>
References: <20190403230354.117915-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403230354.117915-1-shakeelb@google.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=750
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040116
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=807 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:03:54PM -0700, Shakeel Butt wrote:
> The callers of cgroup_migrate_prepare_dst() correctly call
> cgroup_migrate_finish() for success and failure cases both. No need to
> call it in cgroup_migrate_prepare_dst() in failure case.

Calling cgroup_migrate_finish multiple times is a no-op, so thankfully it
wasn't causing any problems.  Looks good to me.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
