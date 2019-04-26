Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7B3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9392206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNRQD5UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfDZW1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:27:02 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46390 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:27:02 -0400
Received: by mail-ua1-f67.google.com with SMTP id n23so1351271uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hezVdxYa7xMFmmsHtJCJ4akvoRKAs160hgitrpcp5Wo=;
        b=lNRQD5UNUI4iKwsnvwfrvRz0oUakOCrhoZhLLw2kCVKIzeR2Ilhz6io4KhWo1/GKw+
         pfsAUJd+rZeC9IaNo7TnD/eDa1NUWCA3ikDm7wD6XscWhwK7mvVtqY5UO4jE17KjcVRF
         ggxCoAR1oyQO63WeTNk0e5foereFgXiglQAYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hezVdxYa7xMFmmsHtJCJ4akvoRKAs160hgitrpcp5Wo=;
        b=e3px3uka0Do8NkNBRwbLe5OO/aBqWvG1TPzWp+sdUDlkA7LmbHbNpMRQ09+ZTuw0Hc
         8Sqh/uyPxXEKvQv+n8E6tjjIOdMQDoESD8J0Pf/skp+qwNRYovHgeSD3tfhzxdtTYIg3
         3VumQ2Tl9q+zAkGsYGhdu19lUXrTgdVA7RTwmqdBM3zusVNli6Yl3T7NmHLRGDnONMVt
         hMQRudeMTYWLZlGF6psCm2Xf008t5NIyncpMn7pIWXinzLB+eZuYv0NLiBHvNON9vz0c
         MfYvD2QPZmPmjcGadyb8m7SdfKrF4ef/mxdNtZyS+AShxS5LiLQV58ZCqEp3icawoEkJ
         WmNQ==
X-Gm-Message-State: APjAAAU/djQ3X9YZxcUnhk5wPMxFcGXpM2n269FcjSC7HNxhiNePA8xO
        GLMohBNr9sNTnmQZXNsGAt31in4202U=
X-Google-Smtp-Source: APXvYqwsjfkLEpEeMaVDluLs+6d/LPcvSVz9qaQYHy1Y/oqoYVQoWPDa+W8yxj/5/iuzGXXS6RFEYg==
X-Received: by 2002:ab0:6983:: with SMTP id t3mr10950038uaq.142.1556317621208;
        Fri, 26 Apr 2019 15:27:01 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id m23sm37148998vsl.24.2019.04.26.15.27.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 15:27:00 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id w13so2844888vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:27:00 -0700 (PDT)
X-Received: by 2002:a67:7b53:: with SMTP id w80mr26630879vsc.144.1556317619648;
 Fri, 26 Apr 2019 15:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190319171206.97107-1-dianders@chromium.org>
In-Reply-To: <20190319171206.97107-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Apr 2019 15:26:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbHa3GrgVMAAcf2e0W5t1gc--Z2t0vWa9RhSo32w12zA@mail.gmail.com>
Message-ID: <CAD=FV=XbHa3GrgVMAAcf2e0W5t1gc--Z2t0vWa9RhSo32w12zA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] tracing: kdb: The skip_lines parameter should have
 been skip_entries
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 19, 2019 at 10:12 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The things skipped by kdb's "ftdump" command when you pass it a
> parameter has always been entries, not lines.  The difference usually
> doesn't matter but when the trace buffer has multi-line entries (like
> a stack dump) it can matter.
>
> Let's fix this both in the help text for ftdump and also in the local
> variable names.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Changes in v6: None
> Changes in v5:
> - Add Daniel Thompson Ack.
>
> Changes in v4:
> - skip_lines => skip_entries new for v4.
>
> Changes in v3: None
>
>  kernel/trace/trace_kdb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Steven: do you know if/when you plan to take this series?  There's no
crazy hurry and if you like I can sent a calendar alert to remember to
ping you after 5.1 is released so you can land this in a "for 5.3"
queue.  Just let me know.  :-)

-Doug
