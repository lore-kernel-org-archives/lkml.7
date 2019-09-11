Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3FC49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F06721928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="O7vSUJYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfIKA27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:28:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44818 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfIKA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:28:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id p2so17779553edx.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8SB4Tk4l3jeKDPocoJfwmYuCNKknJ/uXzi9MUO9j58=;
        b=O7vSUJYfnPUXG0tp/46miovofEqAVmv09RS0FZTPuMEvZ5z7tW0dFUhjtX4AFnsVOK
         S6YVHvd6mmWO3RDO/+A5tRumWpX1W53f/vy6z4AphVynuiE6bgIBM/pvlqDL5UE2FOz0
         nBZUEfyvn7slrDo+QGjUairBF747mqSmBNiMJyx8cd6gz9zyde1HgqIImnS0ujA8Kb0e
         4F9Itt2Ukcb1WmIjdqoGVB2dB8d0C5WZdV4ATei9O0x79JF365pg40bldLMj9zB9ATdR
         /xlA0rfbBsVtndUqVud6GLZAr4NMA8bqE0RpAbu9NTh8T29AICD7RpYHQXYAtf7he8Z7
         5Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8SB4Tk4l3jeKDPocoJfwmYuCNKknJ/uXzi9MUO9j58=;
        b=XyUaJO0SifgQELOpOd1dRlk+ItBV9hugIOBJUOHxYQjSNW5POqYV3RdhycJymLJ0u+
         YD02nXm7pyFWOPkULoAE+Z/dTBAtMeXHE+vfqUBkhWKb7v+MEOTggQBlBop2sFWSi47q
         X0IrCaKDqc1RJjpXkDobFrNDGER5exN2cYN03qMRsA9dOVNDMq+R/47W7dnRvJI7Xqnj
         /dowcna7OkH/dIDZ+fv2N79KLNsPb93juG/FIEqnXd7LFJz0Q5phDmjjEZltQbwuPiz5
         wvwXSGeybje/QkVhU4oWn9JCU+di9QxVglLm62IJQJhr+2Pp4GM9Yz8BXAvWmbacknEe
         xvEQ==
X-Gm-Message-State: APjAAAXOdEFDb8cZe+gHeWV+HE2LPdcoFpnDm0bdZFZBkvImR6QE8dqg
        cJ9Bib1cpVpR+ec0gcPK/jrUlQ==
X-Google-Smtp-Source: APXvYqyn7ZSH8gwx4tNCClr9pBsD8GulR9lFMCLyQ3Z2G44KTd3v288hIooAT7V13V6bUpFipq8PQQ==
X-Received: by 2002:aa7:d5cb:: with SMTP id d11mr34147802eds.250.1568161736490;
        Tue, 10 Sep 2019 17:28:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y6sm3816281eds.12.2019.09.10.17.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 17:28:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4D9DC10416F; Wed, 11 Sep 2019 03:28:56 +0300 (+03)
Date:   Wed, 11 Sep 2019 03:28:56 +0300
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
Message-ID: <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910142810.GA7834@swahl-linux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 09:28:10AM -0500, Steve Wahl wrote:
> On Mon, Sep 09, 2019 at 11:14:14AM +0300, Kirill A. Shutemov wrote:
> > On Fri, Sep 06, 2019 at 04:29:50PM -0500, Steve Wahl wrote:
> > > ...
> > > The answer is to invalidate the pages of this table outside the
> > > address range occupied by the kernel before the page table is
> > > activated.  This patch has been validated to fix this problem on our
> > > hardware.
> > 
> > If the goal is to avoid *any* mapping of the reserved region to stop
> > speculation, I don't think this patch will do the job. We still (likely)
> > have the same memory mapped as part of the identity mapping. And it
> > happens at least in two places: here and before on decompression stage.
> 
> I imagine you are likely correct, ideally you would not map any
> reserved pages in these spaces.
> 
> I've been reading the code to try to understand what you say above.
> For identity mappings in the kernel, I see level2_ident_pgt mapping
> the first 1G.

This is for XEN case. Not sure how relevant it is for you.

> And I see early_dyanmic_pgts being set up with an identity mapping of
> the kernel that seems to be pretty well restricted to the range _text
> through _end.

Right, but rounded to 2M around the place kernel was decompressed to.
Some of reserved areas from the listing below are smaller then 2M or not
aligned to 2M.

> Within the decompression code, I see an identity mapping of the first
> 4G set up within the 32 bit code.  I believe we go past that to the
> startup_64 entry point.  (I don't know how common that path is, but I
> don't have a way to test it without figuring out how to force it.)

Kernel can start in 64-bit mode directly and in this case we inherit page
tables from bootloader/BIOS. They trusted to provide identity mapping to
cover at least kernel (plus some more essential stuff), but it's free to
map more.

> From a pragmatic standpoint, the guy who can verify this for me is on
> vacation, but I believe our BIOS won't ever place the halt-causing
> ranges in a space below 4GiB.  Which explains why this patch works for
> our hardware.  (We do have reserved regions below 4G, just not the
> ones that hardware causes a halt for accessing.)
> 
> In case it helps you picture the situation, our hardware takes a small
> portion of RAM from the end of each NUMA node (or it might be pairs or
> quads of NUMA nodes, I'm not entirely clear on this at the moment) for
> its own purposes.  Here's a section of our e820 table:
> 
> [    0.000000] BIOS-e820: [mem 0x000000007c000000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002f7fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000002f80000000-0x000000303fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000003040000000-0x0000005f7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000005f7c000000-0x000000603fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000006040000000-0x0000008f7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000008f7c000000-0x000000903fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000009040000000-0x000000bf7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000bf7c000000-0x000000c03fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000c040000000-0x000000ef7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000ef7c000000-0x000000f03fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000f040000000-0x0000011f7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000011f7c000000-0x000001203fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000012040000000-0x0000014f7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000014f7c000000-0x000001503fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000015040000000-0x0000017f7bffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000017f7c000000-0x000001803fffffff] reserved

It would be interesting to know which of them are problematic.

> Our problem occurs when KASLR (or kexec) places the kernel close
> enough to the end of one of the usable sections, and the 1G of 1:1
> mapped space includes a portion of the following reserved section, and
> speculation touches the reserved area.

Are you sure that it's speculative access to blame? Speculative access
must not cause change in architectural state.

-- 
 Kirill A. Shutemov
