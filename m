Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05647206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y0ZsEHVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfETRwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:52:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfETRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:52:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id r7so13810134otn.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCYkZ5M+DBQgIFJKIayxK6zD6QbZvJ7bD4zbXBwyRpg=;
        b=Y0ZsEHVpoxgSUFIfwTB7pzDHjHGpHMDMbyua0ENJz7KIRBOcTnPfVSz6MQym1RT50/
         q/69sL2xw4KTqicatOgiKfefuy2ZJm1MrpGBnIzItm8RFVtj0kvioVcudPjdOLNKLCPL
         8zCUimTU+hEALkirtzA3R3/6MvIUnrx5GXSBgmfJzMIWa2kcs0ZrUXIojX18lGHzQBhD
         qlJEatnohUpRB+vUpQxCpNo/CeYotKqN3Y/NeKqK2fzu/cb4IRO9/7ZJkqPWAWHkHvJp
         KIoHB0rqpm81BATx4rjRTn/n0RMoNSG6ujfYgcXJwMQrAX0+gkuXJ+k5L0MNhgUgYaDn
         7N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCYkZ5M+DBQgIFJKIayxK6zD6QbZvJ7bD4zbXBwyRpg=;
        b=SBZb4HLR6RfP9muURioiTbkxZeBhHF3SltlRAdwMxHllRw86+XcHVmd8tINdS7EC0u
         M6cN41iDKo3A2DtobS5McH2xkURVrhiyE1X0SNtKSRh3Q392KJL0sUPpvjwKIlbKlLmn
         woU4KYKu253WoOiGVB/utpfJoAFZqAs7kuRZH42sROSwmiOI6vsOOMHs+8DDNLXC+LyY
         mKb04WixEQI77XG+rpH/LO5isJgvraooNiIVP/q+qGDHUpvMnrgXx2py6fJ2pbRzUD3D
         ddtvUHkip9DE9grZ7cphJQSHMqR2fSY+2+XeC1urHrrQ+Qf1p2Ly367Gm1srUra+fgri
         +3qw==
X-Gm-Message-State: APjAAAXqlgh7lbldcgmltnSBfIWwYwibWdkg2tnJvt3yVfeBLO/+JbGQ
        684vLuhH8xm2H3lLH5aO0v5P8lseHUTLmoer8Ws=
X-Google-Smtp-Source: APXvYqyldFSFE6fn2yQPf1T1K5Er6qeZRNRO8KFH313crHAJiQ1EFivfC1Dboq6ILQFWTm5vdRbbR+xOAqmaN/myM5A=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr45229266otb.42.1558374757110;
 Mon, 20 May 2019 10:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-3-narmstrong@baylibre.com>
In-Reply-To: <20190520134817.25435-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:52:26 +0200
Message-ID: <CAFBinCBmgTdZBDd5D_rCVQwO4UcJpXjX=Rc+0qgADF9sW-wFWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson: g12a: add drive strength for eth pins
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> With the X96 Max board using an external Gigabit Ethernet PHY,
> add the same driver strength to the Ethernet pins as the vendor
> tree.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Amlogic's vendor kernel (from buildroot-openlinux-A113-201901) does the same so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
