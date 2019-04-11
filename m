Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B3C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401F12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554952436;
	bh=yarpaGMsaE+EItRjUnPuzHRP+F0uBBWkdIMrh2vaERc=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=Bosqtwo+vpp1Vq9JkW7hYUpWjm5xfjFNY9IyRz+czDdDEnt+2EX6snWDu9AqD/bMJ
	 FS7xT7i8U2h51ZL9reFcOr9fLVWNS9Pv8ej6ds4HJtvXrOrxtMkd0V2S2RQQCgYc69
	 y0mW2gR6lkjJboOkLLrNUqJMRGjNHci0fnOaL1is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKDNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:13:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36844 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:13:54 -0400
Received: by mail-yb1-f193.google.com with SMTP id e76so1678726ybc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yarpaGMsaE+EItRjUnPuzHRP+F0uBBWkdIMrh2vaERc=;
        b=hsK4eg6XWVwQTSPyKdu5W/9Rzvu/5q7ADbZEmLmamCMV9qIS+JU3VBwprw6Ird30e2
         jA2l2EpOf9KEZ5PR2XQ7i1T3mM55/lYitbUeN1PGmiAva8t5yW5c+VHUKqWHkjDCkkWt
         +piFaKpIXlsf9a0P5UrPdj+Niy0/HinrDZ/54SHgdXQjGVz0hRBma0YKUaJK2U4ki+to
         kQvwxlIgJGZ6q0l3A3JLgw4nhI9qnLOA8Esm7PRnWsefd31eAuxw3UrOMpqzCABnFCwi
         i8tIXt5d6dD0qMlZopLLSTjTv1ndZok3o+GDDFBS/EOrDuCQnl9kTrCcNFg+PMYntaXh
         JJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yarpaGMsaE+EItRjUnPuzHRP+F0uBBWkdIMrh2vaERc=;
        b=TOHXiwY+08kdddg4oTv4HqdY2YA8uLN2eOFNbQme7e366SKICvCxanAFwDy1Uo+AbX
         4K4gEZ7xukaavzFg6FYfNTlnGRwXLPf7J1uJTkCPL0dGubkjwtQycTsM9zWuGP0kXaZ1
         EBERfAV8y+wpL9a5P2gLxrxKHnX7GGi48UBx0DY0lAV68TP96S13YLsZ/VodEPBnRhks
         cYOrRIsFrEP8K2bXjtcVvMjXrRTuwS62ZoRNeoNPEfhnszUPJ8ICk0ExjJvG1lgOBGEX
         hpwFle1jnZZYIdiEHlTtKQF43Ba3BERblVGlLoTVrytnL2nqrp2sd2ojlbepLHXGdx+h
         8Etg==
X-Gm-Message-State: APjAAAWpqfKPCblfdtY1fJZREeT13AyRzbJkTiLShGeXdhCD013Eu7YC
        XNItGgCFmyqpOg0ID5RMbvo=
X-Google-Smtp-Source: APXvYqzvbARJXnya9JLCpbt2Obku/ADcBtLNmtD0vwz9dDH1+uxci6UwK/RGLeWhd5xEQNQPE9l71w==
X-Received: by 2002:a25:41c1:: with SMTP id o184mr11485642yba.183.1554952433853;
        Wed, 10 Apr 2019 20:13:53 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id 74sm8070279ywe.81.2019.04.10.20.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:13:53 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
References: <20190410224213.20651-1-okaya@kernel.org>
 <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
 <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
 <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
Message-ID: <e901a9cc-f335-fb31-535c-97dce2ca8f5b@kernel.org>
Date:   Wed, 10 Apr 2019 23:13:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 11:02 PM, Josh Triplett wrote:
> Then let's fix*that*, and get checkpatch to help enforce it in the future. EXPERT doesn't affect code generation, and neither should this.

I think we have to do both. We need to go after the users as well as
solve the immediate problem per this patch.

As Mathieu identified, CONFIG_DEBUG_KERNEL is being used all over the
place and getting subsystem owners to remove let alone add a check
to checkpatch is just going to take time.

Please let us know if you are OK with this plan.
