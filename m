Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E193BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfC2Jb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:31:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727424AbfC2Jb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:31:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T9O3C4077548
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 05:31:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rhg2k2sgg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 05:31:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Fri, 29 Mar 2019 09:31:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 09:31:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2T9VnMG41746662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 09:31:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49BC5A4062;
        Fri, 29 Mar 2019 09:31:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D7CA4060;
        Fri, 29 Mar 2019 09:31:47 +0000 (GMT)
Received: from [9.145.61.64] (unknown [9.145.61.64])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 09:31:47 +0000 (GMT)
Subject: Re: [LSF/MM TOPIC] Using XArray to manage the VMA
To:     Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
 <20190313180142.GK19508@bombadil.infradead.org>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Fri, 29 Mar 2019 10:31:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190313180142.GK19508@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032909-0028-0000-0000-00000359ECAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032909-0029-0000-0000-00002418B0C3
Message-Id: <e2d4f70e-12c0-7bdb-131a-c916f0aab0a5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Michel and David in the loop who are interested in this topic too.

Le 13/03/2019 à 19:01, Matthew Wilcox a écrit :
> On Wed, Mar 13, 2019 at 04:10:14PM +0100, Laurent Dufour wrote:
>> If this is not too late and if there is still place available, I would like
>> to attend the MM track and propose a topic about using the XArray to replace
>> the VMA's RB tree and list.
> 
> If there isn't room on the schedule, then Laurent and I are definitely
> going to sneak off and talk about this ourselves at some point.  Having a
> high-bandwidth conversation about this is going to be really important
> for us, and I think having other people involved would be good.
> 
> If there're still spots, it'd be good to have Liam Howlett join us.
> He's doing the actual writing-of-code for the Maple Tree at the moment
> (I did some earlier on, but recent commits are all him).
> 
>> Using the XArray in place of the VMA's tree and list seems to be a first
>> step to the long way of removing/replacing the mmap_sem.
>> However, there are still corner cases to address like the VMA splitting and
>> merging which may raise some issue. Using the XArray's specifying locking
>> would not be enough to handle the memory management, and additional fine
>> grain locking like a per VMA one could be studied, leading to further
>> discussion about the merging of the VMA.
>>
>> In addition, here are some topics I'm interested in:
>> - Test cases to choose for demonstrating mm features or fixing mm bugs
>> proposed by Balbir Singh
>> - mm documentation proposed by Mike Rapoport
>>
>> Laurent.
>>
> 

