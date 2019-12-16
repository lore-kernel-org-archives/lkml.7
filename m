Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ADC20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="b6X1jWpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLPGBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:01:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33601 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:01:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so3387856qto.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 22:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2z51NNQPGTMFGtesof0cLcp5BmT40GR+s1mJAxOa+c=;
        b=b6X1jWpTP0RfxR0H/2AEWnknIbaWzzhiV6iFVLwl6X9CxbOBNzjE5GUcxjZ7hJEUAn
         Zc7OU2vHnDk1a726t9a0s/+ZZTMU1TeZTPhtju7Oi59MiMONTQOtK7D7BoAGFq/3OI0q
         8RTFbo/jAklEfgL4DoCUxqRT6V9fIOgVreE/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2z51NNQPGTMFGtesof0cLcp5BmT40GR+s1mJAxOa+c=;
        b=eW+VDG65+PBKFdiE8bHUvxrIYVRfD/x+dJP/HR81U8c6M9x90HsIfehUYgaCh46hMR
         fMlbvECBeENoMJ1jea0QJqoQcko4kNJVjGQ6mFI3Pj4SmhfU1w3yoZYgD2p9V86XySHO
         a1+dm7oIU5q3veF2U2zdMBHi7TgQNJmaquNOzI12OqlOU/lppIyRhFUGAbrLdCDC76Lb
         ioAcfcGvID+bUgdf7dHHKXe/ya+204b/ZFjFwzpevtLtJkYXU8MzBqAS4dI/q6MlkZAP
         kQ3h+k0P2eTYUl7mokr9W22x66ypYDxAaR2HU7Pbl90r7mqjzENVgvCKzXaI9N147aKd
         2m+Q==
X-Gm-Message-State: APjAAAU7VCKD3hbjR2JP7V3zQferyXPGY9M/f15eTa3KG0n2gjb/pYjg
        MBdcuZhfmIfhwFMMP8l6y5KwGlngz7vsZ+yr/g8=
X-Google-Smtp-Source: APXvYqwPky1kIBq5TGeLsTIdyi7DvZWNnzatsH+kjC7TN4z5yU4h0spZkmjXTrZZd+qsQ9tWkqeQPGyHHbV6+3Lse00=
X-Received: by 2002:ac8:3467:: with SMTP id v36mr22831465qtb.255.1576476081509;
 Sun, 15 Dec 2019 22:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com> <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
In-Reply-To: <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 16 Dec 2019 06:01:09 +0000
Message-ID: <CACPK8XdgGLLT=RprY8zVW6kKJ6fjJdm4Oxs0uHBv-W5StMyGPQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 00:30, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 4:12 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
> > order to build some ARM drivers under UM. Do you have plans to fix
> > that too?
>
> The only broken configs I found for UML are all listed on the cover
> letter of this patch. I think fixing COMPILE_TEST on UM could be
> worthwhile. Did you see any brokenness other than what I mentioned on
> the cover letter?

There's a few more in drivers/char/hw_random that you would need.
These were HW_RANDOM_MESON , HW_RANDOM_MTK, HW_RANDOM_EXYNOS,
HW_RANDOM_NPCM, HW_RANDOM_KEYSTONE.

The only one from your series I needed was PINCTRL_EQUILIBRIUM.

I applied this:

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -91,7 +91,6 @@ config INIT_ENV_ARG_LIMIT

 config COMPILE_TEST
        bool "Compile also drivers which will not load"
-       depends on !UML
        default n
        help

That lets me build. However, the code I was attempting to enable
depends on REGMAP, which needs IOMEM too, so I hit that dead end.

Another issue I had was debugging my kunitconfig. This patch helped a bit:

--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -40,6 +40,9 @@ class Kconfig(object):
        def is_subset_of(self, other: 'Kconfig') -> bool:
                return self.entries().issubset(other.entries())

+       def difference(self, other: 'Kconfig') -> list:
+               return self.entries().difference(other.entries())
+
        def write_to_file(self, path: str) -> None:
                with open(path, 'w') as f:
                        for entry in self.entries():
diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..0f261bc087e4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -107,6 +107,7 @@ class LinuxSourceTree(object):
                validated_kconfig.read_from_file(kconfig_path)
                if not self._kconfig.is_subset_of(validated_kconfig):
                        logging.error('Provided Kconfig is not
contained in validated .config!')
+
logging.error(self._kconfig.difference(validated_kconfig))
                        return False
                return True

Which would need some tidying up before applying, but helped a lot in
working out what was going wrong.

>
> > Do you want to get this in a fix for 5.5?
>
> Preferably, yes.
>
> > Acked-by: Joel Stanley <joel@jms.id.au>
>
> Thanks!
