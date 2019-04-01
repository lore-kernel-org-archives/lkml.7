Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5DB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJ02z4qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDAJJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:09:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDAJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fpH3VaWxqvEOoGMV9gNtzLj8g9z7qMYmZikJLueItbQ=; b=ZJ02z4qDIcjjPVsl41leEFTWa
        L2JAeaXTqDDEsv6dcJ12HDKJw7i2X1SzVvekIY/mDvD1Z0l/UzGPPbeRG17fPxpReDpTrG1vAZP3S
        SCBErTLQikNlyupMvZ86tyu+oba9vL/1mWriWQ00617aKC7RZYdzTXd4MBPPE+mcEcd1MtGG8+3Fk
        MymPnLGnD0RG/8CZFX2Z3EWrSRaMw7lucwMOxL8aGaWNYn4k8KQ58afjDz6V/lLrlTzZZ02+5ccH/
        vpH1uWEd903bMCSS/RO5YeoXHQSFqH6NLTZ+FG37YBu0ERb7T8G2S+pMopeosM0ApK6eXH6elcjZx
        8/atIFTgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAswr-0004iw-2z; Mon, 01 Apr 2019 09:09:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A2AC2026BE95; Mon,  1 Apr 2019 11:09:43 +0200 (CEST)
Date:   Mon, 1 Apr 2019 11:09:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20190401090943.GG11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:20:01AM -0400, Alex Kogan wrote:
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). 

The other interesting number is on a !NUMA machine. What do these
patches do there? Remember, most people do not in fact have numa.
