Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E8BC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD7A20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NSH9ULh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLIWZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:25:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45874 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfLIWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:25:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so7933296pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=e8vzmB2zQOVicf37JYB7f5dUsZ9PAEbPEnqlneCb8hk=;
        b=NSH9ULh/1hAOLuPMNPJfxklHlE41CsUwmWn/AlWHF+NXzPTPqa461LIDyAeuIK1ZkC
         jcvFyZM62M3TyE35p9IkhgrSTYl8uWlVlLUlyqR/zuwW4GTq75XDmk4xOazIivi0fjRQ
         HFStxYtDHWNEI+Hi/mOViXqpYWFULyktYYG0zvxkLbmQRhlWfpW8XO+VfQ0ml1j/lvz0
         OXmR1i8k6mKWWm8qHSSNqiiyPxT2sWUaaBZY7l5mRmphES0IKelAqESY+DkgQA28PRT1
         qvTzEDzU9U9VU7mP4ridDIou1QERo9IFl+safi1TbqdJMwfr07By6LDNeDRrT6sR0EIb
         PNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e8vzmB2zQOVicf37JYB7f5dUsZ9PAEbPEnqlneCb8hk=;
        b=p+sxc7tvIkhAmPuMTq3qe68Mxu5w1Fma4x8fKV0FGXsYzGMSJcWoXHdOBHrvO/61vq
         5uk39iPu8saxC7yHA4Z2PfvfV465RecWbeJaw2W5puskYltXBnJjD9yZSMZP+SM+rnxI
         k51ubaDw1U3rpIoGNJyRkt5qxY34w/vknKM8JmWYfvosaa/M2QNbjQOPMAM7owMxHjvS
         g4KFyx7yANdAEfze5ugImxe/eEDtJMJPR90UWup/uq7p11ATAdkDV9i33Jo7JH9Xwbfe
         M58CkghFUoe1kddrD3pUVXY4kVEpexMakvJjeOXAi3I6DIU9GTk/rSCAXr5OwzgLPdAk
         oJQQ==
X-Gm-Message-State: APjAAAUf/GDboH3thieeX2/3k11Bd8N6fy95PLZMGk208oqahqqaGskh
        JViHoFZpHK3E6TxlaMQSVfAu9g==
X-Google-Smtp-Source: APXvYqywvsTO2z1jHZUpDVc2D7xS1pwfKfSChZ6K2XJIA8v7tS/ZhIBV/gXtqeqzdKHsR1Wdvopmsg==
X-Received: by 2002:a62:3706:: with SMTP id e6mr32484589pfa.31.1575930358173;
        Mon, 09 Dec 2019 14:25:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g22sm515509pgk.85.2019.12.09.14.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 14:25:57 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        p.zabel@pengutronix.de, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] dt-bindings: reset: meson8b: fix duplicate reset IDs
In-Reply-To: <20191130185337.1757000-1-martin.blumenstingl@googlemail.com>
References: <20191130185337.1757000-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 09 Dec 2019 14:25:57 -0800
Message-ID: <7h5ziprv9m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> According to the public S805 datasheet the RESET2 register uses the
> following bits for the PIC_DC, PSC and NAND reset lines:
> - PIC_DC is at bit 3 (meaning: RESET_VD_RMEM + 3)
> - PSC is at bit 4 (meaning: RESET_VD_RMEM + 4)
> - NAND is at bit 5 (meaning: RESET_VD_RMEM + 4)
>
> Update the reset IDs of these three reset lines so they don't conflict
> with PIC_DC and map to the actual hardware reset lines.
>
> Fixes: 79795e20a184eb ("dt-bindings: reset: Add bindings for the Meson SoC Reset Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued as a fix for v5.5-rc,

Thanks,

Kevin
