Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88927C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8EF2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSjHXX5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGJCQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:16:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40945 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:16:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so290301pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IZY6bRwRAQjzoXQqf8HuJovnIklLNuUq+A5t+/AooUA=;
        b=rSjHXX5vdjCegktJNlazWg3hrKdWgPp1/UN6PCwb8y2g2db+sbKKA2yiv/7eUD679w
         qol/0/0On+lk1JFARxqxj/GWoiSTxfk861mv3xLN/2EK+HORDzSwW0du4f+rXYqC4bZj
         jRvpHIUpfeKQ+WhWOvXKsbBkWYepuEa3BWzXShSq5kZbFhz9sLHFbqiaJDcvvW7hS5GH
         8FSvlDMkpHcvcCQMyoIW7zRMTd25W4uw+2xdu2S83k+golNx+kwVv1K1R7PDb2HfhtJr
         iVjBzmuhIPaYIcTZg+/Hc3GZ4bcXTa9SOefa51arS82sl7q+7yxo0K36tye+Zy5VwoEJ
         hR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IZY6bRwRAQjzoXQqf8HuJovnIklLNuUq+A5t+/AooUA=;
        b=A/4Xp4pnXEiVHv4jz/JLoe/EIfgscDtaKrwrp+kNBMQCQNXT+9YMSfq5nKkYRc03bZ
         2H8047bHcHFq6aFTFuDK5XfL5MemUAjx2OI8g8ROQoIpjC+QDsb9vObtZsBct01moAlp
         vYVNoQs6hjA6XflQxyZkApt/hIyPrIJsbZecsTkzfl9Wpvf9DN75pGj0dkYfgddDeWnG
         aC0usirvbFgDiEDwdpDXFZ31otJ9WjU8pdrQ5reZAiLES3mcrD5gwLER6eNZ4IdUKbRm
         95nPaCTyYQHQqivemKbcujT5UuP2ueWU81Mxh2kEMx6/ffZJNG8iF3NI9OqDA6pY1pEh
         H76Q==
X-Gm-Message-State: APjAAAU+wSRZuJxIZzsF6zBfBJifUjZYI5Ipp3F0vS+XtGE2R3+Vzv1s
        IOUyBhnH5VpiChkf8kfQJ0I=
X-Google-Smtp-Source: APXvYqxWbZI7rdrR4yEM0s/9je9rCJge8KVD+rD7iWvAP0hkCUC2Z51r9a1d4bA37gHPdkE1Xxnpig==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr33754977pgn.162.1562724994909;
        Tue, 09 Jul 2019 19:16:34 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id z20sm404943pfk.72.2019.07.09.19.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:16:34 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:46:27 +0530
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
Subject: [Patch v2] sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag
Message-ID: <20190710021627.GA13396@hari-Inspiron-1545>
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
v1 : add IRQF_ONESHOT and introduce irqflags variable 
v2 : remove irqflags variable

 sound/soc/codecs/wcd9335.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..9566027 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4062,7 +4062,8 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 
 		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
 						wcd9335_irqs[i].handler,
-						IRQF_TRIGGER_RISING,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
 						wcd9335_irqs[i].name, wcd);
 		if (ret) {
 			dev_err(wcd->dev, "Failed to request %s\n",
-- 
2.7.4

