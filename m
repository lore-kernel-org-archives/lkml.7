Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F8C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="aQd1aeO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbfDQTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:52:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45421 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:52:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id z76so15092791qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uru0Jbz4B8OYoAQYJt2C55pxQlJkGfm/+9nWfpEgZPQ=;
        b=aQd1aeO2CXg7gYGOcvtEUcXMyHfbY37wbHMchotalTNQZ2RxhJxZjLextp8ZWtQKA9
         ElDQno8BAegcG5tWka17SzrohZ4MVbbZKar4D1otZqJs6viRLbUgEjktrlyhXOKFoRRr
         Xqiz5AKyn2cqhIrRtLq2t6y4exSmyJWI+xolW690Pg05j5xcNprdRzKeq2BM/bBe7uD9
         Mna5BBYIALxIoHSfeGneAc4J6qlxgdl4umsVpI32Ws6NYWtDPh57d2uN8d9IDlmzf+34
         LgmN/QkDbE6mdN4NdIUb/v42FYkyBUW0DAfjxZ5Ti4wxRTTn11MCXXYyLy0I5wiy+cup
         dbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uru0Jbz4B8OYoAQYJt2C55pxQlJkGfm/+9nWfpEgZPQ=;
        b=q9FfDvP9f02ol6n8cUk5/w2ZUd/AzNPsyB30k5PVAq8TZiCwLujaZfOcZUa6qnI8TF
         GGBolF+WGJFQ8kl1pk8ZiG/TT0Lm0PTKNKttuN4Of4TUrtAqGdbulvw8uXm6CKJZnCL+
         syuRqYBRIR94gQiJEvKY4VzdchDqOypO3NISPs6wZADaVqnK3pMyInc2Po2QGaF+YYut
         +vJ4QNn0mpLCojKcVn44nzevTR96uRCt7P3XjCybzOmqKlo9A+o5GTzS6ip1spRY5lId
         Aj+kl+4aci/NjssrJ43etnMJtNdzWGagzDmTTyYHpsHs1w3zGYh7G9F46G4jrKggmMMy
         QgSA==
X-Gm-Message-State: APjAAAXMH9QtHH0h9vNYZH2mqH2/Tjvsko/BRJ6XLQNJOC+XwQpqY+/I
        xh0oO+iqzLCj7Q+/BAZIuDjCzQ==
X-Google-Smtp-Source: APXvYqxALLwioQYr156hXrQYUcVxn+eWorINAhsmvLl+aLFkTmy03SLo3tuclnCeyTO/WqSU4/UWYQ==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr70666110qkl.112.1555530737946;
        Wed, 17 Apr 2019 12:52:17 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
        by smtp.gmail.com with ESMTPSA id v30sm28498609qta.4.2019.04.17.12.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:52:17 -0700 (PDT)
Date:   Wed, 17 Apr 2019 13:52:13 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juergh@gmail.com>, jsteckli@amazon.de,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Message-ID: <20190417195213.GE3758@cisco>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
 <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:49:04PM -0700, Andy Lutomirski wrote:
> I also proposed using a gcc plugin (or upstream gcc feature) to add
> some instrumentation to any code that pops RSP to verify that the
> resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
> This will make ROP quite a bit harder.

I've been playing around with this for a bit, and hope to have
something to post Soon :)

Tycho
