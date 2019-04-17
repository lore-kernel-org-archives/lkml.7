Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B77C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4AA205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ti8W5H7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfDQPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:05:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45592 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:05:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id b18so9204819yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LVyq6OE19KhM+/xQW2Gwk2ofoXjKkpXeXhoSwbk5MqA=;
        b=ti8W5H7DMOt1m37y3NdNUhonSIHrqY9ax3MP/DwOqIirdqCPaWRNh3hzf6+dTUS8RN
         6uZ0DRf96ReenpoZExR+2F0t80NQhBLa+i4fSzUdLTUmi+YYSIG5HE0JPpHiFWI9yjAx
         dx9TB/Rb3ISoeOU8AjSFUcKZ7wOwz1Ai+/XYIB097IKpJwt0STBD5PAZ6w3nenElwrfu
         e78xTZYXG5QOFAqCEjvr7e33HmMwdYRqwXfBDCE/QyiUXNzmOnL0Ew7MKuQNUW7qORBn
         wxzISXJV/u9CeTwdsQuTBoL3Mo7RnE9pazUVenDU4BtNNeig9S2lz3y48EAddNRibCbh
         P+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LVyq6OE19KhM+/xQW2Gwk2ofoXjKkpXeXhoSwbk5MqA=;
        b=a6kXw2NVmbgfVyVpEdbhnEFvNxeb91OO9FmZ2+9+zs2/VMaHJY0FwXm1JaLaNkREaN
         NQXsQk8zER+XTXzeehaaYBILCEri5BG+o/FnjcgZpzqN+S0yueuNIL7RayYxCTvIyMPD
         OPsmy61N8p23/dk+0xA04U8fOWk2jnxFmIemwoGkW2gdc0PTAJYuxjbE7+dtuB3hNX/6
         sOwwhJuBw5ymxPasZfeduu7yOc4eaqPEqtONjwZLsYfuKw2RG2HbPa55G6beUbeiOKrr
         6lqDb+TEBzR0n+2Xpg7y7C6qtD3PHnThaBFC9PJuicrgI+b0qeYIHNDEwjmJ5485eSc6
         QGjw==
X-Gm-Message-State: APjAAAX+HaD/vryCmI8SjyYVJ+frBkkSxjaEvaESN4IxBIhqI/NLbf0T
        tDsh5hfFW8s9YaQP06YMEydCsLwJ7WQ=
X-Google-Smtp-Source: APXvYqwnaSGgY+8GXvGpEGOeVdfnmrv02humxUlwDvsTeBJqmXiK044S4LlaabEwB+SWiMHu5SYP8Q==
X-Received: by 2002:a25:2d55:: with SMTP id s21mr71611013ybe.170.1555513554132;
        Wed, 17 Apr 2019 08:05:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:fc54])
        by smtp.gmail.com with ESMTPSA id k123sm19177171ywa.57.2019.04.17.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 08:05:52 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:05:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: fix false-positive OVERCOMMIT_GUESS failures
Message-ID: <20190417150551.GA23013@cmpxchg.org>
References: <20190412191418.26333-1-hannes@cmpxchg.org>
 <20190412200629.GA24377@tower.DHCP.thefacebook.com>
 <0d2ad7c1-4a5f-08b0-0f57-0273fedc4f70@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2ad7c1-4a5f-08b0-0f57-0273fedc4f70@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:04:17PM +0200, Vlastimil Babka wrote:
> On 4/12/19 10:06 PM, Roman Gushchin wrote:
> > On Fri, Apr 12, 2019 at 03:14:18PM -0400, Johannes Weiner wrote:
> >> With the default overcommit==guess we occasionally run into mmap
> >> rejections despite plenty of memory that would get dropped under
> >> pressure but just isn't accounted reclaimable. One example of this is
> >> dying cgroups pinned by some page cache. A previous case was auxiliary
> >> path name memory associated with dentries; we have since annotated
> >> those allocations to avoid overcommit failures (see d79f7aa496fc ("mm:
> >> treat indirectly reclaimable memory as free in overcommit logic")).
> >>
> >> But trying to classify all allocated memory reliably as reclaimable
> >> and unreclaimable is a bit of a fool's errand. There could be a myriad
> >> of dependencies that constantly change with kernel versions.
> 
> Just wondering, did you find at least one another reclaimable case like
> those path names?

I'm only aware of the cgroup structures which can be pinned by a
dentry, inode, or page cache page. But they're an entire tree of
memory allocations, per-cpu memory regions etc. that would be
impossible to annotate correctly; it's also unreclaimable while the
cgroup is user-visible and only becomes reclaimable once rmdir'd.
