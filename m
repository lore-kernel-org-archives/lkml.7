Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F76EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B7E20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fz1+CEGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDMLhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 07:37:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39891 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDMLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 07:37:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so10658246otb.6;
        Sat, 13 Apr 2019 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPr5fJiz4nXGuDrFwW8vntfct74jRoGWcNEctADPJjc=;
        b=Fz1+CEGnRVkcD4QngclFGONsO1Wixzn9nYeHtcDbKPw2nyfUQVOO4b9PsZaHKclgdy
         ZQ19b/6A1HohZ/2Xi8ch0rlAV9VYB3c3SJA/ApdjxA2Az/V4/5swtRzTG6h/ICD1RCNU
         Yn2whrjmth8wNfgyGUaRs/N02gHf0UDeDQ3Na63+Q7Zdm4DvCAA4zg0KQJLGT8V/TwZE
         8y9OCv8r1qNA9LLNrLfqlpYMRID00z9it126zQmFN983nPb4TY0MMIYfdY+mp/8RnU6D
         Lsr2UNxdUiPN4j+rOr69rfEsIvWoJTRJKPmvi9uJCXxa+ogKt0MD4fbb+vu/LDQcupVO
         ICsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPr5fJiz4nXGuDrFwW8vntfct74jRoGWcNEctADPJjc=;
        b=mvqcoy1HgVUXSY/cd19IsBDEnpbXhc0bqLRbqEZN4vCOfK0nxtHG7Ys/Gh2gTAEqCw
         d7F1n3uO4NDHQ1K6b89EZwH8ngNAPZJEMuplJUuP8QFq0booYdDcQO5J5z/ay8Kj7Php
         OIrSjZldu/0JNJfGYmlI68jh/4TP+M3ggePumlo3bW/m38FACbF19gfIsTDQVTspOt/9
         jTk+PwbajF6CSJUNYTihzabMqT9eHF+MyCtxlV+l7DhLP5J+PAAn/A5XS/t0kZZJA88b
         /ACjl37saWT7FxDDNVkUJ7A3ZSGlY2G9QTMTJvG6PmOZBHOzTHmHMMIkGpUBPT5UCv8u
         bTRA==
X-Gm-Message-State: APjAAAU5flqKQVIINv+g/9eFhNoK8s1bzMne+txSzu+QZpAL2XZkaYYA
        ieioAHbPUk15BXh0kT4X0Ud28PgZAcBwyN4AIxg=
X-Google-Smtp-Source: APXvYqxzGCfIyrIAv+u7k39uAGKbvbJJ4MpMp4GSs+6yxhCpJZVFMuXbhKBUhNys6IzPlNuSIUUdYS7bk7oPI+CyD/A=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr4225415otr.117.1555155450171;
 Sat, 13 Apr 2019 04:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190412092337.6941-1-narmstrong@baylibre.com> <20190412092337.6941-4-narmstrong@baylibre.com>
In-Reply-To: <20190412092337.6941-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 13:37:19 +0200
Message-ID: <CAFBinCDRFCo6GiTQ+zArqeuZCYK6BdfMVtRDUAhjG+oLEZyA8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12a: Add PWM nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:24 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the EE and AO PWM nodes and the possible pinctrl settings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I reviewed the controller definitions and picked three pinctrl nodes -
all of them are fine:
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

that said, I had two questions regarding the AO PWM controllers in
PATCH 2/3 of this series which should be considered before applying
this patch
