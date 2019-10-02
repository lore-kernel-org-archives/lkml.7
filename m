Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6864C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E7921D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570038770;
	bh=Z2SsTFY+QfGyIbZTlz/iR0YcIoelgwaEwA/fgK6+33Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FXda3E/iQXpkebfZPMjKQ3xO8IlYebUmfMLa8pdfJjPFTGyzO8F0FSVr8F/lq1PqD
	 ksPHB4XNj94PsbG2MwaZ9JKGHoY3wiKI5MnTe9b5BxeSLra8SzenNlZQWQzl7zusRH
	 XjjHO6gq7/mQ8mGL4mbdLnPvTfhzXfe+y8bT4R/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfJBRwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:52:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45062 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfJBRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:52:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so13369259lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0VOcSracTGyf4mK2cc8NxpSFCIaTLGVQfCgFGzC2+os=;
        b=Da0ulCjd0PWlr56Q/iV7hdkQdtwUT8ixbTGX4LSwlckf+LITNN+ccC7tnrfWsIqQ4r
         JnegAs8ZTFN9xZOuObzFgcKxcd186SCrtXmPd6NGd53CGHLFSbmJJuT9KnKj5cBidD3J
         5wEL+dn/3c15t74OVss9Lc34yPo5x+E/J4t6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0VOcSracTGyf4mK2cc8NxpSFCIaTLGVQfCgFGzC2+os=;
        b=GCrDONg4BUCyrbD5xAX7DHnHaeiIcVTdl0NVFIqe2WOrCnr3KeK3AY0fNb+ZfgOilU
         hDb4oagnllhwVkwKwBPTOW/ArPqXrdjPeL9Li3zA9e1nc3XGUQ9TzSrExVoQhL85Smj1
         uY9j/Lvx5SyDTJOBFlzE6BXV2O6LPv+LIiSw1Fodq7pCr3nwVyy6IS2DY0SDRhZzrCbw
         pQHcO0kEKD1gCMWGzd6MvoE/YRKMPd0UAL0ACXeHY+IBD0Z5bVhnQkFbXs/vkNTp2KJX
         xRy+KiNAOjzAEqv2Wy9yosjy/283HJELgxZc3+awF6dbjCJIPC6J1oV9mOlCQyhsbe6p
         Jj4g==
X-Gm-Message-State: APjAAAXNx29wZr5ReCEMC2gE9Y+GJ9AunxeE8T1zjPpxBoTJn/eSUT2Z
        vXzEPT8giSzr4wrU1AfZ78FrPX9BYi4=
X-Google-Smtp-Source: APXvYqxbsmygGqfqY+yp8zJ/I07y7HUzxmlL34sTtJ/UEZ8Vw4b/F6feanj9/+DN7zS9LGqe11Ik3g==
X-Received: by 2002:a19:ca07:: with SMTP id a7mr3337630lfg.181.1570038767091;
        Wed, 02 Oct 2019 10:52:47 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c69sm25722ljf.32.2019.10.02.10.52.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:52:46 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f5so18080621ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:52:45 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr3363688ljf.48.1570038765543;
 Wed, 02 Oct 2019 10:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191002134730.40985-1-thomas_os@shipmail.org> <20191002134730.40985-3-thomas_os@shipmail.org>
In-Reply-To: <20191002134730.40985-3-thomas_os@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 10:52:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjJ-jOz0SDJXt-+=ezjFy8ZCGXrqnnsoVocO+toxWSmw@mail.gmail.com>
Message-ID: <CAHk-=whjJ-jOz0SDJXt-+=ezjFy8ZCGXrqnnsoVocO+toxWSmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 6:47 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> For users that want to travers all page table entries pointing into a
> region of a struct address_space mapping, introduce a walk_page_mapping()
> function.

This looks non-offensive to me.

My main reaction was "oh, really good that we split up the walker ops
from the mm_walk structure, this would have been much uglier before
that" due to the added vma entry/exit ops.

           Linus
