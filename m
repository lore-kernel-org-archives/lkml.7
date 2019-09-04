Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA5208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bxpw6B/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfIDUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:45:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfIDUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:44:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84Kh54m153884;
        Wed, 4 Sep 2019 20:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CMHKj2GIWVRIBx+G51xYXdDUsZp6Rgv4DQI91QouWAc=;
 b=bxpw6B/gKwT4HLmwUQRwgNAnz0YXhHaNBgTGlpfq+Sf/Naor0cn6oY5D65g75x0gaJ/T
 YGTOllBk9NzMfaWtNn4xsCXYSSbjZtmcCI9K2HGrKd6pInqSykEN+zlH8MIyc1GEo1k3
 uOAYFJ+6Xh/rBfwb6QmrbH5fMEYRs9aIgvASpA03s6DrNXYEXDi0kG1BWBfDdIlPyeDq
 pIlRqDMKZnfDh2vxl9idRmUHOnhhM6Ivg0pRJEhCfnto4Z/mb0Fqe5XvccOslZhaoC4c
 0z/hTlkrfDM+1Ceb4h1wR6z1NpaXAPiVsI+0C5ISGdB4JITFvro5CfHrBzGbzM51MNH1 SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2utmj100ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 20:44:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84KX9xS047583;
        Wed, 4 Sep 2019 20:44:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2usu529w7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 20:44:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x84KimGx001287;
        Wed, 4 Sep 2019 20:44:48 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 13:44:47 -0700
Date:   Wed, 4 Sep 2019 16:44:46 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Florian Schmidt <florian.schmidt@nutanix.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Message-ID: <20190904204446.kceqzrg4zmnw3mm6@ca-dmjordan1.us.oracle.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
 <20190903111342.17731-2-florian.schmidt@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903111342.17731-2-florian.schmidt@nutanix.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:14:12AM +0000, Florian Schmidt wrote:
> mm_vmscan_{direct_reclaim_begin,wakeup_kswapd,lru_isolate,lru_shrink_active}
> changed their output to the point where the script throws warnings and
> errors. Update it to be properly in line with those changes.

Could use the appropriate Fixes tags here.

> Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
