Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B659C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E3E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568852713;
	bh=R0oMj1akJGsgc28xYhjFPw/UimwDICIH1Yia+nlZkj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eVHmVsNm9HxppAp5js8bslstfFQ1osDsI32wlHWiMyFPNXXFLEAFM1iY6NmrGpsNe
	 mMU27doT+x6iRuEwoLShr/2B43chK9g9HkGc482IIvo6o5Xw5P4kGs3Svk2pmTmSLK
	 8wlH3Xa8JVAZGmHB7k6FDqQMmyJz/vx7YbInGAi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfISAZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:25:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37615 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbfISAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:25:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so987644lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBc/eYJTOLPPQiZ5t0llKwVn5FhzICC4mWTmMrXjDEU=;
        b=WIbuDCmG9hzDesKroizOBqRXGwONhNP4QrBll03slXqZ8b1BB3vzPCdVc22psjVksw
         jQmVL7xCO/XlhDKxOO0QWvn92j6bBHADgUhpwQrr60PpwgBbzneGC/apON1Wc9JDdf/B
         qoPD6tb+dylFDQ1HADe1c0C8c5aPCYN+8e5og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBc/eYJTOLPPQiZ5t0llKwVn5FhzICC4mWTmMrXjDEU=;
        b=a1XQq8v9apU8eXkKVGznDgwfD6/Cz8FSWZLrATzQe2I+tmfU71U+6ECOhgqbCbc+AS
         rPl42Wyv5dzSGUgE5F9NfnRJEJUtl9HIxtgOZYEAOU27OdZrgy/w6aYb7q1qW0mDbZ8t
         ggF1swAciY9hu/YL90DEbth/0tueIrKjCgKwMkwB7yoQJu9LTM/g+y5vBYd0G7dD64Wg
         Z9OKzlPSWndDkjgg69X7Vg6G9i9Gy6yxTQJwdU9srtw8bW+HIUxD7JWP6DadkOJspJ/J
         NZ/8TdJ0KBGX5uIHXZ/c4Ff8XP4QOFe8yDOMJNcY1CsJauFpH5MFyoXFPTUQ4D5s1Gs3
         Kp1A==
X-Gm-Message-State: APjAAAVVDxaPI+Q1CimiGhKcdA331JJQOsy0+F/D4YWNEYGc+qwSNxCJ
        GCJdrhk4DAEoZ38mwB7Ljx/uAck5ef8=
X-Google-Smtp-Source: APXvYqw4JjdSv0bgY7Gxn7qbXh7hvXA1dZUlgvqrnBiWdvr//fm97RHkON7Y3N0oLbGnYPxxLRCkaw==
X-Received: by 2002:a19:5f55:: with SMTP id a21mr3676790lfj.56.1568852709332;
        Wed, 18 Sep 2019 17:25:09 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x17sm693393lji.62.2019.09.18.17.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:25:08 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v24so1743821ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:25:08 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr3846937ljs.156.1568852707845;
 Wed, 18 Sep 2019 17:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <16147.1568632167@warthog.procyon.org.uk> <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 17:24:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOw-YDpctcdTwsObUuwSv4+SC+O68kitxzPX-4nW74Kg@mail.gmail.com>
Message-ID: <CAHk-=wiOw-YDpctcdTwsObUuwSv4+SC+O68kitxzPX-4nW74Kg@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     David Howells <dhowells@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Commit messages need to explain the commit. The same is even more true
> of merges!

Side note: that wasn't actually the only problem with that merge.

The other problem was that neither of the merge bases made any sense
what-so-ever. Neither parent was any kind of "this is a good starting
point" for anything. You literally merged two random trees.

So even an explanation isn't really sufficient. You need to start
looking at what you're doing, not doing random crazy stuff.

                Linus
