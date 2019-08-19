Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D300CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A472D218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBPiWfth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHSHkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:40:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:40:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7J7dJCN172685;
        Mon, 19 Aug 2019 07:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=GVh2oO0nd6sSkP06ZTnvwu+Lum4//U9LoDANkL5xm+w=;
 b=FBPiWfthLi/45K++LRRsHnM6lEKJfvmMSTC4rDaMUSQK9ZRqaDpKKoRf1WIVDV1MyMww
 BCsTNBZhrg6X69Mf+7kuXTFwTSln+zl37ed9or9eaog0wY/s4jDdwkvHVL2fgr6k9Uct
 ZzoezD59EVGKzSxz2g4i20oyTcS3iy8BaR6G0rv3sLaFx9wOEoUVo0KiZMZjPBZ+e5OG
 sVWw9EGfToNR40pv/xlwI3oJoFiwVLnOXGNy/eWKmyWNSJBtLRSytlhPBCRZtXX/xsQM
 slgQ14eBNDBMM6tnkRjz5macSfMVHdy6vJ9y8ZBkfzvNTowFX5Obm8oDLllY5Qkuol12 pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90t5s77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 07:40:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7J7bqN5036609;
        Mon, 19 Aug 2019 07:40:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ue8wxsj9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 07:40:10 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7J7e8ZO005044;
        Mon, 19 Aug 2019 07:40:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 00:40:08 -0700
Date:   Mon, 19 Aug 2019 10:39:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     devel@driverdev.osuosl.org, Li@osuosl.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>, Fei <lei1.li@intel.com>
Subject: Re: [RFC PATCH 08/15] drivers/acrn: add VM memory management for
 ACRN char device
Message-ID: <20190819073958.GC4451@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-9-git-send-email-yakui.zhao@intel.com>
 <20190816124757.GW1974@kadam>
 <8b909c22-3873-2b5d-4845-1fee1a5d81ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b909c22-3873-2b5d-4845-1fee1a5d81ce@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=974 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:32:54PM +0800, Zhao, Yakui wrote:
> In fact as this driver is mainly used for embedded IOT usage, it doesn't
> handle the complex cleanup when such error is encountered. Instead the clean
> up is handled in free_guest_vm.

A use after free here seems like a potential security problem.  Security
matters for IoT...  :(

regards,
dan carpenter

