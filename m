Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1100420879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1vQelJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfCYUCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:02:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42703 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:02:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so7091723pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5JxgwOs2B+EJen+Vbto9I2OCKL1skw4uUxxDOPoih0=;
        b=V1vQelJgaDQQqQzYWISB7hQGaeZTXoHmZhXThf5k501WShZZfBE4QhJbkZu60sGHHL
         Ie4NbEAC85J97kQGj/2S1zex567mJVjJp92PpLZ4AeGlwWiW1TgTwRIwS+F4xGDY5wGk
         texYcpZC+a44/YsdfCYcsibNBOuON1gjp1eemf49irkJ90B0nwJ+TzxPiy2YQ4NWE31T
         eaYVZ4HTLOU83l2de2Jm8m+U6aPpvXSel2NHCSKApxo+ALUZW4agnZVksxsGY8O8qs7F
         WbC+jvvzg5WhnYo/npF0dn8BiRy/Jn+LlWJr2bb/nEctTo160Xqu/3645bDKIvMU/hP/
         i3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5JxgwOs2B+EJen+Vbto9I2OCKL1skw4uUxxDOPoih0=;
        b=mwCGfC4ZF6X7o+8/JmIX+5C4e3s6bVbUzNFSjGRO7tqDNaRwSIzD/b2fveDDGUy++8
         CRoAUJWKNF1PkWIxTbaGVujWT6QRupRJbNaxb7fPyvXcy2X28StXICTbtSGKX7Py5tsp
         YCKwm/upurMTPrR/qhkHkwJUl615aWusDK+nmdWMtP7YODD9qmTkLVPcI7gShBS8A08z
         V0wKz0pqEGXzGTa6d4tIJcaeOmCLhGdyV6KVb08Kc3+fuccoODmCGPZZip0/hoe/MRi3
         Hhf9lIFaWbpIBVlUfmNCyGioUR/pEd3JrCu/MTPQOO3Yv2Z9eEHPs7rRvkJNNprHN0eb
         vLsA==
X-Gm-Message-State: APjAAAUt2euATwLyHYC7HZ8/sng6IqvI6bquVwF3pxGvQDmZ5DdtR4VK
        QW6RuHqW6DpbZaLd/lZTgY7aJ2Nt
X-Google-Smtp-Source: APXvYqzWoxU4K3jJRa1HUV2b2LHbqNTBQJJPsOW1AphoR6kmz8y0b+K5seniyWqI+DL8ogTAFwapHQ==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr24957852pgp.308.1553544163825;
        Mon, 25 Mar 2019 13:02:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z6sm25297500pfz.65.2019.03.25.13.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 13:02:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     opendmb@gmail.com, Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: brcmstb_gisb: Remove print of base address
Date:   Mon, 25 Mar 2019 13:02:26 -0700
Message-Id: <20190325200226.14549-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320194057.23946-1-f.fainelli@gmail.com>
References: <20190320194057.23946-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 12:40:56 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. Displaying the virtual memory at
> bootup time is not helpful, especially given we use a dev_info() which
> already displays the platform device's address.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
