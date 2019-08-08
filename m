Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E8AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D202089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2pId28en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHHCrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:47:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57560 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfHHCrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:47:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x782hvDB102089;
        Thu, 8 Aug 2019 02:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lrRmrH7t2DxXhTipWxRRs5ivdb/74vVU7DqRNEZ410k=;
 b=2pId28en9LJEdW0ne3zijEyIyY48YmF3imXfi6P2+oxCWtdJ6n6EKOllE3HNkXrr5Cgp
 25iopFMtfd8J0PeGIJtZLoIgdPA2vGVWrxRnsqRfTfcZglqLzSBICsThdvJrL13fq4/T
 aVshbx3FtGdJ0sIGAQwpJ+wJLDwFPgbaZKp0HBsd7bTk7gyQZ4c2Up4Ap4MqZEB+VrpF
 iTmbzXtzX4OkI2a89ev0Qhj94GjIrsftZtwlv+F7/Qt9fszW46aKfRRnKD5t5l45CN7w
 gt7lhpfWpxRuPcCTPjSVX0u3RXC+7j3W1N3okx3TOm6xL2RQGPktKh5qu4Dlq4kpZkqk ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u51pu7u5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 02:46:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x782hJ4C173010;
        Thu, 8 Aug 2019 02:44:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u7578hr6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 02:44:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x782iqqv010401;
        Thu, 8 Aug 2019 02:44:52 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 19:44:51 -0700
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
To:     =?UTF-8?B?6KOY56iA55+zKOeogOefsyk=?= 
        <xishi.qiuxishi@alibaba-inc.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ltp <ltp@lists.linux.it>
Cc:     Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        Cyril Hrubis <chrubis@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <f7a64f0a-1ae0-4582-a293-b608bc8fed36.xishi.qiuxishi@alibaba-inc.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f072c20-2396-48ee-700a-ea7eafc20328@oracle.com>
Date:   Wed, 7 Aug 2019 19:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f7a64f0a-1ae0-4582-a293-b608bc8fed36.xishi.qiuxishi@alibaba-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 7:24 PM, 裘稀石(稀石) wrote:
> Hi Mike,
> 
> Do you mean the similar race is like the following?
> 
> migration clearing the pte
>   page fault(before we return error, and now we return 0, then try page fault again, right?)
>     migration writing a migration entry

Yes, something like the that.  The change is to takes the page table lock
to examine the pte before returning.  If the pte is clear when examined
while holding the lock, an error will be returned as before.  If not clear,
then we return zero and try again.

This change adds code which is very much like this check further in
the routine hugetlb_no_page():

	ptl = huge_pte_lock(h, mm, ptep);
	size = i_size_read(mapping->host) >> huge_page_shift(h);
	if (idx >= size)
		goto backout;

	ret = 0;
	if (!huge_pte_none(huge_ptep_get(ptep)))
		goto backout;

-- 
Mike Kravetz
