Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539124655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIMMf9/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLQAPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:15:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32924 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfLQAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:15:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so1014072wmd.0;
        Mon, 16 Dec 2019 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYYyHoQRxGSOdiAM34+0Cuf2pCrblmn75emCeEW+TKg=;
        b=XIMMf9/VfNUTzK8xC5swP5gKINuVvSOppAERn4cJimmEiPI7utbo5lBwpIurvsULlN
         ZRAxW9hPLiaKopQGzZyVA3rp4qegJVGHtd8DWy2GgqQIakE5jtD8/UcYq3RclPCDwkme
         +dAOs+3NHnBUdhR1LaC62xAaNksRJPEMTOdhPLyW4+7bXGZJARbEnEjv54AtH+ABe1lm
         yjhZ+EWm1DYQrDoUXtM9M8Sglk7iDOZQJoc+5KhbCInab1uvaRILKajs9DFwZ8VKRov/
         0EANTx0IWmnOzFm/epTvWxi/jO1QouLdNffbetBAeXMW5F5e0j6w8b0a/0bQVmfKGRvh
         S3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYYyHoQRxGSOdiAM34+0Cuf2pCrblmn75emCeEW+TKg=;
        b=d/PIYrJD35GCeZwW4EYJM1Dykg3okoKeurf7JvplmSOVt8gE28/Sxn1GF3jyybbzjY
         gIv4yJLfU+pJUgO7RTVeHaHFe8xE391EWdQsMfUhM3XOsnXQY7xEm6qcMiu/Bpg7Ptsx
         MstNFXa/o0OOdln6iW7Q5dyA0qgIOpCwI7yDhdk1NspZm4WL4xPFoMyEmaoRYHXx/sdF
         B95GyM2F/25AgBeRZ6Rp4d71DSyebC5tDmo464Ia/fg0WpuR8+V1bnMtnyzYrVqabJ+b
         mlZSKTzT9fX1J07X7F6cfxgQfB9orWebelEyRXfdHhvgE9j+lThMmaXXRqNJITsKhdjP
         9e6g==
X-Gm-Message-State: APjAAAUZoyuTzzwACPZKV9OA4j1GHQh0Mn8U2nwQqKtEK8arOo6k0ox/
        BOcqECSfc+2/sutjkByeu2w=
X-Google-Smtp-Source: APXvYqxv88Tu8puIy5rItp/JvAkWSBThhnCLZh4MZ+XkbDdxa+gknsDt7gomIObMs3IrnIu2iHpQnw==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr1858359wmd.9.1576541736489;
        Mon, 16 Dec 2019 16:15:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z4sm1049924wme.17.2019.12.16.16.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 16:15:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: NSP: Use hardware I2C for BCM958625HR
Date:   Mon, 16 Dec 2019 16:15:32 -0800
Message-Id: <20191217001532.13807-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213195102.23789-1-f.fainelli@gmail.com>
References: <20191213195102.23789-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 11:51:02 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Now that the i2c-bcm-iproc driver has been fixed to permit reading more
> than 63 bytes in a single transaction with commit fd01eecdf959 ("i2c:
> iproc: Fix i2c master read more than 63 bytes") we no longer need to
> bitbang i2c over GPIOs which was necessary before to allow the
> PHYLINK/SFP subsystems to read SFP modules.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
