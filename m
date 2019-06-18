Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C52082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q5GnsCpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfFRKMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:12:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRKL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:11:59 -0400
Received: from zn.tnic (p200300EC2F07D6004142CF2FAC564D4B.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d600:4142:cf2f:ac56:4d4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEF0D1EC09E2;
        Tue, 18 Jun 2019 12:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560852717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MoWVPmpMAbs1bfVejPZhyhsg72fZJLKwwn2XNif5WfM=;
        b=Q5GnsCpQ54V6Z8IyXAEBDNG2k+kEe1heRl6f7EKCSm93wgSioxWrc77FZXYECUirzuhjx5
        OVk7OFTVHR3xvnwJy3araxJm6p2mUDX+f38bNdhUhTeW3u2Uzn8PcFTjSXxH7D28M5cVfK
        JCEXX4FT/C8745VrTR/s1ftextMWFl8=
Date:   Tue, 18 Jun 2019 12:11:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for
 early encryption
Message-ID: <20190618101149.GB5629@zn.tnic>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <cdb1fab3558ae11a50c922d8f373c2125c862e10.1560546537.git.thomas.lendacky@amd.com>
 <20190617110241.GH27127@zn.tnic>
 <9e7e1757-2f2f-ae34-5b31-cca5e164a6a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e7e1757-2f2f-ae34-5b31-cca5e164a6a9@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:49:13AM +0000, Lendacky, Thomas wrote:
> Whoever uses it in the future could rename it if desired.  But I can do
> that now. Is there a preferred name?  I can leave it as .early_scratch
> or .early_workarea.

So looking at readelf output of vmlinux, we already have .init.*
sections for stuff which gets freed after booting but I'm guessing we
can't have the SME scratch area in the middle because you need to be
able to say which range gets encrypted without encrypting the scratch
area itself...

But you could call it .init.scratch or so, so that it fits with the
already existing naming nomenclature for ranges which get freed after
init.

> I think it's easier to show the alignment requirements that SME has for
> this section by having it be its own section.

Not only that, from ld.info:

"   The special output section name '/DISCARD/' may be used to discard
input sections.  Any input sections which are assigned to an output
section named '/DISCARD/' are not included in the output file."

but you want that section present in the output file.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
