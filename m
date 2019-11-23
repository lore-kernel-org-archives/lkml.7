Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F366C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41002071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKWEyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:54:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:54:54 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYNRU-0007mm-Bc; Sat, 23 Nov 2019 04:54:44 +0000
Date:   Sat, 23 Nov 2019 04:54:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        yi.zhang@huawei.com, "J. R. Okajima" <hooanon05g@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
Message-ID: <20191123045444.GI26530@ZenIV.linux.org.uk>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
 <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
 <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
 <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
 <alpine.LSU.2.11.1911211125190.1697@eggly.anvils>
 <5423a199-eefb-0a02-6e86-1f6210939c11@huawei.com>
 <20191122221327.GW20752@bombadil.infradead.org>
 <77f67d7a-4a93-4319-e6af-54daffcc37e2@huawei.com>
 <20191123023325.GY20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123023325.GY20752@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 06:33:25PM -0800, Matthew Wilcox wrote:
> On Sat, Nov 23, 2019 at 10:16:39AM +0800, zhengbin (A) wrote:
> > By the way, percpu IDA is for reducing performance impact? This patch has 2.16%
> > performance degradation(Use perf to get the cost of ida_alloc_range)
> 
> 2.16% degradation in your tests ... I bet Eric didn't make it so complex
> for only 2% performance impact.  Unfortunately, he didn't give any
> numbers in his patch submission, but it's going to be a bigger problem
> on multi-socket machines than on a laptop.

It could also be that socket(2) is called (on real loads) just a bit
more often than open(2) in a benchmark that tests file creation...
