Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D63C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3C922DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E3ArLV08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfHTUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:42:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39095 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:42:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so5198455oiq.6;
        Tue, 20 Aug 2019 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtWPczm67CwBeu0M0TFGverK4/MDIuIxxwNeQ9S1vic=;
        b=E3ArLV08QNk9L8LKJkIYGZl0DVDrokXHwB0vK/zDj9e6nIVu9k5BFrMf+kqHc8h0Pn
         +lvOjcitC6Kd8udiShWwkBPzaeVjGAGlh5ptJav6c0MfzzkQQjxaTgCYdspnmNEs0W/E
         0rVKb1yrsux6dU602RR/AyuRcq+MtuSzIvYWI7UWscpnspsah1vma5T+cT2i667idEi1
         EI6egM+KNFL4qj4kH/BiK0YAnQAdiiFSV59fNHldRTL47sHlxq82rFyWVSGxEgEkiV64
         OlNoQGdRbLG5MvqoK6H6ROBNqZrwJOxuQWncK1e4VuHo6ZhPKaM5KhcKBqGAb+mHOJO2
         HtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtWPczm67CwBeu0M0TFGverK4/MDIuIxxwNeQ9S1vic=;
        b=fl5PyG4Y66zBjioFtHkzOFh5xHxriaHYwc1tM/oU8U4MV0ZONtaSoWG6ZUNNeJnBpF
         KzIaazT7WsYYFHZXgtbN8QglpJjrmJhkgWlrmTaiPCUZga80W/9TJRLuY3ajxDT8wPI5
         RcwoD7NMC2YDUZ2KMWlNQXiplJ5oPeonP0jQV35HGBmDsvUyq6MA/RrzwJnHvDlH6Zd1
         bvZXyM4DjBxyBypRS16lKtFr0BvK/iunqXypuorx6QJ4vXi/snN9A/ieqLPF643Lqczs
         9fcZLEYr9BqBtRCBKxi2BRiOVN96VEerynNeKQxKEppjkzZthlAN1G4vj/+tdeVoPlyL
         WIig==
X-Gm-Message-State: APjAAAUOQPcYQQ0TFj7OYybCZp706T2jsZFA8ROfmbbafSh5fgqR9yyH
        DC892ZlShaDjAPiQBzFNIGHhqmtDCw/AzfpLBUY=
X-Google-Smtp-Source: APXvYqzRHZsEZywX6PGgcnI3U8bBt1UQySc3ErcGAntuVNC98xdGIfDMOtYZ9Vh3M4F1lTu7dXuxyT52H7ClOJeIK6I=
X-Received: by 2002:aca:d650:: with SMTP id n77mr1448561oig.129.1566333732518;
 Tue, 20 Aug 2019 13:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-11-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-11-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:42:01 +0200
Message-ID: <CAFBinCB=kMELC94MUQt_n3QagsjNn0YjDfcZ1qk5tghCxjmtJg@mail.gmail.com>
Subject: Re: [PATCH 10/14] arm64: dts: meson-g12a: fix reset controller compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:32 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-g12a-u200.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']
> meson-g12a-sei510.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']
note to self: reference where the decision against a g12a reset
compatible string was made -> [0]

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[0] https://lkml.org/lkml/2019/2/7/358
