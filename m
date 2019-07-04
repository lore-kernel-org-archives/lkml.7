Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F828C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BD0218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4daimFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGDOM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:12:57 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:33171 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfGDOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:12:57 -0400
Received: by mail-vs1-f49.google.com with SMTP id m8so2034637vsj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKRslmpkzPANm9ebv0Qh2Sd9vYr8Y1eAMK6X6T5kz3I=;
        b=T4daimFoCbnkcPP4ZIOQVgY77iXo0ZIcIlZPTifnpZyulS3w0LuHMaiK1JSguD96+V
         1euy9joLBSxe68U31zgjlp4BPHkMnyA7YrcAh3+yHFwqmlmSyEQrToWH5FYt6r+iurja
         QN9Y3TWaZhkMSBRNAuZW/FsWPsf8hpDzOpz5yXr7vYJlROsLMlMfNMupCHru2m0k9J1k
         zzdiGDgvlllO/pT50PHSM0Fg1nas01TNPtJAtQh8cY1K9jXdbdrcSi5X86BlYQRQWdI4
         73I11QM9IJjR0A8WBUy5M7YDf9ec0NNmo6RVAsmtSrnkS+hA2WFE+WYm64YIOQDoghaj
         A6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKRslmpkzPANm9ebv0Qh2Sd9vYr8Y1eAMK6X6T5kz3I=;
        b=MBDJLLwQe4inTeOVQPpaFBwKIwOMEFAVZY+2xHta7kB60ZO5QkCm3reEt+p4VnF3jm
         dLor3sxD8Yr6Qq22bkWQNXUs1YdshG3tJ/a0ZWRMP9u2fwKPzICFTA4UihOMkj3hjVCj
         0S1DvzTCsl1XL8wHSQJqcQZ62plIQ26Q4rbFE0OFATnAzlWYK1ZgiuRQm4IvCAPkikJ6
         8kldjw+IukZMEBoc3ULQ99m2Jl/qCqcnbFsGDz9clbd9P8B6cmbcYQmHuXUwN3mf1gHo
         8EWI/uWpjRC+DOkmK/FPgCVTfzGLkuZFrxIE3yg/ohoxsnubuJsAYIuXVMb6HAWvVaL2
         ht6g==
X-Gm-Message-State: APjAAAVS60FC1atyMY9S1myX2ncBhpDEURVp9Je8drWYHYP0rSujSjcB
        cz3kEng7ncgGra0ZGYgurKAWQF68Kskn28H9y0WQ+xKT
X-Google-Smtp-Source: APXvYqxPAZOanpu6RTkUfxIISe/IMrQS0/sfW0PfVmqysqbzR34aJ+zYJKf4fKmUXkYK6nbG2gk4RdhB5aVhrtKDJQU=
X-Received: by 2002:a67:ee12:: with SMTP id f18mr22886705vsp.186.1562249576346;
 Thu, 04 Jul 2019 07:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190704023605.4597-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190704023605.4597-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 15:13:04 +0100
Message-ID: <CACvgo517dGz+NRr3ejmfiOvsN9L_xzaHYOUze5xxSjsqQ_KXxQ@mail.gmail.com>
Subject: Re: [Patch v2 04/10] drm/panfrost: using dev_get_drvdata directly
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 08:26, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
This patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
