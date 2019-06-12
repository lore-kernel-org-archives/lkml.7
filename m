Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D667AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D17C21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgxAHv9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfFLPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:54:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34861 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfFLPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:54:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so9152720pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dk7iIfVemqp1qY21HX0k9m6z8Gfm7pIDU7ArSW1lF8A=;
        b=xgxAHv9PF8NhuGiJryzFh11JsxLEP0bY4ROwPF8j0vMIqevh3bdvpJnI2LOeuZl7Rl
         7YUEftyKnrQ7Lrfryz0W36tsBRJZ4rA81eA2mKmNjYzf5jjPCbthA4ePLT3TKJslkb9Y
         7lyT0xFlNyOpwdSJZcZRfhDxAFjwnHJromrcO5Xwb7H8G7cqMh9SIuZJI0MIIGMi2OCq
         uReLi8ldAXbKK+coXFPHBKOu4yGUX0kaAYGZLno0Cz4rXDxUkcm6clvKxYEV+9D6z7Gs
         d9UQZaTg45KVMLnKVMl5l595EEZaKZmYLv++9v3tonm5uJ6vSNs9LuW5fDKdFxTNner1
         8z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dk7iIfVemqp1qY21HX0k9m6z8Gfm7pIDU7ArSW1lF8A=;
        b=B2hi93dIqvjyRw7mnHMruRAGOo2HjaGK5VYCtg5H34+d/bxGMWmuXeboZGrwbXR2aO
         y2KLtzhzlr7hrx56OgpIcJRQ+ZzpLHRJFp0cqWMkkVOeuRgegnEd2gt0UcEhlVuNahLW
         V/kgZlKUx/x/JuiPcFyRMBF6H/9hQ2l9D4+MwsMCIzI05yS1cDBlXlZWJ3oEj9W0DSIb
         pkBjuubnbvmswX5fUxWj5bO6XO1I7+we8XES6nQ3It3rb4dpH7WfkCOfnjCk744NuTSK
         ZHztvqApOJ197NtsGeljF8ADSMGe9vzBy/5U/1TWkguQ0PppjoQtTu/RmIricPA+I69q
         jwYA==
X-Gm-Message-State: APjAAAXWEYZCJo8eJumouIcTNJdNt0RAbprk8G9pGXzyrNQNgF0gZIgX
        ZjVpfpPs9uVGBsQfiH4y/8cXB9xchdvU6w==
X-Google-Smtp-Source: APXvYqw2Ko/nufD2xW1ZxC799E9vrB2BlLdKlWf43KzA5IEoAbjRBaopeHab8jUS0oB064lDw6WKcQ==
X-Received: by 2002:a63:4a1f:: with SMTP id x31mr15786976pga.150.1560354854729;
        Wed, 12 Jun 2019 08:54:14 -0700 (PDT)
Received: from davidb.org (cn-co-b07400e8c3-142422-1.tingfiber.com. [64.98.48.55])
        by smtp.gmail.com with ESMTPSA id l21sm1115pff.40.2019.06.12.08.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:54:14 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:54:11 -0600
From:   David Brown <david.brown@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove myself as qcom maintainer
Message-ID: <20190612155411.GA28186@davidb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer regularly work on this platform, and only have a few
increasingly outdated boards.  Andy has primarily been doing the
maintenance.

Signed-off-by: David Brown <david.brown@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..27df8f46a283 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2050,7 +2050,6 @@ S:	Maintained
 
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
-M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
-- 
2.21.0

