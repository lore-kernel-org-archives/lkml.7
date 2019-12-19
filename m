Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D188C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4E227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLSSJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:09:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbfLSSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:09:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJHsrYl144743;
        Thu, 19 Dec 2019 13:09:08 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyq5ru324-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 13:09:07 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJHsxhw145575;
        Thu, 19 Dec 2019 13:09:07 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyq5ru31e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 13:09:07 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJI78pj006975;
        Thu, 19 Dec 2019 18:09:06 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 2wvqc7cpd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 18:09:06 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJI95OJ16580936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 18:09:05 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C4A6BE056;
        Thu, 19 Dec 2019 18:09:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C95BBE054;
        Thu, 19 Dec 2019 18:09:04 +0000 (GMT)
Received: from localhost (unknown [9.80.196.117])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 18:09:04 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
In-Reply-To: <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com> <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
Date:   Thu, 19 Dec 2019 12:09:03 -0600
Message-ID: <87h81wjigw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_06:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Cheloha <cheloha@linux.vnet.ibm.com> writes:

> Searching for a particular memory block by id is slow because each block
> device is kept in an unsorted linked list on the subsystem bus.
>
> Lookup is much faster if we cache the blocks in a radix tree.  Memory
> subsystem initialization and hotplug/hotunplug is at least a little faster
> for any machine with more than ~100 blocks, and the speedup grows with
> the block count.
>
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

Thanks Scott.
