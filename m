Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCAC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D7D23401
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566679913;
	bh=lY2lUYn8kdNdXszdasxfLmlh0JIRJF6NjXy3v0t4lJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ov5FOi4RnXEp9ghKoRgnRX3JvLOVYG9agXSffvOmkrJaPj7NZPm29WmxPpkc3RrIp
	 A9f2rl8LblLO15LYbz8TeJEPpTAZyhpiVGRrF4tqo8KuHMYTzsf9vYCzhf/PiwT8TM
	 gYmLmtKoo/0hsXIyrUTaq+kPUsK0Z0n+28EdFfqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfHXUvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfHXUvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:51:51 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9D923400;
        Sat, 24 Aug 2019 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566679911;
        bh=lY2lUYn8kdNdXszdasxfLmlh0JIRJF6NjXy3v0t4lJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jl9h6QEkd4hzngT/pS1YBKgoP6i2Igr06glL5C1Vq57GKP6C+ixUcPHJgvQT1qF9h
         GFGBS90a7vNsES5EfjSm2oP/dck7aOBUuawr3cNBgjDPPUHsUXoXGDIOIBdNVFXOR7
         W4/MSMq3X1AQP1+srbDD/pt7Ivr1hKX6kR6FXWq4=
Date:   Sat, 24 Aug 2019 13:51:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
Subject: Re: [PATCH v3] psi: get poll_work to run when calling poll syscall
 next time
Message-Id: <20190824135150.39890aa258dc8f1e8c662214@linux-foundation.org>
In-Reply-To: <8a093924-98ea-de13-554d-5f5b6ee63536@linux.alibaba.com>
References: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
        <20190822152107.adc0d4cd374fcc3eb8e148a9@linux-foundation.org>
        <8a093924-98ea-de13-554d-5f5b6ee63536@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 08:53:09 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> > Should this be backported into -stable kernels?
> > 
> Sorry for missing that, should I resend it with cc stable tag?

I added cc:stable to this patch.
