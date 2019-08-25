Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960220673
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="u0cppoVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfHYTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:38:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46334 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfHYTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:38:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so10572507oij.13;
        Sun, 25 Aug 2019 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chkqvuhekHGQhYnW0yA1AUvunv0CUeXBozcgE5RCGR0=;
        b=u0cppoVMppKPI4R3tE0oQQPUsjzQdBiwzIVOtcPozizIdOfQcPFCm4jdFut4NLyLHl
         W7ia+LzopmIt5jWdEAFGUgT7HxX8pm5XT+F4VWzuako2kqYDtXCS2WaL0eRYHmbhut5i
         Wx6Mqe9uay3JAyeHjmznXMHzmTGUENFoFJwfcWYbHOEEZpQN5h8ragkZrjd6CBuQPEC3
         /DHI0LFnSIkbSLRhr8D4s+ip6Bfaj4gjbeP1qf2DNlVlLlNC1Jqu10ePv2ESrd+OUisf
         vnRxY9V6p8RAh4ddtvYeGfnqMu+SgFkdQH9PV+AqPXPIE6Ou6MviSIidgWdoyT00Oo2j
         Nq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chkqvuhekHGQhYnW0yA1AUvunv0CUeXBozcgE5RCGR0=;
        b=dgQWgdiLi1DuwOtrn+csirs25/3irHhtpEMGGv/ChbzdTCUH9WZ50MZmq0ryGLNm9M
         ZidbjF/8w64U8L1tznwzGtDiGuarL1JrklfpcgP3W2lqtJYOFmoRbSbMOcZVVXhJ409h
         XfT01C2mlMB/TBmxs2jhJFAleao/HrX6EOy0cQFV1+MGzzYXvrFXN+rr5dW1EZ3Ofe/4
         wFgam1pQwL/niHFvlfMp0ywMn+aNKVI78hdLce8gOyQzLskJeIXj44dnnhtvDphslMaL
         btJAdFCcH2NLuj+Sin8SYGYsbO0q+Vh7/EtWZ2ojRqjkXx9ocxT+YOGXi5HN/cuWsKdk
         l1Fw==
X-Gm-Message-State: APjAAAWsfoUTnml1YKrvw2zzY7J1Z5obT/r6KiauUGk1TfscgfseP7+w
        8liFrn9JyOResHtOBLzaHnSAqrSw3tazF1WzhWg=
X-Google-Smtp-Source: APXvYqy1R4zVYwEh8pivnSC69fyaMBLMJemyEus17wAdFf0HZLtZeNrG0Fme7e3Pe3MsSQoUcaWkpnlg8DlAMDncj6c=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr10330434oie.39.1566761928007;
 Sun, 25 Aug 2019 12:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 21:38:37 +0200
Message-ID: <CAFBinCD0uhE9Fj1we2MkaTbk7RwtmKh7Fn1C-2nn9wiWqCoNfg@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64: dts: meson: ir keymap updates
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 6:03 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> This series adds keymaps for several box/board vendor IR remote devices
> to respective device-tree files. The keymaps were submitted in [0] and
> have been queued for inclusion in Linux 5.4.
>
> The Khadas remote change swaps the rc-geekbox keymap for rc-khadas. The
> Geekbox branded remote was only sold for a brief period when VIM(1) was
> a new device. The Khadas branded remote that replaced it exchanged the
> Geekbox full-screen key for an Android mouse button using a different IR
> keycode. The rc-khadas keymap supports the mouse button keycode and maps
> it to KEY_MUTE.
>
> [0] https://patchwork.kernel.org/project/linux-media/list/?series=160309
>
> Christian Hewitt (7):
>   arm64: dts: meson-g12b-odroid-n2: add rc-odroid keymap
>   arm64: dts: meson-g12a-x96-max: add rc-x96max keymap
>   arm64: dts: meson-gxbb-wetek-hub: add rc-wetek-hub keymap
>   arm64: dts: meson-gxbb-wetek-play2: add rc-wetek-play2 keymap
>   arm64: dts: meson-gxl-s905x-khadas-vim: use rc-khadas keymap
>   arm64: dts: meson-gxl-s905w-tx3-mini: add rc-tx3mini keymap
>   arm64: dts: meson-gxm-khadas-vim2: use rc-khadas keymap
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
