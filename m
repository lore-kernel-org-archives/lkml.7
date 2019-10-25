Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C200CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E5E21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="L75ud86K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395428AbfJYPgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:36:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40581 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJYPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:36:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id u22so3206469lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VlfRIm/IUQoWr2pXkJdNPTQB7pso0Fzi7iIhyuUYMCY=;
        b=L75ud86KWGPHxPbqsE9fYUV589praE+7kUBzz8/hFeYfnkE8fGeAHqRdb8aN8jIm4w
         zwageU2OR8t7hf7+ngdaTZtqyGunHZMDWOLObCvkvSlTGjc55LsULJyClg+ttQAlqI32
         pLuSMdHO/IwduciZYA4QMk0OOMeuslnCC+VtWuqmJ6ntQHMdHyB4viEdkQ7PhNtp2e3W
         fclXfviKT7AjiDJ7QddXszNO6UWj2BCAzJQFg+vFW6ZKUz5o/PrYPFOCggvaLqeniVjp
         m7Pf3AW42s/vOFU0xM8h8oA+pYErBikv9SL3yl4hol4RbFGyh1714xhDJ/iWhHxm2uj3
         cn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlfRIm/IUQoWr2pXkJdNPTQB7pso0Fzi7iIhyuUYMCY=;
        b=t/1xKY22z0lP5TI1s0wugZPjLVbLxCejnUg76FHnvNk7T/evPlZsY8ED79OXMcy5Uu
         riPuFUZcLsZpQKglaenGaIKGfSS0DewCGxQ9v+FRpjzgLw8JhXqt8M7qRIi1jF6T+/Fy
         jjDbT7ptFHVaooZRUkrwh/p9MrWp0ksh5fbfGXaIW1T6ZXx+kP2LHX0XW7cFf/wz28aY
         htJd10FX5UEIJNhg3v4uLJHLFbIVf4CqY6QSz07yR8RFlryQhCCOzvl0zRbgG19MyEEN
         b3l5iGy3x4n7qWXx1BtN3IFTHNryWSo88qr347rOg3fdZO1YT39ytFJnOEWvo7TP7zBk
         iL0w==
X-Gm-Message-State: APjAAAXCc06M8TqulEz7OFxdmI2EqffVUaa8jrX6CK7QEXT/XRw6hK5+
        ZPoHF5fxyDmsxbWhNzuKLKIE6A==
X-Google-Smtp-Source: APXvYqxRA08GLyrFbHx8Xl51vJWvwsWvNv8hMTj3SCmTGJGUX46vOnxceXakMrAQ4rUIrnz2oASJvw==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr3037222ljb.51.1572017780299;
        Fri, 25 Oct 2019 08:36:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b6sm1066987lfi.72.2019.10.25.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 08:36:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 04DB810267F; Fri, 25 Oct 2019 18:36:19 +0300 (+03)
Date:   Fri, 25 Oct 2019 18:36:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map
 gone
Message-ID: <20191025153618.ajcecye3bjm5abax@box>
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:27:46AM +0800, Yang Shi wrote:
> File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
> the flag is never cleared until the THP is freed.  This result in
> unbalanced state although it is not a big deal. 
> 
> Clear the flag when the last compound_mapcount is gone.  It should be
> cleared when all the PTE maps are gone (become PMD mapped only) as well,
> but this needs check all subpage's _mapcount every time any subpage's
> rmap is removed, the overhead may be not worth.  The anonymous THP also
> just clears PageDoubleMap flag when the last PMD map is gone.

NAK, sorry.

The key difference with anon THP that file THP can be mapped again with
PMD after all PMD (or all) mappings are gone.

Your patch breaks the case when you map the page with PMD again while the
page is still mapped with PTEs. Who would set PageDoubleMap() in this
case?

-- 
 Kirill A. Shutemov
