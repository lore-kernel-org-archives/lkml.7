Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6477C32756
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5012166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qe6yTEc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbfHHWqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:46:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40786 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:46:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so68066495oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=DnKHgJ9F5hokgG278SkinqqFUXS9qMAaHfTmRp0Gvqo=;
        b=Qe6yTEc5lHyuNe3Kf1y+C7yMfA4J8cPirbxyKUxqIMijShWwv71mpS+P1GMZsdk9zU
         MJL0xzY255mrh5Z41UAuis8IXpA0Pm1OL4gudKNwEuyJn9P1OBoUkfaIYdZerfsRdESX
         meXE45SpvCSSjfDpki+qZYRIvBXGe0RkZq2QHjAraxdqYJS0Qi7KZzIQie/wbETRphb4
         Gj7NMoI7icX/J6AJ44ZZKrkpQmX9/QI6HjX/UWkQ2ZhaaQC4h2XOWSk0ypBiL52vH6Iq
         dgya1rDlGzPvgI+Tl4WnLGSeo56oK45GhjZ0LZ4LT2dBYgHcv7i43Wbyv9uvWIXyjHqp
         Boxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=DnKHgJ9F5hokgG278SkinqqFUXS9qMAaHfTmRp0Gvqo=;
        b=SAPBFkXQoDwnNZASATLSWU+EHL457wqJnRmhuPcEvrcXf11RQQQFL+LGAKViRJ2yjl
         oQxDSI3tjTBQUNw6qI4csmWsfqpL/iZu6xFP4nlhPgOmegyqrT6mfVWhSo83MFjVDKHX
         JAkPIBFInUWGEIqVgVFk7pcf/21qFsBdOG5qPlss909MojaTcAd4s/N4nRS/hTmUDEpw
         SY2UsBlYfWfBwYCkeuL9JLOCFdMxqkCnGxrwoVLQlN868/rBGg7LEwZG3Xjp0b5+64H2
         NUrkU9fIfKojYWKSaD1IZfTopYr9Wf0KapJJdivFmWfUqEKUhGvPkjNKz7s/oDR3y51x
         RxOg==
X-Gm-Message-State: APjAAAXgi+irnYkqXMUDRPEEt4T7gD33DmUlhbe/taZu6Jxn/1vDHyEz
        nbh1gTt+hBKxfegEXnwlPPm5oQ==
X-Google-Smtp-Source: APXvYqw/HYoZ5cytMYRaqkQHJ3Zry9RC9XfYq/QgNc6zKYhejepO4NFoWoClcga0cEGE0fNVae45yQ==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr19028205jan.93.1565304387609;
        Thu, 08 Aug 2019 15:46:27 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c81sm148242491iof.28.2019.08.08.15.46.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:46:26 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:46:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: fix the schema compatible string for
 the HiFive Unleashed board
Message-ID: <alpine.DEB.2.21.9999.1908081545190.15649@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The YAML binding document for SiFive boards has an incorrect
compatible string for the HiFive Unleashed board.  Change it to match
the name of the board on the SiFive web site:

   https://www.sifive.com/boards/hifive-unleashed

which also matches the contents of the board DT data file:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts#n13

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 Documentation/devicetree/bindings/riscv/sifive.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
index 9d17dc2f3f84..3ab532713dc1 100644
--- a/Documentation/devicetree/bindings/riscv/sifive.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
@@ -19,7 +19,7 @@ properties:
   compatible:
     items:
       - enum:
-          - sifive,freedom-unleashed-a00
+          - sifive,hifive-unleashed-a00
       - const: sifive,fu540-c000
       - const: sifive,fu540
 ...
-- 
2.22.0

