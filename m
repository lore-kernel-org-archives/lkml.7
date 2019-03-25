Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267620830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4zSqohN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfCYQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:02:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44464 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:02:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id u9so6358679lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B59KWmFqLDQ8Lpk/GuIHhMUic5JXGIjadcLDLnRY6y4=;
        b=D4zSqohNAWqzhy2DZvULe8TfcVPoXUUFc3wVt6Rcgscac9F2tl4a+F1h6wf4pfm/nG
         8XAwZq4cxFqIF63f0rmNzgN8tNjeqRTVKjk6lRQJ3EGzt91P6Eo+4HZGsl9Yf2xP8Qt4
         Uaov38CTaygFAjjWmDPsEM5WgYJiiaXjPoTGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B59KWmFqLDQ8Lpk/GuIHhMUic5JXGIjadcLDLnRY6y4=;
        b=MiT6ksHShTN3BJKE3ecJ5hFzam4YmdntiqrxQqqqxXBYIc1Y5R5t0oavpnyVk6Nogm
         m+xkPFwZ6evfwRiL9lO2TM40mN6UcNGH6MMNcLFRwJSFjSgPQ23eTlrDPiCHo6Ie4UWV
         pmi9qo8T8zbQoPO9d7hoD3hO4zXYFJ6nFNwp7vu2RKC52GavxjEAG5jD6ZOSEf0DzZnq
         Hl2PF8xmhVQssAHk91OGgxTso5bS+4Z0x/G0etrK7Rubuz34UWkNoM+IY/JcujAJ/7/K
         3tkizSxyE4LIMJqv86fP/mUqogsdC+yqf0w6Xj2JgdzAysPQ3XbphViL/YNgLg5KzVVI
         25Ww==
X-Gm-Message-State: APjAAAVTya3vJEsYikUFQHgpKvdrWUSlzBKTXWETJxbWpxgMJJA3iGwG
        nUeieSicScF1AG/1wWuEdhrWSHqaIAU=
X-Google-Smtp-Source: APXvYqwsLWsY3m1RO6/0WA5IFAgi9nDjwyUqGathakLM7sj8teVV1QOYRkIpm7S630nDTFwJPLI6wg==
X-Received: by 2002:ac2:424c:: with SMTP id m12mr13697970lfl.62.1553529745206;
        Mon, 25 Mar 2019 09:02:25 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l16sm3512382ljb.24.2019.03.25.09.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:02:23 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id t13so8321000lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:02:21 -0700 (PDT)
X-Received: by 2002:a2e:12c4:: with SMTP id 65mr13712119ljs.141.1553529741345;
 Mon, 25 Mar 2019 09:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125704.6585-1-hotwater438@tutanota.com>
In-Reply-To: <20190325125704.6585-1-hotwater438@tutanota.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 25 Mar 2019 09:02:10 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
Message-ID: <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Vladislav Dalechyn <vlad.dalechin@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com,
        swboyd@chromium.org, bigeasy@linutronix.de,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com,
        Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladislav,

On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
<vlad.dalechin@gmail.com> wrote:
>
> From: Vladislav Dalechyn <hotwater438@tutanota.com>
>
> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
> caused by an error setting the correct IRQ_TRIGGER flag:
> - i2c_hid incoplete error flood in journalctl;
> - Five finger tap kill's module so you have to restart it;
> - Two finger scoll is working incorrect and sometimes even when you
> raised one of two finger still thinks that you are scrolling.
>
> Fix all of these with a new quirk that corrects the trigger flag
> announced by the ACPI tables. (edge-falling).

I do not believe this is right solution. The driver makes liberal use
of disable_irq() and enable_irq() which may lead to lost edges and
touchpad stopping working altogether.

Usually the "extra" report is caused by GPIO controller clearing
interrupt condition at the wrong time (too early), or in unsafe or
racy fashion. You need to look there instead of adding quirk to
i2c-hid.

Thanks.

-- 
Dmitry
