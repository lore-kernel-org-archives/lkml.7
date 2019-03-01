Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A004D20840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VWCIfWP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfCAV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:57:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33011 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCAV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:57:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so12124881plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jx3z/ytyz5m19uf5/3OhEnIdJ4HeALh1pApg6ERgUjQ=;
        b=VWCIfWP27qc4osBHSUj5kLtCbj1ntVG+T4U8cTziGn3o5lyIecEuKchHhsbnqL+CwA
         13YMR2ZMV7TGE1fULeo/DFlO8tnOmgddd8Pf9Ah2yxBmTgTuxFIuJfYCzPIJHD2cXTnO
         Qqak5FoFfvofzU+xzZijTG3UsxrKz5JVFvIgBNUqxH2Pj1LvDc/JGatqsqlqIk/aCh1M
         MoFY+8OhY3uy8AhjCMqOxtlMiN0zGyZDV6+oOJVShbNAs7Oy2DEe3uUvT7ck+CK5Su7b
         68NTf+tY2uHldMNd5Gtkp7V5WTaz0lxFiMGKLvUyWIS/BHQU3bC/H4sIF36rozN6FoGJ
         mJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jx3z/ytyz5m19uf5/3OhEnIdJ4HeALh1pApg6ERgUjQ=;
        b=UU73D241tTziAGUur+EVET2I758PhDGI49qzxcpeKdQaSJeYXL2ziIuRQP/2q8Skn3
         vUFyFOMMHoYX+UbqsO+ikoGj2ubPQTY/pSyJ2Kv1wW4DUgR4bUfm0KDZgOVc+LXWrn/O
         98sns9XNXTeNm3H1sVEpdRR7PMRB2FcftD/NoIM/XSZTaRa9Fe3MsJiGEdVP7TXnzzH+
         XtYNY+NyxA2IpXpnKAMCPKS9vD8LrkEqF7xkuPcyTjg8Y/gL8fGvPYVepwgv5iGOof+Y
         eYENKvLfmo56DMsuUYG+PtszwKUqbezEv2T+OTqn9qXDfeQRakgGopn4Ee+nzQmJh/hA
         ZYrA==
X-Gm-Message-State: APjAAAVXaGY+DFIJL1xNN5xgwm/Tbz/I3ecFWkx4Pdd9iQOcgBJlCp88
        OvnDLRwz3gQCI9kk/7k32mr5pQ==
X-Google-Smtp-Source: APXvYqynodEY5jKFUK2x2PS4hoYz1An80WXto1OjEKBWf+zdX8l5qOU4JRwZr0ket6b24/Q9y39L3w==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr7841762plb.31.1551477452908;
        Fri, 01 Mar 2019 13:57:32 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id u14sm23818699pfm.66.2019.03.01.13.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:57:32 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id ADD193007CA; Sat,  2 Mar 2019 00:57:28 +0300 (+03)
Date:   Sat, 2 Mar 2019 00:57:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
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
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v3 08/34] ia64: mm: Add p?d_large() definitions
Message-ID: <20190301215728.nk7466zohdlgelcb@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-9-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227170608.27963-9-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:05:42PM +0000, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For ia64 leaf entries are always at the lowest level, so implement
> stubs returning 0.

Are you sure about this? I see pte_mkhuge defined for ia64 and Kconfig
contains hugetlb references.

-- 
 Kirill A. Shutemov
