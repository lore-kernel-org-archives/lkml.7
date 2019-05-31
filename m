Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF04C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204A026CA0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vaNEY3xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEaQ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:59:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:59:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VGmkRa037317;
        Fri, 31 May 2019 16:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=G82jjtVPtIBiymxHtt3594fMUhRhOyCXS9qt0zROSRs=;
 b=vaNEY3xbHbsmFj4uuy58MnSzoYNnmBWMZ1uHLJz4TFgQS3PDxWUY7uo0/yb+5cHLLCQI
 GPx/XnsFEsPnQn9U1wJYM1XDXZtZkBSA5i9qKO+NWK5gGJBFA5LeeSsgb1/2jPXiKqU0
 Ifu/u2p8g04sYFmK5eV0CPPxOFSlT7KCzWSvdKifcZ/8RR8VLBpEs73OSYPVr4kfC81D
 EveRMMmF5HRn9+TFQXc35gdIgha+aTQqi2X0T3LXHfMzmagOchgedP58kzYQlVlkeBk/
 tsbLdCCdJQ0krqpBY9ZVH3eytgUQRnKCKvtp05KQHOSWorDRSYve3FvE//mlmiRGkTEc Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tyn5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 16:59:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VGvdh1084819;
        Fri, 31 May 2019 16:59:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fprjt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 16:59:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VGx2Fc009144;
        Fri, 31 May 2019 16:59:02 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 09:59:01 -0700
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <20190531024102.21723-1-ying.huang@intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2d8e1195-e0f1-4fa8-b0bd-b9ea69032b51@oracle.com>
Date:   Fri, 31 May 2019 09:59:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531024102.21723-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 7:41 PM, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Mike reported the following warning messages
> 
>   get_swap_device: Bad swap file entry 1400000000000001
> 
> This is produced by
> 
> - total_swapcache_pages()
>   - get_swap_device()
> 
> Where get_swap_device() is used to check whether the swap device is
> valid and prevent it from being swapoff if so.  But get_swap_device()
> may produce warning message as above for some invalid swap devices.
> This is fixed via calling swp_swap_info() before get_swap_device() to
> filter out the swap devices that may cause warning messages.
> 
> Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Thank you, this eliminates the messages for me:

Tested-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
