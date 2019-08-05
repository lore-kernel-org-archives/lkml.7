Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1E020B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKMwXg/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfHELbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:31:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36300 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHELbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:31:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so3635892lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqgUfzAKvpX0SuFuxycUxR+geG5thbx1whP2WWmJ1nQ=;
        b=IKMwXg/T/Zh3tXmQ80wWZi72qUbtkNadQI+7xflFTFtdO1PFNpiA/v5J66oHKGOnte
         ve4IoeOLk1m1BddQ8EYHJwJMjWWL+CZoIb60NOOB9+3AkFZ+v81oaPKDrmnABXpZzBP+
         OQWS2dEj9zO0X5o+Civ4c8DEZdR76pV/opay7VlcpN+D6q5zwv2VHggImu19oiw1LUSh
         IJ9jVv6jV1WHC5Iul8rlsDy8GdmhH1josnnRnzFmyWEqtDH3TkZpi6TRZNwX4s6sSXvK
         hu3fG1un26ZOIigZiWk8leCxvia7QDU5m/4IYJUePVQ9l0gEu78GQltHUWEUTBxgI24s
         vYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqgUfzAKvpX0SuFuxycUxR+geG5thbx1whP2WWmJ1nQ=;
        b=b6qDVAi7ah1K6TMMaWgCNAZRUHVjG7x6q/YWVf7eLXxuS2NGHoqCu69yzgnDu/jP6j
         SZPRDmgFZzapkvLc1FBR7uSLoPn/EJsmxWkQJ+A1Fniv8Yfy878nKORccnrov61tZTFh
         wXMpS6ylsxXSLPCTul3ziW7wHRYwLJfzd0J0WWwkEjTve4WGBUoU4zBGpD6hrAfgEXN8
         Y7lHHOnKSgnErjIsV3MiMgEHzbB+PW2OTdKuQ0ZGoaKkwUJ8Sra4ba/AnK12r5QEPuwx
         m6EoETfCR42fAAP7Ac6vODqC03McuP95GJSLPYul1Q5WyPaU2f7iQyziG5Csgwpr13H4
         mmOQ==
X-Gm-Message-State: APjAAAWmdyRxNVpim0A2ug4asjKT0/+XJ9vUkxRZYJEWPdvPIKmGIHH9
        rPiqKj7PZatw9o7RlQIYXDFK7BvY/qX+7k1KX37RnQHP
X-Google-Smtp-Source: APXvYqyzg+cAuOf+j3i2y/o+8wNk9AYsXWTCWpPwk2uwxRInVloNTHNotDlkamFynu15VYZS4xipDjrVNnZSzVl/RLA=
X-Received: by 2002:a19:e006:: with SMTP id x6mr69619045lfg.165.1565004713169;
 Mon, 05 Aug 2019 04:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190731132917.17607-1-geert+renesas@glider.be> <20190731132917.17607-4-geert+renesas@glider.be>
In-Reply-To: <20190731132917.17607-4-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:31:41 +0200
Message-ID: <CACRpkdZA-NTq8dSrD1+_igd7qrFQkJvHhLkippBUu1UXkPWWNg@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: xway: Use devm_kasprintf() instead of fixed
 buffer formatting
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:29 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the devm_kasprintf() helper.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
