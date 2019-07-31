Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0873C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B728206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfGaGkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:40:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfGaGkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:40:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V6b2km103107
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:40:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u33v6csp1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:40:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 31 Jul 2019 07:40:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 07:40:16 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6V6eFDo55312580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 06:40:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DA52A4069;
        Wed, 31 Jul 2019 06:40:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63AD8A4040;
        Wed, 31 Jul 2019 06:40:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 31 Jul 2019 06:40:13 +0000 (GMT)
Date:   Wed, 31 Jul 2019 12:10:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, oleg@redhat.com,
        kernel-team@fb.com, william.kucharski@oracle.com
Subject: Re: [PATCH v11 2/4] uprobe: use original page when all uprobes are
 removed
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190730193100.2295258-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190730193100.2295258-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19073106-0028-0000-0000-0000038985C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073106-0029-0000-0000-00002449D54E
Message-Id: <20190731064012.GA11365@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Song Liu <songliubraving@fb.com> [2019-07-30 12:30:59]:

> Currently, uprobe swaps the target page with a anonymous page in both
> install_breakpoint() and remove_breakpoint(). When all uprobes on a page
> are removed, the given mm is still using an anonymous page (not the
> original page).
> 
> This patch allows uprobe to use original page when possible (all uprobes
> on the page are already removed, and the original page is in page cache
> and uptodate).
> 
> As suggested by Oleg, we unmap the old_page and let the original page
> fault in.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

