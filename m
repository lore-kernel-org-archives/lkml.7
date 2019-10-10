Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7F0218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nImln6xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfJJGWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:22:05 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33369 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfJJGWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:22:05 -0400
Received: by mail-pf1-f180.google.com with SMTP id q10so3227679pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3xx2p4IuteN9onz+UOwtUMU8AFFJXccUDhsiWW9aOo=;
        b=nImln6xaSPO83s71O92017258rJmga2BBxqv26EQ17bFj6qHQ4PiexD1TShHcSFN8Y
         ul5GXGrqUscyNuCZVLe+1FebUHkOB41Kbiq0qGNVnVvGygOCzi+6zGJO8nHe+CccNG9e
         WAEAfH+QHM9WkRJqbk+uQDePxeHkKiibGY3cr0jsqbkpxh3Y8qvMqKmbhkb9kbi2GpkK
         eo0AWsNZR1Ku1zvbmXumfp39pt/J6Tp775yVvkzxqTeNh7axPCjLurMop9lgNx67rpj/
         MUrbhRUdnDDvbs1IpnCdDHpogJI180RrDCL40w2WHJvH1SMXbcXpXlsuBq5ZDyYLUzGG
         Kvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3xx2p4IuteN9onz+UOwtUMU8AFFJXccUDhsiWW9aOo=;
        b=azAuOAwPiqLYxR/uWWOBD/PRIPkhZIwr8I2cCqE+Ip/uGPRjY8+gxMIXGo5gRWzqdg
         PCsbiVSjnRNKt0LRXEs7nHPSR4CwexGJbgMaLFubxUk3YQXR8txdH+DlW/mXRurXiTT3
         0d6jzNqQvD0jdqykRjUDnlE1XklRRuMjjYolqDcfu21jxF9ETCEk7UXFi92PDa+FFToQ
         qSAmLzLahNgSCwq6fuwJC544pSaXfBu//Xd6qXrWVUHTf7Mt92lgqzJyCzJ+nBBf1kB+
         HQZHYWQfFei1sQocQzYyDR4a75c4Tpnk9DO3hUEP1HwKzrTh6lydkDmeJLV5moyl39+h
         NbsA==
X-Gm-Message-State: APjAAAWKNJySbgIIQtDun9UDoP9z4chOIq9pZMlrprThnGtdHdDuzyxE
        W0xywiKIcxRnUq9+Kx4d8W7sZVQQ1RPcTaLesdk=
X-Google-Smtp-Source: APXvYqynqxr3UF+mHBs5FT5Jsa/QUx6bfV020xXLSFbkwxwVwJuxkju2NIDysrTNUpCGtSNN99Hkle6sUSWb0a9V6ho=
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr9043664pgb.303.1570688524540;
 Wed, 09 Oct 2019 23:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
 <20191009174500.GM5610@atomide.com>
In-Reply-To: <20191009174500.GM5610@atomide.com>
From:   Yi Zheng <goodmenzy@gmail.com>
Date:   Thu, 10 Oct 2019 14:20:23 +0800
Message-ID: <CAJPHfYPkPSguU8vvZWbkeinZz1F7SSkcxJk6AAyTBKVfqNoGJw@mail.gmail.com>
Subject: Re: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Sekhar Nori <nsekhar@ti.com>, Zheng Yi <yzheng@techyauld.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

   My patch is canceled. I have tested that simple adjustment, the
device IRQ masked unexpectedly. It seems that it is more easily to
occur with that patch.

So, the root cause is not found yet.
