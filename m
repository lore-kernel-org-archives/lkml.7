Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C9C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DB020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocgp3bkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfCaMVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:21:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37386 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfCaMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:21:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so8028560wmf.2;
        Sun, 31 Mar 2019 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8WHLc8gsWd9ztdXdkumzXCUs2GaBQqD+2+kE4LRD9c=;
        b=ocgp3bkDV9HKd57T6vQ9JnOJoW3A/j2IR/88/53GrVEMOb1lYqNZartcgv+C8wVW4g
         T6yuwyoBqQGeMYK3duikTZtFCekK3nuFVZdQdj8K3K5X5Srm5ubJWvENKfo/KKv+ln2/
         pv7LRPi6gt6ayHWkT8qpiQkacXRpSocvMNkkLnwnnGqHJJdG2Vb2XuuaB/tWe2NC6z6C
         S/6JRcUjVGqJO8Q/BF7N/bZR9uNmeonGuDJikb2IBTCYvkJl32tejGdBFvNaOaLQuKuf
         QkcK52G1/ZnrdQbl3iXu5t+ylWpQxy/qXeWkFrcxZ35ErTFk/gOutKdgQiVpffM3w1Id
         De/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8WHLc8gsWd9ztdXdkumzXCUs2GaBQqD+2+kE4LRD9c=;
        b=ZapldB6JjicxcI93FgUkHGBZRI8xH0jia8PcMxqM9ubnaNtO0mOkoO9xnS4mDE3gSv
         dxHbsHwzQvKN0F9oibvC2d4gAKreE3BrXNF5k+IHyzyS9qgblJzk2a6NquGTRS6GnAPO
         DpKgpg/RjdI1z/2sywrmIeKPZArU6TgPFJr/LWCXdCwt4pIIw642pMl4r9mggAHxpjV0
         WbVaiLf5AZ7oOcltWMGp0Rh1CdcHKfAT9/7ecrMqNILdaSIszebFIIkc9PA2VLm69iBg
         HWsjwKPfNhClpJZIWowtoU/wlb7sXDDjOnYOCWgSDGy1QaNTTWhwElnoiTUTam2kMuUz
         F+9A==
X-Gm-Message-State: APjAAAVcrGI5Q52f0XoS+5G2LU85d6VTyR8l73QE11zqw3eO7lfYcUrj
        czhSAP9igCmMwzIzVXN4xNk=
X-Google-Smtp-Source: APXvYqxzShwxYgQ5Zk3JNapgseqJPPCh3hoHj31qJad/5T7PV9EzxxwKBdyAubWxRLHSmJf988R/bQ==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr9445798wmc.3.1554034866165;
        Sun, 31 Mar 2019 05:21:06 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id a82sm5910076wmf.11.2019.03.31.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:21:05 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:21:03 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 8/8] fbdev: sm712fb: use 1024x768 by default on non-MIPS,
 fix garbled display.
Message-ID: <20190331122103.o7ek46dvhop7lewm@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-9-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-9-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:04AM +0800, Yifeng Li wrote:
> Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
> target platform of this driver, but nearly all old x86 laptops have
> 1024x768. Lighting 768 panels using 600's timings would partially
> garble the display. Since it's not possible to distinguish them reliably,
> we change the default to 768, but keep 600 as-is on MIPS.
> 
> Further, earlier laptops, such as IBM Thinkpad 240X, has a 800x600 LCD
> panel, this driver would probably garbled those display. As we don't
> have one for testing, the original behavior of the driver is kept as-is,
> but the problem has been documented is the comments.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
