Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864512073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osGbMjhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLKXHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:07:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:07:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBMxTM1119188;
        Wed, 11 Dec 2019 23:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ufg6Zi8cXXhjldm/WLu/ZNOlbeAvLg5Mqf76gkYPaqo=;
 b=osGbMjhE11T+clp3ggTD1+REK5tSbHM7okTn1yz6Jsy5TY3KfIUwxkF3AcVy8lrmgIFb
 7zVnX+AImlr/z9C2eTRKKMmS6UcSD7F24ZTIBc+gOkty0vjCaCUy4lmxJoiEIdBaw8AK
 hVo6qZ0RmvmcNlsiOH/T65ughqwFjJ2oI2JyB4+kQMs3BaI1xm85fKQqcS4veFLXbnwX
 377fDsSTC8QET8aiOych9HAAlvqmR0c/VCn1dz+ftUmlPaXzfHgjlJKqtefrdYmd0Sqj
 n5JpAZ7Y9lUAPcxRN+EDwBaNUxQa4g2fhuRnD2FAMeo15O3Euf4z9BUPPPr7SgXiSBI5 +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qfqun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 23:07:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBMxLqm135047;
        Wed, 11 Dec 2019 23:07:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wtqgdt4bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 23:07:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBBN7Q04031969;
        Wed, 11 Dec 2019 23:07:26 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 15:07:26 -0800
Date:   Wed, 11 Dec 2019 18:07:35 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC 1/4] workqueue: fix selecting cpu for queuing work
Message-ID: <20191211230735.r5xpmgwfjjkzxwaf@ca-dmjordan1.us.oracle.com>
References: <20191211104601.16468-1-hdanton@sina.com>
 <20191211105919.10652-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211105919.10652-1-hdanton@sina.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=983
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc maintainers]

On Wed, Dec 11, 2019 at 06:59:19PM +0800, Hillf Danton wrote:
> Round robin is needed only for unbound workqueue and wq_unbound_cpumask
> has nothing to do with standard workqueues, so we have to select cpu in
> case of WORK_CPU_UNBOUND also with workqueue type taken into account.

Good catch.  I'd include something like this in the changelog.

  Otherwise, work queued on a bound workqueue with WORK_CPU_UNBOUND might
  not prefer the local CPU if wq_unbound_cpumask is non-empty and doesn't
  include that CPU.

With that you can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
