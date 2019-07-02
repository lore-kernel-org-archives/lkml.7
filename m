Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E885C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+GRL2o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBS6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:58:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36333 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGBS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:58:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so869177plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NoPQm7BhluIQixsWy6jjw3GeJMnTyieWyQFDmLwmwJ4=;
        b=L+GRL2o36NtPs2femln+N8HVw/kCQfXaqfis0fXDHxD/9YaQS/UQyEEms9tRuHu4sG
         AQ/COT6gGNIL97ops6sXUkIvBWkWPKwpcRkKrWvZOtlChMJUZ1slW/YWRBnuTIjqQWYG
         L3m6awM0Ef3ffxm2Z6hzQnkE17/rJ5hn3mDclRhMRxMEkfFTa6DvrFqutyBemXokpU2R
         aB1JKz2hvWC3uk6LNFnLyJzB9mBQG2EqN+8IpSwBNXTL+/kK1P2SZqwlx9zndbu6bK4D
         FAz16WRHLJwbxZwuIMwUdFP2XTHVM1y7UOTUbnrc3jVnLZsUHW+YY/dNyJ3G/tZAdZPe
         LxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NoPQm7BhluIQixsWy6jjw3GeJMnTyieWyQFDmLwmwJ4=;
        b=acMgLlxX662i0VB38g7sj2pY6Uc7a93Q2Pu1mGOZso3IJqlVdeYueQeshvJ+PXj54m
         oTK0XfmBzaKpRgLoqW8do00r4rMZW34YfgZ6b7OHMOfrCbnuIKmWvSG/hmMUlIqyX/St
         y+bDC6dJw95B/V8GEbEpJj6t0dHb0frA73mjzJJFpfTYNCV+S0hp5mtVODnOLbAsDGyw
         eL0x68fNwIdiB9mte98PdG970RqiPPm6JbJnvh7ZIee6XxUIU34uGqxj6hheBw5sYjiE
         x7VxTICBNvGKF4vb2DWyLHTngqxdLuezQwx0+6nv3chr6bSCvPFKQ8x94FWuJABuPLc+
         8hqg==
X-Gm-Message-State: APjAAAXtOigVmUnojf3gh5tGhF9Z120K9euhzZccEWvfnr4oGbIjpucH
        jxyJk1wJD7Jtp10MW4ZTf27M9w==
X-Google-Smtp-Source: APXvYqw8dPKGUwJocSZOV9TVMQyFfZPDSfOEdfcX1CMRr/CyHjcQzbd3apmIL9aFvsRRF68+qlj8AA==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr37313013plr.12.1562093930455;
        Tue, 02 Jul 2019 11:58:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q36sm12654814pgl.23.2019.07.02.11.58.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 11:58:49 -0700 (PDT)
Date:   Tue, 2 Jul 2019 11:58:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Henry Burns <henryburns@google.com>
cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before 
 __SetPageMovable()
In-Reply-To: <20190702005122.41036-1-henryburns@google.com>
Message-ID: <alpine.DEB.2.21.1907021158360.67286@chino.kir.corp.google.com>
References: <20190702005122.41036-1-henryburns@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019, Henry Burns wrote:

> __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> lock the page. Following zsmalloc.c's example we call trylock_page() and
> unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> passed in locked, as documentation.
> 
> Signed-off-by: Henry Burns <henryburns@google.com>
> Suggested-by: Vitaly Wool <vitalywool@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
