Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406DAC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0818B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/JsQK22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfCZTWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:22:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54869 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbfCZTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:22:08 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so21561493itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yz5iUwny8Ht7a2ATcqBN10pGhmhd/4c3IbQqOwFU9s=;
        b=R/JsQK22WGb0m54Ri61jCZc+s66DyN9WXyY+PIunrLXEwyc2JUoS0mx439O2nVF8VG
         tIIp9vq83mHeDNWEEfXF1nTvhCzSr4UeiF95LbHLc6/D9oATJiVQp9ywUccVN1k5yfJ+
         XKDJxILr0IRUgBW1vuqfNfWV+FL+M/4AkUf7dRXQ4eqo/8Z8OvehipfPrZohDrLFelNF
         yTulv2oAjgnmq3Gq4zqingx7SUaiCRLAn09wnfiLoWUEPH48PaSeKubG74lkjXIa9tli
         iz0P04Es8m3KqACTuttlcpas8ps0MkrsWaIrj+ZIEcGe5LiKLx9nLw/Y8o6Agl1b936V
         RnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yz5iUwny8Ht7a2ATcqBN10pGhmhd/4c3IbQqOwFU9s=;
        b=UgCmeLHET+PA6wKrN6vQhkqhAnL/cXbgytG4pNz0pq+2PW0F7nwvUk4b7lywiVpwm3
         pIz61AWGQMxK0S7hdn0shNt5ACH1hzKurPGIsmp5TJAXL1YJK9T0O9zEd/ua1bZCgM+o
         CBUYSCufDmRkrbb4Iu/B2bXfs9LwqK9smITkmkg0IdXuZNAUCDXjrnZ7cNH0jeQG1dx9
         F3KJ9FFp87W77xfiwFFrNx+WaihyFM0HKSrNTfwoYarDftIox9+RXWjnWSOwTcRxZlR2
         731voREw22yMbUOI92stUjcZBYGQQqprLFixxgGJjCzcRw5pa7m1qUS16FpoxMcuMCnC
         JhZg==
X-Gm-Message-State: APjAAAWUiXPUxfgx/TYEIKINJDEYDzBj/eTrQQ9r9hSVvBa5X130qEi1
        OxWdiILDnGBR6MBS160RntX04FpKvxr9vVuNwLSY5Q==
X-Google-Smtp-Source: APXvYqxAPQCF4Z0uKmKSLnrFjOG7oiPGEHROZ3KSTrEUQGwqkfJNsFi6UJJkPzH8w7q26xeJZRWT228BnvoL+PRLgEI=
X-Received: by 2002:a02:c955:: with SMTP id u21mr6629600jao.105.1553628127676;
 Tue, 26 Mar 2019 12:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
In-Reply-To: <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 26 Mar 2019 12:21:56 -0700
Message-ID: <CACdnJuuZmPymMMFxGgUy8Wm-msWS+MztpXE-HNPzX96WRUKbqQ@mail.gmail.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
To:     Andy Lutomirski <luto@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:20 PM Andy Lutomirski <luto@kernel.org> wrote:
> Ugh.  Some of those files are very useful.  Could this perhaps still
> allow O_RDONLY if we're in INTEGRITY mode?

The previous implementation did, but Greg wanted it to go away entirely.
