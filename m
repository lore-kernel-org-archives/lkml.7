Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E02C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1800208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPt+ISWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438887AbfFLM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:27:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44161 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438842AbfFLM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:27:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so11927521lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YXfx44CbHqzJ+2PHFNUjf1EVeDIqUOcBZAWMQXOofo=;
        b=BPt+ISWtfE24CQZAaHNYHj8ReER12QgsGOkUBErX29okeRmFOPMF4KZPZsqT5026k4
         c8AoGglJVfsw+ElyP/nr4U+657nEJ/oMwIOxqjXGzAn0Cl2wDTT1YobQAc4YyTLDWhjJ
         38/UoElB4LK+c806V/PvRZACTQZU/VdCJ/qB3mgpnCx0AUBQjjbXk9VGkXqWW6igsNuI
         KqtjnxSn+fY1fqJnR0cudtQeG4dRFFb0BkBAqQhJii+2xOI0ktYrsSqYLr5c8ykb0IFR
         fWWZEGbrqn1QEYZjCz77M4UgdImgfNy/f7beUMiRGYZsC4lPQx5hbfmleclzF0MBFTYj
         kj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YXfx44CbHqzJ+2PHFNUjf1EVeDIqUOcBZAWMQXOofo=;
        b=qO3zVV66kx8VOG/KcehTZ9EzKCrk3xE7H+o/5YkpAQCuuLfsPW8QPfPyC78yiE/JMt
         1Eqv8AW9Mx6ul/ubgRgZiuEAkvoAlDCJ2kvFneQGBzblszx2uDy6MViywFT4yRGdJXHJ
         XuCmbjDQNQE8ZfT75dulwC/KGd7b8r4DLTJb8dW97QABeqvZcR48nRzeo2FAesLDXoTW
         44ff/7L7XTzkHLoxCuPjyd3n7ExuBbGwwRlcviYACH6UDy6lyXSfZ6aed+1lsuIcnllO
         XeQf3gCP9zuqLvOW5dH8uJ4mrxOwuw4XRWkx23RkBgRuPEVDA+2gUKqPjs+o/aZRBOst
         2PXA==
X-Gm-Message-State: APjAAAUOd+9HNF52fzUY2lv9TQ5ThNaYtBA1vMBe+vUVaz6t1PqGXAaP
        8Z0VgJGtT3THgdH2Rspjk/FqH5Jc0VpXvBvLlWA36nyX
X-Google-Smtp-Source: APXvYqxPAyw8VQgmjh8XCBoqH+CTdK92GBXr3n9PB2010YxOENF5DffiExDBojd/7HO6BdIOjgXqslUkt3b0WohZiT4=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr17406333lfg.152.1560342443919;
 Wed, 12 Jun 2019 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190610141809.17542-1-linus.walleij@linaro.org>
In-Reply-To: <20190610141809.17542-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:27:12 +0200
Message-ID: <CACRpkdYrL110Ae-FkVJ83=MStDbeZy63aJQotZg3MdG5+gxrAA@mail.gmail.com>
Subject: Re: [PATCH] fmc: Delete the FMC subsystem
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 4:18 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The FMC subsystem was created in 2012 with the ambition to
> drive development of drivers for this hardware upstream.
>
> The current implementation has architectural flaws and would
> need to be revamped using real hardware to something that can
> reuse existing kernel abstractions in the subsystems for e.g.
> I2C, FPGA and GPIO.
>
> We have concluded that for the mainline kernel it will be
> better to delete the subsystem and start over with a clean
> slate when/if an active maintainer steps up.
>
> For details see:
> https://lkml.org/lkml/2018/10/29/534
>
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> Cc: Federico Vaga <federico.vaga@cern.ch>
> Cc: Pat Riehecky <riehecky@fnal.gov>
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

After consent from the authors I have queued the removal in
the GPIO subsystem tree.

Yours,
Linus Walleij
