Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F1257E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u4F0Vrc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfE3LKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:10:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:10:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UB8pSx193271;
        Thu, 30 May 2019 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YCfDGCrbkbS0YzG5aLJic/fCahkN+gvlIX71eGLwvvQ=;
 b=u4F0Vrc/ic1PGIu0LqZqq8jbY5MJOpHhRMgBPVAZ8jxeIyYCupZPqo32+6EVKnq32Ufx
 gIBRlsxR7JUKj035DCe6EoN57oV+xmXDQl5X0NcMUp9cexxEcuS/EpvsUha0LTLnBvKQ
 /emUELgWHhZ96/z2L7+IloQ5afZT32gZT0F6eE0N9aWmY1ukfQJ9xqkLjwmu0Gypn+uC
 LeVyaN47Io/P6TqxhYel8yGbNrsDrE1XUBJ9DaLMmQhJQAHOuZg1jKfBU9DGP0XoyB5d
 F/SqFMAd9Q1cWD1RKBu+NY9PuOGBlYeJCkdZp2J8TAEofrjUx+/luOLPCWWc2ELXXIAG Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tqd0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 11:08:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UB8Pwq175460;
        Thu, 30 May 2019 11:08:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sqh748cxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 11:08:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UB8kmd004283;
        Thu, 30 May 2019 11:08:46 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 04:08:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH uprobe, thp 3/4] uprobe: support huge page by only
 splitting the pmd
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190529212049.2413886-4-songliubraving@fb.com>
Date:   Thu, 30 May 2019 05:08:43 -0600
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        namit@vmware.com, Peter Zijlstra <peterz@infradead.org>,
        oleg@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Matthew Wilcox <matthew.wilcox@oracle.com>,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        Chad Mynhier <chad.mynhier@oracle.com>, mike.kravetz@oracle.com
Content-Transfer-Encoding: 7bit
Message-Id: <6D76CB61-CF13-4610-A883-0C25ECC5CFB7@oracle.com>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-4-songliubraving@fb.com>
To:     Song Liu <songliubraving@fb.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any reason to worry about supporting PUD-sized uprobe pages if
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is defined? I would prefer
not to bake in the assumption that "huge" means PMD-sized and more than
it already is.

For example, if CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is configured,
mm_address_trans_huge() should either make the call to pud_trans_huge()
if appropriate, or a VM_BUG_ON_PAGE should be added in case the routine
is ever called with one.

Otherwise it looks pretty reasonable to me.

    -- Bill

