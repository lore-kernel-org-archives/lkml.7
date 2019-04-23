Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A89520811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6XS5541"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfDWLNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:13:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44608 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:13:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so11387652lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhOw7o912vfFOZ34iqlw9fd1E2tVhBfbGcfDDGhgt6Y=;
        b=Z6XS5541Tv0znlysRgrRT1nBIi1DhNaLap8IJeLA8RZZG42/JfXgtmuoZkt4uFP2a2
         x60vh5iHP4jx5DCL89pu+EwxzqCQaIL5Dw42qpqwqAHIyhkUtHXhtDxgoTWw9idB+LYK
         AigXa5nQn/WsNqhgZQ66efBClnD/Jufxe/JG4mpDzven1/TW23KFkdvQkZko+CtRYQuw
         lyoT0NsNkEXntLBRSudFGB5y2OBWwWmfKcD0WtdmjA7194TDeT++4DY7Ck2VFZYiKqdX
         w2LEZNw1LMD1iTE7xzpqqNjp5+cFedmS1rg8KN9zbyTxT3Xeaxvb/eJ5IAhTzJyXgBQE
         G5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhOw7o912vfFOZ34iqlw9fd1E2tVhBfbGcfDDGhgt6Y=;
        b=QMxc7tRWWM1Zi4AbVZR/7DEPokfj5NSNi0UEeGJhzdRTuKLCQo9QibsSB/dg4wLHjx
         H1+4gZf7JOEJyUYC8u1ynilycs7O2FTe05wXYZz5cHM7tSTC03gmPZEBQT2CKOsSDnXP
         SndkF3v4F+k1SW+YKffZegdIm056qHvwC7MowM+ga0b/BSYnY/mvs6vi14JfAn+fyJPh
         HyX+7OQggHm9jCthf9QD0pVoTOcWsnDgqTmhyers22dNKzlaTIlNKEertL3ReFgO10jp
         84HcXXtteTo7ZoYzMBU6uum0Zy46IIB03M9WJ+/aXv1AMbz3TX1LUeLCeLhf7ZVnIegJ
         XoEA==
X-Gm-Message-State: APjAAAXNZe6EnHlYZsU7sTujpyiLFw5g6gkfCttoaLEq+/BfwZcGcdWM
        PgcVMIDsw96uuwEAUQwU85irRMvF4kj2fk36QABEUQ==
X-Google-Smtp-Source: APXvYqxcNGH4YVFTHh94wJmO6/uuV+Nbfmb4zbwn0bKzlyByVglhZ9OT01AvGqQMOb1HXwjqTsJojhplmatbgiE3eHs=
X-Received: by 2002:ac2:4647:: with SMTP id s7mr13196956lfo.168.1556017991868;
 Tue, 23 Apr 2019 04:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190418124758.24022-1-glaroque@baylibre.com>
In-Reply-To: <20190418124758.24022-1-glaroque@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:13:00 +0200
Message-ID: <CACRpkdbLJYgU5ZP5CkwX1FBv8eHp+7TsAMv3_H51C_EOA85X4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add drive-strength in Meson pinctrl driver
To:     Guillaume La Roque <glaroque@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:

> The purpose of this patchset is to add drive-strength support in meson pinconf
> driver. This is a new feature that was added on the g12a. It is critical for us
> to support this since many functions are failing with default pad drive-strength.
>
> The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> 'drive-strength' is expressed in mA.
> So this patch add another generic property "drive-strength-uA". The change to do so
> would be minimal and could be benefit to other platforms later on.
>
> Cheers
> Guillaume

This needs to be reviewed by Martin Blumenstigl, Martin can you have a look
at this patch set? If you don't have the patches I think Guillaume can
resend them.

Yours,
Linus Walleij
