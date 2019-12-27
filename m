Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AD1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C482620838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+Q0zYT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfL0DvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 22:51:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40088 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfL0DvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 22:51:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so25047763wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 19:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJGZWYLF/oYH+IYqMO0aJyE+4yrYnOlbo7DEs+O617w=;
        b=r+Q0zYT4zwfDOWVnUpfwTCWKUWGJMY+bevNasGdqix6GgZnEAJ46YawUwO2NsbctTd
         iBdcHY/VwwBwZDJJC3T8VkRL1rGLaEMYCNueCpu5U0zyQ1/rcnApeomqx7erYXq5Z67z
         +4XBtw/S9e1pmFGlBryrDWWLu+pgf8lwihd2H+RM+jZC0DSYbx2DxERqcXe3d8rzOqDi
         xl+qXX+Qx2OIyof8g4cMccVj2VsTZ7SKsKnbYvFhE/C80AV7tEtyBGYl/Fvy0DTZHovp
         wQdSs8O2tD3sETD/dAakRuyyB4oZEW9wb9dhJG4NoygjtHF2fyqtQK7wC+eVleEgeB9X
         oobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJGZWYLF/oYH+IYqMO0aJyE+4yrYnOlbo7DEs+O617w=;
        b=eD9kXjIlfwx8RVhm5sWxc+wO1Z/X4B7649keLJ9Qr6L0HO995obkeqbNwub9aygwco
         gESRKNE77gjMVMbKcI9vmOWzysjX/s+OBG1xdrcu68bW3/o004I2dDVQ65pBhuv6zrQJ
         5IYOvDEVHicQ+y5VHmWIWf1HJIUBMUG+FgoE/drYbI/Bo9ANSzQTLjr6EpStqU9yOWVB
         bEOo/bxKHvwm7G2+mNHpAjRVzP/JLMZmLgUrPZpnlgMfZ58UKjowuTrG7uLgFZY4cwKg
         4BgkZUEO1Bm/F5t9T0ruTz7lrTbMI/EqefWuHcKkUCqN/JsnOkkxGfIh7FNq1PKd2of7
         o2UA==
X-Gm-Message-State: APjAAAXq0gWbek1JWkaMtZIaii269dQfjuvxUjDNQfRy8wJ1YTBxI6oJ
        JvdkPjF8pRjK305Th0yiRK4=
X-Google-Smtp-Source: APXvYqxqA4tnROpHjg5MouSdHDkHuqT/iZfyFVmbQNOC4zNLziYL+juYUaZRk3RxsF6rTY+zaLsNnw==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr51018801wrr.265.1577418659402;
        Thu, 26 Dec 2019 19:50:59 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8sm10289618wmm.0.2019.12.26.19.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 19:50:58 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: bcm: Select ARM_AMBA for ARCH_BRCMSTB
Date:   Thu, 26 Dec 2019 19:50:55 -0800
Message-Id: <20191227035055.23274-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220182115.26318-1-f.fainelli@gmail.com>
References: <20191220182115.26318-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 10:21:15 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> BCM7211 uses a PL011 UART and is supported using ARCH_BRCMSTB, make sure
> that we can enable that driver by selecting ARM_AMBA.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
