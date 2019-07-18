Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A51C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D8208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jv0LYAjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfGRPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:48:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37317 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:48:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so19539942lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H848abaLyIwWER/gEmAO68AwOfA/THbvpS8nBllhwXw=;
        b=jv0LYAjJ3cQrNJJG4dHU14YIsAdM97SXPVhpRIr4VVu8+9iERlESrVNBKs76k6FuI4
         5MgODQxyPDbLZqr0MrLNAQSevRvEeeGHp9UlobVgpfitV+wo4l8HV8TOibYKszCq8sy5
         tp1Rbhe/dxF1BUOEUmPucLb6xWPa9oRC8faBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H848abaLyIwWER/gEmAO68AwOfA/THbvpS8nBllhwXw=;
        b=rBrSOWj4dnUui8CkOL3HTmzL2V2+/xMZYCvZYCrV9AcS/5xPL7WTv6Thatwa9tU1om
         FAY0Zb772tbl2wtqzzuVlwo4BZSWAxpwAJZ90CbgN5kNaegzOMvbnnfmXf+NxaV5cU8X
         SWI6VfxUN5yWHNB3Kc3KFjcyJef79oAC7c++hXpE7bzwUM5VcOmvjh2FCIU8Hp1Xd5E8
         Rtvu8GjRWAhScm5q1uNQlS0TPtuyOtV2BSQvdpGdKmkqlYA/Ff1gdu7L5nGY3IhCUJeD
         Xc33Vv7FZdUmeLGxL5DM+/WU17YQh6PwzGWtKKoTa3wOxo41yKVZwOe+icsBiCLQ3rHh
         i7Lg==
X-Gm-Message-State: APjAAAUBcU4PwifTgWjpUuuMhXh+CZbAqaPnCNB/pKneTwjfe5Z99BqK
        OnwVw66oIlTgIl56zFq5ywCxRLvXlzQ=
X-Google-Smtp-Source: APXvYqxKRuDw/Tevua3yyxSZtlXPD/N+kvhz9KEid8HUaa0CFoalJV+YlVKslu6zUQzMK0bKU/s+3w==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr21728932lfp.154.1563464915054;
        Thu, 18 Jul 2019 08:48:35 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t23sm5143430ljd.98.2019.07.18.08.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 08:48:34 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c9so19539856lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:48:33 -0700 (PDT)
X-Received: by 2002:a19:6519:: with SMTP id z25mr21132151lfb.42.1563464913226;
 Thu, 18 Jul 2019 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190718015712.197499-1-briannorris@chromium.org> <20190718074522.GA13713@redhat.com>
In-Reply-To: <20190718074522.GA13713@redhat.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 18 Jul 2019 08:48:21 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM+tN_=RbgWjfajSp9aDq0vJrbLcaYsf5+69R3b-4Y=VQ@mail.gmail.com>
Message-ID: <CA+ASDXM+tN_=RbgWjfajSp9aDq0vJrbLcaYsf5+69R3b-4Y=VQ@mail.gmail.com>
Subject: Re: [PATCH] mac80211: don't warn about CW params when not using them
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:45 AM Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> Fix looks fine for me. However I think rtw88 should implement
> drv_conf_tx() because parameters can be different on different
> network setups and maybe more important WMM/AC parameters become
> quite recently part of ETSI regulatory.

Ack. I just figured we should stay consistent with the WARNINGs (and
we both noticed this one on earlier patch reviews). I don't know about
you, but for me, the whole wireless stack is so full of WARNINGs that
my crash reporter system separately classifies net/wireless and
drivers/net/wireless/ from the rest of the kernel when categorizing
automated problem reports. (And...most developers then ignore them.)

But I digress ;)

Brian
