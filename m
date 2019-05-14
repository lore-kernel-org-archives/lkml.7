Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C285C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8642084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P8zj6pNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfENSB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:01:59 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39486 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:01:58 -0400
Received: by mail-oi1-f171.google.com with SMTP id v2so9400290oie.6;
        Tue, 14 May 2019 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9mhk4DbZv4ezakU8Aj7ifnHOKTzwP5mktlWTqgqpME=;
        b=P8zj6pNOReI3p9Y1u66cd2JONb2ayn5+sL7xWDTRUMD+My55LZGZY4xgzArhbyyve4
         wdq9MlXNtk6AtJH8jUrAwPJvhwkcfgVAwlbEzoinun1bqUFqYwIoHglViZJbmobp6V/u
         sn6MwQ0LeszA2Sw8dK7wZ0W9ElfdvEgyQk7DmsqmXqExuYP/hkM/MO4YvXftUvKDQPMz
         gR4vJeq/lqaonsbtVny+WdFxey2ofjDDPfNwnzJYXLug9tLccj0bWhF3Q8DRQWBsbMIU
         xrQhlKt0aqQ7glNk3i+sTZd+YCCOj6fkYFGUtKYoJwIEDU+39cHimyn9iNCi8yCNlzUF
         ADmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9mhk4DbZv4ezakU8Aj7ifnHOKTzwP5mktlWTqgqpME=;
        b=eJLKNk8FbFelSAiWl/WDDiYc6XQ7uoIKQGp94eXRdxPDFoviAxHSbA5lhDnxpnNqqt
         1318pQZiVYXBALRBzPxIjI3xJKSeDyo2hrW/gq9/hs01E0mo3vRX09n4H54R6PkL2L1F
         5ozaij8A16eUm1tUmKhHJyt7PCcws6cDOe1GwiEPHVcII/Kf2G1MFATBZMtrGqX/1J28
         qZ+Sr8kNFV382HaqxB/gCIexMaw7sxyXAYo8dQRXig+INXRpXb0gzbSa5sy2JXIa1rZy
         Eh1/lht4p8mpUyPd+p0pqoRCE+iaJrWEUZkf/ZG61JxE6HHg+eLxXxiiJ7xS6J6noFWi
         8V/Q==
X-Gm-Message-State: APjAAAU8MNw+IgZoKnYr+tuUlb2qMjCaJr1/HRrjwG5ozeUScSNVMYJW
        wxr/ODHImMvIlinJylRkNfxh89lV7dp902r15Y8=
X-Google-Smtp-Source: APXvYqwT+H6aWmpM1niIbNpH7TQ0ttX3JE4gN+UGqT0K5hC+dhiYfl1xJg3MXJCBq3QpDVkuiDXGJS4ORmWi6/9Z6H4=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr3959825oib.129.1557856917885;
 Tue, 14 May 2019 11:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190512205743.24131-1-jbrunet@baylibre.com>
In-Reply-To: <20190512205743.24131-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:01:47 +0200
Message-ID: <CAFBinCAoj99eieXogc6OVyttAdZk+5y83B0Ltuv3iLNryOq0rw@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: fix MPLL 50M binding id typo
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:57 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> MPLL_5OM (the capital letter o) should indeed be MPLL_50M (the number)
> Fix this before it gets used.
>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Fixes: 25db146aa726 ("dt-bindings: clk: meson: add g12a periph clock controller bindings")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this issue Jerome!
