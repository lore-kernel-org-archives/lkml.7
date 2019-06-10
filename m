Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869CC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VvGpBw1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfFJJvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:51:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388033AbfFJJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:51:53 -0400
Received: from zn.tnic (p200300EC2F052B0034A730CA72A5B0FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:34a7:30ca:72a5:b0fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 656711EC0959;
        Mon, 10 Jun 2019 11:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560160311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fCNMGDhBR6moHGXQO/PdPyxtjG1/DmUqhTwAHW5WMV0=;
        b=VvGpBw1GbJS6NG1HrcMgam2FrzaLJ2fr3ptcxOuBkYxVJpa6AO7la5LWvnAxJzz6p2boTj
        2YE2xxrAtVE9rVpDdy7o917eURN9NFT18cR6GQRImevXIW1OJARIQl4Elu5SZGlPsTjuQ3
        sVSjG75IhlXMsvcYqB91vNLCbs4INKE=
Date:   Mon, 10 Jun 2019 11:51:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Message-ID: <20190610095150.GA5488@zn.tnic>
References: <20190610073617.19767-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190610073617.19767-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:36:17PM +0800, Kairui Song wrote:
> With the recent addition of RSDP parsing in decompression stage, kexec
> kernel now needs ACPI tables to be covered by the identity mapping.
> And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
> ACPI tables to the ident map"), ACPI tables memory region was added to
> the ident map.
> 
> But on some machines, there is only ACPI NVS memory region, and the ACPI
> tables is located in the NVS region instead. In such case second kernel

*are* located - plural.

> will still fail when trying to access ACPI tables.
> 
> So, to fix the problem, add NVS memory region in the ident map as well.
> 
> Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
> Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
> 
> Tested with my laptop and VM, on top of current tip:x86/boot.

You tested this in a VM and not on the *actual* machine with the NVS
region?

This is a joke, right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
