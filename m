Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7A9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215FF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoqZ+USS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404198AbfFMQtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:49:07 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:38703 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfFMElp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:41:45 -0400
Received: by mail-qk1-f173.google.com with SMTP id a27so11898521qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=Uh7QEcZOHyufjXnKgIUUP1TR4HXzFVNhNjMRmSOQ/So=;
        b=YoqZ+USSEjvVBJNXLV9esc9fw1+C5ITKaMSyYellEYDbnDIqAyYLtQidVCeog5VnN2
         i9RV+lHJnbEeufxRJu97ENmOYw95cnwU6YvTHr321OsjDxiWMEMIi7zMfd3DmF6vBO5K
         vu3NUCY52osolrT/cAC9T2lwhbpEfz7MPCE38v7sQ47IIyLs/cprI6aommAUK1G3TH8a
         k2RgO5LilXbUhAi6RtVc5uv9AnDeHiu49aaFhlGbkvTWXO6kAgqqI2pWk1lIwKOT3BXH
         R7eERKgjyQ7m3c0K2DJy58bAGacFm+Yp6YKSC/wWaIxJDT3pO4AyZQIhV+mJ62fYU72D
         JvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=Uh7QEcZOHyufjXnKgIUUP1TR4HXzFVNhNjMRmSOQ/So=;
        b=dVgfprjHMVAu/P1Wrt1l/zEtcvb9GEdRxSzwaZlQ6uFHluGFjWBGcGSTSF+cotOCmJ
         VPPO1XlP5OatpSjs3DHj++mSSeY9aGZY78qrXA9+b3UkY42sn4wjVLKpzaf88L1IP2KH
         APmx2D5SW1EtAv/Fu+72sdy2Fx36Pf9miUJn0AFI5hf2wiq7bHmqwwRK7o7fWSao7Wa2
         92MZkP2/jtpQLSN6nd6x6yVTV/SlumOqeKAlDuxl4l+i8KiYeZZ4sj8Equ0Jay7Vovpz
         6INrdYqhrsmPrteBuI5q+WLa7EM57kCNR0jfvMCnxQOBFGv7X8nOZtRCVz1qJpVn++jI
         rWow==
X-Gm-Message-State: APjAAAUsiwYlNe/DTGNmWLLZC55i3UEFZvA0kmg8rB4F8wm3J0YDbuNW
        4kTXGMBFd358XkCoUni3tubpRUViHuY=
X-Google-Smtp-Source: APXvYqwQkzmP0f5Xf6GB03DEo+j4pTSJdcvI7wjlYg9ohdlo9m0gVB4J9Tc3awuE7h1zqPgs7C2lnw==
X-Received: by 2002:a37:b87:: with SMTP id 129mr50552087qkl.132.1560400904643;
        Wed, 12 Jun 2019 21:41:44 -0700 (PDT)
Received: from freebsd.route53-aws-cloud.de (ec2-3-95-91-234.compute-1.amazonaws.com. [3.95.91.234])
        by smtp.gmail.com with ESMTPSA id d31sm1196348qta.39.2019.06.12.21.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:41:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 06:41:42 +0200
From:   Damian Tometzki <damian.tometzki@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: linux
Message-ID: <20190613044141.GA44572@freebsd.route53-aws-cloud.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux
