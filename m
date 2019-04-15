Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66826C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB7520645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UHtghW0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfDOMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:21:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sMuySctEfubHzRjUzMKLcFnOuCWtF1/VQ+PutI+sAH0=; b=UHtghW0oqvGyT/bXjXCQdLxQX
        EQkydjdJtXoAwt3LUs61iGE16pejsudvyGawucXo5U1P3E5yHZloaHhoL/aXgktioT2NLXIJk9tGg
        enL9A9weEh0+Gz+RaLj6L08q4Cz4QzWzVvYxe4dAmoXtz2l+29clcoguBZlJvhCTHB0WD+/COL9uR
        OEaxDj9eKVu/zuZzp5hKEtQZU8vp3506fFy3NNeMqMAutQLom/BzUjnEb+ckxR6mWcWFS6RKjBxlJ
        Dflzq4oljTewy3gAYPByCSUvDVagT3Ql5Cdk0+d/ZAqRD9Bi1cJLtIiJkV20Qya+K/n3ZQ2z6Q1vy
        aSDdgzw4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG0c6-0006vh-BS; Mon, 15 Apr 2019 12:21:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2DCE213A0759; Mon, 15 Apr 2019 14:21:28 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:21:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "riel@surriel.com" <riel@surriel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
Message-ID: <20190415122128.GO11158@hirez.programming.kicks-ass.net>
References: <20190412235341.29379-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412235341.29379-1-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:53:57PM +0000, Dexuan Cui wrote:
> If smp_call_function_single() is calling the function for itself, it's safe
> to run with irqs_disabled() == true.
> 
> I hit the warning because I'm in the below path in the .suspend callback of
> a "syscore_ops" to support hibernation for a VM running on Hyper-V:
> 
>   hv_synic_cleanup() ->
>     clockevents_unbind_device() ->
>       clockevents_unbind() ->
>         smp_call_function_single().
> 
> When the .suspend callback runs, only CPU0 is online and irqs_disabled() is
> true.

Pray tell, how well do you think mutex_lock() works with interrupts
disabled?

