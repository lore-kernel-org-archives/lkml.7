Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99DAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A751F206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaM5lSuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEFKFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:05:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:05:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so1178849pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J11CAk6hX0rsSVl1UifJnPX7sfZSPwS6EsqX4Zx/yUk=;
        b=kaM5lSuLI0FV3PRZ8stKKlOCGIigBQ3ofdGJObwDHHSCL5UEwGsdcoi3yhbvo6H/5K
         ZIBp/fx/ZM9jarokbi4rfhTl4Skw9U5+/R9qFky+M3PdsEOYnGSaJXlrOZefGTweIRIS
         IK/Nm56I3yTXFWjf3St7nh87hpkbs/X2CHfqmE0kDWIhIkuY6gTQdVZWLTgbiM07MXJR
         Qt8Lq93vAC86lCeyQjRjUu9vs4reNp0Kcrw1V70NYG4IkpRGqX27lvJCN4b5dAOCQDds
         jyxaFs3H8ep+9+Kp4cjj5sxxQm0pcB/T977glnoYh22pxFsCyq61z3UEAgvPS9Xg129Y
         bvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J11CAk6hX0rsSVl1UifJnPX7sfZSPwS6EsqX4Zx/yUk=;
        b=qC4AC9YF+0NJZW5o7EqWbh375WeTZy4bHWw18lK8XHwZJeFQL9rfKXRwqDXgey5ltk
         rIhJ334mbUanIyNJDfO+H3R7kz/ommWtfKU/dCIxAdzP/uQ1KYJCwxpNhYgelVZ8J8VQ
         ePXZ1VC9m5NHkkfhqBnYDeWywl/lYR7tNl0fQBFBCoxHIeHV5a7spXV43j7B95gN0Mne
         vvH53xJWom+k0LMdnqJfhqh7R0qpFAlcluVj9uPOJkgzksrC6Og6bimr0yiHEyXmQ+rI
         ClLlwRg6Tg2Yc1WiRJHnq3H04s+n38SvYwScpfhf6k5Ms2chtRfxHT9K64EA3rObzrvZ
         OpWA==
X-Gm-Message-State: APjAAAXoZyBAsGE+XDQbwfouGwgawRtHhW4uTZyKTaljjK+alWSIZ3gO
        EJmjWpP55YeX/lrmHJQ1CpMu
X-Google-Smtp-Source: APXvYqz3YRJ9CGw5YQkYfcQtat0QM4RY2d72UCJBxq6uSXcYbbBu1tSi1wsMToVYUR4UT9LkO41+QQ==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr31239391pls.215.1557137151415;
        Mon, 06 May 2019 03:05:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id c137sm16229653pfb.154.2019.05.06.03.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 03:05:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: stm32: Document Avenger96 devicetree binding
Date:   Mon,  6 May 2019 15:35:32 +0530
Message-Id: <20190506100534.24145-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
References: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree binding for Avenger96 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
index 6808ed9ddfd5..eba363a4b514 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.txt
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
@@ -8,3 +8,9 @@ using one of the following compatible strings:
   st,stm32f746
   st,stm32h743
   st,stm32mp157
+
+Boards:
+
+Root node property compatible must contain one of below depending on board:
+
+ - Avenger96: "arrow,stm32mp157a-avenger96"
-- 
2.17.1

