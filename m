Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ED2C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1490720866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bfxdHICm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgABJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:49:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37653 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgABJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:49:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so28718301ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJNF7zzDiHYcqJL9y97v859TagsM8CsUOrBW1KXmnOw=;
        b=bfxdHICmkxcEYk5OqlY+pj/RJQV8jBDzu+Hk25x1/g+JImSxDSfnYQOxIrmXzQ+Zgd
         PjAU/WPzFr2vCOqpHXfpBCSSMlUNHVrD+JdDmY+/O+DguHH18pwVhGVvmiD2Oz6Qpr9L
         B+JCov8imOiK2GfvkEKA6L7+SE7Bv0vWlhX56P9Q+0UXVcUBbaHHSKCXPo5dJ13rLKrL
         z9r+U7toJbDsca1SYgfDjAGfRTOr0EBJN9jEMVNiMCcqmO38+FCmi3XBHQ0jzO3QDdIZ
         RHd80FQHaTbgL4YD+6GSPYYEsy1hiIwYYl4CkAxJEUPlMnPZIm1B3MbM8zqdcRaSa2UJ
         rDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJNF7zzDiHYcqJL9y97v859TagsM8CsUOrBW1KXmnOw=;
        b=FduYIN7zO402g1FfdDvo7LBLkyfASCNIADbJ3KtEngFbMrXGFjSEMEaEoBxTNkT8bM
         IO1WSHajcQQHqYi1iAIBUFDQqVO3dsn+t2ImqJmdosW1e7GE66G94E0KqoJs+T7WZAJC
         NQimNSDo8CWBNj5mcELRk8JFbb7GvEh3uNr/TTA9sHp+MJwi6DxOdwhIcf02gyU4TizD
         E60W+epOikCiqMjxS3O26j3oTPuvV14u098shmabQTJGX+nIuWnCvWeRT2Ikeo/8+wch
         kj6GEkjea8ig93twz2YjV9HXWhw//GsWetQfet7EWchWIug9CCZFMCMlGHBHiCg34vTy
         O1mQ==
X-Gm-Message-State: APjAAAXslABcQ5+BEqGbYYtsDMY01BgKoMBX2FKn+kwjvk2F58PTHV2y
        VW4ajyzI0GJms4lQyHx550D31Q==
X-Google-Smtp-Source: APXvYqzpZRfJIpVp3fKDCAcNQ69lZTqQ3latuDOfpbwLHkxW97JGLoWM3BRwossTxUJ5jkeIeghFbw==
X-Received: by 2002:a2e:9008:: with SMTP id h8mr49408333ljg.217.1577958586448;
        Thu, 02 Jan 2020 01:49:46 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m11sm23025754lfj.89.2020.01.02.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:49:45 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1A2C410006A; Thu,  2 Jan 2020 12:49:46 +0300 (+03)
Date:   Thu, 2 Jan 2020 12:49:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
Message-ID: <20200102094946.3vtwrvxcyohlqoxh@box.shutemov.name>
References: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
 <498AAA9C-4779-4557-BBF5-A05C55563204@amacapital.net>
 <20200102092733.GA8345@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102092733.GA8345@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 10:27:33AM +0100, Borislav Petkov wrote:
> On Thu, Jan 02, 2020 at 04:55:22PM +0900, Andy Lutomirski wrote:
> > > In most cases you have struct insn around (or can easily pass it down to
> > > the place). Why not use insn->x86_64?
> > 
> > What populates that?
> 
> insn_init() AFAICT.
> 
> However, you have cases where you don't have struct insn:
> fixup_umip_exception() uses it and it calls insn_get_seg_base() which
> does use it too.

Caller can indicate the bitness directly. It's always 32-bit for UMIP and
get_seg_base_limit() can use insn->x86_64.

-- 
 Kirill A. Shutemov
