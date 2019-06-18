Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F4BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC182084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GWWg2QF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfFRVIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:08:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42918 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfFRVIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:08:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so7311704otn.9;
        Tue, 18 Jun 2019 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si7YN0Ac+8aO2OL5bpmY6oXT3u6BP9ERrdrqLEwWqkk=;
        b=GWWg2QF9YTbOrhn0UN49AHzzOLF/xn6veX8mpU4RShBxXUEgJ7jG9ZJgVGvdQjscKv
         NOBl2KSfYOZtVnsJ3hrz2McNGlYtXYS4GbBz87J9YG/pHS2yVNQ3mCtkub0nOsARDTdD
         rBP02DNR6k34taS8RuX8c6lwsUEXQkgYxrr/YdApz6GLXJyh31ovrbwgTmic+++ETY5s
         N3ZHgXEtObH+vmpeaRBLUTyGdrJDku/gVtEjW4XOahZ3k+iEYa9gO5RwVrfykB49jr4V
         w5neKmVLjeywrdy8lTirIvVF48pOLmT6cRXCVVd2e3c8j+MLhv3PxwL+48UhjivGvmDt
         WzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si7YN0Ac+8aO2OL5bpmY6oXT3u6BP9ERrdrqLEwWqkk=;
        b=obOPQIQ4N8txweo9TAXBg8XtjgmBWcWtH2Vmp0prbXF79NPk9z/11+DW8uys8uBj4W
         WgKZPrw24qZ2vIQAw9NjWGx5btsWOet5mWxg/p4ZPXWpW0ocCeegvs+imtjX8DgT8iLz
         aJoqQbzkJsn5lWw8saedeY+9h6sLY9u3ToneAUd01hHUxRnfwYYqI/kcVaYZydyCVMU+
         HgNfj9JdsK6U1k2Z7xyXBVJOgnW8RazzbzsUHzd0NGTkzpjC3/gWgf/DuDtEOQhPu1vV
         PatJqUzqFfCSOoaTdvB0Zc7dZZokyBh046nRuMymLC+Is/4zspePOgdugk0U172w6T6+
         hWYw==
X-Gm-Message-State: APjAAAUk2s5pQIdpvalK7RDi4ITpOcI5jNWAlWKEb9GJ6UMeRiNp6fc+
        2ZuWa2HSoLXHtoMcObuJ+Bu+vjPpDaFPmQTXQK0t8ygF
X-Google-Smtp-Source: APXvYqy5JCmsbwM5wBUTKhssuXBd9BwTugt+pIVBVM3h43MxZALgsMxF+ZE2IABegnBep6WSQ2xnb5t5u/NcHuXamyI=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr23969406otb.81.1560892120971;
 Tue, 18 Jun 2019 14:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190618203927.5862-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190618203927.5862-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 18 Jun 2019 23:08:30 +0200
Message-ID: <CAFBinCB8OHC+2KqP6ufceTSPDbSWH8dg1RuqWHAeqy2tR3k=5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: stmmac: initialize the reset delay array
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, joabreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:39 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Commit ce4ab73ab0c27c ("net: stmmac: drop the reset delays from struct
> stmmac_mdio_bus_data") moved the reset delay array from struct
> stmmac_mdio_bus_data to a stack variable.
> The values from the array inside struct stmmac_mdio_bus_data were
> previously initialized to 0 because the struct was allocated using
> devm_kzalloc(). The array on the stack has to be initialized
> explicitly, else we might be reading garbage values.
>
> Initialize all reset delays to 0 to ensure that the values are 0 if the
> "snps,reset-delays-us" property is not defined.
> This fixes booting at least two boards (MIPS pistachio marduk and ARM
> sun8i H2+ Orange Pi Zero). These are hanging during boot when
> initializing the stmmac Ethernet controller (as found by Kernel CI).
> Both have in common that they don't define the "snps,reset-delays-us"
> property.
>
> Fixes: ce4ab73ab0c27c ("net: stmmac: drop the reset delays from struct stmmac_mdio_bus_data")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
to complete what I already wrote as part of the patch description this
issue was:
Reported-by: "kernelci.org bot" <bot@kernelci.org>
