Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74105C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A912089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MxFZrkzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfFXMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:23:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33650 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFXMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:23:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so21558974edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8AaMfVCp7F7IloL7HzyXQBZxIJdiFcnDT3qmwYWpOTo=;
        b=MxFZrkzMcC5bsaTujISAfm22SI+Ocm0+uIft25pHlg3msnC45niGTKb9Rmc8s3edTJ
         djI3ccLcikaPVjOXFG5eW+9fxsc4eODPtEEJAYqsEhy73Tgz9JBGo7OO/x34FrELbG1m
         6cWqWPGPTJ7bJn/qMbgomivvrpMUSD6BFpUAPRZIwb2jxIs96RalbbetPhHbPJikY54Q
         9CHhstXClCUC3jyDP4669ynurrGQrTbx4pXFZXHZx4GR/e4CGbr4vOLB2+1X+LDDWI5b
         rTtU5RWoT65BtoRv/P+tT4UhGggYyKQw0CBar4KWFw67y95Vk6EoSv6FugklVyvJXJc8
         Qwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AaMfVCp7F7IloL7HzyXQBZxIJdiFcnDT3qmwYWpOTo=;
        b=jedeS1/KK6Z3Xx/VXNrbDQF0++RjLLkFhaG597nOeRdAeeBwLKKAEi5JzRxgF92T6N
         2G8stcQhum9ILQeoILKa0pWI4UQUpDsRMlqkrUSs1hk81Zx2NwwnSb6wULSkJuPJjW1K
         50NxU9K+CIGJ5cRY9GZXgvIQfmPJltvcTg+PNMjAqztBCz9E/BqC9QOzbXi3oQ4FYeBG
         Venf/oSBjwcuLk18bebzQFKU01fFJHhqunV6Re3+RtgEt3VacN/+4HgxaqItyVeMEmVV
         sPE5iH3w1+trYk8nwTZ3MbgAxEmoT/251d0EUuoHF5m5rUZhtek7xf811AA8YFVpy57E
         9+bg==
X-Gm-Message-State: APjAAAWfFqAyJbwzTjOUmTD3RZVmtxb825j9ex3yfv5aN6/B2Yv+tdP1
        oBuqkA+hrBOquDOK2idbvbsMcg==
X-Google-Smtp-Source: APXvYqwGPURsoXPJ7Oeu6ijCTvFknOcTT+XJfwDXBBA2AhxYDVUNlZhbLdkP6CVf6nGb00jW7eEIUA==
X-Received: by 2002:a17:906:30c7:: with SMTP id b7mr1309762ejb.68.1561379030851;
        Mon, 24 Jun 2019 05:23:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p18sm1872940ejr.61.2019.06.24.05.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:23:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0EE0510439E; Mon, 24 Jun 2019 15:23:55 +0300 (+03)
Date:   Mon, 24 Jun 2019 15:23:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kyle Pelton <kyle.d.pelton@intel.com>
Subject: Re: [PATCH] x86/mm: Handle physical-virtual alignment mismatch in
 phys_p4d_init()
Message-ID: <20190624122355.762cadxds37enfdo@box>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
 <20190621090249.GL24419@MiWiFi-R3L-srv>
 <20190621105449.fp7h7tsmpitvplyr@box>
 <20190624100742.GM24419@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624100742.GM24419@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 06:07:42PM +0800, Baoquan He wrote:
> On 06/21/19 at 01:54pm, Kirill A. Shutemov wrote:
> > > The code block as below is to zero p4d entries which are not coverred by
> > > the current memory range, and if haven't been mapped already. It's
> > > clearred away in this patch, could you also mention it in log, and tell
> > > why it doesn't matter now?
> > > 
> > > If it doesn't matter, should we clear away the simillar code in
> > > phys_pud_init/phys_pmd_init/phys_pte_init? Maybe a prep patch to do the
> > > clean up?
> > 
> > It only matters for the levels that contains page table entries that can
> > point to pages, not page tables. There's no p4d or pgd huge pages on x86.
> > Otherwise we only leak page tables without any benefit.
> 
> Ah, I checked git history, didn't find why it's added. I just Have a
> superficial knowledge of the clearing, but in a low-efficiency way.
> 
> > 
> > We might have this on all leveles under p?d_large() condition and don't
> > touch page tables at all.
> 
> I see.
> 
> > 
> > BTW, it all becomes rather risky for this late in the release cycle. Maybe
> > we should revert the original patch and try again later with more
> > comprehansive solution?
> 
> It's not added in one time. I am fine with your current change, would be
> much better if mention it in log, and also add code comment above the
> clearing code. Surely reverting and trying later with more comprehensive
> solution is also good to me, this need a little more effort.

I've decided to keep the block for now. We can remove it later, once the fixis in.
I'll post it soon

-- 
 Kirill A. Shutemov
