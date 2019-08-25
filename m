Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8191620679
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DUeUltup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfHYTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:41:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43222 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:41:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so13283183otp.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlDDkamxbX2r79L95zXK7WbBhhFB6AOzHAQ3OS8ilaA=;
        b=DUeUltupltLo1VWEITJxKcTkvn0FfJzHF252Zzj4GMZuQU4CwHodqhgKhFAckUu40/
         B9ZjxStjhQTI8+io8lhcYPKaTrlnTIdCRQa3DtSo2RgUOpJZLQ2kntUWzRUOpqKlOpeo
         yHwCrp/NvipwcmOCGDcJbzhnctT40seWRQOM4GjdqLBgP2X6GL2WtuNI7x1sET4haHdS
         kpoOcQyBOd7ef61l3WBdYsiNnQP2heTxH5we2W8mICV3PizL0b1g3mRxMo4kgGgkVtOa
         7/uYj/ijstBI548EDcA30s7K3LwtTxLmSQxzs4JQzKYczkMXY/YrrxmmU0HySPOqZooJ
         T0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlDDkamxbX2r79L95zXK7WbBhhFB6AOzHAQ3OS8ilaA=;
        b=r1dlIzRy9EFS563XskWvcMD3DDV0DYuqDDVIIgOqfMhZq0jnh8O3Q9k6Ui4BdWqafo
         /2QMQoPsegLdm4shNJQW0nShk3P8NWqgRastdiyB6Apud3BtAMgB7crQMUFtj+SsJlWV
         35Fx0OvklkBUgFPBYpEUX5RYvOgkxjy5ZhllIGhFtXPFuQVlEu+MjC8CS4t/1i0zE0GF
         M0f0AB1AGcQeOXP9DhFnniZ9TkNOTmTloE10HtiJUfh+86xhQX27h4E9tWXhOPYEuwGE
         M7828LuAUD7uDM7W/oHY2MsLHXTSS7AhwaCgbpdJX7L8fNxUiIBUvtz6P5ZJhqHjPalg
         9TEw==
X-Gm-Message-State: APjAAAUkkFWxZKmvT1DqN7twisBM9t538hLuJlO3Ep2YYtuS9H1thtcW
        cMIXXMMTCpNvnXNQt/Xpw3Kmoc4cb8RSA0754ByDYANV
X-Google-Smtp-Source: APXvYqxBvjkhxpmOWOLItNdm+J17A0188tF44vzyDOVXDo45nvGlddvvK9NIUw2Z4JdlCBImzeuT+hKRST3xC9eJUBg=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr12390982ote.98.1566762085291;
 Sun, 25 Aug 2019 12:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190823081427.17228-1-narmstrong@baylibre.com> <20190823081427.17228-2-narmstrong@baylibre.com>
In-Reply-To: <20190823081427.17228-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 21:41:14 +0200
Message-ID: <CAFBinCACwWqMGDJ9R7f5D2YhyWz7n7UgH7A4fJbkAp2drKC2Kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> To prepare support of the Amlogic SM1 based Khadas VIM3, move the non-G12B
> specific nodes (all except DVFS and Audio) to a new meson-khadas-vim3.dtsi
out of curiosity: is audio because of different routing on the board
or is it just because the audio driver needs more work for SM1?

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
