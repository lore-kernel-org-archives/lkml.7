Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1561CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D3F20862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfKBTnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 15:43:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfKBTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 15:43:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA2JgB53077923;
        Sat, 2 Nov 2019 15:43:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w15xyxdxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Nov 2019 15:43:19 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA2JgDGC077993;
        Sat, 2 Nov 2019 15:43:19 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w15xyxdxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Nov 2019 15:43:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA2Je1Xu011880;
        Sat, 2 Nov 2019 19:43:18 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 2w11e65dba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Nov 2019 19:43:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA2JhH9A35783044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Nov 2019 19:43:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8867A112062;
        Sat,  2 Nov 2019 19:43:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CDD0112061;
        Sat,  2 Nov 2019 19:43:17 +0000 (GMT)
Received: from localhost (unknown [9.41.179.32])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  2 Nov 2019 19:43:17 +0000 (GMT)
Date:   Sat, 2 Nov 2019 14:43:16 -0500
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com
Subject: Re: [PATCH] drivers/base/memory.c: memory subsys init: skip search
 for missing blocks
Message-ID: <20191102194316.bnglsf5lltc4cztg@rascal.austin.ibm.com>
References: <b72983e6-0560-972a-57c8-9006942ab2a1@linux.vnet.ibm.com>
 <3B456200-E7A1-454E-A70B-92B4A72743C4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B456200-E7A1-454E-A70B-92B4A72743C4@redhat.com>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=646 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911020194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:47:49PM +0100, David Hildenbrand wrote:
> 
> > Am 01.11.2019 um 23:32 schrieb Rick Lindsley <ricklind@linux.vnet.ibm.com>:
> > 
> > ﻿On 11/1/19 12:00 PM, David Hildenbrand wrote:
> >> No, I don't really like that. Can we please speed up the lookup via a radix tree as noted in the comment of "find_memory_block()".
> > 
> > I agree with the general sentiment that a redesign is the correct long term action - it has been for some time now - but implementing a new storage and retrieval method and verifying that it introduces no new problems itself is non-trivial.  There's a reason it remains a comment.
> > 
> > I don't see any issues with the patch itself.   Do we really want to forego the short term, low-hanging, low risk fruit in favor of waiting indefinitely for that well-tested long-term solution?
> 
> The low hanging fruit for me is to convert it to a simple VM_BUG_ON(). As I said, this should never really happen with current code.
> 
> Also, I don‘t think adding a radix tree here is rocket science and takes indefinitely ;) feel free to prove me wrong.

To clarify the goal here, "adding a radix tree" means changing
subsys_private's klist_devices member from a klist to a radix
tree or xarray, right?

-Scott
