Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90067C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BEB21721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ELSXzfTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDMMC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 08:02:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37069 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfDMMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 08:02:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so10694687otn.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlEZGPTlnZZP+TvIWHbuXPtYetCJzqo7TQchFqePyHY=;
        b=ELSXzfTzoZtMaOBJpC5LYogij7n92yZHgTZh5BQ2szD4EXWNez/WxAiRVEFApHdZwS
         J4LzOyS/BWinnBNSdlH01q8Bcw/Yxlm+TrUuzN5QuCybrZtliKQt1MJROHFVqSNYKeJ6
         cNst8OFbOP1b7MDFE02V78KIzU1zcgvG10nPbE8GCGgbDv9VBJLbcDOwfFkAXGp7gag4
         bWhqGi+BqcUIGQgdpQ4gu2YdTFPKiGsK7/fMljmZQA6bO73SyNKjUOQmutxJjhs/pGI4
         +8+Cmdv4ofvZb/zqrwv7pU+TCYF7WN1ehjHKVxGV1/u+ufckrxswbb16NUcZBwaJPwCL
         2rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlEZGPTlnZZP+TvIWHbuXPtYetCJzqo7TQchFqePyHY=;
        b=qLJYo4bBzPvCS0QJdActbD5EYXsZ2sY6ABGsAxzAZo+9J6g8uxTmbswbe0/z6vOWVf
         Hy4PRS8AAmDvjugrOEX1mul1yW8dlfk+RarAM8weBFRgVjiXnceQw8AIN3rUsk7cky/E
         xgY6G8i1ObSMD7JzCqvLUaNtGYiVaSu/UQhKagRvL9ntCxfCRlyiNSGsv0+Uy84UPRXi
         kKumgXrUgO6mZOyFC6/SEr2l2wav9VUW4Whi4h/GRfLht4m9LsmgfmcymvGi+LauGeTh
         HiABqyrBN6Dk7MrQaZhgAvTsUI2N+K+FitEdWjz3SuoDkYWuZt6wf28tMAxZQE+0+plR
         R9pA==
X-Gm-Message-State: APjAAAVz7tmYW8nI+OwEoaveFeR2sgliqFertVgM1EpZe/nHUHpI4xiQ
        kDCr4qXQC2yZI8CKc/ae5n4euhC/qRlIlEXuuzo=
X-Google-Smtp-Source: APXvYqwXnp6BZLhLO1NTKKwb/qMP0AD3mnlOPjJrnhWiMUUU+p51m67YaGsdfmFaOUB6so3SI7PZ9ilYBC32YYg6uWc=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr4282525otr.117.1555156976586;
 Sat, 13 Apr 2019 05:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100518.24470-1-narmstrong@baylibre.com> <20190412100518.24470-3-narmstrong@baylibre.com>
In-Reply-To: <20190412100518.24470-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 14:02:45 +0200
Message-ID: <CAFBinCB_V_JR=+6d40XMYAEP9UPopeB=SGZWzDb-B_G_JXRfDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson-g12a-x96-max: enable IR decoder
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
> Add support for the IR decoder input on the X96 Max board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
