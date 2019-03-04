Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B901C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C56206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eAN2RcKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCDVze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:55:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:55:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x24LrW3i043085;
        Mon, 4 Mar 2019 21:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wjOWfKm74HnT1aTRV2qWh4NO3N9bZ5oJ8SNfdGHeTZ0=;
 b=eAN2RcKSBgXosBVT4O1KYtDPBTSN+ZbO0PxYs2hAmc+qXiYZd8gMmLZP4oZS6wokPK0M
 Jj2oE0Z+1ub/E9m686qwJsak5ych8x+e4cXhqYXjoPBtkpnxNBQF67WEAci8ydu/YzAl
 SsMneak0abbkjPtARoyBWzV6E3EhNb2Rf9NFpoVv+DNwaBLLjrM2WcQh710oZH1tgFfN
 pBQEOYqCHWdPm72KtJHd1Rm0opDWxgqkToP+bjWAJUgW/m3zgChJtrqcfOYx1kcQT2SI
 MWIJEPqMIlehEKJMjxv4sBdLZMpdzz3ull7LTgmM63XYRtw9HGHE8FqxSLkBxg3TGymV rQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qyh8u1h1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Mar 2019 21:55:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x24Lt8wo022137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 21:55:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x24Lt7VK009455;
        Mon, 4 Mar 2019 21:55:07 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 13:55:06 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 81F916A012E; Mon,  4 Mar 2019 16:55:05 -0500 (EST)
Date:   Mon, 4 Mar 2019 16:55:05 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 00/17] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20190304215505.GC30350@char.us.oracle.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903040153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This capability may also find usage in cloud. A user process with split
> lock running in one guest can block other cores from accessing shared
> memory during its split locked memory access. That may cause overall
> system performance degradation.

"shared memory" ? As in memory shared between two guests?

> 
> Split lock may open a security hole where malicious user code may slow
> down overall system by executing instructions with split lock.

How much slowdown are we talking?
