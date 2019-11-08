Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94691C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67397206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E3x9+d1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfKHQod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:44:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfKHQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:44:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8GhtjN157379;
        Fri, 8 Nov 2019 16:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=hYfdkMRkteIIGT2KkzkdkMeBEpG1ri1et0Pk3CjcHd8=;
 b=E3x9+d1a1S5vvXX4xu5lf8IHXRaRaQ7IIansWvtjg7s/E2HDCeWt8C4TUus78dgh6Wty
 e9rNBiuHKlzwAW/yrI+6lHdz7yooGEH8S2az8VH5YqEPKYJXzk2c+rDMJir3dwzWH9Dl
 ZTGMcuPUq7Btinbv5vEm9pzl47+qzSKFbnJDCzh27JCvxSekJRauM6p0uEd4hS3AVJn4
 DEatjmazAsc37oX12zd32e5qFdeDzyrG1sqKtWAigHnH289i6JKQ9IDy7ZFYYhDPFc3x
 3q5P/gcspWmZiz++HUVlnhzZLpfjsMvOAuvC+TUsUAqHLT9UykEXXAuZpyS9619mK44+ 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w41w16f6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 16:44:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8GhmeS115175;
        Fri, 8 Nov 2019 16:44:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w50m5nhms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 16:44:16 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA8GiEeO031808;
        Fri, 8 Nov 2019 16:44:15 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 08:44:14 -0800
Message-ID: <c77e82629f04f0183853884abbeddd871d8f5ab7.camel@oracle.com>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
From:   Knut Omang <knut.omang@oracle.com>
To:     Christopher Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 08 Nov 2019 17:44:10 +0100
In-Reply-To: <alpine.DEB.2.21.1911081534470.32431@www.lameter.com>
References: <20191107115404.3030723-1-knut.omang@oracle.com>
         <20191107115806.GP8314@dhcp22.suse.cz>
         <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>
         <20191107131342.GT8314@dhcp22.suse.cz>
         <alpine.DEB.2.21.1911081534470.32431@www.lameter.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=921
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=996 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 15:37 +0000, Christopher Lameter wrote:
> On Thu, 7 Nov 2019, Michal Hocko wrote:
> 
> > On Thu 07-11-19 13:26:09, Knut Omang wrote:
> > > On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > > > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > > > With the restructuring done in commit 9adeaa226988
> > > > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > > >
> > > > > it is no longer possible for code external to mm to access
> 
> That patch only affected the memcg_cache_params structure and not
> kmem_cache.
> 
> And I do not see any references to the memcg_cache_param?

Good point, I should have made explicit reference to it. 

It gets inlined into kmem_cache with CONFIG_SLUB if CONFIG_MEMCG is set
(include/linux/slub_def.h, line 112)

> The fields that all allocators need to expose are listed in
> the struct kmme_cache definition in linux/mm/slab.h.

So I take that kmem_cache::name was still intended to be public, 
just that that broke due to the inlining of struct memcg_cache_param 
in slub_def.h?

Knut

