Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D95213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqZmHocI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfFYJGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:06:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34291 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:06:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so12091922lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GWdIS+GEfUG5nPSEfqs5x6+drSTvkhfOWgKSNYIqN0=;
        b=cqZmHocIds26v78FD0hZWzSrS1sS4RO1JTOTnN8GdiR69sKc9Bl3wRM71FrY4zT1UI
         2vsZVEc1VurGWpnc5fWwWLl4opKF6oHPsEd3dElV1amNVtQIGlSao7tPhq2UjqktMn1z
         vAL+TdvclegR8/3Ca7qwmr7qPJgP83KAGImVRlMbGIdW83lzO9t6hXOplajeOtyoWjhC
         om3VFvDUVKBoqmnqzcGqXQQsL8X35lrBPCxMkTklJ1eWMbvabLwGMFhWj2sQD+HgrRbg
         8LaKMdBhKqW4uIceY1H/7JwxRS8VVOB/1gFvgVEKkLViFWlS+TLW4X5uq6BVRqsaakET
         zKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GWdIS+GEfUG5nPSEfqs5x6+drSTvkhfOWgKSNYIqN0=;
        b=QaokoliEyqDYquVENTzx8w9AJFj7fWtRpxXfSU7kzJDATD5GUEWS6KoxiBwWOLwe0Z
         C14Aez7LtOsIPIyByBJJa6YY7RuWEJIDgmT3NyY8jF77GcbjmvNcxKvYy123VEGqfb0d
         5hcbOMYMD6Dk/8OkZAFDz5J/+HmKDWs6BByx6BKQAPcxMnMjVmS3iyEoUxQ1UY4InSVj
         BSq0bCMlamXgLgTHaikzvfIBgG6LBvsHT9ESvSmWWyrc7/ixqL9l7o2S50p6RtabYbZC
         UUaVkGlxXmOkVD2LfcitPAQYAMfDgzobek8SkQKyzSF2Z4cRWJlwWN4NVtzYQ2ArZyHE
         9q7A==
X-Gm-Message-State: APjAAAWr5cj9ZgoBKTjPU7WmiTi0l+5B/ByNQo4bNQiDENY0Kg47Slbh
        4OE/3SpGeKJcmoYsDSu32bkBeFKWuta8UPIM89CIziNL
X-Google-Smtp-Source: APXvYqyX8aIOrqvIiIi+XamilqaJJoRB2E+h33a7b9KRiEugg+bPenbcNtzmyITE1BuZOzB+C0AVayz8pq77sBi8xb4=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr13452923lfu.141.1561453605766;
 Tue, 25 Jun 2019 02:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-4-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-4-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:06:33 +0200
Message-ID: <CACRpkdZG4qBUxcxEmov9pHMKhVu=C=gUssaviciuV_OsACB8Zg@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: gpio: ep93xx: devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
