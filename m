Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C90CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 21:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC412084D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 21:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU7h8V0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKBV0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 17:26:49 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42848 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfKBV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 17:26:49 -0400
Received: by mail-lj1-f174.google.com with SMTP id n5so2637148ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sgDk9haId+6tWTMbrbfKiR+W7ofCg50jM/4mDQFOsbA=;
        b=oU7h8V0vhadBvWD7JvdYgmw8g08GgIfiHXhvZBpIVT2BcA5/rgPLCO8HexmONx1H31
         miieXp8d6Bk8CTepspBm0SGygu6OGIb6WWLaU9WktfTkoXS/w8CosYWdd45vA1BJpOIr
         /7XGoRW8z88EqA5rE5Cz4ogfQ9N8wv1owmEGhAof2TG6kzYBobM1zcTVeeujFAKi3omZ
         0wirQn4BUpxpGYU7uG3BjdpdpeMaRf3Cwl3bXVCUy4WduVsmRzRPMfvdmK12egBVIMIv
         bvFYiuD/R3KDj4C2FXsRch46Nxndg5SDXtnSHFD+JWIQwsEXa5Zf+iBURjd6xpnfFCvp
         6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sgDk9haId+6tWTMbrbfKiR+W7ofCg50jM/4mDQFOsbA=;
        b=ioZG9pgwjqSb+IYKjtgFdF0VW0ykLRBilSDEyLH4iWWhofoRQ7uJBdp4s9IDq8/bzq
         1XdSfIj4B79EP2m0KXSjN0xuqUycJJfJcNu1wYlxkq1zjhMkLu9sJnEBmNSnz0wHWBvd
         8FKJ3zBKOYUMgv4EoGIobHWv54+yBZbw9WhMMVXrzQThs1SNthmcMfgizcZsK6YdN0VS
         agRwOdPPP18IrZiMH+RIkH1vQ0SDHAp1VJxvluo/htuAq3goctkpDtaoOkpZTrUjHm/J
         uxFhRh91wiaa01QUtkgtw696nfyWrT/v+E3CuwWf9qtYAXDVxiS0qM4KJg53eVZ2Rhqu
         AD8Q==
X-Gm-Message-State: APjAAAXDO4V5Nv9s4RLHbfIxCzjoVEnmfhD5kUvktabzEuclc84/xk96
        lqKHQsDxS3QwijuO67JZjEZyXT4D7YhBnlQ5WMYvkw==
X-Google-Smtp-Source: APXvYqxbNk3QA3WSX4C4+4ucYk2g0LLYHkFoMhcBkO4/fqsix3Etsb+VbR/PrEeKdfz0jKzXiY7VmOyhbvgCJVTfB9w=
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr9652231lju.51.1572730007240;
 Sat, 02 Nov 2019 14:26:47 -0700 (PDT)
MIME-Version: 1.0
From:   Srinivas Murthy <the.srinivas.murthy@gmail.com>
Date:   Sat, 2 Nov 2019 14:26:36 -0700
Message-ID: <CAO6QMdxGuzXPn1Eq8An4Ckmor+iPwMvBvu0b9Xjd4jBX2A4n7g@mail.gmail.com>
Subject: kmalloc vs vmalloc in kretprobe
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it safe to use kmalloc( x,  GFP_ATOMIC) in kretprobe pre/post handlers?

What is the recommended way to alloc mem in the kprobe/kretprobe handlers?
