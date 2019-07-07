Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC6DC48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278CD20828
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjO120H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfGGSq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:46:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGGSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:46:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so14205077wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6timX0gQJEBIxMah3pF3mfpam6FwMoFqJWEfMCkqVc=;
        b=DjO120H1Z7WiybUUq/FmlobfZa+0Tjq2/BBSi8wrF94PSYVlvDjUg6zU1JBbgBRW/V
         jR6mC9zd5YO7XyYs6j78VgXOGQ9o77M0zBe9oQIG8PVruN0uMFQB8rAb7HMVfgtPRb/W
         x8dYcmSMvvoNrSRQ+l25JyEe8MvOl9dk8KZbCmY9uKT0SkDAF3+FzUtbeydT2IAKpWlt
         ThVrveUStdnioYPWHxgo+I6X+9+vWU9Fue1nE4oIky9eAhFkjw2dTu7q2dTr/hI1n64b
         qEp2+n0+S5NEeIW641OuRxaWmywIBug3B27Qn/mhQXwV0uKISvtJLXOBSFfI8XFo5avU
         Cb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6timX0gQJEBIxMah3pF3mfpam6FwMoFqJWEfMCkqVc=;
        b=sAlSp0ZcvBQ374pp9sc/1ilD2EEnztSyNT7B00hah8PGgShj8n9xRIixCoZ12haBgZ
         Cc1kfGnxnyOpIcsOyzCLUO6zvEgDya2Ea7Rov6FI0XYDbJUUiKwedfgigA0MNCQ9rgvA
         lOEm9PLGrohDNlDWaTD9xd+qeWATc7ZptGQ0u+ejbxBYhZ3htYrxsNTPPSwUQP7vdFoC
         XpG+1fGqNvUtWT5RmcRHIaAep2WI4P3KNJM1BZg78HYbMmuXdiOB1dzeaN4sYB0jgfw3
         ASj3b3Q2AeZK8Hv0Ev3Ay9vYmX1z3+vdCFi5pUg2+trAJkp6G17FwDnht2r+QdIhEQ16
         F46Q==
X-Gm-Message-State: APjAAAWBqo7frV/biQs0XPNWTbRuUDSKUHPI4CuLdGkWVR8Gju+p6PO6
        EexofvEu9KprkdxVsL4Udmni5kCFPUw0z2vm7hg=
X-Google-Smtp-Source: APXvYqxDsivsH4zthvW9FrIbBJrXLQ+6bpjhTvoaebrztfH+5uj3+I0VL3iV7hqmTctsYaJSnmcoo9Ll1g+TsbU8zy4=
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr13651549wme.9.1562525187486;
 Sun, 07 Jul 2019 11:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <1559114302-10507-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1559114302-10507-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 7 Jul 2019 20:46:16 +0200
Message-ID: <CAFLxGvwi4WzHT7FAZaucjSMy=L+Y2GY8oL3uFyBto+hK+BBTLA@mail.gmail.com>
Subject: Re: [PATCH] mtd: afs: remove unneeded NULL check
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 9:19 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:
>
> NULL check before kfree is unneeded, so remove it.
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Applied.

-- 
Thanks,
//richard
