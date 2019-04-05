Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F58C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0A121855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbOLckE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfDERSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:18:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42464 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfDERSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:18:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so2171117pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqVjLLqJXHIVHZRkw4agyBYtGmnqgKev2T7NptFo8e0=;
        b=EbOLckE+QInONXLlNWKYel3NJGiKrh//28V6JiKHoekXnaWJEOnMA/wzzTMpAn+4V1
         Q1bih10evC9y95Y7l5Zjr0W7971tdPOCfbQrbh9sVt1FA2URixmRsPx4D5prztDqLPOU
         YqmEGNC6nw62YsYqXfpFnJKvEV2EhhpUuB2FudqgGdTqOtc81ZHgH8iJ/SuTteMIhEgs
         dhUfoNbBz5QQS35qgPREc1YHs91aYjB4BOwHsuFDYyuaTnoqAsIG/ViuXAYF0PylhP/t
         udTQF+imui84rIiFW0DfrQfX7CfoTWH845a0yXTOG+H+2wmMaick2516HKYeUcL08TIb
         Rxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqVjLLqJXHIVHZRkw4agyBYtGmnqgKev2T7NptFo8e0=;
        b=WPK9+0dKeuWe7p8VJ+W0GTpqyFCNxqAEmuf8a/klTYN9r5whu7kPyHLwkqIa0iAzR7
         ftxEfEi8d9iACKHeZAHmTbDEX0jZO8XM85bVKPd98n9L7f8VMcnDnHbwBMk+2m0xwqQD
         STQPvU63TTzled8mClYoSKZfzeukQir+QmP07FIdniSgizeqQdd6i7sBtsZgu0wXqosY
         99Q+LJ9eudRKpq5njR0KlOq+WcKIO72ENUrbj5HpjOFKonGtZ49SCEDa/AC5QKnSqp3a
         dZxupwStpbs9ueJSxQefio7wjalx/6Yjz3kr8R/Y1/W/iJWOM0meZObrDRV5E+HZY6Tf
         Hb4g==
X-Gm-Message-State: APjAAAXYWMKqsLpfKuGSmPG64uqjeuw91ixoLr2AKjdZgk0LXHcwHsr+
        K/8KIupF2ppupEyDlM8Ol8r8WUdgX6wA2sOS7XtfVw==
X-Google-Smtp-Source: APXvYqxJZn7bBf4oXeCAzQ0xcYU7w0/3wcsx2rsWjz5yyvb/Q1eD2mX/xF0s3t1Ors8XGHzn5yU+BfWd6gHp1LZ8VdU=
X-Received: by 2002:a62:14d7:: with SMTP id 206mr13520128pfu.162.1554484717893;
 Fri, 05 Apr 2019 10:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190402030956.48166-1-trong@android.com> <20190403152719.GH22763@bombadil.infradead.org>
In-Reply-To: <20190403152719.GH22763@bombadil.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Apr 2019 10:18:26 -0700
Message-ID: <CAKwvOdnJLOCKXZQcrCrsM1j5b4U_0vdV7JhbDtBUdLe3cMYp4A@mail.gmail.com>
Subject: Re: [PATCH v3] gcov: fix when CONFIG_MODULES is not set
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 02, 2019 at 10:09:56AM +0700, trong@android.com wrote:
> > From: Tri Vo <trong@android.com>
> >
> > Fixes: 8c3d220cb6b5 ("gcov: clang support")
>
> I think this is the wrong fix.  Why not simply:

I spoke with Tri quickly about this proposal and we agree it's a better fix.

Andrew, would you mind dropping:
https://ozlabs.org/~akpm/mmotm/broken-out/gcov-clang-support-fix.patch
?

Matthew, would you please send that patch with a commit message?  Or
if you would prefer us to send with your suggested-by tag, we can do
that, too.  Whichever you prefer, please let me know.  Thanks for the
suggestion.

>
> +++ b/include/linux/module.h
> @@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
>         return false;
>  }
>
> +static inline bool within_module(unsigned long addr, const struct module *mod)
> +{
> +       return false;
> +}
> +
>  /* Get/put a kernel symbol (calls should be symmetric) */
>  #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
>  #define symbol_put(x) do { } while (0)
>


-- 
Thanks,
~Nick Desaulniers
