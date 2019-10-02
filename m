Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE87C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F89218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KS8XHwld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfJBSTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:19:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44651 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfJBSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:19:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so95513pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1pSxC96cp63O/uKBhjxXAYKtXILwpdL5DptqGzoFDRc=;
        b=KS8XHwldUbXMCwU/wt18G2OK3lA/p6SmJW4QaclaJxjcf0kt6fXXEoTLQ+OgfR6T2A
         6K9i/mQZGEZzIvyz6aVNi0kWIKEllGe8QZtNbxxUitZVjztRbtWJYb2D/h4Es4jvSrcA
         ZIhiPvb34WPJKOp/OrihvBZtGcfdrRQ933q94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1pSxC96cp63O/uKBhjxXAYKtXILwpdL5DptqGzoFDRc=;
        b=FquE1sQGK3tOvQt+7VgfPkeP36zBFzxZ9c7/fsEEPPreJT1WAtUvZNMHl+l25pnn5t
         c7igrX8Be9QUV7lmpqBjdtXM/AKi3sOsSBmLvkF9GWGBvjw8to9FKU7E79Wk0jR5swJp
         zMGwmwyn4X4nkxl3bVkXFqUCIYybMcsjFIeNNx30cnFWmIwj+TKaEGiXOrdHPnsgvj2I
         0CwiysWQVk62PANczV1wbRC/NHAQ8EDe3kVnnZajrjvsL7Kn+nA9ICc1fUmjawq3mF8g
         JKx2KjY5diYUrIz/UO9VjiCsjl9Fknmrcx37VBAlQcjssNrL3FNkECAhUXis/hM5b7ML
         s+PQ==
X-Gm-Message-State: APjAAAWkGtJlLjWmqlbv0FHJNFi72eraHYx2UwNsSsLWDVV7kpButARJ
        jbX8xpCgk/tK5zyGdwNrlhbkKQ==
X-Google-Smtp-Source: APXvYqyoCE1WFuTiE+G81nuaYtNBUeF3ahHA12Odrg2xFman2LZ5fF0xrMGJRhkd5R2IcaOjmlK/wQ==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr5113730plr.48.1570040358638;
        Wed, 02 Oct 2019 11:19:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm132622pfi.117.2019.10.02.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:19:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:19:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, netdev@vger.kernel.org
Subject: renaming FIELD_SIZEOF to sizeof_member (was Re: [GIT PULL] treewide
 conversion to sizeof_member() for v5.4-rc1)
Message-ID: <201910021115.9888E9B@keescook>
References: <201909261026.6E3381876C@keescook>
 <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
 <201909261347.3F04AFA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909261347.3F04AFA0@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:56:55PM -0700, Kees Cook wrote:
> On Thu, Sep 26, 2019 at 01:06:01PM -0700, Linus Torvalds wrote:
> >  (a) why didn't this use the already existing and well-named macro
> > that nobody really had issues with?
> 
> That was suggested, but other folks wanted the more accurate "member"
> instead of "field" since a treewide change was happening anyway:
> https://www.openwall.com/lists/kernel-hardening/2019/07/02/2
> 
> At the end of the day, I really don't care -- I just want to have _one_
> macro. :)
> 
> >  (b) I see no sign of the networking people having been asked about
> > their preferences.
> 
> Yeah, that's entirely true. Totally my mistake; it seemed like a trivial
> enough change that I didn't want to bother too many people. But let's
> fix that now... Dave, do you have any concerns about this change of
> FIELD_SIZEOF() to sizeof_member() (or if it prevails, sizeof_field())?

David, can you weight in on this? Are you okay with a mass renaming of
FIELD_SIZEOF() to sizeof_member(), as the largest user of the old macro
is in networking?

Thanks!

-- 
Kees Cook
