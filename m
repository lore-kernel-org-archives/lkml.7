Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C70FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20120674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8gWtGHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:42:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58294 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:42:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8KaroZ135343;
        Fri, 8 Nov 2019 20:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=YFcF5yZOFSYJOtP4chVp60q0TBH1UftoJWGPVLOwz4c=;
 b=J8gWtGHGofxxuUBifDFLRsga2/1BFYkidP3A5zDU58Tu3fr1K1eBqt5kB3xSW7PNqCTf
 BvskA5NAWwayKn3zVP2dPsiSSxfxwLN8/QMup2c3fPgjUzdrHROGfC7NR+tB3VlugmBP
 RcrYDYfcICaV6Gze7WBmNUzTY0Xlk3lZ5tpn5XManydh6BLBWPad1T5ID1wFSFcoY3i0
 nbwWWJJvySiFAf/DSfnfv31wXz9yF/gg0jkWoBErzFgr0IXIdpKa7VySsIL1a8l5CM7X
 8TR8w/pSl+p+FK+UF3/AGAN7iEuqPJzu2nFguUoa9zLN446iQl2WOrIZWXcRd7RZOHFN Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w41w17jep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 20:42:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8KXgQC119890;
        Fri, 8 Nov 2019 20:40:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w4k3481a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 20:40:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA8KeTDd001743;
        Fri, 8 Nov 2019 20:40:30 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 12:40:29 -0800
Message-ID: <80c402e5fa60cbe7c521c43103d3ee0e8a8c80eb.camel@oracle.com>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
From:   Knut Omang <knut.omang@oracle.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 08 Nov 2019 21:40:24 +0100
In-Reply-To: <alpine.DEB.2.21.1911081647230.756@www.lameter.com>
References: <20191107115404.3030723-1-knut.omang@oracle.com>
          <20191107115806.GP8314@dhcp22.suse.cz>
          <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com>
          <20191107131342.GT8314@dhcp22.suse.cz>
          <alpine.DEB.2.21.1911081534470.32431@www.lameter.com>
         <c77e82629f04f0183853884abbeddd871d8f5ab7.camel@oracle.com>
         <alpine.DEB.2.21.1911081647230.756@www.lameter.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=952
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080198
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 16:49 +0000, Christopher Lameter wrote:
> On Fri, 8 Nov 2019, Knut Omang wrote:
> 
> > On Fri, 2019-11-08 at 15:37 +0000, Christopher Lameter wrote:
> > > On Thu, 7 Nov 2019, Michal Hocko wrote:
> > >
> > > > On Thu 07-11-19 13:26:09, Knut Omang wrote:
> > > > > On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > > > > > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > > > > > With the restructuring done in commit 9adeaa226988
> > > > > > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > > > > >
> > > > > > > it is no longer possible for code external to mm to access
> > >
> > > That patch only affected the memcg_cache_params structure and not
> > > kmem_cache.
> > >
> > > And I do not see any references to the memcg_cache_param?
> >
> > Good point, I should have made explicit reference to it.
> >
> > It gets inlined into kmem_cache with CONFIG_SLUB if CONFIG_MEMCG is set
> > (include/linux/slub_def.h, line 112)
> 
> Yes but that does not affect the "name" field on line 105
> 
> > > The fields that all allocators need to expose are listed in
> > > the struct kmme_cache definition in linux/mm/slab.h.
> >
> > So I take that kmem_cache::name was still intended to be public,
> > just that that broke due to the inlining of struct memcg_cache_param
> > in slub_def.h?
> 
> The patch did not change the name field. I am not sure what is broken?
> 
> Maybe you need memcg_params to compose a name of the memcg with the slab
> name?

No, it's just that the slub definition of struct kmem_cache won't compile because
the definition of struct memcg_cache_params is no longer available.

Knut

