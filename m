Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C72C31E40
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4B0206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563067073;
	bh=zCI+NYze1rL0RwVkYL7zaCN0i9Bb66MlOh4JexxDuAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t4g/9omRQ1ILlbqi9V/oM5kxwkvyDCviUki+A9V3uKCQNSGZnfiAMSlWAqfghTftm
	 the5Rd95dPLvG2jdSINZSpedjxVjx30ZMsHlKLTVL3kmBmztaDZHnxecY7YUNWN4y3
	 EHOnxyszzG32747hJotVcZ2kP/Lx0xagFgpKCdCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfGNBRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 21:17:51 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44711 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfGNBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 21:17:50 -0400
Received: by mail-lf1-f51.google.com with SMTP id r15so3847798lfm.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 18:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/ZbMKpaeDfR0c6CluIR2RGEThcJc265Nfb8zCnn6MQ=;
        b=JFAS9tE4paeCtL/HDO7+w783I/1T0SiLhmNcOpTVr2Heh5JE7iPzUXsY4VP8KwcaKM
         vJSrnpHsO4JGdgNhGCw7jHJlrdrLuxe4RT9O3WBDvxWv1nJ1lG1Jl8Vaz51tC0c8rjCR
         ewi9P8bFkO1yo+gtxWxrpgluzYMFNaW7/h1r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/ZbMKpaeDfR0c6CluIR2RGEThcJc265Nfb8zCnn6MQ=;
        b=LhrkHc8UcV9bPmxSTcWCptR1C4w3NIn9AWZKo1jbOfTbxLW/1wcaJd7UevwwnLUz8C
         LGqObFOokMMjQIHe+UYkUZ0ZuJ33Z2+oLtQdwIuhh2/CAYdsrhaB2zvmKtDrpzWSk1Ic
         sg97iCt1p6JdYIaYAvZ5cogWuY0jVGWeJma/+/17sDWXh08rGEPiJa8wzXdDAs+YwdJT
         SHDOJJEQx8kiMRxVnWM6bYus3dtyA5aDZgWQZ2HFH/xFmTF17ka9dptaBh7+HMFM4GcV
         ZV7Rlb5BDYjfMNYltV3FPTwnUpNPuQTfXV9pD3nsEIpekwsRoytSIdzobQEmAvjG7CbN
         TP9Q==
X-Gm-Message-State: APjAAAVH7qzrWO/dxKO37GKWZiwokMtjFQT2HXWTRH+mB/ayGd1mdWYT
        w+P0sqGxPlA6najgZaMmPZK5NZ7cQwc=
X-Google-Smtp-Source: APXvYqxppTKl8MniKuoUjZ6ppyAq7WvWKY2W1AgQW8a+FC8tRT2Dxl9Hu1rTH+yq6/IT9rnsqWPaQQ==
X-Received: by 2002:a19:2297:: with SMTP id i145mr7980190lfi.97.1563067067435;
        Sat, 13 Jul 2019 18:17:47 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h129sm1684196lfd.74.2019.07.13.18.17.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 18:17:46 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z28so12810138ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 18:17:46 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr9461591ljk.90.1563067065731;
 Sat, 13 Jul 2019 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712180205.GA5347@magnolia> <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
 <20190713040728.GB5347@magnolia>
In-Reply-To: <20190713040728.GB5347@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jul 2019 18:17:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEsUC1uLdYCX6rxGxRcgzKS64e3Y8h5HVLvnpGSj5pJA@mail.gmail.com>
Message-ID: <CAHk-=wgEsUC1uLdYCX6rxGxRcgzKS64e3Y8h5HVLvnpGSj5pJA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new features for 5.3
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 9:07 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Doh, it turns out I was merging against the same HEAD as my last two
> pull requests because I forgot to re-pull.  Sorry about that.  It's been
> too long of a week. :/

Heh, no problem, I was just surprised when my merge result didn't
match expectations.

As mentioned, it wasn't like the conflict was complicated, only unexpected.

                     Linus
