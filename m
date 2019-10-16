Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B4FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925B1205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDtS4Ct8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfJPLjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:39:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38904 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfJPLjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:39:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so17187230lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U44zrrUEGPIKyeOF3bZO4ezT9IQ+ohS6tJrNxnkfoIw=;
        b=cDtS4Ct8KuWqEQHwFav9PV5/jOHM+PFzylmEbTUwCHv8M5H22ez/ZvgXU/AlP81CIn
         zUg+2LXILvxP4B4af9Kxb2/A2cnMT4tmyYdBWfqseP7P4MYnum45g04lADPpkCG69UnW
         vVA8/Qv0SaxwIKNR7jbBx3KlHfXludJgao831emYBXLIV8pjFPNqAnlJR/ZTIiewQl+Q
         owRk7DdyytF3GocIiBNMbCCbV4/lySf8+Vw2fA9MPyUxsbRyTQu6J/8HzTSPD7gGvkIJ
         RAri2J/k2MjTmbHWeksU8eTZLkYqYQvybVdg29MIySSnluDQq8VkQSOzLvpC47pOQgTM
         cn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U44zrrUEGPIKyeOF3bZO4ezT9IQ+ohS6tJrNxnkfoIw=;
        b=Om4UoR5KxFFqsJrP9jwtnL40vfy0NJs6KQCPnby37/NZGspTrP2Um0hWKdvdlaW19C
         uJB8vnhwpDqw8N3nh+wQ4cJicU33SVdr05bmh46TrWM4WA5qJz15xJTdwfNPmOe0Vpb+
         IW36rvw2RApCjkk6coPINoIpqpkSdeJQCMhEr9BP8fUL2A08wUbZyBE1CBQBigLzOdz4
         5Du6uxCe4fNi/1MLR0cXT7K9okozYzWSepI/6MnDGYohtcpRlmDzh/MVolIH2hLsKK8P
         cYx7tzzPw9JGbNEe2UKKyRlxxCR+etTbR02Q4iPUc+CBKELspVPZebO9qnR73buzFTOV
         KNYQ==
X-Gm-Message-State: APjAAAWFj5KemNHcb8WAnSWba98UmBS+oVrnG6ZyDb8kdP1lkzPbh0Qw
        TIJkzlYHkYl24wFcw3+P7RvPjW5Sv0klVyBWXlWT9Q==
X-Google-Smtp-Source: APXvYqzfCYDzmJNrYkCLjNO3+528qx9sXazaTJ4hMTfKdtkfJD7qb/QPqfw0WxRQrluNmVoZn4BGeuPjiL8sr+GDC28=
X-Received: by 2002:a19:22c4:: with SMTP id i187mr5079447lfi.152.1571225955627;
 Wed, 16 Oct 2019 04:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191009091606.17283-1-amelie.delaunay@st.com>
In-Reply-To: <20191009091606.17283-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 13:39:04 +0200
Message-ID: <CACRpkdYGAAU5nrMgobQNo_CZyAHdee5owGqTPYcy6D8DYt_Xjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: stmfx: add irq_request/release_resources callbacks
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 11:16 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> When an STMFX IO is used as interrupt through the interrupt-controller
> binding, the STMFX driver should configure this IO as input. Default
> value of STMFX IO direction is input, but if the IO is used as output
> before the interrupt use, it will not work without these callbacks.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> Changes in V2:
> - use gpiochip_reqres_irq and gpiochip_relres_irq instead of calling
> explicitely the lock/unlock.

Patch applied!

Yours,
Linus Walleij
