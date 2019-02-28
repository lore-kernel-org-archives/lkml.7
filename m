Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537342171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1Iy1vPY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfB1JzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:55:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45418 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfB1JzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:55:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so9438764pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IYFu92nWvBmdxQNEDlDKsadOrpVKHBcKExiWV8cw1Ps=;
        b=1Iy1vPY0XxgtinRImQzB4qrNv+bS/wouWUMdfL+/3hb+A2VP1tul5bn+J4H7EEuemx
         F/gZX+PyToS5Ti6kkMBTtODDw943LEj+qcDP9oOEtx19IgE7Lt6+9H6ks8lRXy+DSL5n
         N6zCuXTUkKSZSXAsr0DOwbRieutm4gGH87ANQheWym6xcSXRm+ig2Jp7id9cCZohZ8uA
         MuFkikO2I/8lM3JJ19R0Un36ij3AHVZCVcCTURag1KxNhv/q9lDw1tE9+AI5qxdHZYw4
         uJGgTm5vXh4ib9MyvkSMb3q50s0tXCHi6JH9NE69qUHhJbGwixrtMS89WipU7AfpUbbD
         jk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYFu92nWvBmdxQNEDlDKsadOrpVKHBcKExiWV8cw1Ps=;
        b=FMnlp64RgeAwYQNNBlqON6o9bA9+DfBywaNG4P+6mqPdbZRwEFhVMnEAVcKJD+Orcs
         fdSJqe6dScr68f2uE7lh4JHeLocWoDlDRrI2b0g12qVXHpqWDnyi9krZgZp+UCrxvZAB
         xGbSxwPaC9ESxgGTxwnXe2xlyBhX6yqECspf9wKLbOuYctf2iA6H9pEWl6EoTG8e2Io/
         t3jR7K6V9XecmvK9ROa1othvmbaRDMys1o40Cy0RObwEx6kOeCTpRc1r5q0Ecl5vl9Jm
         ISMvW321kFxE+141VDrRD1IfC3dDDeI/NyX/YxAJregGxM55tEBeMsattrNEkK1Ggr2d
         QBKw==
X-Gm-Message-State: AHQUAuZB1GfcZv5BGLJbLUiDtiFzJwGDK9e2UPAjzcdX6lVVahAasLKR
        CM6JYrGd6tcW8AEncVrvxCnIdQ==
X-Google-Smtp-Source: AHgI3IZFeQ/VK4u9J0spqy9l4nnebuUpweNDWDELgdVK3uaZHIZcFPacYDdjhenoPxjkbmzuIVhqdA==
X-Received: by 2002:a62:3990:: with SMTP id u16mr6560490pfj.80.1551347707576;
        Thu, 28 Feb 2019 01:55:07 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id j13sm19500644pfh.32.2019.02.28.01.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 01:55:06 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A84E43000E5; Thu, 28 Feb 2019 12:55:03 +0300 (+03)
Date:   Thu, 28 Feb 2019 12:55:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228092346.GQ14858@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:23:46PM +0800, Baoquan He wrote:
> On 02/28/19 at 12:10pm, Kirill A. Shutemov wrote:
> > On Thu, Feb 28, 2019 at 08:35:20AM +0800, Baoquan He wrote:
> > >  arch/x86/mm/kaslr.c | 92 ++++++++++++++++++++-------------------------
> > >  1 file changed, 40 insertions(+), 52 deletions(-)
> > 
> > What tree is it against?
> > 
> > I cannot apply on current Linus' tree or tip/master.
> 
> Oops, I put them on my on my previous kaslr fixing patches:
> http://lkml.kernel.org/r/20190216140008.28671-1-bhe@redhat.com
> [PATCH v3 0/6] Several patches to fix code bugs, improve documents and clean up
> 
> There's a clean up there to open code get_padding(), that cause
> conflict in patch 0002. Let me rearrange and repost.

I cannot apply the first patch too. Hm?

-- 
 Kirill A. Shutemov
