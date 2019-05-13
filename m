Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7EC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC43208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfEMMBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:01:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfEMMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:01:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so14962336wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kI2y91RRPGT/5VzkD7OKqqkIDn0uCsHkdT99PzPwrJo=;
        b=m0hhwUpd0JOozw7zGId0rVHR3G1becJo5mwFAg+GrO3QOd/HQ3B6zr9sTh0drCZ6LA
         2RzflfuH4UxEDRoNTYOCbr6jqSADyr/yvgG5aBDhukoIYMumiysTWnZt0ek095B8SfGW
         PUsURYp6fj5O0EwARa6vgz6ZzvTOSK1LgUlBdWRbhTRuYlrTKtuQDgZnoUU9V+f15Lbx
         VcQFsOr/EtvjMY9S5HJpkeD3KXwtD8YSqPA9SyCdzQ2iVFCjNs6fKQNN4yZFZYaKPDt1
         Z5rcB/JXMxGRnRXg+5aav7AMKT9XOHZ41Hh72jodqTh0fji1SVnzdfrj+8Bj+d4RKrHi
         UDgg==
X-Gm-Message-State: APjAAAUo+coBNgwDSvJhz1hZRpz5DxZNJEidvkSjj2tP7d0W9rXTfHk8
        kHMiMIGv4R5rL4qTo7hWt0D1tg==
X-Google-Smtp-Source: APXvYqzzL7E0h8PEfT4wZH/Xu0YiRnxJ/Klb7n0tQrDUCbV+E+/M9iajly6wubYQTlzvmAr0yNz3Pw==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr4611827wrn.289.1557748879134;
        Mon, 13 May 2019 05:01:19 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j10sm44012622wrb.0.2019.05.13.05.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:01:18 -0700 (PDT)
Date:   Mon, 13 May 2019 14:01:17 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Timofey Titovets <nefelim4ag@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190513120117.aeiij4v2ncu43yxt@butterfly.localdomain>
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
 <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
 <CAGqmi744Vef7iF0tuBO3uBtXbNCKYxBV_c-T_Eg3LKPY0rKcWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGqmi744Vef7iF0tuBO3uBtXbNCKYxBV_c-T_Eg3LKPY0rKcWA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:48:29PM +0300, Timofey Titovets wrote:
> > Also, just for the sake of another piece of stats here:
> >
> > $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> > 526
> 
> IIRC, for calculate saving you must use (pages_shared - pages_sharing)

Based on Documentation/ABI/testing/sysfs-kernel-mm-ksm:

	pages_shared: how many shared pages are being used.

	pages_sharing: how many more sites are sharing them i.e. how
	much saved.

and unless I'm missing something, this must be already accounted:

[~]$ echo "$(cat /sys/kernel/mm/ksm/pages_shared) * 4 / 1024" | bc
69

[~]$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
563

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
