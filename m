Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F10BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E12190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566802481;
	bh=3PjlUTBUR/XzFsMz/GXZD8iuSFefN6Th+8lZSsWt360=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IXxw6/cKMWrmt/lV1CPrDIjGAD5PU+xSxZBEgf9sGq0ODkioGK3xM95qyRUFB01R+
	 W52GfORedjfPKjRPnwO86Q7L7W+xUcLe/mvmvj5lSSb+5jkJ4jrKsypwn+LUBO6HtD
	 +wJWmNGt4Nrz2plzsszx0Fvv8FUGWDMPSXbyd548=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfHZGyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfHZGyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:54:40 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B0B2190F;
        Mon, 26 Aug 2019 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566802480;
        bh=3PjlUTBUR/XzFsMz/GXZD8iuSFefN6Th+8lZSsWt360=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AzCabFC0rp/scNtav1blpO98d8C32C+cd7uVoKTGw7Aoo+LXyg/cM9gZxewmOH3MP
         S8ZY49+3Uc9J9S1ZdvwURzlPnjqzzrXz2WyGqh4p0euGWWlDRY+XMp9MKEqpdqjQct
         JZgeRMA6gixPGForz37C56o2Xf0SYV4BPlCoM49g=
Received: by mail-wm1-f44.google.com with SMTP id l2so14697895wmg.0;
        Sun, 25 Aug 2019 23:54:39 -0700 (PDT)
X-Gm-Message-State: APjAAAUfL3U8mSKvS6LXFdRer14ap5TwD/6iFGhawC6mQbnZ2LDk9h4H
        5Oyl+d92ZKtOcQDYyX4hLcXz9w2wpIfKmZus33w=
X-Google-Smtp-Source: APXvYqze+5N431NKumJz/IGZ4nQDxsfQfeu2kHe+0HCxIp34UIlce18pt7ezfYCMT6xzAK9hM4kCj2tPkQ3AOfbaGnw=
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr19302796wme.172.1566802478272;
 Sun, 25 Aug 2019 23:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <1566443122-17540-1-git-send-email-guoren@kernel.org> <20190826063818.GA29871@infradead.org>
In-Reply-To: <20190826063818.GA29871@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 26 Aug 2019 14:54:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS6myiYmPqMLhSxHJd3tL1rmy+K9Kj42cYq9HLxSMPWCg@mail.gmail.com>
Message-ID: <CAJF2gTS6myiYmPqMLhSxHJd3tL1rmy+K9Kj42cYq9HLxSMPWCg@mail.gmail.com>
Subject: Re: [PATCH V2] csky: Fixup 610 vipt cache flush mechanism
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, douzhk@nationalchip.com,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Christoph,

On Mon, Aug 26, 2019 at 2:38 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 22, 2019 at 11:05:22AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > 610 has vipt aliasing issue, so we need to finish the cache flush
> > apis mentioned in cachetlb.rst to avoid data corruption.
> >
> > Here is the list of modified apis in the patch:
>
> Looks sensible to me, although I can't really verify the details.
> You might also want to Cc linux-mm.

I'll re-send it to linux-mm.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
