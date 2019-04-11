Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8143C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B0E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYYuPQWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfDKVJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:09:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfDKVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so8355574wmf.2;
        Thu, 11 Apr 2019 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=ib31YbgmGdAjVLysZ7UuXHxaCd7/hz1JM37O8Ilej2I=;
        b=AYYuPQWsGF24+538x5UbOoIzZozYtX4HOnd17eubwki18jx3GjspC8ZayOV7nUOa7s
         zN5XmMrFchebAUPY2rgQ9UAwMsyuQeTBi0pzuRpAS4WQC0GcJIo91RgCOBGzkIUI1SgX
         Wj0Bj+amKM+1kUZz9XlAPaMG342+g8LZFgapOoGL8f1BUHAjmvI/uD5Pg4aqA8qZPi7s
         KpaidIuiRi0X180Ag2qCAD/H0AHzzq+WMnySdXFLcMMeRdw/BFUen5VPFCBs5WrhCVbJ
         9JKuUhDsnzFrG50xTypSoghCML5CkJoOvH43t6mCy7iNSO3S6/70LnCJn/vaBzm47ht7
         IeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=ib31YbgmGdAjVLysZ7UuXHxaCd7/hz1JM37O8Ilej2I=;
        b=rclPV0GeWZs61gAeHLQUtPjv1eVZG67T5BS6xm4jaVubGQC5fiumJciFuHIXY2dqFx
         kn4OEU3jix8GZp4brC5nt7VvtIt0xfru92B5SMtSSZYa+QjWMtHq+fbGixInmOGCp578
         aSsB8JZkuC8z1s5K6M1ApsDWZLvZalbWL8Qd0dJl/2lTUjxB0EObk0kOz5U/OLQki1SV
         S5tdL4+xSk42qd9q/ySoN33+4mAL0IfkF0vYgVe8b/iBzlv9tU7M4qQV17QMnO4gjQx2
         fJtXdmDajZS6Mqw5TudMEwyaLiuH50CziwafPlHsHvTShaddP5QsLHxLSKX1GgFhROZ0
         kpZw==
X-Gm-Message-State: APjAAAWDWZrJ0Z6+8Us8pD2+DXKbDeW9sCAz6bkxpJE7tUpSHEFtN61O
        v1BfaCRzsIq7WoUd/Z1ERsk=
X-Google-Smtp-Source: APXvYqwA3m/+nToJYsJLMTB/cv4ih9Uqnvx6aDcVXD5OPbvxOe+fa/YFLpioXBHSb1/Oa7jrwhMzdg==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr8027361wma.135.1555016977223;
        Thu, 11 Apr 2019 14:09:37 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:4102:23af:b06c:8ca2])
        by smtp.gmail.com with ESMTPSA id o12sm41144725wrx.92.2019.04.11.14.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:09:36 -0700 (PDT)
Date:   Fri, 12 Apr 2019 00:09:30 +0300
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>,
        Christoph =?iso-8859-1?q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Message-Id: <1555016970.28872.0@gmail.com>
In-Reply-To: <1554489537.1199.0@gmail.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
        <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
        <1554488052.1193.1@gmail.com> <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
        <1554489537.1199.0@gmail.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


At this point I've settled on snps,txpbl = <0x20> by itself.
If I increase the MTU from the default of 1500 I get a stack trace and 
link reset almost immediately:
(https://pastebin.com/raw/5JBtfWei)
whether TX Checksumming is ON or OFF.

That said, with the default MTU, I get better speeds when TX 
Checksumming is on and the PBL tweak is set.

Is there a better option in the horizon for the near future?
At least for the Renegade (the only board I have to test) it can serve 
as a temporary workaround.
Should I make a patch to replace force_thresh_dma_mode with txbpl 
<0x20> for the Renegade specifically?

In any case I would be happy to help as much as I can to figure out if 
it's a board specific thing, or SoC, or even an issue of the Ethernet 
device itself.


