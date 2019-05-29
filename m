Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B78BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1758423E96
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WefAf3Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE2RDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:03:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2RDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1mK5Smhvmft4JcvDPEMxWC67pAyc4oQ9bkdnZBw20t4=; b=WefAf3Cmu+ntxwjXzgTrWTw1+
        DmS8xvC5x60ErHEUn5jj0rUuKGmjSb+fnt78VxRlXy4oW5Zizoqr3FlZfCaLD62UnLvAgmdwAa9ax
        kYZPrL7zJPXASqXg2SqsyR57N0EMomCKw6pNZrFgfh7Wlpp5FUO6gFAlfAQhA6bNKhRRzExM0Q5Iy
        CL63Z3VvG2zYe/yslLDz5myjb5n3+MM4yaqaOIKc8jzf+4GK0RDrzsNKGoW115UCEflKh61Wh5IjV
        NvveowY9GQgLkh7sga4Ls0FEUDiUQmxhUVtUWQHfX0gkTQ/ruySWz+rQv7b32qb1Bkxa+u6Ws5Qvf
        y+zEiljIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1yt-0008A1-17; Wed, 29 May 2019 17:03:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4080201B8CFF; Wed, 29 May 2019 19:03:13 +0200 (CEST)
Date:   Wed, 29 May 2019 19:03:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au, acme@redhat.com, eranian@google.com,
        fweisbec@gmail.com, jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529170313.GE2623@hirez.programming.kicks-ass.net>
References: <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
 <20190529162435.GM31777@lakrids.cambridge.arm.com>
 <20190529163854.GN31777@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163854.GN31777@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:38:54PM +0100, Mark Rutland wrote:
> Sorry for the noise.

n/p, confusion happens :-)

> Generally speaking though, if we ever task task_pt_regs() of an idle
> task we'll get junk, and user_mode() could be true.

Agreed, but we're not doing that.

