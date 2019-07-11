Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D63C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68920844
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562810370;
	bh=yctOEGr15lqaEv9xSMz2miuVt2G/lSyyty867n1nn/w=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=e7AExg9EvmsgPo/hK4YAatWrWzSTy+BvvBj+rnUYjd6ENrOXVtyYSKfPtpCk3BJ50
	 I4JtycbJJnrQIcoKoMw34RwqcnHRBCz0kN/nBnKqy7/Dc1HKHzKLKouF4ljFMlRyER
	 lCaAsgErIqLdgWB13kYFZP6eHfCflFfBWljmEtlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfGKB73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:59:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46790 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfGKB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:59:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so2888435lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=MQOzZI79mvoiVs1sgBWHfqE+YJM9b7M05jQpHMpAAyRFe0Cs7GZ1SKjYmbrPj6ztHM
         B7Jmo2E1tOKxmtYLHAeJfiv0Yw5iWNpJ6su3Aywbxq++FWe46hRTt1FaTYFdrs51gDai
         Fc+1NUhQh/izklmNT0WE5mkHqoWlVg+hybjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=qTSH2wmJBH0cpMqLnb+JytSLtQ2VyJXRwPOgIPWyX60owE2ULtO8gjtMgjDMmdkuOK
         7QU4hUIwepVU1es8vKe/Mx+B3mXUCRhe3G+F4KjpSxIfwFfbXxpUGrShCd9vpK6HlfO0
         4KnTyCn+ha433WFduGQ7+rctG/1iBEU/ClYhjrb9A+Ec1cSELbEr8zVE7lE6dnV1p9sU
         Lz3Iz7NmqjJK43E/xNdRIQMFUMd9oZyBx1v6JBtuil1As8FjE0bDQU+jaCvxSWw95KWb
         4Ki+qK49wdbXFAUG2AGNpKKOjpC1EgS+Sh1RiA4jC5l4lhJNekM5ghEskXvI/UhgnvmQ
         ZRXQ==
X-Gm-Message-State: APjAAAVJztc93WPKZo8b3HT55Ig6wv3CkFAWYfFzpUGUVO/2jZ9mSTVz
        Cn9r95YBZkku/ZyM4pXAxulALG3/RgY=
X-Google-Smtp-Source: APXvYqzoVSudajDxn9SMoJLBQgRwcK0Q/+Jex0v0sQ9JBn7YTWUEIFg+7uC4zZchM0tqiW7Kzy88mA==
X-Received: by 2002:ac2:5c1d:: with SMTP id r29mr351352lfp.72.1562810365227;
        Wed, 10 Jul 2019 18:59:25 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f16sm599088lfc.81.2019.07.10.18.59.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:59:23 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id v85so2902113lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr355474lft.79.1562810361547;
 Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk> <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
 <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
In-Reply-To: <20190710201552.GB83443@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 18:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 1:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also worth noting that the key ACL patches were only in linux-next for 9 days
> before the pull request was sent.

Yes. I was not entirely happy with the whole key subsystem situation.
See my concerns in

  https://lore.kernel.org/lkml/CAHk-=wjEowdfG7v_4ttu3xhf9gqopj1+q1nGG86+mGfGDTEBBg@mail.gmail.com/

for more. That was before I realized it was buggy.

So it really would be good to have more people involved, and more
structure to the keys development (and, I suspect, much else under
security/)

Anyway, since it does seem like David is offline, I've just reverted
this from my tree, and will be continuing my normal merge window pull
requests (the other issues I have seen have fixes in their respective
trees).

                 Linus
