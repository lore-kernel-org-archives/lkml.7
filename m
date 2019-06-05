Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A70C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED392067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAgoWy5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfFEMLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:11:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33943 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:11:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so5936163pfc.1;
        Wed, 05 Jun 2019 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0VttWoGeA31c+2HzIYdX6LBJx8qWi/Su25TJGeVD+lc=;
        b=ZAgoWy5UXnUyYxUnO8a97KJkK8S5ZwfQbzliMcuFGF5wJCS5QTunurNFF1CsElLMln
         WjKHBI/RI65POLDgTqTuEJJulsSPIAaFaQvdJD/yQhvfxEOjFyiVQN22Ojmw9PJvB5kk
         jzcHhGdI/ve6Tie/C8gawHf9vJFTCLsmKv7VnCeZn5HWgWslTpyMDALN3PKad+FE9SAT
         P1p2CzGDz7zNP6l+8qvGbRypkYGn9YNlj3Nng8FRDSqYeLM8OPEg+9u/CFFQTWWnv7pZ
         7rx/Gy2C1fbo1neEyn2f4+SgiGcu2D0w94tRKn5v8uq8BwbciVwY3RetEeqC6YkTDe8z
         +bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0VttWoGeA31c+2HzIYdX6LBJx8qWi/Su25TJGeVD+lc=;
        b=AvFvnNrAzlOMo5ujeblPj3XpKj3kfbXz6kG/lnF63bHRwCl6efScjgDvfPdTB+K9Bn
         vz811DbMNPyQ7gnLnJWzo9EDwacSlqVV1ywiYsDcjBNJvsMTh0JmzfZqXXBlvM3nqdwU
         zn8710t0mS15ytOYot9zn6qySYqbnDvtIY8RNDQOhXAQ1j7IYQ2IzQ9QqokverpGGYyD
         IR/arL7eyS0mb34uf59FltcLcTdSnckoXPfMOAFUwSI0DAWYhmBUMypz35D/dLwRxOMB
         9SYw5scuPgaM3ZzQr+3BFmOQmy4oyGtGD9p5gq2zMoLmK0kSlB6nkoyYgUEZPHP6tUKr
         pn1w==
X-Gm-Message-State: APjAAAVoQg8LKd/wKlVWUdbXR2NywqjI0AyVCVwiVgMB3U+8a4kR5n+2
        5pvVMMe6H7n6bWeEuP9QSYQ=
X-Google-Smtp-Source: APXvYqz2jOOChrGTnN1pOtlc9Ifhcp1FAReD38lXlHEm7M9HVHDPC1f/UQ4A+msSCasdtIJWKtoOjQ==
X-Received: by 2002:a62:d0:: with SMTP id 199mr15757825pfa.253.1559736682058;
        Wed, 05 Jun 2019 05:11:22 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id t14sm2424182pgg.33.2019.06.05.05.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:11:21 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:41:17 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fotg210-udc: Remove unneeded variable
Message-ID: <20190605121117.GA4729@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck

drivers/usb/gadget/udc/fotg210-udc.c:484:5-8: Unneeded variable: "ret".
Return "0" on line 507

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index cec4929..21f3e6c 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -481,7 +481,6 @@ static int fotg210_set_halt_and_wedge(struct usb_ep *_ep, int value, int wedge)
 	struct fotg210_ep *ep;
 	struct fotg210_udc *fotg210;
 	unsigned long flags;
-	int ret = 0;
 
 	ep = container_of(_ep, struct fotg210_ep, ep);
 
@@ -504,7 +503,7 @@ static int fotg210_set_halt_and_wedge(struct usb_ep *_ep, int value, int wedge)
 	}
 
 	spin_unlock_irqrestore(&ep->fotg210->lock, flags);
-	return ret;
+	return 0;
 }
 
 static int fotg210_ep_set_halt(struct usb_ep *_ep, int value)
-- 
2.7.4

