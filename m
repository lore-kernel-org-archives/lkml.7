Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE6C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C002084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtEgzesw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfDBGcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:32:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45405 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:32:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so6007739pgk.12;
        Mon, 01 Apr 2019 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHS2OJqKj6xRANV1sj2z+WTKmkExPEvasKWv9BLPxUI=;
        b=OtEgzesw2B0IUv5mVHvaxNwujAktKsr5w00A91ZxGIV7gsSSslrvvQxf8VWtStCEDx
         7082XQx6h/pRgh6LjRwyESCB3Gv30/T5Ir2zuFlTjt6qawwCZBgxeaVsThf/GY/aLEVl
         CGwcgudKMRvXmGv5Y+S9vKkzW5f8CZVEeTLHWxgcLc/2MlOEOpDp3zd8RA6wvYDHxCpV
         LgJI1oDSPvSxazZrqSe3lLHlIvG1JUNwvKhHeBl1Kvr4yeae9TH4B4D8LuR8OEylh0qV
         XP25kZvfRSgiEAN/nla8HGltQFI6dLx+Ji69nS25sPQQhbozx3hTyasVMWzBOhUrUcnO
         NBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHS2OJqKj6xRANV1sj2z+WTKmkExPEvasKWv9BLPxUI=;
        b=DzNVT1gkId5WA229459TwWGLa3c+k63CReqamuHFArLUxoo0pVwqbc7TMYbuv7Q2dK
         6v1bpXWRwHL0bfY2OZXOE3TPPc2fKQPo+ciFG5y3quHY72wb76LSRMxdtihUNPHeoDZq
         Mvpdb4fEdh3tvZvXSWms9kl2od5n/6iYARBceBtjPa99tfKCdAJl+j9+bJWCz3Dn+nUW
         pMVtZOh1MaZsu771B2uXpLpCVYqHWZHtsaSaXCrdWzVeCdSYLvG9GgZCEXR4QyrLlnIQ
         CMCqOVjI6LO+EU9pHX2ZQ0rNwU+CqBXrVrwwUSahA9NQprvihzyMN4ZUrv1ODeFm9SbC
         9QqQ==
X-Gm-Message-State: APjAAAWw9nuK5rMJAdbnLW94EmqXU79VCAIHK1Aa2DwwRy9khNDTRG3M
        FsrgdH5FHiQh9YPUJ8ZyGqQ=
X-Google-Smtp-Source: APXvYqwp7lbXFM74wVWgWuUn8e2AojrE5yckHl/rYqUc14StMv0sEf9qHtA/NNgvqW3iXpZdFch9yQ==
X-Received: by 2002:a63:6c87:: with SMTP id h129mr65618774pgc.190.1554186761385;
        Mon, 01 Apr 2019 23:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:32:40 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 15/18] dt-bindings: counter: ftm-quaddec
Date:   Tue,  2 Apr 2019 15:30:50 +0900
Message-Id: <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

FlexTimer quadrature decoder driver.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.21.0

