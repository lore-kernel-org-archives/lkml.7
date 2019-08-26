Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6135EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3489C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qT5sO3/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfHZHZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:25:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbfHZHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:25:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so14258758wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGSQN1D6LMdbmgRSGuE1QGkShUk3nt2JdTILP9Ti30I=;
        b=qT5sO3/VwNLT9TYqFJpq3GUIhwypqUCsOJYUBM/JGzJ/gCpXWQiNF1AM6Gi6hIqIsH
         W+DNZxpwQSlQ/bWfL5331VrESChFxdIa8OBRlfuGlHAfYIZThkf6SUCakQ499aGtoD8A
         xlRZGuz8leZeFBkz6lF+U7393CssphmGpF7rznn47Pg8bxx+9aMs1ws/oeRbl7qKpigs
         SARsEA2jq6l7cLv0phk2SQ+9ynqJUrdGdcl795ULoIayT2/b2cjA3BCNFkdbAzZgcpfh
         wyQ52xxVMQIlDFGRwLQaTMEjziHECD024y92rUV/T4MldmvJisruNiWMlWqgXxlMuIw5
         5CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGSQN1D6LMdbmgRSGuE1QGkShUk3nt2JdTILP9Ti30I=;
        b=DAmvbNM3XbAthaRE/z9wBE80A4yNz8Ioif/xD677BjEhDrFLROv04IWNzMd9UvyFML
         mFr81jkjkJ47wszZAOt5ZbK70L+DSCmebWZJdewZ5/3cjuZXvpoSjcNekJwqc6777qVu
         Oh9APcsB1xp/emsSpjPkxWbLpVNdyFm3QlsRlhO/JEZrW4TTiLhcxe5hEqEXxOUGa5iO
         vo0MB4AMCmkAbqO3ivXKyuVXsQNtz/n8vqWItV87UfB/wOTM051lAWJGLGKci0ukerGD
         zP7yeXb2YPiqnEU98DHp/PqnbWIFtpeFJiH+VOH2+LgrrBUBX8LQiL+lCtm6TBnHDzH1
         C8ZA==
X-Gm-Message-State: APjAAAU/w8feRclwvj8uEqQLYbpFv6PLVGA70Ww607JKbW4OgEdFc7KC
        dPYMRmQmepTSgI7/odEVELGrXA==
X-Google-Smtp-Source: APXvYqwlbtNtWnQBNuZa6LXcquUhpElWikUs08sQ+LU2PHstPRCWiPiyF+S0J+d1FpO1H6bp1Vu7DA==
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr19549498wrm.315.1566804344540;
        Mon, 26 Aug 2019 00:25:44 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm10821324wmg.45.2019.08.26.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:25:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: clk: meson: add sm1 periph clock controller bindings
Date:   Mon, 26 Aug 2019 09:25:35 +0200
Message-Id: <20190826072539.27725-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826072539.27725-1-narmstrong@baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to support clock driver for the Amlogic SM1 SoC
and expose the GP1, DSU and the CPU 1, 2 & 3 clocks.

SM1 clock tree is very close, the main differences are :
- each CPU core can achieve a different frequency, albeit a common PLL
- a similar tree as the clock tree has been added for the DynamIQ Shared Unit
- has a new GP1 PLL used for the DynamIQ Shared Unit
- SM1 has additional clocks like for CSI, NanoQ an other components

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt          | 1 +
 include/dt-bindings/clock/g12a-clkc.h                        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 6eaa52092313..7ccecd5c02c1 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -11,6 +11,7 @@ Required Properties:
 		"amlogic,axg-clkc" for AXG SoC.
 		"amlogic,g12a-clkc" for G12A SoC.
 		"amlogic,g12b-clkc" for G12B SoC.
+		"amlogic,sm1-clkc" for SM1 SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 8ccc29ac7a72..0837c1a7ae49 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -138,5 +138,10 @@
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
 #define CLKID_CPUB_CLK				224
+#define CLKID_GP1_PLL				243
+#define CLKID_DSU_CLK				252
+#define CLKID_CPU1_CLK				253
+#define CLKID_CPU2_CLK				254
+#define CLKID_CPU3_CLK				255
 
 #endif /* __G12A_CLKC_H */
-- 
2.22.0

