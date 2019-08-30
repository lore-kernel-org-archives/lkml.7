Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE979C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17F6233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mEdc7Dis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfH3NZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:25:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3NZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:25:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so7941871eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Zj/8Y/Y7waYN+TCgDjpWoQ2JSAG8CGbnlMXmewzzjI=;
        b=mEdc7Disgjzolfg3x9hn20PolxgZLBj70G4baazpIXB4ImfEgklyXg6dJB5u7NmmB5
         Rcpm+OynmrhRpiFYRFCSadzfy0X3+A7fS/M7CpXhJI6NysbQgN4O95gTyCE2xPHhDaWc
         wHQHb1StRwZcSNJ7ci1RbV+f/ER5Q0CYw8LLO/QR9lAnxGmUYdKhlMQGl8dH5qsdTIWQ
         ot5QwdMa9ykqzcdx9pJTF+NMTk9mmwUwpwz+wX5LXe5SxzYCnnxyckT8M1OgXAPhVJJs
         nKv+gMmwVs1vPcmL+fe87UB72l2NEO43NJBKb7393jw42mfzLGtWeocVKNCHfmcUkvcm
         QNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Zj/8Y/Y7waYN+TCgDjpWoQ2JSAG8CGbnlMXmewzzjI=;
        b=B4MZ7lVUMe8JLM3y96qekr8kXnue+HTIUax6zIh1934q2Nlw2mgjT8rmMjMEgaTwh7
         CRW50/gj3yIUODxVM7XmSfsMix3lNx4qkfzrSfsUbkP9DiRmI6vXX8QvppWAEXU5aCin
         4zlU6IQyfdVApjWqigbFTOf/nqotHnCnyf3LjUJ6rDfn1KNRCt619iwimY4ku86M3xR5
         vFmrPqfgLRnusqywlbGFF+7k+cze2vDXRezDydsqd4eWJ502ZibARJFp17nH2v9pAy79
         Ix1wE5QthgwcsEdoyaGpbMzRuhC48Wll8rhL3/Ij5bcqgpmJXtnJZApaBhG9lPWtJgIm
         3ucw==
X-Gm-Message-State: APjAAAUiDau945ZGj1XUj5cZFwbizklXRILA3aL60Ws1FEFyW/H1Zs0D
        Ny0WmLikidrG7Ejvx8bThtez0g==
X-Google-Smtp-Source: APXvYqxK6DIqe/Pu2WQy6d+ysA0bul3FVt9tp8Trtu4kHKskfdjuWFLCmhkB2V9o5NAwZMgt2vBzSw==
X-Received: by 2002:a05:6402:60d:: with SMTP id n13mr15479226edv.303.1567171510061;
        Fri, 30 Aug 2019 06:25:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h11sm253745edq.74.2019.08.30.06.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:25:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9EB841023D2; Fri, 30 Aug 2019 16:25:13 +0300 (+03)
Date:   Fri, 30 Aug 2019 16:25:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.2 51/76] x86/boot/compressed/64: Fix boot on
 machines with broken E820 table
Message-ID: <20190830132513.emsgzw6nty2blfv5@box>
References: <20190829181311.7562-1-sashal@kernel.org>
 <20190829181311.7562-51-sashal@kernel.org>
 <20190829221723.eicsws3q7gp6nx37@box>
 <20190830120638.GW5281@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830120638.GW5281@sasha-vm>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:06:38AM -0400, Sasha Levin wrote:
> On Fri, Aug 30, 2019 at 01:17:23AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Aug 29, 2019 at 02:12:46PM -0400, Sasha Levin wrote:
> > > From: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > 
> > > [ Upstream commit 0a46fff2f9108c2c44218380a43a736cf4612541 ]
> > > 
> > > BIOS on Samsung 500C Chromebook reports very rudimentary E820 table that
> > > consists of 2 entries:
> > > 
> > >   BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] usable
> > >   BIOS-e820: [mem 0x00000000fffff000-0x00000000ffffffff] reserved
> > > 
> > > It breaks logic in find_trampoline_placement(): bios_start lands on the
> > > end of the first 4k page and trampoline start gets placed below 0.
> > > 
> > > Detect underflow and don't touch bios_start for such cases. It makes
> > > kernel ignore E820 table on machines that doesn't have two usable pages
> > > below BIOS_START_MAX.
> > > 
> > > Fixes: 1b3a62643660 ("x86/boot/compressed/64: Validate trampoline placement against E820")
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Borislav Petkov <bp@suse.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: x86-ml <x86@kernel.org>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203463
> > > Link: https://lkml.kernel.org/r/20190813131654.24378-1-kirill.shutemov@linux.intel.com
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > Please postpone backporting the patch (and into other trees). There's a
> > fixup for it:
> > 
> > http://lore.kernel.org/r/20190826133326.7cxb4vbmiawffv2r@box
> 
> Sure. Should I just queue it up for a week or two later (along with the
> fixes), or do you want to let me know when?

You can queue it up later (two weeks is fine) once the fixup hit Linus' tree.

-- 
 Kirill A. Shutemov
