Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1536AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B87206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eMKx8OvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDCQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:53:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDCQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:53:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Ghk6g131470;
        Wed, 3 Apr 2019 16:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iGxxtIVqEzp1RVOI6u7Mj+o50/tLE0xJ0apojvzIrxc=;
 b=eMKx8OvZ6FoDYDKsbasn8MIS6dsh0biicj8fxmGWOf8mjW29OUno93FDZ+rwFoQ85kYt
 T/w9UyqLWqtHrhEhQ1YaB1x0M4THLsgjrYQYKu3hxaBpDSXmilQ9jphwop3MwmoeEu/L
 rC5FLKD33mFhSnenXyKKUUiyDizZOeTD9lkgtKHC3kQJewpFfzX30mP1u3tJ9tbdJkEq
 wtKkTB0L4y1OdbAyedKLuGO/ltNYiHEPNgQF1kXtWt94CUFtzgQtRVhNTqxnDmE3EP86
 7YuQtJEC/ZNWVS+2eBwZ2vAUB9yB1AhAbxmkfPuTXEkmQA2yyvagoaSwygzGz0FLI1UX NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtaa5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 16:52:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33GqBLc168298;
        Wed, 3 Apr 2019 16:52:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f579tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 16:52:41 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33GqcFo004355;
        Wed, 3 Apr 2019 16:52:38 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 09:52:37 -0700
Date:   Wed, 3 Apr 2019 12:52:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, linux_lkml_grp@oracle.com,
        Alan Tull <atull@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] convert locked_vm from unsigned long to atomic64_t
Message-ID: <20190403165257.prekuppqbcempuxo@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030114
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:51:13AM -0400, Steven Sistare wrote:
> On 4/2/2019 4:41 PM, Daniel Jordan wrote:
> > [1] https://lore.kernel.org/linux-mm/20190211224437.25267-1-daniel.m.jordan@oracle.com/
> 
>   You could clean all 6 patches up nicely with a common subroutine that
> increases locked_vm subject to the rlimit.  Pass a bool arg that is true if
> the  limit should be enforced, !dma->lock_cap for one call site, and
> !capable(CAP_IPC_LOCK) for the rest.  Push the warnings and debug statements
> to the subroutine as well.  One patch could refactor, and a second could
> change the locking method.

Yes, I tried writing, but didn't end up including, such a subroutine for [1].
The devil was in the details, but with the cmpxchg business, it's more
worthwhile to iron all those out.  I'll give it a try.
