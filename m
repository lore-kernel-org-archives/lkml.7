Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E3C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA09206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpa16NEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLIVTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:19:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35631 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLIVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:19:15 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so14120314ild.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+fINYfX0WThUMVmPz7Se9rxOk/QEnp1Ar+VHOYBVxM=;
        b=jpa16NEuZwY2KSfk6NP5RUXRbZTqhOxIOn2ULnB+NQIxcDKg4iwohsasp3jzuTuHAb
         TgUg2VjcSreaaNF1TxupKHVp3rONn6ZriWLhvEyhlf3aIXKMvpmF2XG5Q6nzjYFXmXmb
         QhT3AdjSQXpcBJmnXhpX20x8D9bYKVGNoen0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+fINYfX0WThUMVmPz7Se9rxOk/QEnp1Ar+VHOYBVxM=;
        b=AkJRhyknRIDdJj0m6VVVHmamrnY/jDAQiz0Q8BZj+ErDWMNWDXF8B+6InkRTUIIxQY
         0BuT02Z7xvi4MbiCOMC3T7n9gLYB3TJv7xCqN6H9vg3vi9McPqsp/E7IaTk5Vng/KTTb
         jo8lERSXWmCEQWIqj6GldhjkX55I3COChLkKBPfAH+kXs8MxK2bhJZc0hRnBQBG5GzYJ
         iWIULd/oPqc0QcpyrxG6ss1Rj7rz1e8VK+ebVN+h3RV7sIqb7mT22KmjdYMaiOsBJ5Gk
         mAvY8VJfRztQpLkDQpCWRuOiBWSAZFw72Xe9QAvm9hNCKOmNCnqmwhEt2dSJo3KuNkFS
         xdCg==
X-Gm-Message-State: APjAAAWl7ddRv65zibAJbfPjKiBc0AjgYUD7Wi3iP5knjazdrR+Q5h0n
        QyQd20Un8rBVI7RmmRg02kaGqbXwR48=
X-Google-Smtp-Source: APXvYqxmPzCdnnANb/BAmlBjNhUmbG+FKLnMKiUUkelpaGeslGo9VYtaktmWAxStpDIbEVb2hRDjHw==
X-Received: by 2002:a92:8c90:: with SMTP id s16mr30927942ill.38.1575926354555;
        Mon, 09 Dec 2019 13:19:14 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id y11sm204372ilp.46.2019.12.09.13.19.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 13:19:13 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id a7so14104758ild.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:19:13 -0800 (PST)
X-Received: by 2002:a92:d581:: with SMTP id a1mr27952212iln.218.1575926352743;
 Mon, 09 Dec 2019 13:19:12 -0800 (PST)
MIME-Version: 1.0
References: <lsq.1575813164.154362148@decadent.org.uk> <lsq.1575813165.830287385@decadent.org.uk>
In-Reply-To: <lsq.1575813165.830287385@decadent.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Dec 2019 13:19:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpyONBT_XcKLRj2qkcJHkVntoHJJs=tYbVjzF9V10ziQ@mail.gmail.com>
Message-ID: <CAD=FV=XpyONBT_XcKLRj2qkcJHkVntoHJJs=tYbVjzF9V10ziQ@mail.gmail.com>
Subject: Re: [PATCH 3.16 10/72] video: of: display_timing: Add of_node_put()
 in of_get_display_timing()
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 8, 2019 at 5:54 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> 3.16.79-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Douglas Anderson <dianders@chromium.org>
>
> commit 4faba50edbcc1df467f8f308893edc3fdd95536e upstream.
>
> =46romcode inspection it can be seen that of_get_display_timing() is
> lacking an of_node_put().  Add it.

I don't object, but I am curious why "From code" got turned into
"=46romcode" in the commit message.
