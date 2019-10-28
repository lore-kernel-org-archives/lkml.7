Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD2CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DF121835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djJHw5Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbfJ1PM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:12:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36086 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfJ1PM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:12:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id x14so4746584qtq.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rj/mLsST/N2k9IF2aWftGlir972zQLwYBEZ8L6s+jBw=;
        b=djJHw5Zorjm802K3vKcF1InAi67JmjRlPUHVD9hYRwO7h9q/nv5/d7AQAzNzO+0D+9
         vmvMgh2Nv1rP1nooWYv2dxFyTogwXdA6/zHiVgVDWZtRuq5k1VUG+fxDm63mXrvRue/s
         smqNeNozUi2he4kDToeOIJRmXH+ujjk+hEuyFf0f9YN5jopLFz5nmS4Z0KDtGWbhq2rV
         6pgz190FPmtTAxgAX/77Z7DrUy6WLpXEbeOF4uoGd7vn0sg3KMBwwnQkUZ0DcKiKor1P
         xemNWU+yvI2UlKpKVmmWkRt4bPXAKIYKsUNpCgTTI61vwiv1c9tKoYZBRvZiLMCLKOHe
         0F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rj/mLsST/N2k9IF2aWftGlir972zQLwYBEZ8L6s+jBw=;
        b=gilVVZo49YfniY4MbsSJBEqJ8OJ9Z9XKCb4Y8lAEQ78A7MdyOGylVZVkH267e7ycKT
         i9dROYQueb9zaR/kxYWrAiRMLEmnVIXoX8qekW8n5tJ2YWY7uhyDwWfaCaVQaEllYi9N
         h5sfQ4CzebwwdC95qR2uA9rFe/FWqsN0MPVdPh0/U5oHMrHbWGlfqAvcQaumPJtDoNvn
         thWU27fv6SGMXgiG5A6+ejYdxrRBghT+mLdAD+kCFLL/n+e/XSuO7w6gz0V3gaobWsDq
         3FDrOSnTuGenNOmRYTUXLwuzFI+wrfxTbYmpFlo3068UshAi+4DzDCwS9GJOlijvaZNB
         MVsA==
X-Gm-Message-State: APjAAAUqVJzb/UqId1AIcz/3tpiJgZ+Ps0Lg9bRl5211n+KbAJVJIZdi
        gO2248lvTe3qyMYam3MtC68=
X-Google-Smtp-Source: APXvYqw0sFYMyUCcowoJNcFQcDPt5wU2NEuGQL2TVbB9BmHxILzhKeKegCSoeiA7g1FL9jz0k4Z/wA==
X-Received: by 2002:ac8:7410:: with SMTP id p16mr18315726qtq.62.1572275576385;
        Mon, 28 Oct 2019 08:12:56 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id u23sm3608098qtq.88.2019.10.28.08.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:12:55 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:12:51 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Cleanup in rtl8712
Message-ID: <cover.1572273794.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup in rtl8712

Changes in v2:
 - Arranging conflict between author name and signed-off-by.
 - Remove unnecessary parentheses.
 - Change the driver name to rtl8712

Changes in v3:
 - Change alignment of eth_type
 - Change alignment of SN_EQUAL
 - Remove commit of unneeded parentheses.

Cristiane Naves (2):
  staging: rtl8712: Fix Alignment of open parenthesis
  staging: rtl8712: Remove lines before a close brace

 drivers/staging/rtl8712/rtl8712_recv.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

-- 
2.7.4

