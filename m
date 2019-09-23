Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3C7C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6251B2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569266263;
	bh=HSTtGYfqyQ7E2gn/3lA+KpauEkGyRLGkzwWNcYJ0b6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C88JO8ZNlhbZyzdKwp2rE4MrVRKgsR2YABxs+ndoDNrdtQpVUKLjUfH/Dwmo/t8c7
	 dk660hdAWr1xGgrAVk5Zks5PvBlet2kKqm8VopYTyFlhgsYJP5d6dD//NL9syRI7pE
	 0T9OBnZ6w+o1qDdfiG++7hRV2bH0Ql+AG5H+Mk4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfIWTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:17:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36754 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfIWTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:17:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so11034292lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrRLQn3RzqvLOL/i6mhPpJ10+RmKd1euOe+YMl2OYp0=;
        b=f1ffZU2sPanOCuHiBceitjTlbhQE9vji8lZ1iD711xp+ldw6uJgEuKLN8+GC7Byalb
         nwAAiPg7+uP3R5SZCV+80m9S4HOJl9DPeuyxvFQv5NWy9NXmONOgY1hB9hDLeuHfYCdW
         +1/jkugNzglnZ4KwGRBl0e6c1DD4gcxsNkFuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrRLQn3RzqvLOL/i6mhPpJ10+RmKd1euOe+YMl2OYp0=;
        b=P50pUsPBVUbvVP4vltgwVfqNlGzY6seXAnoiAt4CmdhbSqX3F9jNz8UtRD+y+7IkB6
         RFXMYLc+8KJ3/3EfSUAyoklmyakFzQJ3t05vP/SQd6xgfOSwRLln0KElW8s7k9gS1pig
         gAnEusKWDkYqvktbWVooji//5KWOmWdoHA5Ok3bSnXJXr7YIX7lS1T6kHVPsizKsr3J+
         2KhQVs3OaMdK18yOwP//878lwYb/h756v8wJ9pdljqA9V/sQmi9ZnvRJ5viW8zqwizQY
         fKTxuAxYTaUYUW3LujaehrEhMPAdRjY9bmOL5hwB6FIYLkU9f9tS7daP7HWe9usHKlXw
         eCNg==
X-Gm-Message-State: APjAAAX+4WRrc6Yl8BH+FGRJ4r2oRjF41pbnA2Z+nwPZr8NffDHTICev
        e67c7rFJ+lsw27fuitb6Kju96jKjO/E=
X-Google-Smtp-Source: APXvYqzK2dU34889JQ7TczvVoWoOb3nJR7HfoHYRYIyLzEQHW7GaPR8i4TP9k2hSrxCF0IA0DTPolQ==
X-Received: by 2002:ac2:568c:: with SMTP id 12mr644601lfr.133.1569266259990;
        Mon, 23 Sep 2019 12:17:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k23sm2525253ljc.13.2019.09.23.12.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:17:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id t8so10968116lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:17:38 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr684575lfp.134.1569266258665;
 Mon, 23 Sep 2019 12:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
In-Reply-To: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 12:17:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNEGetrwyShSLP_5nCA2+YTR9kdNFw7aLua9jaR-YvJg@mail.gmail.com>
Message-ID: <CAHk-=whNEGetrwyShSLP_5nCA2+YTR9kdNFw7aLua9jaR-YvJg@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This is my first direct pull request. I think I have followed process
> correctly, but if not I will attend to my error as required.

The contents look fine.

However, it's from an open hosting site - github. Which is fine, I
take pull requests from github all the time.  But I require that they
be sent using a signed tag, so that I can verify that yes, it's really
from you.

And no, I don't do pgp email, even t hough I see that there's a
signature on your email itself.

git uses pgp too, but unlike pgp email signatures, the git support for
pgp signing is useful and user-friendly and just _works_, rather than
the complete and useless disaster that is pgp email [1].

So please make it a signed tag with "git tag -s" and ask me to pull
that tag instead.

                        Linus

[1] https://www.vice.com/en_us/article/vvbw9a/even-the-inventor-of-pgp-doesnt-use-pgp
