Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C35CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620921019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kZByJbH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfEUR1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:27:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43954 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfEUR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:27:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id t187so13402392oie.10;
        Tue, 21 May 2019 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TayEp1ksFcqXBm82oIipJqb5D8UI8dYtdKg/emIUJLo=;
        b=kZByJbH2mc8eeETLvwO5waL7KS6N+JCa4Orr7jguque/5C1bHCOj6z0WH+gicoHa/I
         JHu5YAWXcXn25mUu+LtrzzyjChJ1mP0xXEgVR5R3EC84GlLf2AKLEsVzEUtqGMhgqUhC
         iG39xsYxQolPC5wJYaXa4aprxlAfE11mcZOQ/cMPJ0rHuyHi1+YrCFu/pBkAD6c9HhTk
         mU8T1Eo69zGX1G2nY0/jV1VuwyLwW831BQ5NyUNfpzq1zj7KpTInFCiG7/6WeAFhn+W+
         G6F9hrSEHn9lczssdA73ZaAr0M4BwP3vkTC3DzicALdQQSKnbS0moqp6VN6wOojM+yIN
         fgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TayEp1ksFcqXBm82oIipJqb5D8UI8dYtdKg/emIUJLo=;
        b=cFnwHSI5yKnvIIe4/xQK72F226FmVLJEz5a/MenrQI33DjrN1AQCe/uI7xRDzKlwse
         YUxJbiJdp3MR3StqsNA1JZUf4PesYaEbQ5YsN5ERraRn3nL3eLcJSDDWGSoAEV/omsZI
         5pUMvcgLiwwiFgsShSKBmDjzwUDw9qbD8YkAjtDr4hybtIGCGNtvtfz3z0cfYLtfqvTv
         5UCJcVp1lNxSP9fjJnc5yxfTcmYaLj1c2wbD+V4roQm8ac0TiDFFzpf75KibUndsgStj
         9YBoBi0M/dpDl3Hrorumlw2yAjM+pNxVEiXnsb6uTRPoTmY6213CAcmqrNuEwuFLTWF+
         DHbg==
X-Gm-Message-State: APjAAAVyk4i/NPSZN+wkMQsc9b+nZVWpf8Vej0ussrx+nVBC72XIwPRJ
        UKzw4SQGCk8+mzTlSNRGY+aQANo04OfXYJfIgHI=
X-Google-Smtp-Source: APXvYqwBydkTAgIPGsBBBTU6zoHGfizVaMAtfM9QlyULjdJhMvL8xcCdDFr72f/jNhNO17+7gmDznI34NCAH4vu2Pw0=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr410085oib.129.1558459654071;
 Tue, 21 May 2019 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190521151952.2779-1-narmstrong@baylibre.com> <20190521151952.2779-2-narmstrong@baylibre.com>
In-Reply-To: <20190521151952.2779-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 May 2019 19:27:23 +0200
Message-ID: <CAFBinCDbQAMHT-g7arJLZNf0OGfjYTDdqsnMXN_njamhPYHBvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: amlogic: add G12B bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add compatible for the Amlogic G12B SoC, sharing most of the
> features and architecture with the G12A SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Rob, Martin,
>
> I converted the patch you acked in yaml, I kept the Reviewed-by,
> is it ok for you ?
yes, it's fine
