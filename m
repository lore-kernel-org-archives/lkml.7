Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73094C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E9206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lr6AYQJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392350AbfJCQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:42:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36993 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389868AbfJCQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:41:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so2128834pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MISJlJaBtFFImzW51FlZ2qBGeso4c1E39oXCASoBNDs=;
        b=lr6AYQJIgnwyB7CwEqqjWDeQ9SsqVwsCdDapXVnps1l33RshyzxmKLbE797W6iLl0z
         c88v9cK8+7ZGOqqXXM4++rUrt3XwsJJDtfu3IIe5aZHXMk3TH1y4EqZQvoiSnHfdB9Cf
         wMzHvqN6FwpbJ+hPU/4yhFzPlPyXM3/WtDMU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MISJlJaBtFFImzW51FlZ2qBGeso4c1E39oXCASoBNDs=;
        b=NRwDVfPkjIRgf/d5n8MT43nkubh3nLgdW0qQ3kO1cVvv/KODHMk/dd6cdu/aL27aed
         X9aWuVmzHb96VOiTzokQNIpCy5Pu4AFgzZSejZ2AAyloZXnUbb6GnPzoWNj1JmEn1HJ3
         tEwjwWv0teBJcKEbZRX+/lF5M8EDm0VeKjiRqTVj97xyRGRXF9rBpLfyclLtYcb7O9kq
         +hFR3/0n3UgdYk1cUPaADzOMR70MUqNgqmWfN9gHHARF83GiPCu453FXU1nT7xWRcF6p
         OoKSC+bAgHU18X8HDfQNizsMfO0G1PFaS8Sl31eCBibcIUWG+DtdnT726W44SnT5IMgx
         020w==
X-Gm-Message-State: APjAAAWlj0dwPyCzYsFF3WFa9pG2Ww2ZZwzBZWwoLW5//c1mt4YWuteU
        LFMdYDOgiMStG4cWi+o70AIMGA==
X-Google-Smtp-Source: APXvYqxmFA99XijlyILdYbdhLdTgH03fa06ehVPjZcS3nkRSbv5LJHGq4R3QE4o0s14IFNIpKdzkwg==
X-Received: by 2002:a17:90b:f11:: with SMTP id br17mr11589381pjb.80.1570120916856;
        Thu, 03 Oct 2019 09:41:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x18sm3280507pge.76.2019.10.03.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:41:56 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: dts: rockchip: Use interpolated brightness tables for veyron
Date:   Thu,  3 Oct 2019 09:41:52 -0700
Message-Id: <20191003094137.v2.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use interpolated brightness tables (added by commit 573fe6d1c25
("backlight: pwm_bl: Linear interpolation between
brightness-levels") for veyron, instead of specifying every single
step. Some devices/panels have intervals that are smaller than
the specified 'num-interpolated-steps', the driver interprets
these intervals as a single step.

Another option would be to switch to a perceptual brightness curve
(CIE 1931), with the caveat that it would change the behavior of
the backlight. Also the concept of a minimum brightness level is
currently not supported for CIE 1931 curves.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- added 0 as first step for devices/panels that require a minimum
  PWM duty cycle
- increased 'num-interpolated-steps' values by one, it's not the
  number of steps between levels, but that number +1

 arch/arm/boot/dts/rk3288-veyron-edp.dtsi   | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 35 ++--------------------
 4 files changed, 8 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
index b12e061c5f7f..300a7e32c978 100644
--- a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
@@ -41,39 +41,8 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <
-			  0   1   2   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
 		default-brightness-level = <128>;
 		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 80386203e85b..a4966e505a2f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -20,39 +20,8 @@
 
 &backlight {
 	/* Jaq panel PWM must be >= 3%, so start non-zero brightness at 8 */
-	brightness-levels = <
-		  0
-		  8   9  10  11  12  13  14  15
-		 16  17  18  19  20  21  22  23
-		 24  25  26  27  28  29  30  31
-		 32  33  34  35  36  37  38  39
-		 40  41  42  43  44  45  46  47
-		 48  49  50  51  52  53  54  55
-		 56  57  58  59  60  61  62  63
-		 64  65  66  67  68  69  70  71
-		 72  73  74  75  76  77  78  79
-		 80  81  82  83  84  85  86  87
-		 88  89  90  91  92  93  94  95
-		 96  97  98  99 100 101 102 103
-		104 105 106 107 108 109 110 111
-		112 113 114 115 116 117 118 119
-		120 121 122 123 124 125 126 127
-		128 129 130 131 132 133 134 135
-		136 137 138 139 140 141 142 143
-		144 145 146 147 148 149 150 151
-		152 153 154 155 156 157 158 159
-		160 161 162 163 164 165 166 167
-		168 169 170 171 172 173 174 175
-		176 177 178 179 180 181 182 183
-		184 185 186 187 188 189 190 191
-		192 193 194 195 196 197 198 199
-		200 201 202 203 204 205 206 207
-		208 209 210 211 212 213 214 215
-		216 217 218 219 220 221 222 223
-		224 225 226 227 228 229 230 231
-		232 233 234 235 236 237 238 239
-		240 241 242 243 244 245 246 247
-		248 249 250 251 252 253 254 255>;
+	brightness-levels = <0 8 255>;
+	num-interpolated-steps = <247>;
 };
 
 &rk808 {
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 55955b082501..c833716dbe48 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -38,39 +38,8 @@
 
 &backlight {
 	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <
-			  0   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
+	brightness-levels = <0 3 255>;
+	num-interpolated-steps = <252>;
 };
 
 &i2c_tunnel {
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
index 27557203ae33..bebb230e592f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-tiger.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
@@ -23,39 +23,8 @@
 
 &backlight {
 	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <
-		  0   3   4   5   6   7
-		  8   9  10  11  12  13  14  15
-		 16  17  18  19  20  21  22  23
-		 24  25  26  27  28  29  30  31
-		 32  33  34  35  36  37  38  39
-		 40  41  42  43  44  45  46  47
-		 48  49  50  51  52  53  54  55
-		 56  57  58  59  60  61  62  63
-		 64  65  66  67  68  69  70  71
-		 72  73  74  75  76  77  78  79
-		 80  81  82  83  84  85  86  87
-		 88  89  90  91  92  93  94  95
-		 96  97  98  99 100 101 102 103
-		104 105 106 107 108 109 110 111
-		112 113 114 115 116 117 118 119
-		120 121 122 123 124 125 126 127
-		128 129 130 131 132 133 134 135
-		136 137 138 139 140 141 142 143
-		144 145 146 147 148 149 150 151
-		152 153 154 155 156 157 158 159
-		160 161 162 163 164 165 166 167
-		168 169 170 171 172 173 174 175
-		176 177 178 179 180 181 182 183
-		184 185 186 187 188 189 190 191
-		192 193 194 195 196 197 198 199
-		200 201 202 203 204 205 206 207
-		208 209 210 211 212 213 214 215
-		216 217 218 219 220 221 222 223
-		224 225 226 227 228 229 230 231
-		232 233 234 235 236 237 238 239
-		240 241 242 243 244 245 246 247
-		248 249 250 251 252 253 254 255>;
+	brightness-levels = <0 3 255>;
+	num-interpolated-steps = <252>;
 };
 
 &backlight_regulator {
-- 
2.23.0.444.g18eeb5a265-goog

