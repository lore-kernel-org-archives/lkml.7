Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52B720843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQn6zvQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHMJAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:00:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39424 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:00:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so22465160lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHb3M/zpCv3XhUADWf/LjWKijlatOoK9KZez4AIZj0g=;
        b=aQn6zvQZ66OHEFe8Xkc0a3btTovtK0xZ4XR4HIGjuYpr/CxoudSkUcnU6dStwl2WQI
         HQ8TipNkeQUkCzpdy1/nqstAIMmg6kw2sWC83+NYjabyTMD3VVtHJhNLwCXsm5QgSp18
         Y4IOGTtkYo9MW/xvxhqSShjofqPrS+Ds9dq/Nfu4+kAvbF8YoRezMXv0SKUZ4bgDwiol
         +ey5Ep4jFdPuZNVZd7bjO8AvUgDI8qVnfDViUWEeWNFm8hXT1cVgvkTa/tCVLk5TPUzQ
         IFaSG20uzkDJxkpDwfdgdRrzuoO2aVIrRAoN82ajXfrPsykknG6fLGhhZjxvy4zQCXw6
         OrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHb3M/zpCv3XhUADWf/LjWKijlatOoK9KZez4AIZj0g=;
        b=s7CZ0qOv7pQga/3t+y8pkS9C5qWGH6lVV2LLfin4fwdsqGhi0EfhVbpxNqqLkT6sPb
         u02OdECaPXqdeOrzk18PCVCfLV2STBkkqG+8zqSrk3QFSmiyGZT0D7bx4395ZZoVLOph
         eDHQ8nzUvDa8YxL17Yw+RMt+TUQhu+7tOY6mp6eW3F2qyLFOtCpg0zirJixLlFO02N+M
         7FEiwNNy24ofzwIWDKelhUiNhSCBLiOtiznws/E7sAJC6u1il11gnJVnB9FHTH02wyHd
         P0P8kldSfI21y6Lb3SWn8tbQPehJoFiSkeuhz1gmxr1SDtdLQGe2whWfSJWgTzyL0E0k
         HcYw==
X-Gm-Message-State: APjAAAWo7Yw7N7Q4igT6BWkGsgoMoxcVrx7xUEHe1ijpO5ySBBknRpEX
        6tovtxiB3enRZgfWBInXHZ8xovwWbEkYog==
X-Google-Smtp-Source: APXvYqw2A+ZU0nehbGG/JYNg5kFw6TRdudXxR9hV4BDfwBjIYjL5rKTVi90xQhu7tNMIGtJ4k1RUsg==
X-Received: by 2002:ac2:549b:: with SMTP id t27mr21659945lfk.25.1565686852997;
        Tue, 13 Aug 2019 02:00:52 -0700 (PDT)
Received: from pc636 ([37.212.214.187])
        by smtp.gmail.com with ESMTPSA id f17sm5563841lfa.67.2019.08.13.02.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 02:00:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 13 Aug 2019 11:00:42 +0200
To:     Michel Lespinasse <walken@google.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] augmented rbtree: use max3() in the *_compute_max()
 function
Message-ID: <20190813090042.m7fdjilfks7cp2my@pc636>
References: <20190811184613.20463-1-urezki@gmail.com>
 <20190811184613.20463-2-urezki@gmail.com>
 <CANN689GT3CorHHegQBFR8tiVPqv5XAb2oYLCEbjB=tBhkO2PCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689GT3CorHHegQBFR8tiVPqv5XAb2oYLCEbjB=tBhkO2PCw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Aug 11, 2019 at 11:46 AM Uladzislau Rezki (Sony)
> <urezki@gmail.com> wrote:
> >
> > Recently there was introduced RB_DECLARE_CALLBACKS_MAX template.
> > One of the callback, to be more specific *_compute_max(), calculates
> > a maximum scalar value of node against its left/right sub-tree.
> >
> > To simplify the code and improve readability we can switch and
> > make use of max3() macro that makes the code more transparent.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thanks. The change is correct but I think I prefer it the "before"
> version. My reasons are:
> 
> - I don't have a strong style preference either way - it's the same
> amount of code either way, admittedly more modular in your proposal,
> but also with more indirection (compute_max refers to get_max and
> max3). The indirection doesn't hinder readability but IMO it makes it
> harder to be confident that the compiler will generate quality code,
> compared to the "before" approach which just lays down all the pieces
> in a linear way.
Thank you for your comments. As for compiler and what can be generated
as a result depends on arch, etc, so i agree here. "inline" is a hint only.
But it can be rewritten. One way is to use __always_inline another one is:

<snip>
RBTYPE max = max3(RBCOMPUTE(node),				    \
	node->RBFIELD.rb_left ?					    \
		rb_entry(node->RBFIELD.rb_left,			    \
			RBSTRUCT, RBFIELD)->RBAUGMENTED:0,	    \
	node->RBFIELD.rb_right ?				    \
		rb_entry(node->RBFIELD.rb_right,		    \
			RBSTRUCT, RBFIELD)->RBAUGMENTED:0);
<snip>

i.e. directly embed an access to the left/right nodes into max3().
That way we can get rid of extra "child" variable and to have a liner
code as "before" variant.

Again, i am not interested in just pushing this change, the aim was
to make it more readable for others and that is it.  

> 
> - A quick check shows that the proposed change generates larger code
> for mm/interval_tree.o:
>    2757       0       0    2757     ac5 mm/interval_tree.o
>    2533       0       0    2533     9e5 mm/interval_tree.o.orig
>   This does not happen for every RB_DECLARE_CALLBACKS_MAX use,
> lib/interval_tree.o in particular seems to be fine. But it does go
> towards my gut feeling that the change trusts the compiler/optimizer
> more than I want to.
> 
I see your point. Indeed the generated code is bit bigger with the change,
however with above modification it improves the situation and becomes:
<snip>
284544 Aug 13 09:53 interval_tree.o
283192 Aug 13 09:57 interval_tree.o.orig
<snip>

but is still a bit higher. If we care about that, then i will drop this patch,
because "before" code is better in that context.

> - Slight loss of generality. The "before" code only assumes that the
> RBAUGMENTED field can be compared using "<" ; the "after" code also
> assumes that the minimum value is 0. While this covers the current
> uses, I would prefer not to have that limitation.
If we care about negative augmented values, then we should stick to
"before" code. Agree here. If you have any ideas how to extend and
cover negative cases, please let me know. Otherwise we can drop this
change and do not pay much attention at it.

Thank you.

--
Vlad Rezki
