Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E79C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE07E2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="do9XptRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfCAVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:48:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35931 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:48:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id k2so12089735plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vMUpOerzimh7H/ZPQ+1fel3zw8mp4Atm+/r0u+Z/foA=;
        b=do9XptRbUwmwOJ3TNHNpY7KbSRtzGbGiAA33/7Hv1NxUsNU78SH63CuZevLDRyJ/L8
         knvcsZg82jPJQe8lRj8nhiuBnN3x//VBi/vZqNhmINjvFG434tEWr3skViQU3GOMnXOE
         icjaf/5gZwATMlgbtZt42vLGlXZ7XwyOWGzO2EMcmVkvSkbK8C0fFf+BQC6NHlpfyHnV
         M8uXTnLkroLn0Tg4TvhqHc3lXzfbVckhBiLRjNCnTBOCYqr803EfjmoxG/telV7wwSzz
         8+lnnSz3pyJB2cuyYR1oHmgV/URTcruOp8IrEWqtU5CpoBeyNR+WW3ylkA9wPl7Xk7mo
         lYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vMUpOerzimh7H/ZPQ+1fel3zw8mp4Atm+/r0u+Z/foA=;
        b=LZ+ldOkhZag4feSSmnns/X1UnuyP7YWjHEWV7Z2vIDN1zbaqOyw6KBPGkLqeVoCrcg
         ZjVyzYN1RzB3zsNV0qqZgDPC0LmDEGOINUPPJVVrox/gAaLNrS/oE9hz344PofA57xLN
         ZUK+QI4A44Gtd6ldylp/8tM3PqiCe+KXu/Ssov5pP0+dofbw0R+QTFHOl/AvOHaP/do4
         sR6fnrJmDF7Es2ximC2tQHXXG2HdH54zNu5AfWKCCCZanThjl/Pbv9fb1INzTaYtrcL9
         LNc2Gu7IbEcm+VP0r/pcAwEWM7jY6fi0akIxHx+6W6FF3/kgQaLSukwJiwahJ6frCgqy
         ngUg==
X-Gm-Message-State: APjAAAV4nKdn/kYT7zYb1XYSnJQBU2qmT41zUe5dsHE4KTA5CgZ89phO
        5m1FZNagpJ1c3nNJaoHxrJju5A==
X-Google-Smtp-Source: APXvYqzPzAwmBTBYphssJHL3LTRyrhCSKJni1K7CY95rVxxRffbrHWIoSLpljCZS1fuiXLzqGmQj6g==
X-Received: by 2002:a17:902:7e46:: with SMTP id a6mr7768122pln.150.1551476936266;
        Fri, 01 Mar 2019 13:48:56 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id l72sm28226444pge.39.2019.03.01.13.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:48:55 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id F3EE43007CA; Sat,  2 Mar 2019 00:48:51 +0300 (+03)
Date:   Sat, 2 Mar 2019 00:48:51 +0300
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
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH v3 05/34] c6x: mm: Add p?d_large() definitions
Message-ID: <20190301214851.ucems2icwt64iabx@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-6-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227170608.27963-6-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:05:39PM +0000, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For c6x there's no MMU so there's never a large page, so just add stubs.

Other option would be to provide the stubs via generic headers form !MMU.

-- 
 Kirill A. Shutemov
