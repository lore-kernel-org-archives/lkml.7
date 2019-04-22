Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9242077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XI/gGUG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfDVP5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:57:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDVP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:57:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MFiBSe058592;
        Mon, 22 Apr 2019 15:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1YFWhk18nPvj1sYrbNiGZZtKSn/WuN9LenTer33fr9w=;
 b=XI/gGUG+sf++GowsIupWT5i00SK26pIYdJnbzRAIp5hm0bAIDhZ+HttAnN8UusZbg37f
 So4eNeN89QqmJDJYtFelMLz/WtDjWFC4JI13s69D8/mCyTwTiKeEy3M1ol1MZPpLBRVM
 EQAZVzhqPrMY9wC7JFjW77AgLSQwVDPUfzH0zzmc3k3rW5FewyAfituuLXUvJFQdROGx
 GS362yi9MfcSNU3GoqOPsC8ptuJCrMaT5jVDs3wh6y6gqMsMYSdN9CpJPmByAnZi2MJA
 xR2qnfkRNVjMcTAoSXvj5iXxpKQDOeZy3BVYwnRY548p3gsR0HBA8WtDdtlKPvYE71Vc iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ryv2pxx83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 15:56:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MFsMGr013459;
        Mon, 22 Apr 2019 15:54:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s0f0v0qrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 15:54:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3MFs8g3003588;
        Mon, 22 Apr 2019 15:54:09 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Apr 2019 08:54:08 -0700
Date:   Mon, 22 Apr 2019 11:54:37 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Tull <atull@kernel.org>,
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
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190422155437.qppyxcbfql34ginr@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
 <20190411095543.GA55197@lakrids.cambridge.arm.com>
 <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
 <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904220119
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=724 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904220119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:33:51PM -0700, Andrew Morton wrote:

Sorry for the delay, I was on vacation all last week.

> What's the status of this patchset, btw?
> 
> I have a note here that
> powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch is to be
> updated.

Yes, the series needs a few updates.  v2 should appear in the next day or two.
