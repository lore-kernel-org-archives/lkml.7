Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286D20449
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SlklKlmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfFGWa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:30:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43529 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbfFGWa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:30:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1850920pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=T+gmMrSV8LpU7puTEZ6kwYpFcqjKjofHEmL9rgK1UKo=;
        b=SlklKlmBBiFdZPIfe8yLVR3wMr0yt2NHj6Y+rR/RuvE70WJgfk3E5VAJqvEkCAOazw
         N2IC6i/JCQIMB1aAqezYbAAFLQ0w7SXRwMwCf2qex94hkdMHZ8hFG5M6oWSeXvsUkSKE
         +7TNpDMtSrdMz1LIRl6h62d1jWPGFVYPirYiUWeJMpg43N8YN9gZuatmaFQbzNB+/R/A
         lhAtKDBRKeEjFhVAR6/JVH43HLndE96qB6NoL+EQX/N4FEYnHZ6IbGUuAOSt7yOopIJ6
         T+5+RY2/P9l5SxchgzjL6w2E4HP2tDeePcYLIcQqP3CPEhVdPZE3dC2xoOA67HLHlVon
         lb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=T+gmMrSV8LpU7puTEZ6kwYpFcqjKjofHEmL9rgK1UKo=;
        b=HqWzfjNM2WsQ5ymGFmxuEHPZbFPIMyi0qsWTCMs6+WmjvPHmzTHbYms+FPtGn1YDFT
         TauhjdQZG4V18icLJYv2lk717tpMuNtXsk85pVwae/UTvOz8iCyvRWQeRBx47mDZZjYN
         9SWsweVewsCp7LZOsI7K+XzxQEOpsx+4ezOlmF6njZfUVO7NDLFeN35i9C4ylUUJJ1x9
         zF7JBUqXjKYTElceigT1nCkondr4EYkHLhcmHHu5FseqSfxINr8cFZ782KnfiOLlOiR2
         pi5mQknY3mx87mej4hitrk4C1FZp4t7sw5/MjYM2CO5kN+ShZcJbXdehpizR4jB/khbj
         AcQA==
X-Gm-Message-State: APjAAAWk0SBdmjdqN4pCnUQzY09HkmF/R1z0fiQfHk4Kxm7YZFfslB0X
        fLkZcInjsDR9n+RgBkXmRSa2Qg==
X-Google-Smtp-Source: APXvYqygPMKbPrpvJslf3FYcxdtb3QVEH3xirov9jP5r9Se5JGvQK+yhNT57w9YN+pdO+FqSHHNraA==
X-Received: by 2002:a62:764d:: with SMTP id r74mr38588693pfc.110.1559946658401;
        Fri, 07 Jun 2019 15:30:58 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r64sm3822829pfr.58.2019.06.07.15.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:30:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: meson-g12a: bluetooth fixups
In-Reply-To: <20190607143618.32213-1-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:30:56 -0700
Message-ID: <7hr285auzj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> These patches :
> - adds the 32khz low power clock to the bluetooth node, since this
>   clock is needed for the bluetooth part of the module to initialize
> - bumps the bus speed to 2Mbaud/s

Queued for v5.3,

Thanks,

Kevin
