Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75132C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E957214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Jm+dRAmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfETR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:57:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40649 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfETR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:57:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id u11so13799804otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBj9l+8qS83R4d944kCh5FZICV9c0jOFalFfN/lgxh4=;
        b=Jm+dRAmJk4amfMTF8IHYg0rsprKSINdrd+kRQ5sbvlNhiaSSolz9xcqz5WJOqkHlJI
         76EJk1DFIEYPNXg14slyvPeNUF1MLyU6/O+tfXgykme/aowz5aF9yhEN3Fzy5WdcrmBH
         FqWRGELCwOR+MVO5ICUx8bAlqvUUmRAdUQlDHe+xPCppBv6wjiendwGU/P+5LUgvg1Xu
         k8SbLt92h3PjAM6auus9btv4lq3cSNcFIZjSBwFwBPdh1Ns7P8mjmnhsIdPGStqUP790
         V/tgU/3+KaNSd331TZCL0SzKBPpHUwRV+pLANmF+SZrfIKVG/9mxzJWYC+O8D/2ks8q3
         ogVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBj9l+8qS83R4d944kCh5FZICV9c0jOFalFfN/lgxh4=;
        b=QLzzj1HoKRzMBjsFYoUlo7OMyWcgCzYAoMxOG5OvHc0fFXMXAnkxnyfKo6PVL+9u7E
         k6qEc4mf+qUg15mNL+9ytDU4OnxdNXjC/c41oM3BjyYUTgY2skF6Ps+H3gDgwGn9TPA0
         /PB07gxL9VXCq9aDMmCKLUmXwdibbwtt2S0NotsKxltEtMobhiargc2uZysQCW8S8az9
         xhlMf2nDtmq74QVrXFPOveUsyBf6UQQbiC6amIKjFNvJ3TC+lIgraaCAcMGEFl13uya3
         sNGLafeJ1kaUzghtwlRAZHBKLi5ARwWQA+af37FxVkWQ+XLur81mv+BrGCTYBojA8RiN
         wWug==
X-Gm-Message-State: APjAAAUWSKhE7ZlVCvKsDDjixp/e8k+WFHQrZtQL1v8J4W9DRu9E/imj
        lKlxQMg8gxTl8zraV+2SZU3VzwZHBssXNEsy3J8=
X-Google-Smtp-Source: APXvYqwPtuZd70oVFgnz/ZRdporflNxhgJ9AfG40Yt2pymgufhHMABwcSqDP6wbC4IbWfcsfxx5iy+4Dxo6A9QLvNEw=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr46462707oto.6.1558375062083;
 Mon, 20 May 2019 10:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190520140007.29042-1-narmstrong@baylibre.com>
In-Reply-To: <20190520140007.29042-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:57:31 +0200
Message-ID: <CAFBinCBdw9vTPOYcJO5kH3ia_bysStkF-bRvDtoKLn87AneBXg@mail.gmail.com>
Subject: Re: [PATCH] clocksource: timer-meson6: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
