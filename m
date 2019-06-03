Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE07C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579A25B03
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fTB1vRcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFCW1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:27:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43620 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfFCW1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:27:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so9073481pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=E6ho1ZxlV0Xih2i0RKDw0kTDY5g9DdMwFcOCpRpL+7c=;
        b=fTB1vRcswc/BiwKh12U469X9crlhodyYYQFkPeD6d/eTl9gac4t6MbzYHc6I77Zpby
         32Gc1ts7Xt3yXF2sBJXH4ag+ZMlzs36IMlp4xkNLZOusP+eiCkRIPGWggFLFW5dG7UE0
         HTKhtzIBIsmunH2SB0mMD4mug/y5h2QGP0WSdOmyDkPIH48H9iNb565F5sPo2cnYANpk
         QGs2LgJF6tWq+h54z2L0F9XcLb8HccoiukLgzys9m76cw7PImSgGkI5VOlgTiCA9HISm
         Wd54DU6gMnQwNHnuUoyS7SXBcPJKdYE4RM6fgsoaYDPSybiLUdP8mOYE2s98upqrPtjf
         QDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E6ho1ZxlV0Xih2i0RKDw0kTDY5g9DdMwFcOCpRpL+7c=;
        b=JxDhxCuDPiwjVUBed9qG2FNDG0QKjD7G6hAwGVzvCzFcRDeyVoYw0VxggUU+mON/M9
         DEZ6EMH+sU7bsbld5GBE3b5bCoq1h4Kircb/2xfyNPYhsnJ2Jei0tI/bJpoXqYjcCPU+
         QcbzxWCxqGidfXnJufWandNWkayvNV5Q/jjo2K6thC58onC7Q0qome2RSQvvC8A94rh+
         IKZbjSlmrv9sQ8Hd6+j19NmmF6VaDLdS0+ABKnSODGABikjEi5+L9tZFHVHh471ZJbIa
         T0AXmY+unsBEbmBvIE0dwxxV7Hj9xHqWj1871sajbJtHGoIn/A4tM8Ul6BFzFswDSawT
         iPaA==
X-Gm-Message-State: APjAAAWmTORkgmX+rljucGgiFad1nLUINlHtBMPxDe4t0huLYxRpR44w
        aRAhNCA0sl8JCNtluIdB4NkXZw==
X-Google-Smtp-Source: APXvYqx707HxXF81Wy5xSp5ixyEwaBT8ijV8VlyNBX3DNj3zhlyhGQN3d7WIYt0NBWk9dtoIqY278g==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr34462634pfk.239.1559600852507;
        Mon, 03 Jun 2019 15:27:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id b90sm895560pjc.0.2019.06.03.15.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:27:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 01/10] ARM: dts: meson: update with SPDX Licence identifier
In-Reply-To: <20190527133857.30108-2-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-2-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 15:27:31 -0700
Message-ID: <7hftoqi9t8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.3 with Martin's tags (branch: v5.3/dt)

Kevin
