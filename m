Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2ADC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B05F21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Tuxr/W+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbfIIIOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:14:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42375 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfIIIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:14:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so12098733ede.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3sstLaCSj7E9ixnuxLxjeWVyAPlT7tlX/zmEc4rhUw=;
        b=Tuxr/W+L5TAU8+6Vm+I9McgdhVgIlvuIYrXGgGQvPV4/y8/zeDZhxsvyLamjRdxe/g
         HExvm6QBvbnQTsywBSzH9nq1RigXpCG2M+hUTB7OL4LREEnkNWFAkWZgfffXtdZhmXco
         CE1slF5ReB+buKtl3MkOOPaEdBy4Zlg5vZG7wb9KxqHeuDsH1pd6EmLS47VLC0DSr6yV
         9QPBLl+n6/9icBnzGN4/fBDSRItWsmtbhe+z67qSlSxCQpBHgHbD2h5tBuQrDP3I2d1+
         bJ9u2mfhH4PxleS/+fgf0KPceePRvnztQ62EfoSHBYI9XxfVc4TB8+EX5zOypJolh63+
         sGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3sstLaCSj7E9ixnuxLxjeWVyAPlT7tlX/zmEc4rhUw=;
        b=W+Vz7ZvjxJ2nqrNe8O1VlwWyO3M0U0V7J74xsicSgIhDauj0/9WEJ0XoNQnNz8CQ1s
         CFaiWTWXaCyf+Ecl3VvdTVIOLyPltk+qaVernQ8klIITCyiJO3017EKTB0UqozG2I8ns
         OBD6lKYU+bCHws8qOKKdlcGZjjuhjnp0DEcQrEJGFkF9dHXK/lsAvr6rtXLQ5dVt4DYC
         o4lNyJkcLYQBj2we2DDQ4/Svu1P9c9hXty+EETF5wSEAegiAl5wZ8h0ylYav9b2P4lQG
         opLUfxPBO0YvQVIRcunsnYBnS/NxPvoySZmDgbLG3J6FkTtfYl34RRkbAV3oGXZNH4jz
         HWNw==
X-Gm-Message-State: APjAAAWpxi/q0uRB3HI7UJtEXYKJUalAlfrnb3pOweBD3ejXev0S2ja6
        1HCrqA8mNhRVz+H2tbqkAsTrpQ==
X-Google-Smtp-Source: APXvYqweRKGevLavkl4ZwLj6+I5IFRISBwxsgFxQZWj+hwVGL0+5744/TaWTJ9rn2ZVoeewXWz8byA==
X-Received: by 2002:a17:906:128a:: with SMTP id k10mr1066306ejb.9.1568016856153;
        Mon, 09 Sep 2019 01:14:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bm1sm2835501edb.29.2019.09.09.01.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 01:14:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4514F104AE4; Mon,  9 Sep 2019 11:14:14 +0300 (+03)
Date:   Mon, 9 Sep 2019 11:14:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190909081414.5e3q47fzzruesscx@box>
References: <20190906212950.GA7792@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906212950.GA7792@swahl-linux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:29:50PM -0500, Steve Wahl wrote:
> Our hardware (UV aka Superdome Flex) has address ranges marked
> reserved by the BIOS. These ranges can cause the system to halt if
> accessed.
> 
> During kernel initialization, the processor was speculating into
> reserved memory causing system halts.  The processor speculation is
> enabled because the reserved memory is being mapped by the kernel.
> 
> The page table level2_kernel_pgt is 1 GiB in size, and had all pages
> initially marked as valid, and the kernel is placed anywhere in this
> range depending on the virtual address selected by KASLR.  Later on in
> the boot process, the valid area gets trimmed back to the space
> occupied by the kernel.
> 
> But during the interval of time when the full 1 GiB space was marked
> as valid, if the kernel physical address chosen by KASLR was close
> enough to our reserved memory regions, the valid pages outside the
> actual kernel space were allowing the processor to issue speculative
> accesses to the reserved space, causing the system to halt.
> 
> This was encountered somewhat rarely on a normal system boot, and
> somewhat more often when starting the crash kernel if
> "crashkernel=512M,high" was specified on the command line (because
> this heavily restricts the physical address of the crash kernel,
> usually to within 1 GiB of our reserved space).
> 
> The answer is to invalidate the pages of this table outside the
> address range occupied by the kernel before the page table is
> activated.  This patch has been validated to fix this problem on our
> hardware.

If the goal is to avoid *any* mapping of the reserved region to stop
speculation, I don't think this patch will do the job. We still (likely)
have the same memory mapped as part of the identity mapping. And it
happens at least in two places: here and before on decompression stage.

-- 
 Kirill A. Shutemov
