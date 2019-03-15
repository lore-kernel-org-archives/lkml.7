Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115F421871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NbxOdJhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCOVmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:42:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38626 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfCOVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:42:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id a15so8554417oid.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCtk3aXt0Yk6toX/gAFR9+fxygQzQO4SiBLOx7sFfow=;
        b=NbxOdJhq9SeSW35J3K5euk7k4btHshv4RGa4iDBMFWEdlD3uPj9hlHv3n7SsxBD5Yl
         phlsAbb6LW/U8tCX0VrgcTLaJbCbZKXKpHLEQJnU1z+0Ea1CJZR0MnyVSzSt4JcF+Zu6
         Rr/J3fb3P2KmxsObU61K4pCwUEPpRb6UfdGayMPTqEHjOWS2A4liIjCvgQ2I/qrJkdKu
         2b5qhmfapYqhA0iKFmA0qG0qYwdaAAuON1Q1GLoowBpy0FMF90SOjk2IoV/kH7B5Ssxy
         i5m4L9lWEmapHDr9bgc5AyvHE7+j+oHnMkjl+THCLVDj37BijQJKSRAcA5pmFAkf9umk
         WT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCtk3aXt0Yk6toX/gAFR9+fxygQzQO4SiBLOx7sFfow=;
        b=ZsSpO1G67cj47aAqXyjBrGQ+eLJMJVoIZJULMdozzcF0AFbWzJls6a6Azh8+4XL/4q
         E/vphYyqaUWRz64j2+cMNuGqWZpJZ/vDf5uYd/dBymkWoLQUWNAE4o6Wlf+rYga8C5nD
         0wSVtWmhL2m94eSA1DHl4BEsfqam3pF++FrkWWetY4gkcMLMTOJUoUqQ7U6VGDGa5m4d
         4pD0+h3r/5gKD0Ai9D8NxkdpyPs4t124juRQv6tnCPX0LgCMeVVmQGjIpTr15Bxx/KQo
         uwkzrDFyFya8O1q+/dN2VGZR5snxG5aTkryJIEv0MANdiuf+2JKKjUNtm1JCClI/ZFyY
         Y8LQ==
X-Gm-Message-State: APjAAAXii9igF8C8AINU0/cLM9M4lwka44IZzNyfC44nDpFmo6s4iPQL
        LLB9W2kPOHYHqrBBzEmQUqJxUjDRfHLyMoL1UAg=
X-Google-Smtp-Source: APXvYqzxwy8S8cPwa0trdQVoNcSJAZk4CWjMLbj0E0bgebNh6uzLV+EbtUpD29j3sTl6tSweF7SuZXbAlJl6ZJCXz7g=
X-Received: by 2002:aca:cf07:: with SMTP id f7mr2937582oig.39.1552686152583;
 Fri, 15 Mar 2019 14:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-2-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:42:21 +0100
Message-ID: <CAFBinCC4ZsPxwMHC7Tcysp8hkg_aDoPLUGdS7J81tLzndksRzw@mail.gmail.com>
Subject: Re: [PATCH 01/11] arm64: dts: meson-g12a-u200: add uart_AO pinctrl
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:56 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add pinctrl on the always-enabled debug UART AO.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
