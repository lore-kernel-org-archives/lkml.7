Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204052173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qaww4cNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfLLURy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:17:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfLLURx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:17:53 -0500
Received: from zn.tnic (p200300EC2F0A5A00BC9FD9E905C0F14B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:bc9f:d9e9:5c0:f14b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97E3B1EC0B73;
        Thu, 12 Dec 2019 21:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576181872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=itHJwNSnRzhYkPr455TQi6sn3XUABqQNepfDBG4er7U=;
        b=qaww4cNuNKxdDgpKW4MIuYJKiUAWQU6u70wZjCOHIrR9C26Qj4imHqNbzZiupLu2bZZCZL
        BfA5Rx9yG4HIXbCiYIxKKuTL+0UvNlj0Yhj4F/iWXzblLyJXew0+3CQ56TORbPxPgHqK6E
        LVvfWp6APmcYkHu8MfcAuNSLYyCSxbQ=
Date:   Thu, 12 Dec 2019 21:17:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Adjust the padding size for KASLR
Message-ID: <20191212201746.GJ4991@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115144917.28469-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:49:13AM -0500, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> The system sometimes crashes while memory hot-adding on KASLR
> enabled system. The crash happens because the regions pointed by
> kaslr_regions[].base are overwritten by the hot-added memory.
> 
> It happens because of the padding size for kaslr_regions[].base isn't
> enough for the system whose physical memory layout has huge space for
> memory hotplug. kaslr_regions[].base points "actual installed
> memory size + padding" or higher address. So, if the "actual + padding"
> is lower address than the maximum memory address, which means the memory
> address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> the overwritten.

I can only try to guess what this is trying to tell me so please rewrite
this using simple, declarative sentences.

Use a structure like this:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, when you write your commit messages, always talk about "why"
you're doing a change and not "what" you're doing - the "what" is
visible from the diff.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
