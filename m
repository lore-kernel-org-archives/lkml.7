Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B410C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ECF21019
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vljJxcwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfCONmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:42:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36559 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfCONmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:42:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id e16so6167660wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uM0s9S7vXv3GaljebP63J+EXUbxskzR577CHIKCJygg=;
        b=vljJxcwyIz1T8MjotFTCUWy+GOpcrS+yczFqjCEFqb0DyZb8H1evSnHSk7hkKk7lAt
         UIg2oARBfkeT1fbDP1OVXqLKD8qWUkgtwd5F2mgold5nTnJjARiOL7tXYzVf6qUDIdgk
         ArTzIRVsd9QrA9EZYgjsrk543c6AKJwpbDz+bo3mzEuU//0kYHoE2BbP8lsIZhK6OQ4+
         ql3CxssMQfQXxu7GOds0fW63t4IcpX9g4kItu74rkk5c0YmGZBRJWJm9a9/jPSQClOMR
         FReit//JpjmubaJugnNGmy1Xbcgwt3vsvOMBmiBNrlYwOpAEaPxDC3sb47u/Tspllyav
         OjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uM0s9S7vXv3GaljebP63J+EXUbxskzR577CHIKCJygg=;
        b=KVyFU1qjakYLPzXMEbGh+Kw5gTLWJUjAN94bBuYzsfjGNqVB+lzBaO4XbDYHGSdgWZ
         cowSZM2f/nMrCAtNPFtLBfCjqzBsZ9UzGkdFlPy/GN8IHTFVuTNGKxI3321DV1lN6Mcx
         kwO0UkebjLtmoM+vDB2htoODVSPmDoyBxAKRg8V0zld7/2nJIfyZ0WK2Zd1cm+R3gvRk
         NVHnAlf/BgQ3c8UuFHmJyTTjg3ZEhXMaM0m+eHpegHH4zs8XOI+NgZ0FI4koxd4CDiS5
         t8WI6bu6JEvoBCV80lfXwqMcg8r7RzVQNzKjtpza1dg0R6y191UPSec1YyJsgCyfcVn3
         /bHQ==
X-Gm-Message-State: APjAAAXVsmqL7uxEmkgOdCD34a5GvURxL27JF4iTy4bEx1iyDdmhEf/+
        2CHANJj8Ug7XtGCgo4sRI7GRsQ==
X-Google-Smtp-Source: APXvYqzaCVBzGct+nK2d7TGr+O02Pa7sptZZ/tPLUkYTi0w5SmCKlbpZuYPuboXebpaKIcLlJ2USkg==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr2117187wmb.52.1552657370820;
        Fri, 15 Mar 2019 06:42:50 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x17sm4616143wrd.95.2019.03.15.06.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 06:42:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: g12a: add secure monitor and efuse
Date:   Fri, 15 Mar 2019 14:42:42 +0100
Message-Id: <20190315134244.14141-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the secure monitor and efuse to the g12a SoC family.
These are sent together because the secure monitor is required for the
efuse driver to work properly. This is probably something the bindings
should show but it was not designed that way when the secure monitor was
introduced ... something to look at someday.

Jerome Brunet (2):
  arm64: dts: meson: g12a: add secure monitor
  arm64: dts: meson: g12a: add efuse

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.20.1

