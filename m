Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D2C31E4F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D821841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yX+cOzz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfFNWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 18:43:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35671 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfFNWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 18:43:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so5660116edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+zbZlurnvydl/6SQ6CAVUk3op7xjOMn2bTLkOUdsIE=;
        b=yX+cOzz8Sxb7/voZ95Esa2tAFIQ4ZDV+JXtp2AqsXPwtzu00IC7YhwUjTqMSZmmDWG
         jyJrN1VeTCeyuHxyQHWRxyzsfTK23n488pO5wGs9FVsSgFSo//1oSd4n0Kcztkx5qY41
         UW1blc0iLoR//CqQxKecxSMwZ5tv+cqyr60vaqn9mFiRh3ods3UnncsNCUptxHe2aL/a
         hiU6Da9QXyXnFfdPu4umhw6Wmt40nfUTwgU2EkPwHa849X1gd/4ve4pGxQhIudmyLuRF
         6g0gnjJHItqyD2iY7f5DPjM0W4SSILwtM4oAyxobutdvFsFYJwzeKyVqsk9sw9zu8ONX
         LzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+zbZlurnvydl/6SQ6CAVUk3op7xjOMn2bTLkOUdsIE=;
        b=nPbzR/QJtE0OJ9/fiwBcvxFH6JBHy/dHE9VrSA/bddr3gmTgOdXpff4kWto8/Clsx4
         SXT67zMiWy+Tu2l1NcUOJegP23Js0Gbe10sSjZAxKZcDDbgn+A8BaymiQnUpsVMJTgjA
         cL1FfuLMJGtvAdKXBqMyuwccZ2XoCnAaXJFnUDcREyh3s6U6xRmNISpNIWL9K+MUloiV
         wlTixBO2/OQfliAg9QAYr20XgeYK2V7N+51HvOMmx1EanNFfZM8GJd20P3ZV2Jz+M4JT
         kil2AzW+iVMSkdkZQ8mzhx5u7WxsgmUwh+EhHBNVPiMuJwRWA06Jqt/7/EUrRt15UfEY
         hcEw==
X-Gm-Message-State: APjAAAUhITGigjr2Tlj+MWRDk4YNnpdnu+0gv8F6KvKLdnULm3+W6wkw
        wFtXbbHdD+FmjeUyWo1Emz8EUg==
X-Google-Smtp-Source: APXvYqw9qKi1+ylGIvjwojh4i4QzrWkN08hFImxH0eZYpGMAfqyAEToAzK6czxnnTAxd1f84jFyajQ==
X-Received: by 2002:a17:906:4e92:: with SMTP id v18mr28509947eju.57.1560552189912;
        Fri, 14 Jun 2019 15:43:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g37sm1360017edb.50.2019.06.14.15.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 15:43:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6DB911032BB; Sat, 15 Jun 2019 01:43:09 +0300 (+03)
Date:   Sat, 15 Jun 2019 01:43:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 18/62] x86/mm: Implement syncing per-KeyID direct
 mappings
Message-ID: <20190614224309.t4ce7lpx577qh2gu@box>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
 <20190614095131.GY3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614095131.GY3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:51:32AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:38PM +0300, Kirill A. Shutemov wrote:
> > For MKTME we use per-KeyID direct mappings. This allows kernel to have
> > access to encrypted memory.
> > 
> > sync_direct_mapping() sync per-KeyID direct mappings with a canonical
> > one -- KeyID-0.
> > 
> > The function tracks changes in the canonical mapping:
> >  - creating or removing chunks of the translation tree;
> >  - changes in mapping flags (i.e. protection bits);
> >  - splitting huge page mapping into a page table;
> >  - replacing page table with a huge page mapping;
> > 
> > The function need to be called on every change to the direct mapping:
> > hotplug, hotremove, changes in permissions bits, etc.
> 
> And yet I don't see anything in pageattr.c.

You're right. I've hooked up the sync in the wrong place.
> 
> Also, this seems like an expensive scheme; if you know where the changes
> where, a more fine-grained update would be faster.

Do we have any hot enough pageattr users that makes it crucial?

I'll look into this anyway.

-- 
 Kirill A. Shutemov
