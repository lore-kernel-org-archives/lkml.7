Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C3EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD2C21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIUTOy91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfI2VJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:09:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36764 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfI2VJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:09:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so10536394wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=835gZDZiuAF6RS45JuXHhw4Y13hBZmcyjNDrpLLnfmM=;
        b=WIUTOy91IuoCxAELuPqxD4CKI0w4Iiw7JljoJS3qctBLHtDR76dHlhD4OpgzaNUnWQ
         tKRpmpEgz21rdRo2gCI5zl7tzSSeGwhKxh9hR0Ui1ebdy0CTYRRsNaB2/I2X9s6NFZYj
         UecVusL2XHESUreXOgMkoY/VSUylSNw/8RLBC1jjyc8Rz+UZirvQ6BRkh7xmSmJPIHth
         5sBqvC243Hbujb661UxDZOSmFS7heSRsrs6wf0PMggl200i3/QHKcpJptT4uw9wSA4G8
         H3Kh2XR2QntogKOgLxgDyqLDe39VbIcsCMVFNXJNh2jJVyBg/LKt9NHnL3sa7Ht44Czx
         RJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=835gZDZiuAF6RS45JuXHhw4Y13hBZmcyjNDrpLLnfmM=;
        b=mrvdXJ8N+bwneF+evfkcuvhSuKlsLiWz9f8W2trU89jCQc6MiO7B5Qu0G7U98KxXiz
         qpf9JX0uHJe2NOcaxFtsi6JoLgQxrsZfoCIPlZDifPTEg5tRqEWJvhPhJBCGpLS/Ma4g
         5B/Aq1K7k6bzv+W9Cd56YSi4JGQsXR3GdS6VOGkBb6nYEiMOSVz+kbAgjEqaff0vWyLD
         JlrAbzjHrxaJyXZ77NEE4HpVjokwW4gbkpdHCzU2AGVJoM/6G+kjnd8jTYgV6SZ0q94K
         4qwL53Bo9tpNa9ZyNqVpMYQjKiJZLxX8YnJKYnqqVnB6AL3YmbrTYHtqEJAH+aXMw4js
         Kk3A==
X-Gm-Message-State: APjAAAVOE8Dd5gVxkJ3QFoXgUFzprQPjdRvgC2yFLEWmhoX57au24qUp
        yfubNe9DO0OPTuQXA38gPw==
X-Google-Smtp-Source: APXvYqw/QW34YVSRfb9yYDWgKOd0tsxqOry2MrRncpo1t7GZ9CS1E9wu/zy+Y6iVPy/h/SGTKM1XVQ==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr14001127wma.119.1569791350994;
        Sun, 29 Sep 2019 14:09:10 -0700 (PDT)
Received: from avx2 ([46.53.249.180])
        by smtp.gmail.com with ESMTPSA id j1sm23452456wrg.24.2019.09.29.14.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 14:09:10 -0700 (PDT)
Date:   Mon, 30 Sep 2019 00:09:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH] Make is_signed_type() simpler
Message-ID: <20190929210908.GA14456@avx2>
References: <20190929200619.GA12851@avx2>
 <f99ca43d-1ba2-95fb-b90f-6706a06f8ce6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f99ca43d-1ba2-95fb-b90f-6706a06f8ce6@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 10:21:48PM +0200, Rasmus Villemoes wrote:
> On 29/09/2019 22.06, Alexey Dobriyan wrote:
> > * Simply compare -1 with 0,
> > * Drop unnecessary parenthesis sets
> > 
> > -#define is_signed_type(type)       (((type)(-1)) < (type)1)
> > +#define is_signed_type(type)       ((type)-1 < 0)
> 
> NAK. I wrote it that way to avoid -Wtautological-compare when type is
> unsigned.

Was is W=1?

godbolt doesn't show it with just -Wall

	https://godbolt.org/z/kCA7mm

And the warning which found i915 case is -Wextra not -Wtautological-compare.
