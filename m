Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8217C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E78222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbh0gee5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfIZV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:29:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36668 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfIZV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:29:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id h2so568820edn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XhbcEFMCrUOyRJ7vn2d6dQlPX6QvdKDh8uJ22uRPbM=;
        b=nbh0gee5ixe+jBwG+DzwSAU7539u93HYZVDedMx6/lpFPM9q0jBLeUSblHo+wGCNfa
         k9uPIzLRlJPY3YD+cKH5z98K4qltJ0lYcv20rd/MZx9CWsQUXA+n5puWsBV4iUUTkK+u
         VAavvjrnW1XFvfb6gY1kmmVljdsXAgzKLcNzbp5A+wYVlbkIjxEu5rzv1iTXYxxTS82k
         9BOhm83Pqg3ov/r0q1rf5o3uNQTYywxfTi9P+QkpCQeEO7q9ckb2F6zHwCNlbp4aVzNv
         ibQWQ7vEdEgtNtfzPbrY6AeqcO2ZH6AG/Nbg5hUYMbXWpAv+ocNJBZfk2b6IbU4uBo4E
         IPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XhbcEFMCrUOyRJ7vn2d6dQlPX6QvdKDh8uJ22uRPbM=;
        b=iy9UK0IQWOI916Afvao9nD1CUX23NQ6SHLV777IqNY+9k2kzy8Etb31H8Ki8YVh3vL
         UR9T4O9cTnVTzBHjKXspblQz8jyjql50lwuf5d9lPmH9WhCphQXt+UywkMoAEAFAkUCx
         29rwqyzwl5lStDfJgBlzJUb/xJJoRvaA/QrvqbXQ1VHqfmjLXQsOWtDw/BXLqTr0K++V
         XcsLFbPyE+FpMg4OuktAPyTKj3KKM4YuRSeN2zHFP5CkYTpPjbfwfTYpRio4uLlcbAVO
         TDKNtuVRn3UzfmD4gQdWVU5VVqfOakjQM/c18aWJXzPNKhcvupEKES9bL7g+Wbd4A04K
         51fg==
X-Gm-Message-State: APjAAAWsOHASVJbgVt6wrLF3QfajwAPbuiTs3LDuGMMADZc6aRHMdzWq
        qrowpYGVYtf+BR5o+EQPQf6DxwCk
X-Google-Smtp-Source: APXvYqzxCWAoS24MIqYFeCsqPCKwdoSlL8sQebKqzDTHXbIH/rD0R5WOG6vk60Jgc7PS9mqis3/5QA==
X-Received: by 2002:a50:a7e4:: with SMTP id i91mr1062570edc.9.1569533360887;
        Thu, 26 Sep 2019 14:29:20 -0700 (PDT)
Received: from desk.local ([2a02:a03f:4080:1900:5de2:f287:160f:22])
        by smtp.gmail.com with ESMTPSA id m1sm93083edq.83.2019.09.26.14.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:29:20 -0700 (PDT)
Date:   Thu, 26 Sep 2019 23:29:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: resolve most warnings from sparse
Message-ID: <20190926212918.w2i6wigveopngtnm@desk.local>
References: <alpine.DEB.2.21.9999.1909190125400.13510@viisi.sifive.com>
 <20190919173142.GA26224@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919173142.GA26224@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:31:42AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 19, 2019 at 01:26:38AM -0700, Paul Walmsley wrote:
> > 
> > Resolve most of the warnings emitted by sparse.  The objective here is
> > to keep arch/riscv as clean as possible with regards to sparse warnings,
> > and to maintain this bar for subsequent patches.
> 
> I think this patch does just way to many different things and needs
> to be split up into one patch per issue / code module.
> 
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/entry.h
> 
> For example adding this file should be a patch on its own.  It can
> also move to arch/riscv/kernel/ instead of polluting the <asm/*.h>
> namespace.  That being said I'm not sure I like this and the
> head.h patches.  Just adding a header for entry points used from
> aseembly only seems rather pointless, I wonder if there is a way
> to just shut up sparse on them.  Same for most of head.h.

The pseudo-specifier '__visible' (for __attribute__((__externally_visible__)))
is defined for this.

Best regards,
-- Luc Van Oostenryck
