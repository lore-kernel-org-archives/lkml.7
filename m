Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD752080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556598184;
	bh=hvglgYfJFbUCAo8WiocF8DRMw/+HfUp58YE0E+kHb1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lDOrLKE6D6v7t1bOk4lZhJCFhsGLzEAB4E0Amn/WyurdEbLgQKxNJbYz4831eedp4
	 EFDoaWajSyZWI5hqkr3/RBfviKlw+gKM5LtaG6QKjynFwrYfUougu4FVCM7iirK8Vd
	 QUEgJ6PHdmqEtahrYvPru1xnI/tvnTosdrG79+qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfD3EXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:23:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfD3EXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:23:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id r6so19218995wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4rU18cp7Phgu2DDw4oFlvhQGG9Aj9IkSQjep7ze+eh0=;
        b=TrvoZ0z3LuDkKGrGl7AlprvGf18faJdloN6WEkmN4rO5v6+F3nn+PS/U4wyqe3fsPd
         XYGFmClOXJCaqvSioHk99nlSpxSs+i12gv9wHXgKiYMXwctNoPLiXkcnoj+u+wRZg1Eo
         e612rawSl+XEO38fGw0k2pUnmD0t9g7e2ICk4nk8t7e1duhQOzeRcAN+C69UFVrp4376
         6stQYFl0CbINFfUB+toDbdIgfitk29EvkGPa6IMBfXPiGvkGXDTRlkTrq/3K625/BdEt
         aR9FLrzbGs0H6bCezR5oGgrdcxFJmnlPIflyKK+kMlCvM0dQW2kbKyfl0KVnGLBTZGci
         FgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4rU18cp7Phgu2DDw4oFlvhQGG9Aj9IkSQjep7ze+eh0=;
        b=gLcvQBNPd5vS4FwvsdtfQvspqrliEIuP8D98I+sB/SiF8gWscMpjOnEpDXKUawQTg6
         6UoNiatGoRj9b3W9BtAKbQgOUbnKjvg4bjoI1yChd9cmceqPHnDpfatetcyHGBMKjYfG
         qC9S4lzd78fNUKCJKwLEiIhkQJYVMii1MPpnebsQ6r6zIi7Xw6XsjKpEt6BPqBWNrBp3
         z1XyTE6togE5zyPh8oInakycDpamXvLKzSt63obH7FsPT4cSjqp64jvFkjk4/JXHgdbe
         H83HKNqRYk/E3Q9gnMMtBetoX8D1Z8t5VEUwyjMr3Vsi+36CiguzlfAkmcBFj73kzfnS
         qDCg==
X-Gm-Message-State: APjAAAX4vkm/IVFasJ9jC/WDFEEMq934ycz2mfKOLhwb7J3QBvrxeT4G
        eo+vKVkWCOVrLbtJHZYjdk4=
X-Google-Smtp-Source: APXvYqwR4+8OOvHEBqFxBnlQJwiE5lLugDjQuGwU5VEcTj0gk3Scy5KZxxMlzNk9m1IWaG0HR2nkaw==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr22078817wrm.188.1556598181204;
        Mon, 29 Apr 2019 21:23:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o5sm1221259wmc.16.2019.04.29.21.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 21:23:00 -0700 (PDT)
Date:   Tue, 30 Apr 2019 06:22:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cpufreq: Fix kobject memleak
Message-ID: <20190430042257.GA73609@gmail.com>
References: <20190430001144.24890-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430001144.24890-1-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tobin C. Harding <tobin@kernel.org> wrote:

> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> ---
>  kernel/sched/cpufreq_schedutil.c | 1 +
>  1 file changed, 1 insertion(+)

I've added your:

   Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Which I suppose you intended to include?

Thanks,

	Ingo
