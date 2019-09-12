Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F446C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5467A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AcI2st//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfILWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:03:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46045 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:03:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so25268085eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTWV1PHcMEZ2tbHQyGgaAoapUOFSMA5nnel0RfApA0E=;
        b=AcI2st//s7n3ZrHz8WLwiHbmc2jnUg5v13wcOd1sC2QkwHQZjydvXULqxgf/SF4aIB
         dclVTAEqacQ5lCUFizMddS/QDH8TFl/+UF7MNgHvCmYDOHXLOxpqedBkBio8uST6MZU9
         YBfPB8E8poBlj7f5ytBkyyXHubJmae2jDgUAni+ikEJmRqYL9DrpJfggnFJCnfVNuww+
         8DWqmaAqGzz07AP8SqBFQrhYUKY64+mkFzOTdwpjxoGJgri2iBNVeyjO8Zvx+CVYFf2v
         UYYlAO66G6T6KooDMFOwk6XKQ2Ftu6WFm2Lb3mDbw8Od+hABeUKpE4sN0bvDRjeFBTUn
         mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTWV1PHcMEZ2tbHQyGgaAoapUOFSMA5nnel0RfApA0E=;
        b=q1QvX64dFyjwxjrRjV3CRhd3GkCZ8+tjOXfEAQzNb6WkuRUHbgsrGPp+H3FmA7emvq
         YsvwJGOkkey7vD/mPbpp7u5vxBO7k2oFYO4yQwXZeRj+QFdz5h5iH4dqwzrEaVi3fBsE
         8ZxNDQJHn/VVcN0nVqUf2ZwJhq9HuZTSt9ixLabIi+M6pt205UmMh/IUCh3BtzgMPT6F
         oWMS2LsAZNt1VWa2OeeyRjPQlGXBv9Uq89lwOcu501eyHHYThX4pZNA8L6dR28mxiepP
         qxSD2wjssmL6UQyWLZu3UJKUJtBSb229PutqB/Ziu0iooAyixJJNxldaJg6RbIrsOoxn
         iN8g==
X-Gm-Message-State: APjAAAUNX2x9DQM4McdDrwL4mOAw2AWXRVpZRK4i9NcupmaVK5F81nlA
        V8D50jqQfYgv8ItoveZiHWqexdqUm+Wr+Q==
X-Google-Smtp-Source: APXvYqyoc8ULQxeX19cY3FEvwSeitz/LG8gSM7GyDHW82lvtFykJW9m5rO/8I9elKLwTU3lUvgItqQ==
X-Received: by 2002:a50:e885:: with SMTP id f5mr43584966edn.163.1568325784405;
        Thu, 12 Sep 2019 15:03:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y5sm4996612edr.94.2019.09.12.15.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 15:03:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E1E9B100B4A; Fri, 13 Sep 2019 01:03:03 +0300 (+03)
Date:   Fri, 13 Sep 2019 01:03:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: correct mask size for slub page->objects
Message-ID: <20190912220303.ijdwnoxiwgv7mmv4@box>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
 <20190912094035.vkqnj24bwh33yvia@box>
 <20190912211114.GA146974@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912211114.GA146974@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:11:14PM -0600, Yu Zhao wrote:
> On Thu, Sep 12, 2019 at 12:40:35PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 11, 2019 at 08:31:08PM -0600, Yu Zhao wrote:
> > > Mask of slub objects per page shouldn't be larger than what
> > > page->objects can hold.
> > > 
> > > It requires more than 2^15 objects to hit the problem, and I don't
> > > think anybody would. It'd be nice to have the mask fixed, but not
> > > really worth cc'ing the stable.
> > > 
> > > Fixes: 50d5c41cd151 ("slub: Do not use frozen page flag but a bit in the page counters")
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > I don't think the patch fixes anything.
> 
> Technically it does. It makes no sense for a mask to have more bits
> than the variable that holds the masked value. I had to look up the
> commit history to find out why and go through the code to make sure
> it doesn't actually cause any problem.
> 
> My hope is that nobody else would have to go through the same trouble.

Just put some comments then.

-- 
 Kirill A. Shutemov
