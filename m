Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46017C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B08206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dHlmnpuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfCECPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:15:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCECPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:15:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so4413072pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 18:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8YNstb4QLrxVpmLYdgdYB2Tp00ZhoJ7B/FWk4EMLa3c=;
        b=dHlmnpuLVh7jhiX2Hxb6J3XB35YM28IWrvr8tsfLKYcfPY1y95rjoXJHWzXZgKfWQ6
         A6NIynX14q9u4ummnm5ziT+DrXuorXn5d3TP2SYDcjvQk7Y4ClSvI3mMjdYW2UeY4oNc
         jquCzWFqZRLedKELulDUurh/5WpoKqvBrK2uNWimA7MtkB5CVZ0dWtC4JBZRLwN77lfp
         pvmiWxGQOqik4EB8oPcX1O3qaAIZ9xO3H30msXg61Srfh0GtvS8n1fiYa5/447TdmWkB
         y0+xpqK3qDgj6c/6uxqYfCl4dPmmhU06Y1KfCF2TQJq9E6GBsZ0TdcCSXN2htmGLfHFq
         iukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8YNstb4QLrxVpmLYdgdYB2Tp00ZhoJ7B/FWk4EMLa3c=;
        b=UcepkBPHJNmLmq6zVGN1LKAl4iyEqHV8kdW0bvWma0i3CP85OCYiHdcPcuoOEiEFpU
         26DuMaP9QPPcXYCFmoqhpIFXEQw1FwwXkMSQHZDWeXeCnOCVz5B3Gs+jWljDXm8k5WGi
         D7SbeJsxGCvjBcyBbzhsTDVjD7EP3MZZFyN76TyXcRKaxPRt3Mh994ea6ILfPgLtxrlZ
         Pk/Hz3TneXMHmKQ2eILjorMon2TH8UkrKE8VMd6ftUthQ5z9EBZsvi5wQBGh1Kn91K8N
         xXFud717Sik9KSAdYm3/FwoalLTJLgixpXIw3svC8T+ghw6zFDaV0dj9s7Vk/YJeMAYy
         Rf4Q==
X-Gm-Message-State: APjAAAUNiq+Pev6vs+mx4NY+wJ8XyBeu4ORtONUVujly/gDlgshUfYHu
        vwKGmi8d1AHXINpoYlwYMA+ZNQ==
X-Google-Smtp-Source: APXvYqysVRGGJ7I4kULXbapOjvurW49KUNLNlVLoZiW/ceU7gg+x4YdjsiXj8MkMQtQJsSshGAp2GA==
X-Received: by 2002:a17:902:aa06:: with SMTP id be6mr23873455plb.57.1551752123170;
        Mon, 04 Mar 2019 18:15:23 -0800 (PST)
Received: from localhost (115x125x248x66.ap115.ftth.ucom.ne.jp. [115.125.248.66])
        by smtp.googlemail.com with ESMTPSA id j14sm9554741pfe.12.2019.03.04.18.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 18:15:22 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: Add and use pr_fmt
In-Reply-To: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
References: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
Date:   Mon, 04 Mar 2019 18:15:19 -0800
Message-ID: <7himwyjcco.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Prefix all printk/pr_<level> messages with "PM: " to make the
> logging a bit more consistent.
>
> Miscellanea:
>
> o Convert a few printks to pr_<level>
> o Whitespace to align to open parentheses
> o Remove embedded "PM: " from pr_debugs as pr_fmt adds it
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
