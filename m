Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8A20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RdiX+5x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfE0SHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:07:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35968 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:07:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so4223716otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgdAS9QmA+kymmNkQFCc70wQxZNKe+LAPHfdbYWWNfs=;
        b=RdiX+5x97w6OwJDSWefjcNdvbOMuBwDoYzdemIbi1EC9zJY/jnJxjq73rbhPUy5Gp0
         5WcerhbzlpmR8zxHrLCmMNTD0AwH4OziEYn2lGl+CvWL58RXUvfAHVxAraZg+gQ+dvQo
         0XNeO96gK+zlOa5WVuhJjfgRP9auy6lUqQDYRwCbD5pnfj5lxLJdu6jvbUgKrXFjJlcy
         WLXe2IOIhKfDcra2vZlEenW1HThjLw4og2SLQP1wxPhcrzgi+H+iFrqzs1VlQO+oF17W
         3fpk5k7RmMbYga4hDydvtqMA2OAaE79u28vhaEscZatdQ3X0iBX+SzuLSAgnw7CgUJkX
         QSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgdAS9QmA+kymmNkQFCc70wQxZNKe+LAPHfdbYWWNfs=;
        b=fAgP3uZmMbLPSHj6ExNsd42ZbZRICuky+kVhSME5GyMFlOh0CvcBeyhM0DHt7VT3Vo
         gQuQgASMhf/KjepwyKg5tjrDad5UJ+o6cT+TjTUbaneO8P/ix0BHn0UwiJhZ7beF+qNY
         W9pQlrHO5/lhIN9Pu/Dda3M1vMU6xdw8NJ5EpvVvztu6mNbgNRHXrJbYX1p3CiKtyWOV
         TkITUZU615E1+Xmw12JrYpzXzd8SthL+xFFCJY+Sk/aKdIgYOwovZHUV4h42zOD/CO4K
         HsA5s94UgomsByvmBTdTELvIuYo5Bl075c+Bs/FMmea2RudDPGXGEJzXhk0Vd5sgDmFC
         cYtw==
X-Gm-Message-State: APjAAAXUgvx9I4IACHKqAb4OxM4yv3BkUqAmORB8uvPDmnV7E6EABeyO
        ggEHehyPPWEQtCTUuLgiG3WceQT9oz9e5kBGQ+8=
X-Google-Smtp-Source: APXvYqyAOgJ6VVk72xMf8ZhSixSYxxi37uMWq89IE4E5NvqQ/aeeb41CgR4FNVUgkOF/sHyiicjwCR6Kz4EyMPOQ2ns=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr71815029otb.42.1558980458177;
 Mon, 27 May 2019 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-8-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:07:27 +0200
Message-ID: <CAFBinCB4Ss6S7L2J6j_gVW3yFVW6puysGPD+xDO536-g15uquA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: dts: meson8b-odroidc1: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:40 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
