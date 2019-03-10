Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928D2207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh/Pf83L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCJVaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:30:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46116 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCJVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:30:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so2927680wrs.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XayYu6osvInJUJaPOufT68C1ORPD1W8ysng6inaqvaQ=;
        b=Fh/Pf83LKiO6+VD4ejwXfiscN+RzAkpxRa8HBzTFaxuzxFlGUN47TEj01XrnL9yG5C
         99UFE5Q/5/C3JXPIn1DM38XVeEG3BMcibuDzrDPR0lv/E7G/FUzF3sTxVly6svrWw/m6
         OVqDkTN9P3w0c9cc0FURA2vnseP6GuvjuT8wt3pYabMbz23Z9BH9OXqMLqrYbV3csJ4V
         D/PrWFWTUbvHj+42V48ZLl9cKLBx5Q8fhamygsZCaQVZg4aPrAylpOvc9AF5xeth7c5g
         W4sD/0QPFvEi7SyrcvlFVZmGyOk8igeYeZ3sVtv1Np0uI8JAqfj2b/ZPwgwXS6MejrHA
         s6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XayYu6osvInJUJaPOufT68C1ORPD1W8ysng6inaqvaQ=;
        b=ZSXyUDP50uhU+eIV6KRsGef4S2drS9j2CrRmvPJGU0oPxrbrYDZeg8iqzz7jMiwBdp
         QMCVvWWSUcSlVFsPxgxGmkA8UcYYltBCEnuRoLv9opLJZsiNIcF6qzZ1nqnUpHu08b2Q
         WXnUBTm6ZG1vJL7qlEPU1xvlxnFLGssGj5ZiCFJ7x9rEp/n/HtMwyvodn8sGD3isjr1B
         Av3aNwsrftuuwZBZVPpbUodJlAfkXlABqH1YCLEkwZ9HeP6/JpEJr24R+iQ6UhoGU2zU
         3bzEz9/E6Ib6eAlfc0YT5e2JQDNAtusSH2aTY44C4+Y8FITEa5Mx+oobhmfbX+U8ATyS
         msXg==
X-Gm-Message-State: APjAAAV6Dtq/lfT6TRDpKtfeY4Z2wH6F8kAoCUcXywqGi9Ita46+RBTn
        JfNM1s0xI/Fc21+BE0kW6WVXdPY=
X-Google-Smtp-Source: APXvYqzjnzXpLrMFEQBC5WSIBLtp7LlPRrR0Hq9t2Z1+LiahM1HMEVdkV7yVia/er5diqImcxxWnxQ==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr1298114wrr.229.1552253408743;
        Sun, 10 Mar 2019 14:30:08 -0700 (PDT)
Received: from avx2 ([46.53.246.68])
        by smtp.gmail.com with ESMTPSA id s13sm826058wrw.47.2019.03.10.14.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:30:08 -0700 (PDT)
Date:   Mon, 11 Mar 2019 00:30:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_assert: move before people start using it
Message-ID: <20190310213006.GA18349@avx2>
References: <20190310105157.GA15039@avx2>
 <1d957ac2-3423-2471-6b7f-f6f25dd0273d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d957ac2-3423-2471-6b7f-f6f25dd0273d@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 10:19:37PM +0100, Rasmus Villemoes wrote:
> On 10/03/2019 11.51, Alexey Dobriyan wrote:
> > Userspace places static_assert() macro at <assert.h>
> > 
> 
> So? That seems a rather weak argument. We have lots of interfaces that
> also exist in userspace which are not declared in similar-named headers
> (e.g. we have no stdio.h, which is where snprintf lives). Not to mention
> that memcpy and friends are in <linux/string.h>, not a bare <string.h>.

Linux 0.01 had memcpy() in <string.h> in fact. :^)
I don't know what happened.

> Your assert.h would be the first and only header to live directly in
> include/.
> 
> If you can somehow convince Andrew to take it you can add a Meh'ed-by me.

The whole BUILD_BUG() thing is a misnomer. Userspace has assert() forever
and it doesn't require double negating (which is why assert is good
and BUILD_BUG is bad). Once everything is converted to static_assert(),
it will live in build_bug.h, so might as well put it into right place
immediately.
