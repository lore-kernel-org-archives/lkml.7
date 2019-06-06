Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC467C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu7nnn9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfFFUyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:54:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFFUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:54:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so1394318plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YoJ3njYYHju4gWF0UDBaqx7cQlwNKwpKTA90sZyzSuQ=;
        b=Nu7nnn9vfPpPz7sJxzqHoDx7JUBZai+/vvUUZYEVShpjf+/WoIFd69vDm490dRtAIC
         3/H83DydzDP+pAjIcUz9k3WNrfVW0HsVmlqELKBg8gnj0bRoyZo8MVo1UcJiTEVY2SI+
         pnj0Drye6jfQILs7l22P2xML1Elc79OSNTLn4hgwyOo/QokPL2q6Bmp14mQsmpbNN7Rk
         iksow+4qEgKgcWET9s4ApvtocM1MVqaHqiuwD9GJmJEWAY6uTTDP42BEuTOpf9/+GPfL
         WWTAxu5+ByvouWksg97xH8Dg414XiC58pgwqSdUEyZHtgoUsqO/HF76Hq1EUCG95Cvh5
         cbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YoJ3njYYHju4gWF0UDBaqx7cQlwNKwpKTA90sZyzSuQ=;
        b=IyRDWQbWkGBbUFAjIvKtbm30ZhcZT5aYe0H1tMlPSmv/MjB+nWnlIUhFM9NfTue5Zq
         kLfdeDVrvpuk5tsgkNRWffxnDcDV2wbgsXZ2PhIbN+su35tabHogcESyfL1qVZcXkFVt
         KWNbTlYHg2LttKcND4kSwHOlToLviZNr5lKgVF1ND/QdgAObQuczTjTmCm5O8cAw6Qev
         hsZMBBL6FpNzjaOw4G3KN6RH0SHp0+vCz7fX5zeFshuVoQ9VgKM7B7VXawtL0um9H/90
         nuygm67EBKExEsyJXp58f9yZlsgDbROCBMG12Tu4321h29gBEqWoBE32m37Ki+yYgMlJ
         wpDg==
X-Gm-Message-State: APjAAAVVaMrPSmERWZGBlm2PX6Hc/2Kqeeiqxz9XVERNTZ9yWkGbU5D2
        X7jodXuGg8eHJxz4530n4K5EmQ==
X-Google-Smtp-Source: APXvYqzzAMglGevfusW7tK60HbnxOfGl1ecbxmkWIc836qB8QYHrsxg3mMGRvfA5XFepfVeRePnaHA==
X-Received: by 2002:a17:902:2ba9:: with SMTP id l38mr45854802plb.300.1559854450219;
        Thu, 06 Jun 2019 13:54:10 -0700 (PDT)
Received: from google.com ([2620:0:1008:1100:dac3:f780:2846:b802])
        by smtp.gmail.com with ESMTPSA id m5sm60680pgc.84.2019.06.06.13.54.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 13:54:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:54:06 -0700
From:   Tom Roeder <tmroeder@google.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     yamada.masahiro@socionext.com, mka@chromium.org,
        ndesaulniers@google.com, zwisler@chromium.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] kbuild: Add option to generate a Compilation Database
Message-ID: <20190606205406.GA120512@google.com>
References: <20190606203003.112040-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606203003.112040-1-rrangel@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 02:30:03PM -0600, Raul E Rangel wrote:
> Clang tooling requires a compilation database to figure out the build
> options for each file. This enables tools like clang-tidy and
> clang-check.
> 
> See https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html for more
> information.

I'm glad to see someone adding this to the Makefile directly. I added
scripts/gen_compile_commands.py in b302046 (in Dec 2018) when I was
working on using clang-check to look for bugs in KVM. That script
sidesteps the -MJ option because I found that trying to add it as an
extra option ended up adding entries to the database that didn't work
properly in some cases. This patch adds -MJ in a different way than I
was trying, so I hope it doesn't have the same problems.

I would much prefer to have this functionality integrated into the
Makefile system directly, so if this works with clang-check over all
files and doesn't lead to spurious entries in the database, I'm all for
it.

> 
> Normally cmake is used to generate the compilation database, but the
> linux kernel uses make. Another option is using
> [BEAR](https://github.com/rizsotto/Bear) which instruments
> exec to find clang invocations and generate the database that way.
> 
> Clang 4.0.0 added the -MJ option to generate the json for each
> compilation unit. https://reviews.llvm.org/D27140
> 
> This patch takes advantage of the -MJ option. So it only works for
> Clang.
> 
Can you please add details about how this was tested and compare
coverage with the existing script?

Tom
