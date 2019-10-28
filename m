Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC98CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0148214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="f1WGJM1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfJ1MbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:31:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36578 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbfJ1MbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:31:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so7657988lfq.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIXc50+5NShj5GVfLHp2Ko6erwsoS1EC2cpl3eH9z0g=;
        b=f1WGJM1kyUToCExwbx/CdRQ76h7eSHjP+Y2ccs7CiP8DAWylaZe+hpT8xFznruu1DT
         7ajCJV0H9YK/GJpA+RJ5fJgGUN3PA3nB6KeRngGp4hqooSTu6FsxJxQ1B/r7ohchci1J
         rOdq7M75ixPhHlQlbvE/6BfBwcQBea5JRZn0jBwi5s8lO0Iw410C6OV1CBEefaFxV0wE
         gQ9Y2fVed8YRw7RTDjOevxVTVHdbKabSDZSwr2y0wl1HVfJemKYwWHjL06zOfxDuqLEP
         lBE4RP4mp8ioGF3UESn0+NOuFrS+O1PUkD+bE3LdcWSC1rFzkUTJQgSUGXXGhk6G+/8v
         21Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIXc50+5NShj5GVfLHp2Ko6erwsoS1EC2cpl3eH9z0g=;
        b=POFwRP1bAU/2pW+if0tvSUsiPVpgdldfZJU8RjYr2zeD5ch8S2pwE+k3T4sd8zScvo
         nmSAj7LSiF/In9AxnXBTGvV8pYyqtwOutkH7ZVz0S759z81FRfdZfEFW2BODmzyign+4
         uoWJISP8UY5Dh2TNWwcTTiCahg2fa1ALRuZp7X6Phj3GBg6t8Q7gRHNP2cUQ0pHKNVNf
         wBiS1YJDEvhPtsAcX4A2JSgWWmVv5wm6UoKD9kzflZE6m+Pg8nGcArGikD3tGzyKYehL
         x3SGeSr+GrneFEuOcVn7iUdutrO9yrHkPz4p6z6bsXcu3vogrQKaLRSzPHsbpRawoFFW
         qhmA==
X-Gm-Message-State: APjAAAVYMImfOg4Wp8hmPjoslQpdflsgztwC75H4kNjMqr4dPARH3VKW
        vwPaxTu3/PcfezMPfIltPp+aBA==
X-Google-Smtp-Source: APXvYqzXshtDXv1YEsaKl5HV85rzz0BM+nqGCOx2pc/Myp1qFpjohRxVgQfnpbkmMhUoV9YmeetT/g==
X-Received: by 2002:a19:c790:: with SMTP id x138mr4355216lff.61.1572265883446;
        Mon, 28 Oct 2019 05:31:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e8sm7535160ljf.1.2019.10.28.05.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:31:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B38B1100242; Mon, 28 Oct 2019 15:31:24 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:31:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191028123124.ogkk5ogjlamvwc2s@box>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572171452-7958-2-git-send-email-rppt@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The mappings created with MAP_EXCLUSIVE are visible only in the context of
> the owning process and can be used by applications to store secret
> information that will not be visible not only to other processes but to the
> kernel as well.
> 
> The pages in these mappings are removed from the kernel direct map and
> marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> the pages are mapped back into the direct map.

I probably blind, but I don't see where you manipulate direct map...

-- 
 Kirill A. Shutemov
