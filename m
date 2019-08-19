Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49DAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4611205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZZAymUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfHSXsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:48:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35305 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSXsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:48:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so2149723pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QgmxRXiV4eVbA2D+CIIcdEV2MHKTvfb/XetIC7rubus=;
        b=mZZAymUSnMr0p4jzxwKi8QzK07aaNJ7XYQnKIsiXYe2ou1W56SjSX9PXE3QSg8XWEZ
         1Nq6cFiogPtQO1sjxpWu0t2NrU9YhCfYBgcvaUYc5z4OxBp9nNy0j2OfHAE+76P7Bpdg
         2ZFJhPS3sKV8HL3thf/YKLozN89C3JtCWJirNe/HbE4F9X6esAaGLZuyHzcI8dusq1Ke
         caMLXlvCnFU2nKkn+BfyKXo9HL4J5Nk49OxzIjK7sMFeu5cAVBOdOqc+lpYZp928f132
         OjK8W0EUYh69iB9g9ETekJ8y/EkRSPHhc0kOnY4r7xWGzXZv+NZWm3EA3lhAW8vuy5rI
         Ayng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QgmxRXiV4eVbA2D+CIIcdEV2MHKTvfb/XetIC7rubus=;
        b=Fw5NnltB6wMA6fFIJ8bvqUZbcZgK/9flUhWn6LWRChStms4zOb/KsqL+pjRJmBFwTg
         YEHGjR2OhgC7X0Ca+W/9NLL8zMEEtkxhhww1UX/NigsXhwSMjGLF1/pQDkEPwrnzOKQ2
         tZjkhqqlU8oFh+d/5IZk+5I1xkWhtFMwzdt6nzR9WXKDV6GQHaag41OETFGKu9VzQtwC
         qqwvmMrjgDeS8cmZLANYAqWVbbiuSDNIXgWhEFfRG+LIG7vxagUZp0ybqvVIQt3RHXXz
         pBYycyYuRiNC2pAzxhKDJHQa1m5Qf9BjTAJw11AVYTiXrHFourX5Igb4doCjPObvAnfJ
         uiyQ==
X-Gm-Message-State: APjAAAUWK0LuWnPkIj++/2oHOa0TTC5Y0IXSH822SXuIhRI+GWv0BCop
        W71Um3+FD3AlQhWX49aPLdlDKG+3+AM=
X-Google-Smtp-Source: APXvYqxLZYDPjHITYPuLGErUtE7snQdksVmHOzJvYGqjfz2RdpRb8Kwiw0Y+5f6dwxBeKzZAVreQ+g==
X-Received: by 2002:a63:4042:: with SMTP id n63mr11517121pga.75.1566258526047;
        Mon, 19 Aug 2019 16:48:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 185sm18769681pfa.170.2019.08.19.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:48:45 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings for lima support on HiKey
Date:   Mon, 19 Aug 2019 23:48:37 +0000
Message-Id: <20190819234840.37786-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter sent a patchset out back in April to enable Lima support
on HiKey, but there's not been much action on it since since.

I've been carrying the patchset in my tree, and figured I'd send
out just these three dt-bindings changes just so hopefully they
can go in and the dependent driver changes can be more easily
pushed later on.

thanks
-john

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org


Peter Griffin (3):
  dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
  dt-bindings: reset: hisilicon: Update compatible documentation
  dt-bindings: reset: hisilicon: Add ao reset controller

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt  | 5 +++++
 .../devicetree/bindings/reset/hisilicon,hi6220-reset.txt   | 1 +
 include/dt-bindings/reset/hisi,hi6220-resets.h             | 7 +++++++
 3 files changed, 13 insertions(+)

-- 
2.17.1

