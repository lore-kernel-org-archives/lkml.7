Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BA5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08038206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hI8t2IGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfFDXbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:31:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfFDXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:31:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54NSfYV119967;
        Tue, 4 Jun 2019 23:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=PYnlYwcrqismRpkktUNEE7wpHvUCY2x+J4QeRuh9P6A=;
 b=hI8t2IGipGArSITl/hZ8ilGOQA3SwfM5OFN5CTLViC6D7NnOh8xBuFffelsP3dEI+RMH
 Hdb/7hAU/AjL4ogfjWmXKJ5wJKtn4x7jxQK8G0NAZQKLUlQdM128/bGuyEVtgB3xZ/De
 G6zPw1OrSFKlAVP7XoMFbXi0hBeSswBSWOaAuuSHbFz9yLoTnKRKnJ/3muZD8rT8Vfxa
 jOtDdPEnrPKmhjWQnjVzxw2c7BoSqKr8zeCUpyyZ3onUtqGKnTrNfKmWpYRvS0tR34mK
 LsDzzKYDR3xGHuLMvbF1ag5wQAJ1biwk+nU2UxHV8MemR0+UxtjsYEYF8nA6YJDSSon6 yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstfy9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 23:30:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x54NUbbL004697;
        Tue, 4 Jun 2019 23:30:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2swnhbvg30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 23:30:51 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x54NUm5x010464;
        Tue, 4 Jun 2019 23:30:48 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 16:30:48 -0700
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Subject: question: should_compact_retry limit
Message-ID: <6377c199-2b9e-e30d-a068-c304d8a3f706@oracle.com>
Date:   Tue, 4 Jun 2019 16:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906040149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906040149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at some really long hugetlb page allocation times, I noticed
instances where should_compact_retry() was returning true more often that
I expected.  In one allocation attempt, it returned true 765668 times in a
row.  To me, this was unexpected because of the following:

#define MAX_COMPACT_RETRIES 16
int max_retries = MAX_COMPACT_RETRIES;

However, if should_compact_retry() returns true via the following path we
do not increase the retry count.

	/*
	 * make sure the compaction wasn't deferred or didn't bail out early
	 * due to locks contention before we declare that we should give up.
	 * But do not retry if the given zonelist is not suitable for
	 * compaction.
	 */
	if (compaction_withdrawn(compact_result)) {
		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
		goto out;
	}

Just curious, is this intentional?
-- 
Mike Kravetz
