Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C7BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACAE206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBi5fWpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404659AbfIFMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:20:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbfIFMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:20:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so3073269pls.8;
        Fri, 06 Sep 2019 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz8E2Km3qb90hXAs0IYE6gU7l6QgyfYQZCSLqivyf6E=;
        b=sBi5fWpLkJxLG+1JbIBpFxU2wYFj0Rs9t7FdUjuEGTXEdUskawkWs7bKLQTbSiRpG7
         qjhl0dF9LHFwxei4SsNWyHZYsRyITHY1813nt5Qmhl+ekqxXelwFqEcADBaOHIKXX/0V
         khF8myUbLbxdgH2l8IGeznwGAlWmeOPqKraFv7lW4jPV1UHxMzEYrAaMxmgXfRKklht8
         3KZpkKg8mfU/uXRHZ13pYQo24TfaYwGj180ya/4o/m81xAdpJ+HDpQ6GOZWyXCRx2kaO
         jSNd6NlTTHccjWA3MrzpQdVAtKPzijDLC9pUugAWmkipIibe5KE6wbEzDvoq8MnF4xcE
         D9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz8E2Km3qb90hXAs0IYE6gU7l6QgyfYQZCSLqivyf6E=;
        b=DBz4hIRqss+K7Y6iT+rZVDHhir2morblWnyC883APYuaKmMv334XQfnClGv/ynLhF/
         XfBtH6yu06r7BUQWR97S/6920e58m4EhxqjAn38Jeo7sKle7CF/5bfLkcLHFY/tx3Fui
         1GROnAQH0Pcep0+acyy6xSC2ZTqxGP5uSw2akQjuzKmiARDixhAG8WcfYN9HhgCVajZD
         lWLt2R1V4dml7EapMT38ztL+7QpkQxdv7qnaDU1TKsMc1vqtnAd2ZmvZLDQ24S456P6T
         RcJmxDbpUW/jSsYUhNK6Y/RZm6jRfkBwqeQyHWgGwE77+CyyeU6sV9VO0g286v2iS2Te
         +4hg==
X-Gm-Message-State: APjAAAVEsrITwYMWpteREfH1qDjq5YsMj8GNtEQVeSXl55vckbkNgMW/
        nK46hvvEbbE1RZehRqoJays=
X-Google-Smtp-Source: APXvYqytNc4583TyUBAV/uTzWtXmL7i+BG+xiP2y5wuQOBP1Lr6CNp2zeZDS6Vji8zuvtspD30AQow==
X-Received: by 2002:a17:902:7b8c:: with SMTP id w12mr8244462pll.276.1567772452654;
        Fri, 06 Sep 2019 05:20:52 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id c23sm4944218pgj.62.2019.09.06.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:20:52 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3-next 0/3] Odroid c2 missing regulator linking
Date:   Fri,  6 Sep 2019 12:20:41 +0000
Message-Id: <20190906122044.372-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below small changes help re-configure or fix missing inter linking
of regulator node.

Re-based on linux-next-20190904
Changes from previous patch's series.
Build using Cross Compiler.

Added missing Reviewed-by Neil's and Martin.
Added few suggestion from martin for rename of node.

Dependencies:
Changes based top on my previous usb fix series patch's.

[0] https://patchwork.kernel.org/patch/11113095/
[1] https://patchwork.kernel.org/patch/11113099/
[3] https://patchwork.kernel.org/patch/11113103/

Hope this series get picked up for 5.4-rc1, finger crossed.

Changes for previous changes.
Fix some typo.
Updated few patches as per Martin's suggestion.

I will try to commit less mistake in the future.

Best Regards
-Anand

Anand Moon (3):
  arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0
    regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to
    VDDIO_AO3V3 regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI
    supply

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

-- 
2.23.0

