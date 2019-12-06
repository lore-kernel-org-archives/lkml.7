Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC0C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085824673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575658769;
	bh=JtveUOr7XUYXrTWHMvoe30H4/qDW1WlD79x8Ahi4Ly0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Ubjn9iUQsy6snnviQLBwTHb/JzuFfFY+blzitVd30xdi755NATbYYY/7uEezV8Ze2
	 L2FE8mjMxRZFfUUOk2WQVhWDnaKu6PlBvleXp/YekNBpmWcmnUiepOsKHaebV4eopI
	 O9GSQ3zfG8h33q7jVV370pP/ueXLvi+t98yAwuOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLFS72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:59:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40128 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:59:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so8749450ljs.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1FDNapKMyJbKRN4aBAePV2ePHaiGaeNO8oMNreucOQY=;
        b=PgSQDJhkFDTFDemGwLYHhtvXR6HJRvYj90hNfBT6osoTDg5ezGsSbGl83LOQXCCHJx
         i+MdTOYgdB4keVytADAH76rUGbbekCtN0m1I+heTBGpmgPAeblFj2jYDfHmvwt/W+n39
         MuKxbAsB+RUFfgptJIHuFE+m0X89qs3bMVfSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1FDNapKMyJbKRN4aBAePV2ePHaiGaeNO8oMNreucOQY=;
        b=YIMSwmPxnc/Lrb39Q7Js08OnP+aCq/MKgNuiz8j1W2O10kHmvzpAtYw5nHbjYzTJ1g
         +UvEBU+KXIH8XKJuvH0WBaRsEYuxxKQyUnr1ZvCTFTWcaXTmu0uxkcLP93AID5rXvgRp
         cWrP563GCPfrS4ePXf9hSI9bw6njhaep408KM/NDggAXkxYiT2L625/Vcvz3YlecdJwI
         HgLoKai3jzsan9oXLEvrAkIH6tZSBmBllhYbO6MfWrZ1PED+sJFI1dBZrA5UdLVsYKrw
         JD87hBVLFZJ+ZQX1dKwfna9JmJu3btbOg2iUm3k3mLdro4eMzifJ0qubSd/B9X++tiSQ
         7zVg==
X-Gm-Message-State: APjAAAVsRIeJmmeOP+6VinXgZxkZZhkzsK4S5I0gg+dboQAvvKpT+T+1
        +I9gyUhYXe/mi5sGDL0UNEUzcpDnaHM=
X-Google-Smtp-Source: APXvYqxh5ZYkvdKfRKtS+xCsZMVTK4+F7z9loL16vkuXH78C1S5e1N254gjBCC34vKpnSu4mU1x0TA==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr9567458ljg.154.1575658764733;
        Fri, 06 Dec 2019 10:59:24 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a15sm2846587lfi.60.2019.12.06.10.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 10:59:23 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id c9so5529164lfi.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 10:59:22 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr8819122lfk.52.1575658762585;
 Fri, 06 Dec 2019 10:59:22 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
In-Reply-To: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 10:59:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Message-ID: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. I think I just saw this same bug with a plain kernel compile.

My "make -j32" suddenly came to a crawl, and seems to be entirely
single-threaded.

And that's almost certainly because the way 'make' handles load
distribution is with a network of pipes that has a token passed to the
sub-makes.

So there's most definitely something wrong with the new pipe rework.
Well, I can't _guarantee_ the pipes are the cause of this, but it does
smell like it.

              Linus
