Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C36CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C270D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="xdNyogpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ3K3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:29:39 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:33287 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3K3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:29:39 -0400
Received: by mail-qt1-f169.google.com with SMTP id y39so2524937qty.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czU7HzP6DFG+QGZIivdRBvNS5jNlduf8mAt1YzDvVTQ=;
        b=xdNyogpac3p0FXHke3oPRulvO/IxkuAWDR0O0Nne+5pOEOjBIxFW8YjEep/S/4uiob
         iBC+kiOv1hL6/bnDvQIEflQFK64XqzIjIdH9griQU8Rq+L7unmcwa17TOW9kj1iD6PDJ
         9BGjVnYwQljoLGxHbv4bUS3CxH+WMBh43hXm2VpViujVyYhNhz948P3ey+0kCYwLbzlc
         SbeVKYj27oTxlHDZ69u/7RvKp9y2MVeXOLFVatbR57PIKOogDr3jLv8SCQX8rSFUXKA+
         uuJHugeXxnLU6oX3fF2Nv7qC6caMQxUzBaMHAk1xLlfG8dHrG+spE8Fo1w0Wc9gOdUNJ
         GHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czU7HzP6DFG+QGZIivdRBvNS5jNlduf8mAt1YzDvVTQ=;
        b=QDUJDQuBtxnCKT4UH8I358ndA3mHM+xA+cUHjX6559XZj3ExY3TwwH1rthbOfSivb8
         51kQ7hpIkY7J3fVrbBXiqus0sGOqpnbqaVrecudNjRmZVTcwCVImDeidLuFf1D0nOXeE
         Spi3kezE+vgcZvS6ajdQqyWcbaYJJQ0Bzhvi/alJqrQPfVCpXLHhXxjXrKvmMDMh0LYl
         wlS+jNHH68pisT5nBQpPHZ+lmJQJdNJ0sKanvkrjy/dzWETcpo7GnndPLAqCShzqHuyN
         C3KZ4o9a6976nprHUSC/KDbMM7PtK7Ci4uFKwvJspncVZ+0yifmE6klIKajueMUWI1dL
         RvSQ==
X-Gm-Message-State: APjAAAVSZnDqFjEUuIIAiDYlfwRhs+Omytw7E55hFv+XqjcZ2GjaCiXd
        Dt0JRVAOCDNTjQoxTkRI+2iLzRoH68ziXW7uxfvd9A==
X-Google-Smtp-Source: APXvYqyY5T2WwdX0mJSYsnJh3/hfizo9f9VHhqy+xUHwQ3zrHKLOjhlGB6++spXWfoRSWXGeqmjHu6gLX3V8BxO6H64=
X-Received: by 2002:ad4:43e5:: with SMTP id f5mr27717464qvu.37.1572431377931;
 Wed, 30 Oct 2019 03:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwcMqyOLJFPcVyoGuiXo-ujeyzL2TJkpZ3qAc1HymJ2x7A@mail.gmail.com>
In-Reply-To: <CAB4CAwcMqyOLJFPcVyoGuiXo-ujeyzL2TJkpZ3qAc1HymJ2x7A@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 30 Oct 2019 18:29:26 +0800
Message-ID: <CAB4CAwdsiknt99wk7akPFtsC6GQHtCViecB8k1QZW7-OW5ffvg@mail.gmail.com>
Subject: Re: Unexpected screen flicker during i915 initialization
To:     Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 6:25 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> Hi guys,
>     We have 2 laptops, ASUS Z406MA and Acer TravelMate B118, both
> powered by the same Intel N5000 GemniLake CPU. On the Acer laptop, the
> panel will blink once during boot which never happens on the ASUS
> laptop. It caught my attention and I find the difference between them
> but I need help for more information,

Sorry, I forgot to mention that the problem was reproduced on the
latest kernel 5.3.

Chris
