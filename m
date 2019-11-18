Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20EC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BCF222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="t5weXUGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:28:56 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46090 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:28:56 -0500
Received: by mail-qv1-f66.google.com with SMTP id w11so6955438qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rury4ZZBdE8YLeSDPwSjljk3dVtJlEOvKyMr2vi3O/U=;
        b=t5weXUGAVmsQStwPj4v4X/U1MmOY95N/K56kPstKmQF4arNhyRORYSXsWauzEacMXb
         JqhTYeEb1S364qsmlrmH2Ac0I49RfS5VfaipBlRA4LTAeyLOUWPW1paOU7a4oRkJOiV7
         k/YI7dV2R8eGFp9rKo+JiT+PlhARfTYuaQ2jSeqOp2uA0ik41qAUY+VIDzaRviKLjbWU
         WyiILBRcfAyWWgqTWScDeJu4fRb6NUGl2+uAnpWSMR7MIeAn5zq5kuCSVzknRMJw/kNy
         aPu4XUNv+4/FST7Sq5GX73fckuKvxVYDE9W+iMHnunV3Wc6J+OcNU7Hmppo4Ur3H2Qcl
         HvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rury4ZZBdE8YLeSDPwSjljk3dVtJlEOvKyMr2vi3O/U=;
        b=VokybTsLz27+zLGxVaQhtptkCg4cYhYVVLllZoATbtFfD2Ai3ca5/o6oSK5a+B7HWf
         H2AHEhO84ot9uZE/xv5fUmHY1wlHhiorJpq3DDAT1dZZpUK3JC60LwgypJ/FtfBCP80J
         ZqpyfeulNLAZ/gU9KLlx8djUq9Du5T5icB+hIT5TJOYgciIpFgRt+TjMUf88ucd9viHs
         zqsnSJv7VcVFi5JeEIGGwx39xQdiu48uW9FzA48fFHpq4O6/4cT4XQYsL7M1aHjtaJ4y
         r+fM7lAwzliGO12U6JgW/1OIS8mywncMjSxHK32feJMvZUfcumM35EmW8QR9+yHFSHpx
         jURg==
X-Gm-Message-State: APjAAAXioz2WdTLgxxuYDnfBlwQqYhTlC1urs/1mfsq67OE3NyAh0x2U
        SZ+iPkEkEIXtIIFlubITK5BWpw==
X-Google-Smtp-Source: APXvYqyl/aARQmjBKzHTmHzbVrT8MzUIpL5E7XmWwEt1kaN/urxHlwoDGk5fd7gzop2bqCj4f4lKcg==
X-Received: by 2002:a0c:df89:: with SMTP id w9mr16219834qvl.158.1574101735081;
        Mon, 18 Nov 2019 10:28:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id d126sm8997866qkc.93.2019.11.18.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:28:54 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:28:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/vmscan: fix some -Wenum-conversion warnings
Message-ID: <20191118182853.GC372119@cmpxchg.org>
References: <1573848697-29262-1-git-send-email-cai@lca.pw>
 <20191118182547.GA372119@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118182547.GA372119@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:25:49PM -0500, Johannes Weiner wrote:
> On Fri, Nov 15, 2019 at 03:11:37PM -0500, Qian Cai wrote:
> > The -next commit "mm: vmscan: enforce inactive:active ratio at the
> > reclaim root" [1] introduced some Clang -Wenum-conversion warnings,
> > 
> > mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         inactive = lruvec_page_state(lruvec, inactive_lru);
> >                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> > mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         active = lruvec_page_state(lruvec, active_lru);
> >                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> > mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> >                ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~
> > 
> > Since it guarantees the relative order between the LRU items, fix it by
> > using NR_LRU_BASE for the translation.
> > 
> > [1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thanks Qian!
> 
> Andrew, this is a fix for "mm: vmscan: enforce inactive:active ratio
> at the reclaim root". Could you please fold this into that?

nvm, I see you already picked it up. Thank you!
