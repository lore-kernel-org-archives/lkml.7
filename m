Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E1C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0408F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHv3WsVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGLRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:30:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47074 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:30:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so4809873pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fliyxzDfAGBMmN1oXsqyomaZR3XENMW0vd2GXXQScuA=;
        b=WHv3WsVcfVvezkKKS3H0aawILgSQZgZE2JrppFVVLLcybTbjvszHp0YHwdEC8Mf8eo
         JzxgpasgG5Kxq8s70uaXFGQwXCn+ZNp6bXxCYCYHm3tvKGeeeKApuaseG/7BdcZluyVt
         tEnoDzmgETCjXgOnUchBlcdeExxDDA9aXuRU9ET0a8kLQEMR7SrFpRC/HVhVPAKSxzId
         NT26/oYZHx6T4E4JDMsaL1qhRowsZUv76rpP49r0WACj4E05JY8YPi9rBPXhIE2FuyZt
         TczgW3dgHLYaGMpEBmIDg6jZRBL6mFGK/4L+ao21+6sqhrKuga8q3qawuZSb3J/F/fLZ
         h+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fliyxzDfAGBMmN1oXsqyomaZR3XENMW0vd2GXXQScuA=;
        b=B3hrLor4yFRp4UC+2Cq1r8+3y/jVCkzYG6vncL9HvD6DF4Dq8tL4N0UF4/4+F1/ezO
         q9sTKMlMOrSZPl5HwnNoflc1+8ONYPzMxpITED0IvA7tGZoE04Cl09zyp86K5X4H43M0
         MPamgWGmdvYeGS/oIXpoCe/f6an1f/DGQoVgxjC0ND077g+oNFXESzL/YXhPBpFr9fZT
         jim93YcM0GYbBZODYvOtC+zXo+EEb1P6EykG5JIdm3fGD6YteS0p6jt79K1L2DBZ5iul
         zcDW918c6O/+/1Ls63WvWqmjfd3ectC5hR8LAoVlQdwKC+/Rc2UTXZx40qEWbXl83IrF
         BTeg==
X-Gm-Message-State: APjAAAU5iYvBssHXYBnQCWsn9EIRRMFCwMHEqxa03tOzFpXiZGB1aabl
        GxutE0HecZRalw+yMJkxgjM/9g==
X-Google-Smtp-Source: APXvYqyFRe+9t9oI9OuMUg/uWyyqVPA9eQjdSu5mEYBvFWkkDunZWJTVzidpDAc5NnLVlkAKLyul+A==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr13024964pjb.51.1562952618502;
        Fri, 12 Jul 2019 10:30:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v5sm8405051pgq.66.2019.07.12.10.30.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:30:17 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:30:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] slab: work around clang bug #42570
In-Reply-To: <20190712090455.266021-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1907121029590.128881@chino.kir.corp.google.com>
References: <20190712090455.266021-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019, Arnd Bergmann wrote:

> Clang gets rather confused about two variables in the same special
> section when one of them is not initialized, leading to an assembler
> warning later:
> 
> /tmp/slab_common-18f869.s: Assembler messages:
> /tmp/slab_common-18f869.s:7526: Warning: ignoring changed section attributes for .data..ro_after_init
> 
> Adding an initialization to kmalloc_caches is rather silly here
> but does avoid the issue.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=42570
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David Rientjes <rientjes@google.com>

Let me followup on the clang bug as well.
