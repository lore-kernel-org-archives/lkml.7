Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B215DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8822520873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWc9Lgb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJaHMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:12:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42376 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfJaHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:12:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id a15so4972898wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp3Ez8VC0XFbaT+hgR6CPrD+SWbALo91LUbFh4nLv2I=;
        b=BWc9Lgb4ffE/c6zKH93LKOotgFgvzrf7Iiqx5peY+b+phsQPhNRoSKurM7+SOk6tXd
         lGdIiobByRKpNPxkENxN0xzPlZzsmj0GfjRlUHaNz/KxMjdB/VaGd8jc0+PMoqUN+8ie
         Y5YAXsNluRkWlsBv5eO9bueZtKTFLROkx8kNoHnKREeD/ScZwnNxJeIbKtufpihY2U/d
         7tft9dDX3FxSR+eTX+ZHMf848+ZYfw/fdj9rdvCxKuxsfNk0y2mqUP5By6oNjf9QkzFU
         34/WlKPOQq8eWyxuJYaKCWGKVPaHdSyaTHT5STGCZo6FRCOZrQ3m7hWhxcwU2bh/ArHs
         fEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp3Ez8VC0XFbaT+hgR6CPrD+SWbALo91LUbFh4nLv2I=;
        b=ssaaugf5A6tv4wNPRlt9g4JG7SLVMZnSxyDX2DRe7w2A74hwdfu3XwHk6uz8P5i+IQ
         yAtDWHNUo49hhg2RCqMafZ6eX7a04vXXiWXRyrLX5L8DtsPMp+kCQjM/DQnHI14QarpJ
         LSYWbTUEPZECa3zeWtBEcktrH0twlSdhRRlZVYdRVV6JV3NejZWqy59JwZx1iN7ck3K6
         c3+0RsJ/AWg2k1MYDrV/DTqI/voJKPg8dJpP+VsFm1Ohj2cideZS6Dpyh7lWnLyFYHlh
         fQiYLro7wtge2KFwAasifwWNgvKey+MqGvr1gl1GybPxD5zRTeClnk8SaC/6GmSVazxQ
         /MKA==
X-Gm-Message-State: APjAAAX5C2azlb8OSZNj82ehYQxIHvJCglZtNJ1G9zy+6PUz9OrLIele
        qUoKZMF19h8YgVx0+1sT/5rf+w7uhPbHybPLJ19Thg==
X-Google-Smtp-Source: APXvYqx48Sm/Pjqigtw0m+ZRHtBWYpse3AxLPAsfUZ1r9FmyFacpaSNqXi6jIvay0nhWPZqFnokYv/fVf0lF8NoF3IM=
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr4001921wrx.394.1572505954230;
 Thu, 31 Oct 2019 00:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191024224631.118656-1-davidgow@google.com> <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam> <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030191255.GD18421@kadam> <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
In-Reply-To: <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 31 Oct 2019 00:12:22 -0700
Message-ID: <CABVgOSkKCXodwi=RcmRpB+t157surmEjq2b+92VQQD2Cy0WTvA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to agree that it's better to either fix or ignore checkpatch
than to arbitrarily change things in cases like this where checkpatch
is obviously wrong. Equally, it certainly seems that there isn't an
obvious way of modifying checkpatch that will both not cause other
problems and not add another arbitrary name check. The main concern
about just leaving the checkpatch errors in is that people might be
automatically rejecting changes (or worse, the whole kselftest/test
pull request) if checkpatch errors are present. I'm not sure how
likely that is, but I can understand the desire to be careful, since
relatively minor changes have delayed KUnit changes before.

So, there are a few options, I guess:
- Hack around the issue in the patch (as this v7 is doing). Ugly, but
does at least mean that this change won't trigger any automated
rejection-of-checkpatch-errors people might be doing. (Even if, I
think we agree, automatically rejecting anything with checkpatch
warnings is not really correct.)
- Accept that tests (and other functions) with "for_each" in the name
like this are rare enough that it's not worth the complexity of
supporting it in checkpatch, and taking v6 as-is with the checkpatch
errors.
- Modify checkpatch to handle this in some other way (e.g., only if
the name doesn't include "test"): I don't think there's a perfectly
clean way of doing this.
- Modify checkpatch to make this ERROR a WARNING instead, since we
know this check has some flaws in this test, and potentially future
tests.
- Re-send v6 with a note about the checkpatch warning in the
description, so that it's easier to tell if one or more of these

Is there some combination of the above that sounds good?

-- David
