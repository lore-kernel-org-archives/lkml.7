Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E9AC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Z19Eg8Zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCAWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:12:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38652 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCAWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:12:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so12072254pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 14:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgavR2DFMNaf/vLZRKzzbgkI0A+HRsMgfHhmYXn8qi4=;
        b=Z19Eg8ZmrghAT9eBXNyLpiI/7ERPMdrWg5DQeGPgeU16srlz6HQsrx0aMgpqjuLQlQ
         cwbxb5u1F8g9p0jGQhOGqdRT8+YRzUxZtcL2tTYYl+0i4zMOLlAw/Af8ZGXeRAIdZkab
         gN+a3UjlXLRZHSea7cTKzQFud5aqbi+g0zUUKlvey6DJkNLE6G9ETpnNO7MBSOXeM3wr
         YKObJWB40lILN3qaxB1hHcrNQIOwHAH3mKe0qJ0CvTkVSAilzXaGHLK40B7wJz8+gdTn
         9YYxqtRcctZhiS4IrS+9+grY1WqYPiU8o8Wn+r+AHvg+kFW6HONdnYpr0XSiKODtNPNl
         SyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgavR2DFMNaf/vLZRKzzbgkI0A+HRsMgfHhmYXn8qi4=;
        b=a8yre4raNYn8h7GBy97gKt0zd9JoHNBE12R0ouMU4lEWXJD7QBtU4pfgzwvg/3cX0u
         L/rN5ZY0vAWK2aPaKI8N5NV5OwoyoxpN50Fh4FvLCfTxBhxvCc076TNbOaUQ5xm/1iag
         4lmgjiu3urtUui9HJOzXuToKy/e7INzFKzrLtyXNE2g+8k81nt3DEM2sE2QTGhdRLBf8
         LrdRDLqtb1sZIT1TUIN7nz98QBGE0LFrDye9RZi0ZOvVqkseGSJ5koE7eDVCO3IGvrrd
         c4EOGW0E2cpK0tDEl/ltxjlvbTMrcJRVkemIP/DCer+Ca8bk46bzr/pyHf1GjQ0dlkjG
         S4Jg==
X-Gm-Message-State: AHQUAuZuJkDu9VjZGUtN5EBWaRk/5FRv3RIhqldyOGCW5qGSGpCUS7+g
        zBiBUnJKQNJIZ9dA7euhUVB7uA==
X-Google-Smtp-Source: AHgI3IYTSxYFj6M42G+F5q8mktYtGtp45mqV2dSA6y4kEmnaHrlMPzNlAqdKw3hK7RfzKI6R5msSYg==
X-Received: by 2002:a62:ed08:: with SMTP id u8mr7944175pfh.200.1551478337753;
        Fri, 01 Mar 2019 14:12:17 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id l5sm29968347pfi.97.2019.03.01.14.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:12:16 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2E4AB3007CA; Sat,  2 Mar 2019 01:12:13 +0300 (+03)
Date:   Sat, 2 Mar 2019 01:12:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Helge Deller <deller@gmx.de>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 15/34] parisc: mm: Add p?d_large() definitions
Message-ID: <20190301221213.snm7cwowr67pdifs@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-16-steven.price@arm.com>
 <fa3072ba-f02b-fee5-dc16-d575a5308d4b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3072ba-f02b-fee5-dc16-d575a5308d4b@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 07:54:22PM +0100, Helge Deller wrote:
> On 27.02.19 18:05, Steven Price wrote:
> > walk_page_range() is going to be allowed to walk page tables other than
> > those of user space. For this it needs to know when it has reached a
> > 'leaf' entry in the page tables. This information is provided by the
> > p?d_large() functions/macros.
> > 
> > For parisc, we don't support large pages, so add stubs returning 0.
> 
> We do support huge pages on parisc, but not yet on those levels.

Just curious, what level do parisc supports huge pages on?
AFAICS, it can have 2- or 3- level paging and the patch defines helpers
for two level: pgd and pmd. Hm?

-- 
 Kirill A. Shutemov
