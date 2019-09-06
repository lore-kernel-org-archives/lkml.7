Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68016214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K5oZjUdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394915AbfIFPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:53:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40926 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfIFPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:53:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so4770085pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VH1ZILNqohndXjvxeWKzTEguahN3F+DE5ixkUlkKd4U=;
        b=K5oZjUdR+AueXYMxc6zWqN9dQhO2RFQ2uHbKjzsq8PhbAHDEh396m2IlJKbDbEkMOc
         +Ji+pZ6yOLVd/97BIp/lya9U1Hp3weRJmTSjT11r5gOzqfIktHsG5RX4FSEawW5ubcrM
         p3epOYj0VgvQOZe/k2jR2bCFl1AtUEQ5toHok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VH1ZILNqohndXjvxeWKzTEguahN3F+DE5ixkUlkKd4U=;
        b=kIYsIOmN1DcE5T/kSMnHX4JTSRtTI4NdaVtoBOZWAPx2zgiRikuIA9/NFUHePzwmeQ
         XftZ1P2/PFxhOwB3ypCwgW0atfbEkkpcvZdaUky97NR4yo1hIkdpoXYa/nBdalJejH4g
         EUfi88jn/bfae8m1SIZYBDG0Oi++GiZucAPvvNc4XrNUYVDTf8f1kDXrUtPtNjbf8QV6
         6P9Co/Czf7vClg/mfBKQdOabMj+NlwxV2wTWeHpTHo08gK/qTIkvNiNIi/23FNzU1Ljh
         ABYHe0WfChLvEHUrVadyjJ6txdROilkWtGxxv/PSf6O4IEB1QbKzE1x5NJm+aGufpgBp
         kL+Q==
X-Gm-Message-State: APjAAAUDBzre2kvdf1TnZR17OxDr5bA4LdsHNP72wI5gN9MCTILN6pIn
        ZjGKoJ5o4rMo7LZusDfDfV5H7g==
X-Google-Smtp-Source: APXvYqxQpbwstVao8+VjaxFRrDeyLaWxNzFQ26T/YmTiwa6c5FJ//J6C0tdquOXjUkJlBY6Zr442dQ==
X-Received: by 2002:a17:90a:c587:: with SMTP id l7mr10128760pjt.25.1567785219552;
        Fri, 06 Sep 2019 08:53:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r23sm6101830pjo.22.2019.09.06.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 08:53:38 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:53:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] rtl8192*: display ESSIDs using %pE
Message-ID: <201909060851.36ACDB23A@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <201909051352.89D121A4@keescook>
 <20190906093829.GK2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906093829.GK2680@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:38:29PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 01:53:43PM -0700, Kees Cook wrote:
> > On Thu, Sep 05, 2019 at 03:44:25PM -0400, J. Bruce Fields wrote:
> > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > 
> > > Everywhere else in the kernel ESSIDs are printed using %pE, and I can't
> > > see why there should be an exception here.
> > 
> > I would expand this rationale slightly: using "n" here makes no sense
> > because they are already NUL-terminated strings. The "n" modifier could
> > only be used with string_escape_mem() which takes a "length" argument.
> 
> SSID may have NUL in any location in the name.

Oops, you're totally right: I forgot the "*" part here. Ignore my
comment. :)

So, instead, this "upgrades" the escaping from "only NULL" to all the
unprintables.

> 
> > > -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> > > +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
> 
> > > -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> > > +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kees Cook
