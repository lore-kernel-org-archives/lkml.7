Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55065C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CDA216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i89TR/RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGDTKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 15:10:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38858 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfGDTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:10:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so3281163pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eoeEYOdEqIZcZNq9pmeZ1c/pJgF9dtMJSkeiYBAiydQ=;
        b=i89TR/RH7piu7X1G2CDukfVjSPIu/SqpUXrxtK/fbY++fQLTH+s6TUGWfRBi3Szjpb
         Ldv1rCeo/zE/Kueo63qiqWKBFb9+EFuzV/pC5Zs+hwFh38bOeBYVUSiZZ7mTagYabtnC
         SFgrzgyqiWfilRgSmuaUxIU6CM8OX81suJz5WaajShPmrQU9zF1aRxPOWvRFyjbt0+TP
         CGnhVDcxmLQbqj3XOysUoevjX70EP3d8H/SB7lymxT2oUradpMtkrLcfmreQn4PFyUYs
         SlqhJnrrTu7bk4HEqTdTpY9YGwpW/ZBtmoRlXeke14CHTzRsfLRnH+tXc+GH+wkmDUnN
         n5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eoeEYOdEqIZcZNq9pmeZ1c/pJgF9dtMJSkeiYBAiydQ=;
        b=HOJZJCB29/qoK42+HABv/ja45oOYXZMaFqbQoDOptr1b8NhtP0i6SfDpvHArW7+8P2
         LmR8TSvYVChLfObeJ/48leRCYck8oG54lf0HxsIjYkmJBAq29X5sIhi93LVnoKHH5yds
         TFY5EVo6nu2OzzZjpCzAq9XlgUIk1BjHoxtxqmUPvSOhHOzyjr5gAl/CShx4ZEVSQ7Xn
         WBU71lAH1BkRTyUvm5Ch4R9BSvgv3PJ8Cf3dF6SsP1NqAqxY+PXfteuubl43XUJ7QL5E
         ZZYaI5tQRxVcyuqqRdMDbg4lJXpHO27quJNjaGY5W2rUPcCiEjcIto390BJ+bo2pcHc4
         jgIg==
X-Gm-Message-State: APjAAAXtD29AIHN+0MAyrQPwdS6aCxgFeiDkfmRrdlohNVcMdf7oxvc9
        z3kfREt9T3SqsrkG4iCIXWUHVsvN
X-Google-Smtp-Source: APXvYqwrIftnJWSgTXCug1xbFEa+ugyQIaxmZrbO6htXQ9e08mEfTQxBLUkKBrxI+t6c488oVAYUQQ==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr1147947pjn.134.1562267434822;
        Thu, 04 Jul 2019 12:10:34 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.81.29])
        by smtp.gmail.com with ESMTPSA id t2sm6702982pfh.166.2019.07.04.12.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 12:10:33 -0700 (PDT)
Date:   Fri, 5 Jul 2019 00:40:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag
Message-ID: <20190704191026.GA20732@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
handler finished".

fixes below issue reported by coccicheck

sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
primary handler requested without IRQF_ONESHOT

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 85737fe..7ab9bf6f 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4056,6 +4056,9 @@ static struct wcd9335_irq wcd9335_irqs[] = {
 static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 {
 	int irq, ret, i;
+	unsigned long irqflags;
+
+	irqflags = IRQF_TRIGGER_RISING | IRQF_ONESHOT;
 
 	for (i = 0; i < ARRAY_SIZE(wcd9335_irqs); i++) {
 		irq = regmap_irq_get_virq(wcd->irq_data, wcd9335_irqs[i].irq);
@@ -4067,7 +4070,7 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 
 		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
 						wcd9335_irqs[i].handler,
-						IRQF_TRIGGER_RISING,
+						irqflags,
 						wcd9335_irqs[i].name, wcd);
 		if (ret) {
 			dev_err(wcd->dev, "Failed to request %s\n",
-- 
2.7.4

