Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D86C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EAF206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Or8HpsYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHLRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:50:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40342 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:50:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so6246356wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stBKKVsI+4UvfEdFNUUprqBQVBNTUmemikvPps8gLE8=;
        b=Or8HpsYZpLiaPQQNpEID7tVw7MxJmfcAKHT4O/iVrJgsBwWJShl/XcOewcvSHSVEDQ
         k1pnMrQ9FnGFQurkDorTlrcEdAqBwoO1n4I4dbDkMJISpj0YCXjfFb28ieOiL5NRjTtt
         89Sxl690KoN0W+p4ouvNXnqEsBFxEBi13nDzOYF/8/YaaMEkeA0zG05dgPcPDc+f+l0D
         3r9FvjHSccqzm5ydUyCW9wytjP3QoQNJD43V2k0wPkGFCjvZ6sWcQb7mTmMzDlqOm1e4
         jUeuY2lNdxLKeA2OVP0l4rNY9UsW8qIrb+GdKrL6d9G6m+nOW4OZSzbcC4sIz+sllNX3
         dbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stBKKVsI+4UvfEdFNUUprqBQVBNTUmemikvPps8gLE8=;
        b=FBsLdhi8LD4dhHz17jowmZR1sMAC9NMVgGRssaRBBwvtJrp5iZ7VJjFiVrIfcoOptT
         Z+H473cMCurke8hm1anLopglYiJcA5wSI2a96P3lLj6r6OGYg3ME1WTE7Pau3/FMnYsC
         27N6Z8Tk4PUIdKJq4/X1XiHcJrSSIA4A5EsUt+l9p6SqSwSgM2W18cc8AfQN9oGQz4VP
         suFEH77Ian+ibTYCoxmt+kqzemB4coF1ZDCmgGwSOFitJBau38irWbv0irLpqDzyTB22
         axmoqXwoJGid4JuDZL5mYSBBMCU4kMQIsFL5/pUDzJ0Kftm7jO5Msdom27dfy84zXC0i
         Tzrg==
X-Gm-Message-State: APjAAAUWiNakkA5A4wQED2a8zqvVH6y0opNT7v4HRembLpJ0OC5Chy29
        nlaNmKU9u5BauVTHowJdhqA=
X-Google-Smtp-Source: APXvYqxZ085YucVRWLR7bncRkqmFLN0Av/atoYmK+5kGSsLcfHbtwGk/UrRgTGET2hkx+86R75kfkw==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr19369660wrc.132.1565632223084;
        Mon, 12 Aug 2019 10:50:23 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C1F600059A26DE113A463E.dip0.t-ipconnect.de. [2003:f1:33c1:f600:59a:26de:113a:463e])
        by smtp.googlemail.com with ESMTPSA id u7sm4084858wrp.96.2019.08.12.10.50.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 10:50:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] ARM: dts: meson8b: persistent MAC address for Odroid-C1
Date:   Mon, 12 Aug 2019 19:50:03 +0200
Message-Id: <20190812175004.24943-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes Odroid-C1 use the MAC address which is programmed into
the eFuse.

build-time dependencies:
none

runtime dependencies (without these a random MAC address is assigned,
just like before these patches), both are already part of -next:
- "nvmem: meson-mx-efuse: allow reading data smaller than word_size"
  from [1]
- "net: stmmac: manage errors returned by of_get_mac_address()" from [1]


Changes since v1 at [2]:
- only add the nvmem cell to meson8b-odroidc1.dts as suggested by Neil.
  It turns out that neither MXQ and EC-100 have the MAC address in eFuse
  (which means only 1/3 boards has it at the given eFuse offset, so it's
  not worth having it the common .dtsi)

Kevin: you already have v1 of this series in your tree. Feel free to
replace the two patches from v1 with this single one.


[0] https://patchwork.kernel.org/patch/11062659/
[1] https://patchwork.kernel.org/patch/11062657/
[2] https://patchwork.kernel.org/cover/11062663/


Martin Blumenstingl (1):
  ARM: dts: meson8b: odroidc1: use the MAC address stored in the eFuse

 arch/arm/boot/dts/meson8b-odroidc1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.22.0

