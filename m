Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49925C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5A222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kjre9Ltq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgACRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:50:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgACRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:50:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003HiDtK140901;
        Fri, 3 Jan 2020 17:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Dwg52ekGkl9nKmJXL2HlQ1KyCKoDg9K/QsJcIiIz2Qs=;
 b=Kjre9LtqjEwBTbd3C4YxEUqecoxk4NxBPsY7SO5NmtO1JF5uyZg+Vdhmckt2wDY5k1/C
 p8inhA2qWpaFmPqWrbamfwGSxlAFAZCh42u7PBuetplOm8AYwSfh1cqxNTXkq1q56GFx
 7XdeJ5jlX6CzkYRYEc4uDrglLaqzqRi6yBIfrVNQSalLCzByvJqSZWoNuddHZtCkuHeE
 zCEtyEzjZ86gdv+fgZxR9RLI94WGammtj0qGTDzKsdYZqYmRzzG52kRDNgy3YygpDY23
 Vesniv/w996qoKy5EJ3Q+QeWfMuodJiNSVNJv/aK+xO2l167ECkB1nJYAjAEmWgd7ju7 SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2x5ypqwfpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 17:50:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003HiUEo189352;
        Fri, 3 Jan 2020 17:50:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xa06tycbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 17:50:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 003HoD45022317;
        Fri, 3 Jan 2020 17:50:14 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jan 2020 09:50:13 -0800
Subject: Re: [PATCH] mm/hugetlbfs: fix for_each_hstate() loop in
 init_hugetlbfs_fs()
To:     Jan Stancek <jstancek@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a61653f2-64ab-384b-1596-3d2676415786@oracle.com>
Date:   Fri, 3 Jan 2020 09:50:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9489 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9489 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/20 9:37 AM, Jan Stancek wrote:
> LTP memfd_create04 started failing for some huge page sizes
> after v5.4-10135-gc3bfc5dd73c6.
> 
> Problem is check introduced to for_each_hstate() loop that should
> skip default_hstate_idx. Since it doesn't update 'i' counter, all
> subsequent huge page sizes are skipped as well.
> 
> Fixes: 8fc312b32b25 ("mm/hugetlbfs: fix error handling when setting up mounts")
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thank you Jan!

My apologies for a relatively obvious bug.  Testing on x86 did not catch this
as the default hstate is set up last in the list.  Not an excuse, but that is
why I missed it. :(

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
