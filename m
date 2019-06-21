Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC4AC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3652089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F3oK9ItC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFUW0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:26:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40827 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFUW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:26:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so3656455pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DWIfKY3sHhlypxieTHXlR0ue9pX61XiXTJFQC3OO8/Y=;
        b=F3oK9ItCKHZWlvyXbWlgudvY62RgLBcpeWB0uDFSBVHAlndEsOKy2T4/ZemmpzvRqZ
         oY3KQbbuu9yaU9lrznY9Dnf+cVQ2In6REloEYX5Xo4pr9Ou4thXc69h3cdaS5PSnSkPM
         zBpg3DUoPZ/x/EWtz1v8KcgnKa4rBKvX9hGOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DWIfKY3sHhlypxieTHXlR0ue9pX61XiXTJFQC3OO8/Y=;
        b=SYXmdiXLLwwMN7qKG5Dn5odOmyGniQFZwLOArjREBS0qC0YIFauvquTiS4ej3RC0Fz
         fJtEWIkWKM3dsTuvszQnKaQKM0hHtimstFtQJpbBh8UKx8FCRgKllLF5gmLz99nY1li/
         l0Gnv9tIKBYvNnnQ1YtW7Xxjdaqyc7pd+5mv459HzOmJW00EYO+6YIPO0+dWjB6A/WOe
         FQtN4FrPVEy9JpHaoHtp0WxV8/VJEJHRf3SKBCqDOHnaDS34BmJwhCR3s6y9tJnJKUUV
         CkfmrqBSdDNgRAz1k1kGzhR0KtQo0mQSl/XaGd42XKpepLKpZDY+3G9qYhRhXcwrWy3N
         zXPg==
X-Gm-Message-State: APjAAAW1gm+tgEDnXAZ49Ba1giSZac1qTRsRZ+p0rcaUW/66fsTlDrAL
        6WIGjvAWnW89gz83e7SAFHZRbQ==
X-Google-Smtp-Source: APXvYqzHKz+FN6uklKxhJ8zGwzVlc0a3NhIekAb3EpSCFfLlnPNerTelJLHoHEdZQT35C4irwOD+VA==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr121282560plz.132.1561155962449;
        Fri, 21 Jun 2019 15:26:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12sm3282622pgj.80.2019.06.21.15.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 15:26:01 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:26:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <201906211431.E6552108@keescook>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621174544.GC25590@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:45:44PM -0400, J. Bruce Fields wrote:
> I'm not sure who to get review from for this kind of thing.
> 
> Kees, you seem to be one of the only people to touch string_helpers.c
> at all recently, any ideas?

Hi! Yeah, I'm happy to take a look. Notes below...

> 
> --b.
> 
> On Thu, Jun 20, 2019 at 10:51:07AM -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > I'm exposing some information about NFS clients in pseudofiles.  I
> > expect to eventually have simple tools to help read those pseudofiles.
> > 
> > But it's also helpful if the raw files are human-readable to the extent
> > possible.  It aids debugging and makes them usable on systems that don't
> > have the latest nfs-utils.
> > 
> > A minor challenge there is opaque client-generated protocol objects like
> > state owners and client identifiers.  Some clients generate those to
> > include handy information in plain ascii.  But they may also include
> > arbitrary byte sequences.
> > 
> > I think the simplest approach is to limit to isprint(c) && isascii(c)
> > and escape everything else.

Can you get the same functionality out of sprintf's %pE (escaped
string)? If not, maybe we should expand the flags available?

 * - 'E[achnops]' For an escaped buffer, where rules are defined by
 * combination
 *                of the following flags (see string_escape_mem() for
 *                the
 *                details):
 *                  a - ESCAPE_ANY
 *                  c - ESCAPE_SPECIAL
 *                  h - ESCAPE_HEX
 *                  n - ESCAPE_NULL
 *                  o - ESCAPE_OCTAL
 *                  p - ESCAPE_NP
 *                  s - ESCAPE_SPACE
 *                By default ESCAPE_ANY_NP is used.

This doesn't cover escaping >0x7f and " and \

And perhaps I should rework kstrdup_quotable() to have that flag? It's
not currently escaping non-ascii and it probably should. Maybe
"ESCAPE_QUOTABLE" as "q"?

-- 
Kees Cook
