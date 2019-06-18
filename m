Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E512C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D757205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJjmI7tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfFRRdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:33:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:33:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IHTFVh075820;
        Tue, 18 Jun 2019 17:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=A/pDYyQdkl9FaixeSmyGWxOfU59IEYoWIfih+uEmTeI=;
 b=lJjmI7tBEaYn1cbGnRysa5fMWQO81kczzRYs84lCEtDKkpNI2x3l058vM7adE2wa52LG
 WIStoIGsXKuH61i4DA2E/5/1C3rLqo9QcTrYGOmRPlIz4qSuS9Fk9zKzNPv6vIBHuVAh
 xVbNHKt1uTL7jIWmc1UO1ZNRgiOMyQCrgD/BN/7yOR8EhBb+AQFJl0xrVF7HDpf3YZJE
 jEPQxnnVUfbCSvdlk82HKwBkYLET98Tljv+mTQJtdlgxtlwuv7Imw3WdfZP5MV8R2huH
 vYapILMyj0J313xxK08FESqKkBwKJRWblaLiLoRfx5FuxdivjgPLgSoW6k/C9UerBFi6 DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t4saqdvdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 17:33:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IHVZKn162872;
        Tue, 18 Jun 2019 17:33:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t59gdysch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 17:33:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5IHX3FN027699;
        Tue, 18 Jun 2019 17:33:04 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 10:33:03 -0700
Subject: Re: [PATCH v3 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560761476-4651-2-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d40a3ebe-6b4c-b723-2750-6aa743816349@oracle.com>
Date:   Tue, 18 Jun 2019 10:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560761476-4651-2-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 1:51 AM, Naoya Horiguchi wrote:
> The pass/fail of soft offline should be judged by checking whether the
> raw error page was finally contained or not (i.e. the result of
> set_hwpoison_free_buddy_page()), but current code do not work like that.
> So this patch is suggesting to fix it.
> 
> Without this fix, there are cases where madvise(MADV_SOFT_OFFLINE) may
> not offline the original page and will not return an error.  It might
> lead us to misjudge the test result when set_hwpoison_free_buddy_page()
> actually fails.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks for the updates,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
