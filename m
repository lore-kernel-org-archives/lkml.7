Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5707EC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9C12230F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HY/3X4Py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKRU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:56:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34535 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKRU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:56:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id i17so21888228qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpQIGKOXBuvR+dqKIe6qupfgLD1+kHFwhnlzCAXLMkI=;
        b=HY/3X4PytVjFgVH4p0dhqrSdeoAERiXGrFMIc9EwdUR7raHTE6LMUKlReOJG86ENg9
         oPzUflcxzhACB90GxluhmZsgJuDlUpyCn4vSplR5LH7xVzI3LL9WvKHDuDesdW020V5u
         emwxROuaukkkd6aBerrod58/V5SgtuyM9abw7hf4/fYgknAt7HaoK1KJ9Fwx+21VlIA9
         Nof/uztLpqUukz1fOxoYbUUwEjrhYOnas3touHBFEFFGzewi7jhXOFR9hCFm+yBurobA
         VsWDSRfmLlWpS5/ljZHFZ9YtELyxIeDrur2kRDrkuQ6fgVF0KZqvZZsM5PVJJfXSfQDv
         Eq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpQIGKOXBuvR+dqKIe6qupfgLD1+kHFwhnlzCAXLMkI=;
        b=ISknjUgtnTyacGtXj2HKbk12lNpHrJOjBQ4YCm/b9P482R1YyNFCFDxFowIWhZpjsZ
         dRZ4JETvs5KyLdJLeEzcgY3ba0+Kf3dcccJqN9+pCoBXxx2xn5L7mYjPuyck3r8LMqsA
         AvbU8TFAZffVg8NiV4io4Tr5hBSuX9TIjyFFxepkTOgzQYgkEz7mE9h3Zm1/svqD7OBn
         8219aXeKYZ0dGZwoS+efaNnqFGO0JvcjRSQTnlbDVYZYuM3cprto5i7uwG1Q5JSpPpzc
         gzcN8k8QVZI3sYntQ5FK0/Z9iNFLfT46dQ7gjC94lCHU5vwBulZQyQOE/XhxvHGoHppH
         rmaQ==
X-Gm-Message-State: APjAAAV8B872D5drW3nSU4fP3I1wy7kyM9EQ+UMO818yE4RHXkmFdiQg
        2awga/TRAMZJVOA+7onkBvZiCg==
X-Google-Smtp-Source: APXvYqyUcizojlBpOIM92IiIW2GoXyUc6B64Y6klEWFnQe5DKB+hDbdzFEPRdgSpUEovgYzxbHDudw==
X-Received: by 2002:ac8:608:: with SMTP id d8mr29368011qth.258.1574110575770;
        Mon, 18 Nov 2019 12:56:15 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w69sm9419221qkb.26.2019.11.18.12.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 12:56:15 -0800 (PST)
Message-ID: <1574110573.5937.144.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/vmscan: fix some -Wenum-conversion warnings
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Nov 2019 15:56:13 -0500
In-Reply-To: <1574110334.5937.142.camel@lca.pw>
References: <1573848697-29262-1-git-send-email-cai@lca.pw>
         <20191118182547.GA372119@cmpxchg.org> <20191118182853.GC372119@cmpxchg.org>
         <1574110334.5937.142.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-18 at 15:52 -0500, Qian Cai wrote:
> On Mon, 2019-11-18 at 13:28 -0500, Johannes Weiner wrote:
> > On Mon, Nov 18, 2019 at 01:25:49PM -0500, Johannes Weiner wrote:
> > > On Fri, Nov 15, 2019 at 03:11:37PM -0500, Qian Cai wrote:
> > > > The -next commit "mm: vmscan: enforce inactive:active ratio at the
> > > > reclaim root" [1] introduced some Clang -Wenum-conversion warnings,
> > > > 
> > > > mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> > > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > > [-Wenum-conversion]
> > > >         inactive = lruvec_page_state(lruvec, inactive_lru);
> > > >                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> > > > mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> > > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > > [-Wenum-conversion]
> > > >         active = lruvec_page_state(lruvec, active_lru);
> > > >                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> > > > mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> > > > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > > > [-Wenum-conversion]
> > > >         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> > > >                ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~
> > > > 
> > > > Since it guarantees the relative order between the LRU items, fix it by
> > > > using NR_LRU_BASE for the translation.
> > > > 
> > > > [1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org
> > > > 
> > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > 
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > Thanks Qian!
> > > 
> > > Andrew, this is a fix for "mm: vmscan: enforce inactive:active ratio
> > > at the reclaim root". Could you please fold this into that?
> > 
> > nvm, I see you already picked it up. Thank you!
> 
> Hmm, I don't see Andrew picked it yet.

Ah, I saw it now. Too many emails, so I'll setup a filter.
