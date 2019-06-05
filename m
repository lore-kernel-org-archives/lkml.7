Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4527FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EB820872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6/CTKw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFEUHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:07:45 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:38450 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:07:44 -0400
Received: by mail-io1-f49.google.com with SMTP id k13so546081iop.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWPCkjiDpsVKRA3zAFLVPrJDaYwckwujcOqte+GF4Qs=;
        b=Y6/CTKw2HpfFzRV8cVp90r2srB2SmP6at0zd+tEXm7XFl50kmu/Y3nIEEWGg3Kzk/B
         l3D3Qr4UiAJUphHXpmvTqTi4wbNRjrImrlG7ZnCCJKH8FdZqjq4BvR9hjClj79ZJXtpo
         wJwy3Sz8MDxzQjIUSDal0FQ4e3ED/l4WprxHOQB1SqDvdINs5Z2Iqe466nxFxl7DIM25
         bdtQ+7JbvDnxmhTWFmbnWKhDxV3HeUg0fR3ZqWqUeprL7yqliCoe6qJGgY9soYeL2+c4
         g5KyxxMf4S0cwbsB+gEsHrj/UZW1Nk7qSFO7PfGWDWJQGbArg1y384v4TeP+oCHceLWr
         6KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWPCkjiDpsVKRA3zAFLVPrJDaYwckwujcOqte+GF4Qs=;
        b=EjXUeRXhSts3UyKkdcJo4H0voNLXs04AbI7GgppTXgt9V+L4VjYGYRdH2oBcmT9xFd
         adrWaTn5LzKA72RzL03lOphiLBKPiQ4Qe0brfeGcKo7FfFULVIQQ8M0F1U5NlOW0VTrb
         FNdFvkdiVCIcGbmJ3P/NwPG8eBudg5jN2RfqcnZzdh/88KySVA3cgXEhUGmBxUYve92H
         K7Grs71N3BKmphEikdIM9wrKfDJiQYvcaVgxO/htYPyK10nw4UbKH9ki6As81PG7WpFX
         tWZQoLIu36ZlY6LLpFsu/Ldj2D/eZ6ebJ9bZNVrWPC23b78h7IEkIt/gQ96mohnYVGL7
         C5sQ==
X-Gm-Message-State: APjAAAUPKDFjL6Fw9fHn9XVHZLgNnzRV82vG/jJfEf5tChHrimMKkFkE
        wiWljo9Z8aEAsig0QsZELX64LzWGS3KDxTb/DvOaggBHeu4ziw==
X-Google-Smtp-Source: APXvYqzGleq5vDpqLVlVafId0CX+B2A32E7+JeJwJXNMpga7x9yP1fKCekdulEwyHbBdx18n2S7Lth9ehJe4hSJLcVk=
X-Received: by 2002:a5d:9d8a:: with SMTP id 10mr9444816ion.179.1559765263703;
 Wed, 05 Jun 2019 13:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com> <20190529180931.GI18589@dhcp22.suse.cz>
In-Reply-To: <20190529180931.GI18589@dhcp22.suse.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 6 Jun 2019 01:07:32 +0500
Message-ID: <CABXGCsNTjHhpK4OoGxo+rcp60F0pAc377KpdsrgWptyFjfLLog@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 23:09, Michal Hocko <mhocko@kernel.org> wrote:
>
> Do you see the same with 5.2-rc1 resp. 5.1?

The problem still occurs at 5.2-rc3.
Unfortunately hard reproducible does not allow to make bisect.
Any ideas what is wrong?

--
Best Regards,
Mike Gavrilov.
