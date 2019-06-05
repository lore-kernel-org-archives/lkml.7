Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F47FC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF7206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1nx20dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfFEQAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:00:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfFEQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:00:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so20031225wrs.5;
        Wed, 05 Jun 2019 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+gmg8zF70tZqcuZYnBHWzWLmIsLYzqqZen+t6Z0irwY=;
        b=n1nx20dxtXxPpRy++RZgyw0xB1v8ACLPAYMXerK6LrIxpO/PHaqSjPl8NLqKDUazsQ
         QaTGTwQfpXusLWWe8eGRu6PzVJsERMQMhPfbKnL2oSXa/6t0/yT8jG0h7dZnwH9MGKNh
         EN1kWENl/HXb/8Afldv4Ll4oteIfmkENRVAF4v/0uFY7vrh0kezWFHrTi5DHJw4ZbtYs
         u/2MQ5rmP5/9dDS4rFjhnZgxxIyniia2V20qQ5KxjWqQ9do0delzh2EOTs58RhiOqEKZ
         YVX/uhMmbEs6EAayybYDw9G9ruNeNqUN2/FKcaworYmlVj8hO5DUOWDDWzN5LUC0w/9n
         eqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gmg8zF70tZqcuZYnBHWzWLmIsLYzqqZen+t6Z0irwY=;
        b=krQ9IMt6oIv4E6ddAsVHYiET9Vp/+ZFdGFQfTlAW8jvuIgzX7iLkCTQ+NyLhpsaYrP
         jBZhvlRNX+3ayQXUkGV7bb9r2CC1NfvvsSjaPTb8thfPXBXS9ZU5HUtRwG6fdubNPTm0
         zuX0MLklZw7+8BAUg7BNbQNjP2ZEt6zHbQux55rWBU56w9U7vPmyh0PvD+8HWKTIDqSt
         F1Aw1m+V+fkMM2xAp4gokRtDmtpuYuMSj3oAxmZ7exjcHkwHlJlPvVLCwZLIBtEEm4Iu
         U6BqUdnxvMXbwnxFIE1CySKc80vSDSR3NOLharYZb0/wLUxPzqeqp4LyYF+TXtunQDsF
         cV9Q==
X-Gm-Message-State: APjAAAUaYGBocrLXyHBkiOq34pCPkEshm4b2CEZnEFYzM5Ymy/vZGVHP
        9Rxvahmge9CHbnk2reKdeKk=
X-Google-Smtp-Source: APXvYqz8e54iOO1uLb7oV5CEK+/epIMcx9rIsldyhvvt7MHAHm3lvtCtrqBmrkA46oNohVp5fZVZtg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr25624367wrn.313.1559750452348;
        Wed, 05 Jun 2019 09:00:52 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id s63sm12069359wme.17.2019.06.05.09.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:00:51 -0700 (PDT)
Date:   Thu, 6 Jun 2019 00:00:43 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Message-ID: <20190605160043.GA4351@zhanggen-UX430UQ>
References: <20190531011424.GA4374@zhanggen-UX430UQ>
 <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 08:38:00AM +0200, Jiri Slaby wrote:
> On 31. 05. 19, 3:14, Gen Zhang wrote:
> > In clk_cpy_name(), '*dst_p'('parent->name'and 'parent->fw_name') and 
> > 'dst' are allcoted by kstrdup_const(). According to doc: "Strings 
> > allocated by kstrdup_const should be freed by kfree_const". So 
> > 'parent->name', 'parent->fw_name' and 'dst' should be freed.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index aa51756..85c4d3f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3435,6 +3435,7 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
> >  	if (!dst)
> >  		return -ENOMEM;
> >  
> > +	kfree_const(dst);
> 
> So you are now returning a freed pointer in dst_p?
Thanks for your reply. I re-examined the code, and this kfree is 
incorrect and it should be deleted.
> 
> >  	return 0;
> >  }
> >  
> > @@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct clk_core *core)
> >  				kfree_const(parents[i].name);
> >  				kfree_const(parents[i].fw_name);
> >  			} while (--i >= 0);
> > +			kfree_const(parent->name);
> > +			kfree_const(parent->fw_name);
> 
> Both of them were just freed in the loop above, no?
for (i = 0, parent = parents; i < num_parents; i++, parent++)
Is 'parent' the same as the one from the loop above?

Moreover, should 'parents[i].name' and 'parents[i].fw_name' be freed by
kfree_const()?

Thanks
Gen
> 
> thanks,
> -- 
> js
> suse labs
