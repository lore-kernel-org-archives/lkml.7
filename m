Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2801C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aQf+Iy0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfFTPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:00:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFTPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so3503294wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=By2vibD8ed5SvKJiLslQhTFpnxDveNnIcoeXnTW3Wf0=;
        b=aQf+Iy0nQ0FQz8qVhHiGfNhuG8rZz4Xwl8uToXWSA9d/lK5cjgTn5CJbCx89xFVaUY
         zhvkAyBr0XVnDpxdj7Os7AjgRlMh3uMWCzy7V7QqvOBDr9m3wKmhkzqxgw02c/jmoZDd
         pkYbaHjQAE+XlY0OUqp+Tm3cMJVRI8gogX6H21TYpYDn6V0yTXXjkgr6zLhR1ccb/Qur
         Sy0w50kZ1kuE5m2WZZog4dyJjKa5qzizHbfwjscF+BBrU/SGTkIKzLvD9lbMoJIKyhFF
         vpshSB7255OsuDSy8vFEEwplNxQtoiCs3MhaVO1BfwvwWxNTNrQGApMOsLU8dmjwWgSg
         zkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=By2vibD8ed5SvKJiLslQhTFpnxDveNnIcoeXnTW3Wf0=;
        b=Xw5iZONsx0K32OigHXycmFlp361Fo4yB59YEcAnOMyfZq9w8oNlTECoPa4pXLUCazJ
         2XPWPoBAsUzp+a55FniKKvYWlbzO/+dEKG+M/n+00aj6OR7bTzQOgO06g4JGQ6MUGivt
         UB1u3Qz92to0RvlylCn1lPI9qPp1E2hn77V8Fsv4T4ZXi+ywaLI5/ElA/B0bin0aNx+c
         rUmffbSRvP67OvQ4q95bq6E2RfsYILnXeG4kwG5JXdi6UFUdHxEteEtquxpnafSKQcmz
         2TdcL9NDP9hEnkLo17JO9IUyl0hVSwNVmtQaxxRgE5hJsjPTX0jwIJDF1GLNDi899Ev5
         7PXA==
X-Gm-Message-State: APjAAAUxmqFeseZRhRyK35ryJMRmdZFHB5oGbTsAcvHuofKT3m0c2Vdc
        WVJIUboazRXHwf2fA2rqNvO82A==
X-Google-Smtp-Source: APXvYqy4PpfMpc89fPxuLdkIg+PgewzWYS4fDQc+uPktXcbMW544oq2gwfbsa8I3ngP0nFcrvQzD3A==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr81645wmc.14.1561042822413;
        Thu, 20 Jun 2019 08:00:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 02/14] clk: core: introduce clk_hw_set_parent()
Date:   Thu, 20 Jun 2019 17:00:01 +0200
Message-Id: <20190620150013.13462-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the clk_hw_set_parent() provider call to change parent of
a clock by using the clk_hw pointers.

This eases the clock reparenting from clock rate notifiers and
implementing DVFS with simpler code avoiding the boilerplates
functions as __clk_lookup(clk_hw_get_name()) then clk_set_parent().

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk.c            | 5 +++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..3e98f7dec626 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2490,6 +2490,11 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 	return ret;
 }
 
+int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
+{
+	return clk_core_set_parent_nolock(hw->core, parent->core);
+}
+
 /**
  * clk_set_parent - switch the parent of a mux clk
  * @clk: the mux clk whose input we are switching
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..8a453380f9a4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -812,6 +812,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
-- 
2.21.0

