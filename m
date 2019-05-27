Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16958C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E711520859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gIoH6vOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE0SHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:07:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44802 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:07:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so12416276oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcaNvQthNDxKMvADNpdrHbGy7J+JNlWa1s2SqBcaEbk=;
        b=gIoH6vOWf1CUM7ihI4sZTjpRSzfhaHBkPyAifCAnj2KxZUk0kXB8nO9b9zBjtdIt82
         FJcq+ZakIQnwNnpacSYY8Q9XZ3kACUtY36oD5HL1S3gSqZ5vbCeTUuOwZksxbVTsQSm4
         alcasRAamdvLQYfcwt0PAKg1PMsEMaFSR8c2KJJ7H9g6GRtCYe84O3SbIcFrD/IgmdV5
         8e8aFqQ59bLfBtQ2mGJnmcoeHbKaNxkaB39HeAujNjA4qO0ZKPz32/PgFt1tq2ZGtFqD
         xkXhwYlpGhGgJa/+4y95Yt3riqa9me5+sGtg3lEwM84SJ840aVDldMz+OEol6TjSrWyy
         AuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcaNvQthNDxKMvADNpdrHbGy7J+JNlWa1s2SqBcaEbk=;
        b=ACXV5jR2X3EclMH5RO3pOwGMKqmtPQvQVDCI7QAJAQH78f09n7ciRVVWEgN90qt0P7
         2KVLhEfkNx6buH8pkCCuWBAqyglanqyQwiiNCapJj9zed+lf8Hl2knvDMgx0B4wH6v4L
         nkcZfVL7WeEjy2qowOgYHpLM41biFDds+ys7I2K0oHc7Poz3NkWU2tV+hxtQdu4SHP2q
         v4BJ/k5yzY9KI3lN5qZmyzeUS1BJhgIlDEdF0njSpLEUrE0X8q1dMtIyAJECLF4sYsUZ
         3QQflE3jQDJ4H6dWUwArdnPeNx/uJHVbICwQ757hLHzUaJF4qcwm7BbQeXg8xfZnZArj
         quTw==
X-Gm-Message-State: APjAAAXTbyGK/pZL/P6TEXg339gKGb9HfUfvKfKfaJQjJtsMzK5lg9Ul
        wwJ+33smaxoY1wnsXcg1BZQjAyP6p/On1unKXqI=
X-Google-Smtp-Source: APXvYqyKJgVpri79hGrpfwOvc1XUZLuwonSoBLbzelPi358W+vr2nCgaFj9A+/DdmdxrgBHpTBcRgN+TmPll0F1fK9s=
X-Received: by 2002:aca:3545:: with SMTP id c66mr135571oia.129.1558980468560;
 Mon, 27 May 2019 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-9-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:07:37 +0200
Message-ID: <CAFBinCBPH6pwxOEVJaJxpEqnbi1775a15Ec8Ac53nVpa6+8-Dw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ARM: dts: meson8b: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
