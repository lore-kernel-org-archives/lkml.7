Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383CC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B125C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxTUeHWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfEWMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:08:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40413 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:08:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id q62so5216441ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tD+qhuLt5qsLm3SGbeSuel1UeuQsI4bGOp7Ijyc6Z9U=;
        b=lxTUeHWlC9pmRKtqbsZO74um4vrYUDvyMnqMP/IRnFvJuuks0xkcEzrhtDl4a59kIM
         Bri1WS9kqQHVRSMnIMXzO71FtsYHWnd84w5lLdXsWEes/0zLIB5q9gaYkQHXmPlk2plU
         OKGX3MloEsBqDa8iAv6NrgdmlI/uGyq5V/NAeeOT9gd8+/lFxGXsrMudMPU4mWB4p0TP
         tDQnVjE0Zea7yIQJQyVYztjQ1dOMItqsXifbf/nhC8AhgfiDjdzmRsaOjAGXL8VOQqyQ
         gOm3MRbJh8e1NZnKGJfuXNebA0h7/o94/y6uPZKLjsvFmi+ZU3EigKiK+DLGqsrZd4Ec
         WN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tD+qhuLt5qsLm3SGbeSuel1UeuQsI4bGOp7Ijyc6Z9U=;
        b=POHvAyTtZgjcurAyHH8AaZLYEYqjBPS3/2u8EXRGv3nL8vxB7JfpEJcW8tEEr5p7k0
         5Qqkz2Ne1/ECAzzAomcUam/fjT2IlF8gUzAD8jvPqFW9Ac5wnybiZRUHirWdsOErXaj+
         wztXGDT8W0ZRn39uAUI71BZjoeBdySOGj4676NCk9jyFVyHJSTjmOp5AIHJO+iW4K6Cw
         X1h+Y/Qz9dByWkxRkBfHqPX3gkMrdGOFjMRM3iXoCweW9CGQ0Wvn6OVc8qdewsT2TGwa
         mmbrp+byIK/d1sRxAPDp6oFTGw5mfR1NISS1IgjJQSWdySQ24C0OotJNZxCwbTDqxRS6
         iFSQ==
X-Gm-Message-State: APjAAAX8cfA3Z1bXKB8k+b3PFd23L7WpZRO5p/eqy+OE2AmTr88JSAWd
        aNEbH2+rJvXuVO8T06+3Gxw=
X-Google-Smtp-Source: APXvYqwqnEnLn8hPK/xqWSwuvz6thK/QrMFBvfuKWJmH5rjvl/IzgIoyR0RZeSN9VPN81s8NfOTYHQ==
X-Received: by 2002:a2e:864e:: with SMTP id i14mr17271725ljj.141.1558613278568;
        Thu, 23 May 2019 05:07:58 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z11sm5868082ljb.68.2019.05.23.05.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 05:07:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 23 May 2019 14:07:54 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-ID: <20190523120754.4e2wak7mn7t3wfkz@pc636>
References: <20190522150939.24605-1-urezki@gmail.com>
 <20190522150939.24605-4-urezki@gmail.com>
 <20190522111916.b99a18d67bc76f7cf207d9e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522111916.b99a18d67bc76f7cf207d9e6@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:19:16AM -0700, Andrew Morton wrote:
> On Wed, 22 May 2019 17:09:39 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > function, it means if an empty node gets freed it is a BUG
> > thus is considered as faulty behaviour.
> 
> So... this is an expansion of the assertion's coverage?
>
I would say it is rather moving BUG() and RB_EMPTY_NODE() check
under unlink_va(). We used to have BUG_ON() and it is still there
but now inlined. So it is not about assertion's coverage.

--
Vlad Rezki
