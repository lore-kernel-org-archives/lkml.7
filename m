Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73186C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E121872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="BDGOjdrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKNFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:05:21 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38611 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:05:20 -0500
Received: by mail-wm1-f42.google.com with SMTP id z19so13127308wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptfgZiJrJRT37KV6qx/ANFTtjHXD6glvvm6dcn8VVZI=;
        b=BDGOjdrOiR/70UcRqMcVVH7VffzPCSZLLyoX5htmD99qQ65QbHEdi1A94TTEZKTGia
         bu4YKgChFJqm9P5eaC7FDAyXwIxRw7WczK/jDbRGD+k2jvtrx4tcCibk7Aa52STDdVIb
         iPIO1FJHqec/eDyz5qyxHqj3PBz5G2DEVuBfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptfgZiJrJRT37KV6qx/ANFTtjHXD6glvvm6dcn8VVZI=;
        b=Qqq9fbCjCTR1n7QHeZwF76M0qqzFdGF8B3YMnr2q9qv2gblhsq/DeQSq9fspM0j1Qb
         MNQUtaet06/AZayQDkIW18hDhZ0wpw/tb6snA+muKla9UW8iaumKHPkIRhTELxYZv7rB
         3qGs7Yua3gfhhCPylHh0Zqz0PkoLUvr5SQ7xp6PB9P+NUU+yZwcscgWIFpV9kVLUJO4v
         OQihxDWw1z6K5Gzr8yRFxLbAk7BnRijoBYcys16Zbb3n6LxrxkW3yqmUMxN85nCGqnuv
         o1LN46nE1pMk1K6kApX543H7bg/X2O9aPJZlmUXGNcvkJhy8NptJ2xwlnvZ3hzynTj6n
         nQag==
X-Gm-Message-State: APjAAAUlQSpNFeKQxuvZcZ29ewgdJx69ihJnlFJyabptN5c2GIKE9ABP
        OhY3cPqXUYviBhF1XNktBDTr+w==
X-Google-Smtp-Source: APXvYqymiSpQifawQQU3UdosjYX+3QNdQAwiUyDIgIP9zu5AyARgYX7U0WXOyuAEec5YlMqntyZ0Uw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr19557371wmi.17.1573477518329;
        Mon, 11 Nov 2019 05:05:18 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id u26sm14397929wmj.9.2019.11.11.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:05:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:05:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111130516.GA891635@chrisdown.name>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai writes:
>> On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
>>
>> -    for (zid = 0; zid <= zone_idx; zid++) {
>> +    for (zid = 0; zid < zone_idx; zid++) {
>>        struct zone *zone =
>
>Oops, I think here needs to be,
>
>for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {
>
>to deal with this MAX_NR_ZONES special case.

Ah, I just saw this in my local checkout and thought it was from my changes, 
until I saw it's also on clean mmots checkout. Thanks for the fixup!

Acked-by: Chris Down <chris@chrisdown.name>
