Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00541C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1C52171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FxhqrGLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393024AbfETRio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:38:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45347 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389971AbfETRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:38:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so13721226otl.12;
        Mon, 20 May 2019 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2ldd/M0FLdTJ9wAEQGe7z5FCDWr1SH0YWbEMWe9MZM=;
        b=FxhqrGLOlUJ81o/y0/pdmuMObdiPop1mTrMmvAH0MSclnUFbf7Hzn3MD/mdU+Evlbh
         geE6UnZQz24ZEhh6DMb6gKuaOx138Il0vxz6QGArHBj5NbyLbloif9DcPlQ+5FKUnBQ5
         isFwzBfKsxDk/LBTPH697rd3Q4/eOfIE4glMEg1Dbo4tDFNI+Vr8inrmhpRsncHzMmgb
         MBYqoXWmpL8hXfRklDkXbtnlwE7yn49acH5dfVyMRO2kFfMMpV7cHpe7aPGnUgICVltv
         kETLigMAPAZ/1E5PqjtL7MGRKjjnu5O31BDTKi5UkQoTMkY8PdZ8qaBgvZ4gPw0NFPXZ
         iyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2ldd/M0FLdTJ9wAEQGe7z5FCDWr1SH0YWbEMWe9MZM=;
        b=bmaYWYn27eM3Md8p+8Yhb1GZWSH0Y+PZzBR+dsQ/VNzG0H9YrwaIfPy6VxNuOlhlgJ
         HN6Ni7xNGr37DUkF63yzYMypD5Dutq3WPpa54xVvMPwcOtLrUClb7tR4uVMRrWeXi9mD
         2jf0uMCrw4E+c2REQ30IBcDsXX04Lv1Ytywc+I1sbkmJ8lTB+una6DVTbcH/q2Sy5F0F
         ftQ+7XE8aWvev+MErFmefnH2oVf2is+uikJAtpif9FkKh7niDfCPvdQuD69TOtAO1kGk
         FzfqbPIgU1cG+MTgh5F0UJzOS0jWx345TsCixyg1BHzTh92XnBvwheYytfoaLU7pZtbq
         w3Ew==
X-Gm-Message-State: APjAAAWnmebCU5755HpBR/CkFZcXcbWqspc0iUxXkVB+N7wV08q1gNtE
        uEsD4leTmpN1zYyWv6CWLRJM4Qx+hd281aYJjGM=
X-Google-Smtp-Source: APXvYqwxeP620JOS9yve8ETKab1BilmFKqx3q7kcUvnXybulQhL0HPoi56dggfDrmtzjdJwI13+OKQ1jctUoAqTZwqI=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr37792152otn.98.1558373922999;
 Mon, 20 May 2019 10:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-5-jbrunet@baylibre.com>
In-Reply-To: <20190520131401.11804-5-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:38:32 +0200
Message-ID: <CAFBinCAuPqRtWydk=gbB-H1iMGOR-HbMAo6NnM=6Xyi784LV2Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: meson: u200: add internal network
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:14 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The u200 is the main mother board for the S905D2. It can provide
> both the internal and external network. However, by default the
> resistance required for the external RGMII bus are not fitted, so
> enable the internal PHY.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I don't have this board but it looks sane so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
