Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E878CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 01:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E2220692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 01:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCfDZsbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIOBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 21:08:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41037 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfIOBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 21:08:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so5619580oiw.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pVY7GYznZUijjBc7X2tclsJfpGNz8NESBfTF4Oaa2qY=;
        b=aCfDZsbWEAWGGRMky2a5nmbJNhj/4+ui7XoQwZ3ntNOVLaO1OYoLJe3jVDKBsxA54q
         I/EUDSWo9IUqdsl0vs/o+E9FjdxbNKikEeAS11oMyuzx2KyeFadayPu68SLOqdxIYK3i
         plU1/lDlNs0YiFGQKMepyrmiPm4gfdHW3OZnnklSmEgCjAex31ctzzB1g2P70K5VO3k6
         svRrr1/GNpgusqNsKe8p/ht1MkfWX1ei98ZK47BkOGbzQ3c3cRgIAAm+/+uBz4xnW5zK
         7PMpdtAiaYyjDfqhRXBmNu024ExalLi4X/frubr281H0TaWGYDQ4koZHUCbeDiN0KsNl
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=pVY7GYznZUijjBc7X2tclsJfpGNz8NESBfTF4Oaa2qY=;
        b=uNjhk7SMfPRtmlU4TPXAF16mwBb0BhwfgLB4MRafHE0QmlPZ6bcVkaGbhP8JF7hAlb
         fVoz6W5BYybOgSG7a+hjFQiveFPZAVHYn+JnGblhqXLNPGC2eOPjVQTVe1V55vRugwdE
         7cYoqkwQp5WD9KwV5CuHCuIFDdVdd1lJ9m3ymmMMXOaC9lP1k2BXbiGFOCOgGnd3qF0S
         1OJ8IaUioaLSZaKcEhKNSWFiQMxGuvaooEZwAMMMgxfTb1kKcDBx+QIbVoc5KoDzoI8A
         B7uqrUrUCcCz65nWkT9+1zmR/0KgvFo75Mor8e4kBV+RJvksK2NnoihjA/4h57kCFSjb
         4KMw==
X-Gm-Message-State: APjAAAXDKU/BG34AbA8r+IIHJzPnN5cmLTtZq6z+z8u5Sa0monLj5PtB
        Rdj/PQRq/abWRmLAiEaPYQ==
X-Google-Smtp-Source: APXvYqzk0vH7Ypv5ygXpcKT6IjSLBaOk6loAWxvPTkM2yU6kWKDVNF10YkS57pigMx+uYzyB5Toz/w==
X-Received: by 2002:a54:418a:: with SMTP id 10mr9079555oiy.88.1568509736833;
        Sat, 14 Sep 2019 18:08:56 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 93sm12736604ota.16.2019.09.14.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 18:08:55 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id B00271800D0;
        Sun, 15 Sep 2019 01:08:53 +0000 (UTC)
Date:   Sat, 14 Sep 2019 20:08:52 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     openipmi-developer@lists.sourceforge.net, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH 0/1] Fix race in ipmi timer cleanup
Message-ID: <20190915010852.GG13407@t560>
Reply-To: minyard@acm.org
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
 <20190828223238.GB3294@t560>
 <15517bfc-3022-509d-15ea-c2b8e7a91e0a@gmail.com>
 <20190829181536.GC3294@t560>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829181536.GC3294@t560>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > 
> > {disable,enable}_si_irq() themselves are racy:
> > 
> > static inline bool disable_si_irq(struct smi_info *smi_info)
> > {
> >         if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
> >                 smi_info->interrupt_disabled = true;
> > 
> > Basically interrupt_disabled need to be atomic here to have any value,
> > unless you ensure to have a spin lock around every access to it.
> 
> It needs to be atomic, yes, but I think just adding the spinlock like
> I suggested will work.  You are right, the check for timer_running is
> not necessary here, and I'm fine with removing it, but there are other
> issues with interrupt_disabled (as you said) and with memory ordering
> in the timer case.  So even if you remove the timer running check, the
> lock is still required here.

It turns out you were right, all that really needs to be done is the
del_timer_sync().  I've added your patch to my queue.

Sorry for the trouble.

Thanks,

-corey
