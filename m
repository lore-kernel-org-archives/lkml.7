Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA0C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E880F20692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pugj6Iab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfIOVig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:38:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41058 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfIOVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so18445234pgg.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=21oLpXaZj4J497/4OayRnybX2D972/PKmY9dbt/gmqc=;
        b=pugj6IabxpP/wd6MMnBsyU3TdktFk/BWNqILYV2Ku0+TFI9JYMkg6iptGwDMg30Pnr
         xMviD8MU4ZygdlW+uVZzm0rDxP1H8d01VEYYz5YEuqh2lidM6XOouo8ieHOSuY7ILJzn
         ueRebe0cUyaDavwpHajRItBoXoFTC0lDs+qiENH/lmiGei4kEnT73iUZm3SPks5oTUsS
         bE3BhIyg91gbX9l2w2l25xzZH7CX+F/HDSzagPlGY54txF3UZmp/fP5EWqesuXpmw6EK
         InYWZEXsWkcicM+EMC5e16Rfklu3pcNRFt2PbrL+v+GbjrYrY6luMB3EscobTBglWWPU
         uXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=21oLpXaZj4J497/4OayRnybX2D972/PKmY9dbt/gmqc=;
        b=sUWAqBqZ4sK7Dg8WqdpdxeRwXlDJk0pfxbE+uMxFUSVXtqrv3rm7ysgO951102BQFz
         cEorTdtzBjR3SGda3ssyEz639gxRglrMfZS8uGD83FLwlv9yk21s4qLqEch04XTmw71D
         qEBNCXtqaDoxgIw2PK5uUoqJoQt92kaobNM7iDWQLZ3ysM6fubn20JsU6SbQRGAKhcwd
         YPAF8K2jA5GaILrRFtZIUK4sEgVFG1n2iJRkQZ2AvC+0fzQ+9Uk4j0hpgZ+2b26VgUCc
         K+tfnDn2p99hs8wF9n4bhEdCLPbsXlNg+9MGTf/5I6Zr/fndzKmhPiYK389FeBe+wD7L
         t3yQ==
X-Gm-Message-State: APjAAAXxfqc064+THMOgeF3VeZUhX0SZju/vgstiReK+0Vptytcwo/ik
        Z52/0HjsECruyNK/NUL/HAhbgQ==
X-Google-Smtp-Source: APXvYqwtSGea6ppywW4+Bn4Lihxar6q1j9svt/dw/9+wCG2I1VwRpQ9e9HxLMiwUsV1n9sfrxnzRWg==
X-Received: by 2002:a63:3182:: with SMTP id x124mr17080393pgx.41.1568583512166;
        Sun, 15 Sep 2019 14:38:32 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n10sm31240211pgv.67.2019.09.15.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:31 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 3/7] mm, slab_common: Use enum kmalloc_cache_type to
 iterate over kmalloc caches
In-Reply-To: <20190915170809.10702-4-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151414380.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-4-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> The type of local variable *type* of new_kmalloc_cache() should
> be enum kmalloc_cache_type instead of int, so correct it.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: David Rientjes <rientjes@google.com>
