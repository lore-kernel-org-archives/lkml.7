Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C980CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82DB21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UuJXdNFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfKAJMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:12:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37595 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfKAJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:12:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so6752076lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XlvIQVFH0OsvvtfZAtH/Qzezeu3c9I63M8S4KPzBTmI=;
        b=UuJXdNFjFQHl67JtwQY9epQ7JZlX/qPb15ER8c6Lqil7fRSMcWNmfwOoeV2vHvtVIf
         MQprOmpD0hwsPPFv2gxzxn4Ufk5Qeavun2lFUk2TgV9/BJmHdQ9LjJJ4cLQHvBjOt2iq
         7InLsmyICkBrD2SFovxTIo55dNntzl9yo0IcQEGHox/sHEWXjP92g9WoW1Z/R7RjoyCR
         dw+A/DYMa1eBrvJi7jIO94xX+0zK2qTl0s4ygNxkGhD9Tvg/jlXPIsDkskH/BRFS0OFW
         rBmZ4ZqdBwG72D4QcTsAOtQDJM+k21sLl7cD2V9ljZhidt0HoZbQbczQibBO+ANCIENx
         R3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlvIQVFH0OsvvtfZAtH/Qzezeu3c9I63M8S4KPzBTmI=;
        b=cLvh5jKFKprT8j/yHLwDVYBdya8auSPbaNMSayX6/sCbpfQn35XnbUrs+KF2MLg0J8
         LYnSOPQPrtSFJ+vwxZ3VXBlExTzsW3gF0TLV1R7VIqK9/Ve/9U8gTxBXPJC+7XeHSCzs
         SMLUSEUgSSdlaP+2+5amwyzELAXK9PKQy9OCdIXOPqjYFqsI/4huVg22p33VW7eKaNxS
         MDCPC2xqOF6fEhmEm4OxBpmt2To8bi6YQyCNDegFXpmf5KebUm05dPrDnLL7jvC/JHkK
         KLr5ufun5N1Ou+pKJkq0YmH9eoIeyPmH1SLPFfRey+EroZKL8Z9rL6d7ZU2d+nYxb8+E
         7U3A==
X-Gm-Message-State: APjAAAWYfG04x16mfaieIshe6ou1g0h+loBQpIbtzj5mNksX3KcTOAMh
        jwAcFs6GhCL1hUTSbOgsvz2KWA==
X-Google-Smtp-Source: APXvYqz/HnRIkMMRi6lyXHmUXuPZQAZA0KSr/y66JRxF1fApobZgQwfrztMJrO8lOUblE8ZNClOn4A==
X-Received: by 2002:a19:6b04:: with SMTP id d4mr6761779lfa.10.1572599518710;
        Fri, 01 Nov 2019 02:11:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r1sm2237427ljk.83.2019.11.01.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:11:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3778110134C; Fri,  1 Nov 2019 12:11:57 +0300 (+03)
Date:   Fri, 1 Nov 2019 12:11:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 01/13] alpha: use pgtable-nop4d instead of 4level-fixup
Message-ID: <20191101091157.q4cesn6vsiy5qj2j@box>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
 <1572597584-6390-2-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572597584-6390-2-git-send-email-rppt@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:39:32AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> It is not likely alpha will have 5-level page tables.
> 
> Replace usage of include/asm-generic/4level-fixup.h and implied
> __ARCH_HAS_4LEVEL_HACK with include/asm-generic/pgtable-nop4d.h and adjust
> page table manipulation macros and functions accordingly.

Not pgtable-nop4d.h, but pgtable-nopud.h. Also in subject.

-- 
 Kirill A. Shutemov
