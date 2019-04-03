Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJhEq3a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDCP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:56:04 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42898 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:56:03 -0400
Received: by mail-wr1-f50.google.com with SMTP id g3so22090024wrx.9;
        Wed, 03 Apr 2019 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=smtmugjUengH7o/rPhG39S10hJLY2XSkPxiSSe6Erv4=;
        b=BJhEq3a9s6peDPA8A8b7eAIlTvXiJCzn9b6pXYB54cYnhEiBXjsu3r+yUtD9ENs2qk
         joYTQqoM+4g4GVEjMvcHsFOLR42LxvjvmqkPY3oyREBWo+KIrqaoTm7uWhhgM6BtumQe
         0Sp3hpJmATdfkMogCNy2nO1S8oKizlYltDfZrbwNssbMd1bo3P/Cmr1+ktj+RIb5g6a/
         w8EHmc1ddjEEasVZuPrLP0K3D+gZmsyD6co8jw5Fvj97IUfvVJd4H/3OEpSCqK2I2aZe
         So/DddIfExjSIqQs0ja3/YVVxzKwAlp/aug5ANEXEFptliFgl/Zn4FK5kiJVPAuTDk0B
         CKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=smtmugjUengH7o/rPhG39S10hJLY2XSkPxiSSe6Erv4=;
        b=XMN7BxcZMle7DNRGBy4RNqt5ZpxZA1RK6sLZtFveHA3K+PCYBW48S9840OulEi3Fka
         RGLUVUxkOjuSl3c8UMuK9iVVX620O9/BZhCdkjHVqh2RwozcMSHAsHZ3KdfxjY3PYO8U
         EdHqBNiMG2NAz+xqFVrVSH5nK9l0JT/D6b0DJJcqUtH1c8MYxUBikEF6YAnhjpE69UT9
         QxzMP4uhYJc0+8cP75J2kPBvu5wMaZUIDW9PfCQiC7REncCmo+JxjXynN0T/pATM64mA
         byk80Xs9IVvhI0jcBTvM5jgoTixEb5eSsBgzq+zDxinvkjenOhjOmOq61GCJdkLp2yAD
         7YPQ==
X-Gm-Message-State: APjAAAWFKx/G4HlqonL69Noo8quDsWaZUblrZVzd5ejD8j+/5cvAUY/R
        IHLxsXahuXZuCET7SCGZtIM=
X-Google-Smtp-Source: APXvYqyL0ZD/w1CWqRxenO+dr0r40z3Z+/L7bvrGS17cMu9aUCD5gt5LmJpq0LqajlkpNEHUOfpBeA==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr232683wrm.124.1554306961636;
        Wed, 03 Apr 2019 08:56:01 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:d5bf:dcd8:8640:a2fe])
        by smtp.gmail.com with ESMTPSA id f128sm19406994wme.28.2019.04.03.08.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 08:56:00 -0700 (PDT)
Date:   Wed, 03 Apr 2019 18:55:54 +0300
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>,
        Christoph =?iso-8859-1?q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Message-Id: <1554306954.1328.1@gmail.com>
In-Reply-To: <1554305721.1328.0@gmail.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If snps,no-pbl-x8 does indeed have a performace hit, should the 
> workaround be to
> a) turn tx checksumming off or
> b) snps,no-pbl-x8 set?
> 
> I'll test to see the difference

Update: It really seems like snps,no-pbl-x8 is the better option.
So I say, replace snps,force_thresh_dma_mode with it.


