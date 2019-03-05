Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA7A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jq19CoHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCEEuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:50:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfCEEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:49:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id n125so4703371pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 20:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrWa1I1KlS8O2M5oWvlBrE0dGk9UBUElSbe4mXouqcQ=;
        b=Jq19CoHMlSEmGOgfXTJSaz1flGHi6N50sqGo7PIDHDRoGZ68zEJfMhw9nYvM6RWcRX
         VRy+4rAjQXlHd63YnL18K5KvqCSAILA2ae0Exe6q4dA+WRqego50j/8h0LqoW3CFwluX
         9Prt7O19nyKUjf7ofAUR4Hqb9wbxV5PtYm4PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrWa1I1KlS8O2M5oWvlBrE0dGk9UBUElSbe4mXouqcQ=;
        b=lffQbEPFFsvfS4eI/SHkRZAqlZNbNDcD9e6USTcnjK5yWQISwJgMoTlitG+SmGsTTE
         VbLBNMuHWqAMpB0RyMBViXx7FyTIZ/CeYhE1oPI4nqmh7+7A1oCVnRnQscdI3wshmfNm
         dT8Ssmls6iE3GXRPMXtSgJS7JxZt3UZjAPUj1bQPcm/W501adOiGAJ1x8LjJhp0nDurE
         9cwpDV4BTq9cIXsx7R3IQ3E8Z4VmWcjYl8ZKHK0FOAOK5tQ0ireSj3sWWj6f0fphNvzP
         j/A/yZWIm2yPcfbYEh0EYv42hvmwGSonFKGnTRLTwQTE0BJ3eoq6xjKAnQVqWNrfpHHJ
         +fIw==
X-Gm-Message-State: APjAAAWry0nFK/s1oXP1JEeSTubBHIo775X52aUAD0qIxsD5Lq7TAU8k
        jFMGCGGG8hJv8BOnUDz2Y7TmNBGYUHI=
X-Google-Smtp-Source: APXvYqxDX14Cia3IBVPkEaxEtMWwSwJovoamIP4HvycxEA3628n/4HnTYgRe/72ey0QB8nrmzdrjcw==
X-Received: by 2002:a62:2b88:: with SMTP id r130mr23596219pfr.93.1551761388046;
        Mon, 04 Mar 2019 20:49:48 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id z15sm15893883pgc.25.2019.03.04.20.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 20:49:47 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        jbrunet@baylibre.com, Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 5/6] docs: driver-api: add pre_rate_req to clk documentation
Date:   Mon,  4 Mar 2019 20:49:35 -0800
Message-Id: <20190305044936.22267-6-dbasehore@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305044936.22267-1-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the new clk op pre_rate_req.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/driver-api/clk.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 593cca5058b1..917f6ac29645 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -82,6 +82,9 @@ the operations defined in clk-provider.h::
 						unsigned long *parent_rate);
 		int		(*determine_rate)(struct clk_hw *hw,
 						  struct clk_rate_request *req);
+		int		(*pre_rate_req)(struct clk_hw *hw,
+						const struct clk_rate_request *next,
+						struct clk_rate_request *pre);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
@@ -224,6 +227,8 @@ optional or must be evaluated on a case-by-case basis.
    +----------------+------+-------------+---------------+-------------+------+
    |.determine_rate |      | y [1]_      |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
+   |.pre_rate_req   |      | y [1]_      |               |             |      |
+   +----------------+------+-------------+---------------+-------------+------+
    |.set_rate       |      | y           |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
    +----------------+------+-------------+---------------+-------------+------+
@@ -238,7 +243,7 @@ optional or must be evaluated on a case-by-case basis.
    |.init           |      |             |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
 
-.. [1] either one of round_rate or determine_rate is required.
+.. [1] one of round_rate, determine_rate, or pre_rate_req is required.
 
 Finally, register your clock at run-time with a hardware-specific
 registration function.  This function simply populates struct clk_foo's
-- 
2.21.0.352.gf09ad66450-goog

