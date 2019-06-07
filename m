Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5981CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20564207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrGIZKbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfFGWIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:08:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43411 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfFGWIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:08:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so2991326ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHlZ/09HVQo+stV3OrPMedEmO1HgLZq5U7B9/c6/p7Y=;
        b=QrGIZKbx5k7Xqdv8z/yDPKaoDJuxRaggORVS9azbjG280GDunTQtibk90YWn/nobhR
         wiD+GkdtLQmOI3rndTluSkSSzvyxl0QYWwTNX/kjxbjMzi08Of0f5IrjSjj71JN/63Cz
         N5J4b5LskZkGWp5+qJ4eV/dmhkOEssyIvvHvNFJmi8JVuZxuMELvRlejSE35OkQeVZtj
         lMYPOdya2Q8etIbvyQX6M8Ab84uY9UKBtWdIYJ5LvaNmwpJn2svZpvCPpMPQmss/z6Oq
         PKWfQhNWjleRXUuugMH14Gm6sK4aSig5EcoJLhtJ2bVhRzZIUrKCFWP3NnlAgDhybrif
         5cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHlZ/09HVQo+stV3OrPMedEmO1HgLZq5U7B9/c6/p7Y=;
        b=mY78ewnoQ0ZEgi2qN7H05sEw3btrkmycJO6qwmUM1Pj8YWbzrx3vfNKL4cIBJcegMD
         5QzGW9R0mep14A8h3R34yM90EdY85wH90DPVjZ2JR9GPCZ7MWSQ9+n5yq6XL8F3XBJz0
         GGa91NMCXFYu9mx/ZWlesSk0uUPn9+pv4VK8J+LkM1CL4sYgTjSfIun5sCHflGXzQKyB
         7KaP7Uj2FlyG+rUmKhtqD/benFxz+G94SH2+55sZTQemtkj+BYbqMpe7S/BkyY7XZ+1o
         WUbWFzS1+ivIjkoAbXF40jeVyxwq9ZZiNvYRzrcFMFCpJnpAYJGBv4gD4eEtH6oDqCD0
         Z3XQ==
X-Gm-Message-State: APjAAAWsp+ZXxOA7fV/2+QeI5RFnGHslUnW6f2m4wmJe4hKxoTXlX6j8
        njrOaUE/G4dSShCrGkygn0/HxydpSm1d1B/qS8Dh0Q==
X-Google-Smtp-Source: APXvYqxXuBhhgn7MmZAfsZykWUQKNY/KzC0S0yVRQlT2pFkpO2Tn+jLM+faONvbgsZcuBOlTxFOjmjWE8oPicI3r45M=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr29274449lji.94.1559945298255;
 Fri, 07 Jun 2019 15:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559656538.git.mchehab+samsung@kernel.org> <ee8f4f56658247a0ab0d9e2c16a9afafefe38da0.1559656538.git.mchehab+samsung@kernel.org>
In-Reply-To: <ee8f4f56658247a0ab0d9e2c16a9afafefe38da0.1559656538.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:08:10 +0200
Message-ID: <CACRpkdayQdrtqO3aygY1uDG0LCX_9rVnSnxP5F_C-KMZURTAYA@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] docs: gpio: driver.rst: fix a bad tag
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 4:18 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> With ReST, [foo]_ means a reference to foo, causing this warning:
>
>     Documentation/driver-api/gpio/driver.rst:419: WARNING: Unknown target name: "devm".
>
> Fix it by using a literal for the name.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Looks identical to the v1 I already applied, so keeping
that one.

Yours,
Linus Walleij
