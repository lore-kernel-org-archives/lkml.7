Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A32C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961862075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="N8cidJa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCDNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:11:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so3082911pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0mz8hR/PW+TukAB77KzXlPfAhIvUFB5c4A/6VIejvxk=;
        b=N8cidJa+RBPGSL+FpF/dmOQUuLI1A9v0JjWx4C3aX+xibANTueBDzft2D+a3cvEHdu
         ZBbZPzSMgIcHuBY8biFXoXeJo85Qodj1KzLd5RsEJda/rl8QB/jcFckZllQYBND4I9db
         IFXv1KogTJk3/eGYvqccL6WziE2Oz9xj/ktRqxWvtARahwOh22wYKWaseQ5OqyzEDi3q
         z/To1xy/WMuTBcGyGNxUp5sWGAJS7/dBCr2ouCq0CXGRFzkC5eySyZKUYSVGNxzhnE6O
         jV25/GxjZcafM4uCvTHkUX1FvmvZ8UHrqXoAdE6HGE/cfws19vborK26vWJlV9v2XcpR
         OguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mz8hR/PW+TukAB77KzXlPfAhIvUFB5c4A/6VIejvxk=;
        b=iNYxsLFAiP0oUhpqe2vGgGWqWHKhqS4vaVQIi6BgzyyjUplnmGoUvslf+A1aGndT0U
         jWCGolN74qhE381nswpH9nTNkEDVNMnTMFXSAG5bX6AyoYElBPXvJslk2w0S8FYvO53X
         doXnQ5F9LOA0pKEI2v8swnygjwsFzWDFGg2CQ91LE7u94yLsp195sMZo7mvM9M+l/HCz
         Q4kpVfFJ6hYw5uLkAHI2rriZFq1YGroE0XvH4IIjWY2XjNJwTELbyXO1Q43Z6oQDj4z/
         2pPdoWNM6IFCTE4+RdDkG9qTgjXcPrLO1WDLmUw82ZwsyuRFoBwe2OjSh1ailDA9FLgO
         tHRQ==
X-Gm-Message-State: APjAAAU8+EMxBg8c1INr8O160jaPFH5Q1jwGTw+/M+w4iBndkknE1lYP
        rg3/hgbPWaxLqMnAwuFIOKKzJw==
X-Google-Smtp-Source: APXvYqzAWJ2k3k7IQ3uno9qOI/nhQp7EloMYKyZOcYGMZpgzNkdiqKlyXi09LWDL4bNZVmSSr/me3Q==
X-Received: by 2002:a65:620f:: with SMTP id d15mr18557884pgv.112.1551705077993;
        Mon, 04 Mar 2019 05:11:17 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id v6sm8704444pgb.2.2019.03.04.05.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:11:17 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0B911300429; Mon,  4 Mar 2019 16:11:14 +0300 (+03)
Date:   Mon, 4 Mar 2019 16:11:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-c6x-dev@linux-c6x.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 05/34] c6x: mm: Add p?d_large() definitions
Message-ID: <20190304131113.qlf4bs7to77wm3ui@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-6-steven.price@arm.com>
 <20190301214851.ucems2icwt64iabx@kshutemo-mobl1>
 <f840db0e-bbb3-db7e-d883-79b5a630767c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f840db0e-bbb3-db7e-d883-79b5a630767c@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:01:37PM +0000, Steven Price wrote:
> On 01/03/2019 21:48, Kirill A. Shutemov wrote:
> > On Wed, Feb 27, 2019 at 05:05:39PM +0000, Steven Price wrote:
> >> walk_page_range() is going to be allowed to walk page tables other than
> >> those of user space. For this it needs to know when it has reached a
> >> 'leaf' entry in the page tables. This information is provided by the
> >> p?d_large() functions/macros.
> >>
> >> For c6x there's no MMU so there's never a large page, so just add stubs.
> > 
> > Other option would be to provide the stubs via generic headers form !MMU.
> > 
> 
> I agree that could be done, but equally the definitions of
> p?d_present/p?d_none/p?d_bad etc could be provided by a generic header
> for !MMU but currently are not. It makes sense to keep the p?d_large
> definitions next to the others.
> 
> I'd prefer to stick with a (relatively) small change here - it's already
> quite a long series! But this is certainly something that could be
> tidied up for !MMU archs.

Agreed.

-- 
 Kirill A. Shutemov
