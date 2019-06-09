Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41285C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4FB2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YxQZHF9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfFIL5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:57:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32888 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfFIL5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:57:55 -0400
Received: from zn.tnic (p200300EC2F324700A0FC456C8A6AAFDA.dip0.t-ipconnect.de [IPv6:2003:ec:2f32:4700:a0fc:456c:8a6a:afda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF19C1EC0985;
        Sun,  9 Jun 2019 13:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560081472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d9m75o8ZoLGWyfrguzdmDLguXdoHu/ir6nRIMJHfCa0=;
        b=YxQZHF9ATaCUtg5Im8p0HhUrtkBNdkY1G1fXA0wrFXfYAt7ucv72r3Y6IjDvR7PmI2ke2F
        be9WrkCa8MV7yF5GMQ34YZ/nYE0i/n28AImfX92pF+mbOaRSxpUdrTECgn174DtygBgZkr
        kdfgLFMuC9zC3VgQBcwzLmqzZMJoG04=
Date:   Sun, 9 Jun 2019 13:57:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-edac@vger.kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:ras/core] RAS/CEC: Rename count_threshold to
 action_threshold
Message-ID: <20190609115732.GA7338@zn.tnic>
References: <tip-b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd@git.kernel.org>
 <20190609090637.GA26453@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190609090637.GA26453@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 11:06:37AM +0200, Ingo Molnar wrote:
> 
> * tip-bot for Borislav Petkov <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
> > Gitweb:     https://git.kernel.org/tip/b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
> > Author:     Borislav Petkov <bp@suse.de>
> > AuthorDate: Sat, 20 Apr 2019 21:30:11 +0200
> > Committer:  Borislav Petkov <bp@suse.de>
> > CommitDate: Sat, 8 Jun 2019 17:38:17 +0200
> > 
> > RAS/CEC: Rename count_threshold to action_threshold
> > 
> > ... which is the better, more-fitting name anyway.
> > 
> > Tony:
> >  - make action_threshold u64 due to debugfs accessors expecting u64.
> >  - rename the remaining: s/count_threshold/action_threshold/g
> > 
> > Co-developed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: linux-edac <linux-edac@vger.kernel.org>
> 
> JFYI, the SOB chain is a bit messed up here, the proper chain would be:
> 
>  Signed-off-by: Borislav Petkov <bp@suse.de>
>  Signed-off-by: Tony Luck <tony.luck@intel.com>
>  Signed-off-by: Borislav Petkov <bp@suse.de>
> 
> This shows that the patch started out as your effort as a developer, then 
> Tony enhanced it and passed it to you as maintainer.

Actually, I was trying to point out with the tags that I simply included
changes from Tony because they belonged topically together. There was no
passing. I don't think you can express that with our tags properly thus
the free text above it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
