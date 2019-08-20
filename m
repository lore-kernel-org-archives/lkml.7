Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80088C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2E622D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ux3qmG5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHTUWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:22:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43795 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfHTUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:22:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so5153087oih.10;
        Tue, 20 Aug 2019 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nchB5IQJ4eCth7WRS+xQ6t/J7ftCZRuwWmTvIH98SPY=;
        b=ux3qmG5nOv6RqqUO/UrNs19nFUZIDIKIO7BX6LX3OPX2OxfXe+uFPOLooSObQ2w0ds
         EnvmG4AXd+88LnBogF6v/DuNpOpLiH/uQQhgqL6OE+HkMmiATORfDcDAo1/QqMcDf6Z0
         +MKk8OVRri9it0A2iMQcts7O4hCeME79BXEQFWKiKhtpHCnHPk0N+fcfL/KaVTrdtHw8
         yuXCZ5qSq1ZdP8rPyXspMQYC1XIGKbr0y8lGSBlaRcn+0JRvFYQWy0M2RDqqpjMyTdHK
         qYpasjQT1u954Rd2Led1/R7OQQkQ8HxJNZe4TL05ptOv87/+rZ4LAF+3FKtJT5K1fA01
         G8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nchB5IQJ4eCth7WRS+xQ6t/J7ftCZRuwWmTvIH98SPY=;
        b=pCdaIO07fahr11gfgC2dK7BXpFdGmszoyKA8Fa3iZokyif9DvVJk/1YZsHX7Swg74Q
         XtGvtAZV2aszqP6QqvKacSsJMdW/Nhd3mVWOxwgGQRQp+lEYdEFGqMCctNIc7xYYrRUC
         Rx8fyWa/IF6rhCY4X1UK278Adnf4aA+PVAm3CmvvKPqw5bmLGGQABxf9/ZA0CNmAyOJx
         BYR4979bbhkRMCx5CK0hV4YaEPUhpN3hxc4n6+wRHSehJCwiFimZR0BTnrP853QtAbqw
         mI4QgOP6nEGv+ve3ibeFoQaOeoiFlx1nCNqi5afdPYbi6Veq3rQRRiYi9lGtZot/WLQE
         SIYw==
X-Gm-Message-State: APjAAAWDJooJX53WmPwf3Ja0Ht7UsaDWdUqW7JQNGJL/iSoKnLOUvm6A
        q6OpEHrT/lPgMBln4dZNIaf3j0UBREBxM8nH9g4=
X-Google-Smtp-Source: APXvYqxumwUgslc50+vHGLyx2kOQnH2aNwLHVp9M4yP8Dwkeo7QcsJKJWf1GmXl+B6DS9UwRECTx1xxWxPS0jw31bp4=
X-Received: by 2002:aca:d650:: with SMTP id n77mr1398101oig.129.1566332523693;
 Tue, 20 Aug 2019 13:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-4-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:21:52 +0200
Message-ID: <CAFBinCDvLHrfy4_kSc4ne6Au_+gdC6Z6BX16KamPO_=rcYaDqw@mail.gmail.com>
Subject: Re: [PATCH 03/14] arm64: dts: meson-gx: fix reset controller compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxbb-nanopi-k2.dt.yaml: reset-controller@4404: compatible:0: 'amlogic,meson-gx-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
