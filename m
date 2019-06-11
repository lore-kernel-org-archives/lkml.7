Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A26C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80F520866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbfFKQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:15:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404034AbfFKQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:15:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGBJal054872
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:15:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2fkbr8cu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:15:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 11 Jun 2019 17:15:40 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 17:15:37 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BGFaNx24576476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 16:15:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E08C42052;
        Tue, 11 Jun 2019 16:15:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE0C842045;
        Tue, 11 Jun 2019 16:15:33 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.73.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 16:15:33 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
In-Reply-To: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
Date:   Tue, 11 Jun 2019 21:45:31 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19061116-0016-0000-0000-000002882CF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061116-0017-0000-0000-000032E55CB2
Message-Id: <87tvcwhzdo.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=461 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pingfan Liu <kernelfans@gmail.com> writes:

> As for FOLL_LONGTERM, it is checked in the slow path
> __gup_longterm_unlocked(). But it is not checked in the fast path, which
> means a possible leak of CMA page to longterm pinned requirement through
> this crack.

Shouldn't we disallow FOLL_LONGTERM with get_user_pages fastpath? W.r.t
dax check we need vma to ensure whether a long term pin is allowed or not.
If FOLL_LONGTERM is specified we should fallback to slow path.

-aneesh

