Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1ACC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9321479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VIMO5j89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfE0SGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:06:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45364 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:06:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so15474693otl.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=VIMO5j89eAKkZ3BZaR3UNVrOBTq8G7EzDz2d7UVeCRB3QmXVlk6gO5QBY6a+zqiSwq
         XeT5TmkLs6P1XgBDRpyJBEVhem40JqYvx6iuHyspme1Kqc1kSXc2P32gr5PS+Da4sLRs
         2kCm7xAkLqqaxYpogKocEDBaRqkgFZCwEcnTupyT6lVj+5Hno8Pp1DyqTzaem3jl5VP8
         3tduNdligrKsnpDlQTofcESHOElwHQuM46FMAclszjZLa5I3MbX7c43WVg253VYEXXfr
         oonqzC/yZDOC2f2eX24JhPWEv/1HGnIhgG0SJSiMHLhjOgnMZTJkHZgIC4BoiAxlxFgj
         ZMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=fly9xOorePKC5mvOjaV1AIz+JHDMw2OpOXd1rR+od8+zpFVjVFBH4hDaf8OeKXEzpN
         JAdt027OQqwmbANh2dghLcW08KSPTM467dulIBRu+RRbF0uEAQRM6TY5hbjcxV25hJo7
         2/Z567ZYFm4L87ZoP8DlQ9n+j/ULh97i8XjcJBH83DuI0KAg+0QGq/gG00L6/iG30ezI
         8NJVNIbyCBaJlMo6tKfyTZyx9gYgMSmm6lsC0DzY6GPbwsgZxanQ4CKaAAVCNwLIBQHe
         pyfGKTn1gaosi9csTq/nm3Oq+z+ZBngzA25BIFUmKa9IWrojHyfWvtw5gyXwRWHn/qma
         +IqQ==
X-Gm-Message-State: APjAAAWyOnh6ZF6jBjOQNrlKsaY+YzNYEQL6gzMTFo6fDjzFIsze7Lek
        y5+TlBjw1Gtzyn2ymhBU8uo2D2VPcqWmqZE0j7w=
X-Google-Smtp-Source: APXvYqzNvbybIxun0sU5draEQ7ge3c2t/2uDs569BXI/oeZpZdVW/zg90e+PwWX1spRmfHdTfLHxqYz6QYBGe1UcujU=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr61296326otb.81.1558980407622;
 Mon, 27 May 2019 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-5-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:06:36 +0200
Message-ID: <CAFBinCABE=C3LP+8kxvBiuaiXVmKM6j1Tkxhi7tdXZcRy=qJNA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ARM: dts: meson8-minix-neo-x8: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
