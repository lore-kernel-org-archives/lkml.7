Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18EDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A989B22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ol+VAJf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfH1MiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:38:17 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:41043 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1MiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:38:16 -0400
Received: by mail-io1-f53.google.com with SMTP id j5so5475678ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9ub6dj8BakJd5JJrKLeLyNZnt+cLi7XQzPxfXn1B/Y=;
        b=ol+VAJf+uEe+pW+OLeIh97TD4/T+F5ti0j1SOXt8p3g3+9AxRgrzHA2mKJ5vaZU8VN
         Mtw2wgGYnnDXzVmxqToGtF2nfMvHrJsaRTKUm6NFeBvnBEL/AE1VgB2U4A+TnFgGlFJv
         N3OutN+gjpK3Rrv6OQryvih8Y47Q1kTDwWl9GUwd8SvcwKziaGAnwe7nyHPNsvpwQUma
         IX11hff05i2Q3HWy3nNHliuIoVJgJZC4rPy7abvo469srBQp9xh3rCEfMD2lAM1jknIq
         8/zI0DqvJJeFJiUb98QaHvF8wwP/1clSTYqlKYm6UCHQpY3oSvVrXFAXBEEbPpXvHWuI
         boiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9ub6dj8BakJd5JJrKLeLyNZnt+cLi7XQzPxfXn1B/Y=;
        b=M5hy5AV+WLKIuE0zUsKubi15ZSOfUr6HnQ9jPitgSYLFS6jqKQC9WfjheclBy3T3x6
         rpHwS+N+poMY4F3i/NjEw7/7sNTjz6zr+nW4/WxKMDRe+JYFRFvAjeIBPHVedtvcP7Lw
         TAvgQyx9PShQv6DTUxS3N7GMXUH/qrqhn1gSrFy9gxR4fYto0JbJxv5MflHL9AAcVPQW
         eEa0gXYze0tzZ8d1DJskoj4ajmKzjFq6/2/j65RzeN4LcI42+wfH4kLzTQ/prEh9uyb6
         o0VcC9fR66OnWBS9RMCmRr30jA1LUMhknUqGc3Md/vegwGMy7+iuvJ3cqBkjcXqdIYbe
         bYOQ==
X-Gm-Message-State: APjAAAWIFFb7tvTzyma/sMzhaKlQT22yDU7Jvq6592cMnbVa/031PITR
        WK94ev7iz9Tj8Ujm1hebYX7QDdaFh85q0sqMnCx4DA==
X-Google-Smtp-Source: APXvYqxbmqQHdWluIFStqQGMBY9/BhbwVz+UeYCfBFj2T06LLlJsyfJiSeDsrC/N2EuGpd3vnE0wVob9VErTw280+4w=
X-Received: by 2002:a02:3446:: with SMTP id z6mr4201108jaz.105.1566995894846;
 Wed, 28 Aug 2019 05:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com> <CGME20190814104630epcas3p44755443f37e78b2613f7dda35d71bb71@epcas3p4.samsung.com>
 <20190814104520.6001-10-darekm@google.com> <6bbfb6f8-15c2-9ad2-8857-898f4c6435a3@samsung.com>
In-Reply-To: <6bbfb6f8-15c2-9ad2-8857-898f4c6435a3@samsung.com>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 28 Aug 2019 14:38:02 +0200
Message-ID: <CALFZZQHZrVSaKhTSH6suOc0epMQzcgxAHddoJGxvtdhSp1tW0Q@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] drm: exynos: exynos_hdmi: use cec_notifier_conn_(un)register
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, Aug 28, 2019 at 10:39 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> nit: I think err_rpm_disable or err_pm_runtime_disable could be better
>      label names.
>
Submitted v7.1 which replaces err_runtime_disable with err_rpm_disable.

Thank you.
