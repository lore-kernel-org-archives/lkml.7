Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2DBC34378
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6E24722
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev1ov3Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfLMS7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:59:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfLMS7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:59:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so262514pga.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=plyeo90oN2lC9FaEGxIDmndtKqGo1ODsL7ANDiHR6uw=;
        b=ev1ov3Z69+9ifz2uLH3YjJmANxf/x2pMC+Q3R4ECYfpsfZCju8m7JyZ2vVk8GqCURy
         Xl+UoIb/HgEXibOHSA5baMV8H7bhbVgDk1ejwjWpksMK7JWcMzyFCl1zY3UJAzT/Wh/l
         NBeQOyVdM/v+p7wlD/9h/sFgX6uc8HCYUfXLObJhneORP6VKrO/XmFaRz+1qvxr3hxaq
         hv3LAFnxsVkKbQfdZog1CQCWTJDpZMhqxtrYkvGkGt5ZGB2hUWGhxf4VVB/SEXMZq4Fm
         PCVxUZ8Eqd0UnpnZyBToTrVUhrRFbBLJcKMe9nAoxn+iuRCdFz6fBM0hl3/ndzSQy6Zz
         PBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=plyeo90oN2lC9FaEGxIDmndtKqGo1ODsL7ANDiHR6uw=;
        b=UX7835713QUM17NvNb2KRb/rnGlIkIh88eCeCAju/NoDdYGhvocSV/t7tu4pOLqjpJ
         nybA5Qpcay0L2FzcOZFqVhUWJgY2faOIjAUWAE0yzX7jYuN4Ca1uUBOAyCWdrEPK3v8g
         dRhRKwCj4cVPoa9ayDjo11uheMI67NFJQlUPkowVgP7HK0DuQFpDNR05O/+f5GjOVTcg
         qPnxBVn9KQ8aMXiopo1yjdkyr2ymxl8Ou7u3L8FamrIfCrqKeBdv03ND7Z02J08vscWZ
         pnO4QmJ2Z08uAk8iY+fb4xjH2BbOqCJtNGcQJ2W99npFPCJEdLQJE2kCVMPy+F9aUrmE
         zXiQ==
X-Gm-Message-State: APjAAAUNBnyRFbENDMbp5fbjRcza6E299VOZqYrPb2QGQIcMNuQ+Dzrp
        jd1iv3RoNooNw6lk2hoxuthn9A==
X-Google-Smtp-Source: APXvYqzWYkjmz/E9S/bb/nS8Bbq0ypi75OA0Xoo8KsHh3BWbICiz04plubTRc6XIQMIesMEGOgOeQA==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr995058pfk.216.1576263541782;
        Fri, 13 Dec 2019 10:59:01 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m3sm11487799pgp.32.2019.12.13.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:59:01 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:59:00 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Florian Westphal <fw@strlen.de>
cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove __krealloc
In-Reply-To: <20191212231822.GO795@breakpoint.cc>
Message-ID: <alpine.DEB.2.21.1912131058420.24843@chino.kir.corp.google.com>
References: <20191212223442.22141-1-fw@strlen.de> <alpine.DEB.2.21.1912121459400.121505@chino.kir.corp.google.com> <20191212231822.GO795@breakpoint.cc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Florian Westphal wrote:

> > > Since 5.5-rc1 the last user of this function is gone, so remove the
> > > functionality.
> > > 
> > > See commit
> > > 2ad9d7747c10 ("netfilter: conntrack: free extension area immediately")
> > > for details.
> > > 
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > 
> > So this also means that we can fold __do_krealloc() into krealloc()?
> 
> I would leave that to compiler but if you prefer this I can respin.
> 

Sure, no problem.

Acked-by: David Rientjes <rientjes@google.com>
