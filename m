Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC9C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B116E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vUhtS+rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfEURai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:30:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46136 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEURah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:30:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id j49so17042867otc.13;
        Tue, 21 May 2019 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9NBxGWR7DQfsNAp+UB8rtdlEFycVGIN+18JmsiYGuc=;
        b=vUhtS+rYX9L7zrYqAWyLBRvFFbqk/RHqIizF7drZi52M8bmoLwhxK4PSijJ+uUIfqF
         rLP0jDniA9pfsOBlUmWsEtXBAeUc1/niCJfPqU/iQiqGl6XIF7sWJAeexI80nUwKxjqx
         r3VEK1k81IkqsPC9VXBMoA/saHdq63zxZm4P5HjLjTRJgzWb4q2u5xNYii0rJrYQnyNQ
         wCyxAfC9ULgZjosiglk7uTRpT1QrC+aeOEt7ShH1+Ys9v7DYYutg4H7xnBBhO8QkqDxW
         kABm7cXkC3E4ala2PojMu41af8nsStfOwQ/3KIKerkFrJzQpyHjiK4yZVUB7ducP0Gar
         IukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9NBxGWR7DQfsNAp+UB8rtdlEFycVGIN+18JmsiYGuc=;
        b=GAyvY5kSI59JnPwphWr9uQP41wUdi+ecoN0GLJcdUuCMy1XgdMCqY8yMXJX9+rnmie
         qTVD1LlaxbD89aKbY9MTfyqDvGuqDDgJYredu0GhzrBhXgUSQc4txplXp90GAOoL/Qzt
         uZTx8qSvjKdSeUPBzvSl8RAy9r0eU0pqVC+EIO8eeGwBMK+89gp0QixtWAg7bMz5NCJC
         urH1cV8VXMTlxytR2ockY2wU6H1nt/Jiu1EdjQSdPERXwHeNH5uAsgensvVjgJgLFWvu
         JzfMxtQKNVI7o+p0nI5lcr2K10wO/QFNF2zs/oIn1689PNpe20tdmwm7SQOk6bP2wm2a
         3bag==
X-Gm-Message-State: APjAAAUE0uHW6aAZS8TL6J/WqjSPBjNez6J2czfxLb+KyAGHhB9rdHB9
        0xFdeh0Z3u9v2YGnvKm6P/DnMwlm3NKzkxMJ5Lw=
X-Google-Smtp-Source: APXvYqz3bsCqphTyB2v13j/v7Ohjzl6D44cpTCYwzD61Mga35oYp7a+Bu3LOVZ458XKaNJoA+kmPDHcyl1gOxohdNA8=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr37879265otb.81.1558459836920;
 Tue, 21 May 2019 10:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190521150130.31684-1-narmstrong@baylibre.com> <20190521150130.31684-2-narmstrong@baylibre.com>
In-Reply-To: <20190521150130.31684-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 May 2019 19:30:26 +0200
Message-ID: <CAFBinCAwD7W1zQ2YZgecowZUEnoVpGXyGQnOKhB5T3OvOvvbkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: meson: add g12b periph clock
 controller bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the documentation to support clock driver for the Amlogic G12B SoC.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
I missed this in v1, it should be G12B?

>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
with above typo fixed (assuming it is one):
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
