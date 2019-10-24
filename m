Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF6DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5521BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 23:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BsAUU74u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfJXX7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 19:59:05 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43777 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfJXX7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:59:04 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so234602ilh.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nrYq+Fut0kmQhvcRn7pxSXUfim+ixb8xYZ7zEoN8gXo=;
        b=BsAUU74uS8B0k+6fZmvognM6tez13o3m6eEh19qshytOcDMGPC6/x5LGe/utbx+1Nm
         Gl1SGTWaU8I6VXpWeZ96RVdo7Frjt9AcOHaxwXXe7MH3vVU1iFa/l7vyawBgOEZVPXxt
         CueHWNYxJECkUK4BvK6ePH4zszEQ5pLR2MCh5x2zHXdWwdLD+6LxuAyu4qVRPSLopghr
         DyOME0SHIzrw5NVMiUWTiCA+Jlc0cRHJ2Ssf5JeQcGMjRTX2DBunouQ9WY5kRqmbAu+2
         ieryA2hktUS1oEOY23HDFq8SVOrlikVEKeY6qw/rRZ/K/x1KjS8crEvmviI3tXGCwjs+
         YXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nrYq+Fut0kmQhvcRn7pxSXUfim+ixb8xYZ7zEoN8gXo=;
        b=LJBlUy8DcL0gBK17NAZQh3Kr/hjrv2R0yurn98s1h2cA9CEQSk3Wh51Ih+14Py8ej8
         dehe2wfOC0B0SqrWcVWUgA3hnPRArwbEaCGLGqHH8KjKMmGDLt048+CfC4CUJkzd7o3i
         nLSWM3SzVm3SeMqNN5doyZl8DA4+Dv5t/3Vl50QzrkhA4y+KFQs6a7W5PEuaWgMWNZoV
         CHUFLP1jA48lszn2unzR+ptQACWWDHExuTNep7k3EnN0v/6aPOMl4QJpYIdbkRqZQWT1
         SkqJE/dulzgfcqnSP3C2A8WAROck2bROLX/SbSkqfBGnPULCgIxVB6jreREBVBw4j6ox
         HxzQ==
X-Gm-Message-State: APjAAAUTg0NxW0PLsfE3bUMOxhhnRS+uUgx37b/b/HhHaCvgnixacr2q
        fOTmsuOSM+mg0unsJ7JcC6YEew==
X-Google-Smtp-Source: APXvYqxSqNsy/Qwmu3LlHURutjKdJmHQxsFx2ie7La+PrF/qzATogjgyh4MjolOQL4abtFIhbi4ZfQ==
X-Received: by 2002:a92:ce83:: with SMTP id r3mr959589ilo.176.1571961543943;
        Thu, 24 Oct 2019 16:59:03 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t68sm88604ilb.66.2019.10.24.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 16:59:03 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:59:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] riscv: add prototypes for assembly language
 functions from entry.S
In-Reply-To: <20191018154923.GA23279@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1910231812080.6074@viisi.sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com> <20191018080841.26712-2-paul.walmsley@sifive.com> <20191018154923.GA23279@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Christoph Hellwig wrote:

> On Fri, Oct 18, 2019 at 01:08:34AM -0700, Paul Walmsley wrote:
> > Add prototypes for assembly language functions defined in entry.S,
> > and include these prototypes into C source files that call those
> > functions.
> > 
> > This patch resolves the following warnings from sparse:
> > 
> > arch/riscv/kernel/signal.c:32:53: warning: incorrect type in initializer (different address spaces)
> 
> I don't see how adding prototypes will fix an address space warning.

You're right - that was a cut-and-paste error on my part.

[ ... ]
> All these are not defined in entry.S, but called from entry.S.

Indeed.  After reviewing this patch closely, I've just dropped it, and 
used __visible for just about everything.  All that is reflected in the v4 
series.

Thanks for the review.

- Paul
