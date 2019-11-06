Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9DA214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzHf6kB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfKFGDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:03:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36644 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfKFGDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:03:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so10925317plp.3;
        Tue, 05 Nov 2019 22:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3glad4Br7OFEAWnKi8W0AlNCFEiGRDuGfyWXnuRNMA=;
        b=uzHf6kB0GTeoZmJskAE4bVIa44hr+VnWrl3YJxN7gmWfrAu9fJjie3TljhWSxLKXNw
         lsOSi8z8MReol8e7oMeys7OeUm42qfTDgVtYcHJpK7ffoA7gOdDAf+jhhQ++z9uWjNBw
         gdcjRU76VTJ9xFtOqfmeT6DGEijMrFXO6maO4tAWNZFCxyZLr/3tYdkVcD1eJbfCnF5e
         fE/vDWfhmOFWM0mX3wYVn3qgchPIA+qcm+pQ2fz333564s6mBSuTrzGoNTQV5gp6dRxl
         /zRDDZlknhi03yE36AfsH04n0wOrjgD27Gy9+J/PmUAiWwKSiQQFjgNXbczgzdeSEjtW
         VRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=t3glad4Br7OFEAWnKi8W0AlNCFEiGRDuGfyWXnuRNMA=;
        b=ODsuagGYSsIo1qyNgTtwypcnCIxrBj1N2r22zE1G0bDOo7DVpBvvhY2RizBneqBbBM
         KI8kiEUGsId+Vz31HmTPp/dTaY8iPxwVavC27bqC9Dk1+ZDD58HUgzuGGPYW8mtEFchh
         ZLGxGyGrytSfeKWpX4d9BOJQasgop57nknnW99mS0+BW8cenvbIo9gkIwKEsodVI61/I
         QhhwWbw9ZDp+oyJs5rm6+fF6LHNcxoKlnFnN8JuCpgVRw9gkL/UxdTNLTlF++HSvYdNH
         Mam0KlCyGUhXZ6UlmNSNFM/lqIx8mBP3XoG4OD8/eiQmpAgjl7EdwI5V7WJg24BvuhM3
         eltg==
X-Gm-Message-State: APjAAAU41g8nuCgt3tiLQV/Fm1KlU57zJ8sKq7ySNYVTfej1xz1HE7Ns
        jqBlViBHypIngEqnUm3Myug=
X-Google-Smtp-Source: APXvYqxexZTj0llvvOMRO+bSz4awYD0RVKTmg8rgJi8XJReEgUsLu5a+nDgjDqxs/TZXO8FmIHGBdA==
X-Received: by 2002:a17:902:aa02:: with SMTP id be2mr831168plb.326.1573020194371;
        Tue, 05 Nov 2019 22:03:14 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id u65sm23177676pfb.35.2019.11.05.22.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:03:13 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 0/4] clocksource: Add ast2600 support to fttmr010
Date:   Wed,  6 Nov 2019 16:32:57 +1030
Message-Id: <20191106060301.17408-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the AST2600 timer.

Joel Stanley (4):
  clocksource: fttmr010: Parametrise shutdown
  clocksource: fttmr010: Set interrupt and shutdown
  clocksource: fttmr010: Add support for ast2600
  dt-bindings: fttmr010: Add ast2600 compatible

 .../bindings/timer/faraday,fttmr010.txt       |  1 +
 drivers/clocksource/timer-fttmr010.c          | 68 +++++++++++++++----
 2 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.24.0.rc1

