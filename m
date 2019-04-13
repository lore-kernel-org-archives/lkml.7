Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF69C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEA12171F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a3ahAyDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDMMDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 08:03:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42127 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfDMMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 08:03:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so10665671otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B0/4N/GgHHkXxtx0LaRaz4Tldr/FyYIlrssUyZNuJg=;
        b=a3ahAyDSoWAsNWJqIgMOvYDIVZjjqh9H307hAu89hMVscpLRs/JLipPIyCEV2GmhrO
         vFZDaLNeYmJEVEqB8EhcXdgPXBsF9nfevTLmIsr/5i+5Cm8+cDP+jicpNh7UipSNMKIC
         I/3UL3l0nL8Pc9MmJVRdtSXFj80BRvQi3UAbUZQCaGehPqk34LOVN2X1EsVdXtHLvviy
         pPA42/fkpYbXPsjwMIYmTdTq6SL9VdiWX579neehLvKbB1JzMUvjkeb1lV0SUX3qwe9c
         KWXFSynkIkuAMf73EWWbwfXPnw4FfoUrhji+kq/UGLnFD1FK67II8WXoWkeqE/g2ddrB
         V4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B0/4N/GgHHkXxtx0LaRaz4Tldr/FyYIlrssUyZNuJg=;
        b=Zii2NVIuswqadwc/jrY0UjgWcmDucoJJzPtYymyYf9yzrJtCPOZv0HlwuN2QiZ1wAl
         fYzhShYsim4P8NHyD7w7GRdUZOSOlwvvpMW6gmOtmibmp+UgXW1E7Dq37K4dXyY9fYRQ
         zuD0KlrIKhJ8JEdQzEq47nVLw4yKXwDLGkrUiIoNEPievgsk5JvCFtrz/uKn0Kv6ARWa
         lwQnwuTJ+3s+NmoVUgvXjbZM/CJCuwJuNBEmcNGsu1IVZLUQrzk7ZZ1M+pBpEWCyz2N1
         55T7kIcmMXlUWXlKtwph3G27dUwqLY7w0ToItpzT745oPo1J8Fmz4IR0mY/NhF6TFXto
         vv6w==
X-Gm-Message-State: APjAAAU7K3F6jh5XJS6OFr6L2a1Zi4isgKWzwGLoXTl4FeWNFzezL23j
        UjxrxPDxbyYiBQECBO1Am/yURNlp6s3MwO/L+RoPfmld
X-Google-Smtp-Source: APXvYqzaY8ICJlDJarIx5dKM0+Gi0Nx3J1tOSWEUB7j1NRB/T0TSrnrOAei+1hdboPzLXnddeDt2dOLislIGnVtHJBg=
X-Received: by 2002:a9d:4d0d:: with SMTP id n13mr19526835otf.191.1555156990347;
 Sat, 13 Apr 2019 05:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100518.24470-1-narmstrong@baylibre.com> <20190412100518.24470-4-narmstrong@baylibre.com>
In-Reply-To: <20190412100518.24470-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 14:02:59 +0200
Message-ID: <CAFBinCBo8Z77mDk3Z6WpdKoSemPkopFDd=VvCR7LjsU4LYamfQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12a-u200: enable IR decoder
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, baylibre-upstreaming@groups.io,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add support for the IR decoder input on the U200 Reference Design board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
