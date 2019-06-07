Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED02208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7Wmh3q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfFGU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:57:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45834 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfFGU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:57:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so2583333lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYNEKon6hw5ozLF7/eHiScGkoKPZ0mKYiX3PiahFBLw=;
        b=F7Wmh3q5hTHJ7+8NfKn3Q9mrsjs4JGeQZci0PL3H7hbu3GM5K9yUsz+Y0lgGRdBSdw
         +328NWNP6IM8aUm8EjN2Pd17RWK8NOdSUoO5S7ntn/z5g5RWrIZMcumaXQai6X3CXyEz
         BTphLGtLKEzrV1gZxidM73Z5KN4zHh5E2v5y5RfDYyS3RAVcE44ehACnh+yYBOTkI6ex
         GAIvwDGuBk7jbRANq1zYREobgsZOOPeA3mYAQ+avOz6ivrRpqghggPfxfWeNmfqmhXz+
         mLgdz2EccWQ3t0kUo3VrJ9H6siVLFsY94ENBceRRT/iSvi2sqKJcgKc2W3kMsgQBPqQN
         zHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYNEKon6hw5ozLF7/eHiScGkoKPZ0mKYiX3PiahFBLw=;
        b=q2pv3skSyFEDrDBsbwE88yF5BaZZRjnTfVLEzAkVBJsOLUKVgVXhnK1p8h2L059PLG
         +wTrefKNLMWOoB8Fu5jKCJDFWynvVqu+FHHFDHGnWHZH6f+R8dp2H2qJ+Q1JS2S3zrzZ
         IOwzuaK0Pj8xJO/VcjPlGyJj6Q3/8/kFIigSDOpojSg923++kXddsndEO2vMMwGtv06g
         JlGZSzmcn1a0yH2brVpqUa1rsOPKPkGnI8zwbK2f1z4OPOZgyJR5fHca0JFclN71bIak
         KY+Dq19WbTX/IY9wfY0pasDSJtzr8WM1e7Iww4jUkDOrpWf6AYUXphe5yonBUi8FOML1
         vsCQ==
X-Gm-Message-State: APjAAAU4TWa+lhCtqUEgXUlmjT6x4zJ3MkSAslEqt8BjOY2i8NtdDj8p
        YxOpmLw2peXpvYy5meLwADSJ1lwGxM1E2D8lczxKEH+S
X-Google-Smtp-Source: APXvYqxKaiD6kl9h8t32IOzlBaDqaa1v0jAvUNt4RxTlRdfOHLS4WOZr4SjmaRPEIRLtKJJjaaIYIUpiBZDJGi0LUrA=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr15902022lfc.60.1559941044041;
 Fri, 07 Jun 2019 13:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <ab694e03ba6de8908d0a19a58408180eee3f795b.1559171394.git.mchehab+samsung@kernel.org>
In-Reply-To: <ab694e03ba6de8908d0a19a58408180eee3f795b.1559171394.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 22:57:16 +0200
Message-ID: <CACRpkdYmqGj3PC1firW2awWyi4OuzHwSrYo7n3Ph8j0==824qA@mail.gmail.com>
Subject: Re: [PATCH 16/22] docs: gpio: driver.rst: fix a bad tag
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 1:24 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> With ReST, [foo]_ means a reference to foo, causing this warning:
>
>     Documentation/driver-api/gpio/driver.rst:419: WARNING: Unknown target name: "devm".
>
> Fix it by using a literal for the name.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
