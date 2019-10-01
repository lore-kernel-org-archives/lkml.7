Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F0C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577E21924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TqlVV4aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfJAXHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:07:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAXHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:07:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so10737456pgt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Nf7W/69rcbuSCjp3T5cjBQS4Gd3M1DUTau7shEAvBo=;
        b=TqlVV4aRNdNJI/F4t+UvY1imNZCNpHkFYzdwAZRWjvxazB056mnYe1qHRWC6KUYq+z
         iSJNy6Os93x9pQOaW/lYUA3GScy2NV3Wlsk6OHQFWvbZS0F1cT0NtKV48S1jve0inqDy
         3weCrTIfx4rISC/82sP2LHIKHMYbaJANnsEwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Nf7W/69rcbuSCjp3T5cjBQS4Gd3M1DUTau7shEAvBo=;
        b=r7Nwi5gqa/e04D8rj94cdG70dAq+Ur0yOz9bphv99/pxjax9UZMUgGvBgDEvVCOMdi
         G4wlUaiS8sKIRcZ/EHOuVhiTEDwMSy/1gIbBegyykcgrErMmbYQ/MwEmPRLj41+K2ERn
         ESXZMBQT+u4baRuVmHJ9UZptkyNTFv15R2yyP3KOgJIf2ie/Nd9SdIuPHM2Fic6zZNG0
         eg7wA3oP7ZnVEGv3cRwHtGywlpMM4Py1S07yYzVDUhl8GoUThYRshRd5E4esdBsyY1Vw
         yOcVNWE+h0FTLOp4mZPG4w/+gObwt9B+VTgccHAtxfGvj6v7Gb2qqa693Ssq7uL8f53D
         kFiw==
X-Gm-Message-State: APjAAAUe97nS/L4YRC2A+5+YV27eMgISExI1c5qU742hosEtacPHac3t
        ackvrIvB9x6CLgImYcbykXVAlg==
X-Google-Smtp-Source: APXvYqwHNpEZQEilkNVmA3O5/XhCn/v8v+BBDw5V7KfhdqV5vHV6BNpopnq9XLH3i0O2OgOBpUpVkw==
X-Received: by 2002:a17:90a:170e:: with SMTP id z14mr721514pjd.119.1569971268070;
        Tue, 01 Oct 2019 16:07:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y10sm15879881pfe.148.2019.10.01.16.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 16:07:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Use interpolated brightness tables for veyron
Date:   Tue,  1 Oct 2019 16:07:43 -0700
Message-Id: <20191001160735.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
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
step.

Another option would be to switch to a perceptual brightness curve
(CIE 1931), with the caveat that it would change the behavior of
the backlight. Also the concept of a minimum brightness level is
currently not supported for CIE 1931 curves.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-edp.dtsi   | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 35 ++--------------------
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 35 ++--------------------
 4 files changed, 8 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
index 773bedca872f..e95c89fe0545 100644
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
+		num-interpolated-steps = <254>;
 		default-brightness-level = <128>;
 		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 56ad9a43a6c2..5e10cc644875 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -21,39 +21,8 @@
 
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
+	brightness-levels = <8 255>;
+	num-interpolated-steps = <246>;
 };
 
 &rk808 {
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 6b0e1cb1f681..503278e60d6b 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -39,39 +39,8 @@
 
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
+	brightness-levels = <3 255>;
+	num-interpolated-steps = <251>;
 };
 
 &i2c_tunnel {
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
index 27557203ae33..e50367564dc6 100644
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
+	brightness-levels = <3 255>;
+	num-interpolated-steps = <251>;
 };
 
 &backlight_regulator {
-- 
2.23.0.444.g18eeb5a265-goog

