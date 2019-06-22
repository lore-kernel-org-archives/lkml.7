Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F7C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F2B206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiJ/mrz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 08:45:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45286 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVMp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 08:45:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so8323978lje.12;
        Sat, 22 Jun 2019 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=heSL+WGM2GJyAS9s3sd10GubIAAtqQkB37FZimio9Js=;
        b=iiJ/mrz0Ki4ETv7y4D7UGRvIfRyLK+k9lZEUke1CeRaQXfnjTXKh+FALbAm7a1GNga
         nKlPQJssp4H6lss9iFQWvgdTK2r3bdhp794Wy9oZjb5Tkv7RAKckbKF5K8pW5zfgehYO
         a592Qpf3jr8t2cAKBujmsFGrBs32ivGwVrkJHnJCKWPe/G9j/il71zKX+v1Um158U2dt
         9rN/aZxxkNDUzLzN7W2GbwzYo2CqFMkw0qua9XGfEI1+Dd6HXa1ibhXQbQiUXcgCMIT1
         uHOd30M7e+a0+SvjPGKVd+HOh1TSVeFSJt0JH1W8wdAx83Eb4QckGgDfZdNkqEJOYumE
         Kmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=heSL+WGM2GJyAS9s3sd10GubIAAtqQkB37FZimio9Js=;
        b=jyLC4cVAqXRkN/9q//ADqDtUuhq2+9Fob4hSKVMhsIoa4lpP3Em4N8dnYoblho2nmf
         MuE1vUDTJWb1yAbhV+sv3lWcQegGJU59J151NyvsVBAgoBCyLLmE+ckaZHQZdmSpmhw5
         QbPPx0W6JLZyzB8fEg/DrUyHHcr8Fkm6WIZCN6rXJ9EE5yGRuBU3RrqXvo45tvtjck/1
         /uVJ2zVKZkSyCElqd7gIbvfZzmcAzNYqMsUklJqG1HOQXefpNdTzKElzLyYslQPbkyf7
         KQCu1TL6G28WiBlEZqPaOCTwjetYzJWNaCy7t8513qJXPjyEb6HOpHDvEpH7MqniXdNw
         Ff2w==
X-Gm-Message-State: APjAAAXyYUMg2wXOd4dOY9Eh8NGbKswRN9P8cTQJR21k92K2sh3WdxdG
        b6z/Ekg7+aM8EhBq2pCI8ptz5GAvDzrGMpDHlfY=
X-Google-Smtp-Source: APXvYqwwzzLrOT6ulKtoJYJeUAopmAZ1Nc3CneWEwq5i7tKYFCRvciG0FPHiFXwOijwZdfIVaOQreuMbdrbbc7lIu2Y=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr35106486ljk.93.1561207526078;
 Sat, 22 Jun 2019 05:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 22 Jun 2019 21:44:49 +0900
Message-ID: <CAGTfZH0EMos5AaLxeONDOd6_tyt5=Gt7s_Sam930H=6mf9rRiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I applied this series to extcon-testing branch.
If there are no build problem for few days, I'll move them to
extcon-next branch.

Best Regards,
Chanwoo Choi

2019=EB=85=84 6=EC=9B=94 21=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 8:14, P=
awe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1:
>
> This small patchset adds support for Fairchild Semiconductor FSA9480
> microUSB switch.
>
> It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
> but it can be found also on other Samsung Aries (s5pv210) based devices.
>
> Tomasz Figa (2):
>   dt-bindings: extcon: Add support for fsa9480 switch
>   extcon: Add fsa9480 extcon driver
>
> Changes from v1:
>   - Added newline at end of dt-bindings file
>   - Removed interrupt-parent from dt-bindings file
>   - Added Acked-by to dt-bindings patch
>   - Remove license sentences from driver
>   - Remove custom sysfs entries and manual switch code
>   - Switch to using regmap api
>
>  .../bindings/extcon/extcon-fsa9480.txt        |  19 +
>  drivers/extcon/Kconfig                        |  12 +
>  drivers/extcon/Makefile                       |   1 +
>  drivers/extcon/extcon-fsa9480.c               | 395 ++++++++++++++++++
>  4 files changed, 427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa94=
80.txt
>  create mode 100644 drivers/extcon/extcon-fsa9480.c
>
> --
> 2.17.1
>
