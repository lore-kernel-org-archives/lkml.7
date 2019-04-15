Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B390C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449120854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc2j0ymu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfDOWT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:19:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42437 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:19:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so23978669wrx.9;
        Mon, 15 Apr 2019 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=erLh9lDrQ2tIrVMooRVVe8ztODSFxROdIcIGIPoIrEA=;
        b=kc2j0ymuXX7fIimkzCRl8E5LzCs78to7DOy5pOmz4xsY4b6rZQnJtcZbvA/ESdooeD
         VSjs1O4fvxV7XUN8MTpoMb73h1UBrwXc1LFrDDFFNiyhArn7wwhP6i+dScXZ408y45xU
         yiNyT70fnKMwXowmsabECItqyKK/21f/mqHGX5Ac5cQDhxoF0tb1Ur7jAUtEF1RFuYSc
         npiJNBinRulHJkPb4fxfu4ltOfdlnZ46hsYqn4t7Yn+ZnwUtL1fOxX0PlclOydLdZkHw
         1Uo1Y3jh+JLD6wdJ4pT1t1Kr8Wncr4AMOdZpBnDyABkcBkF0N3fULLCR1EnkDRtrpOnP
         xVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=erLh9lDrQ2tIrVMooRVVe8ztODSFxROdIcIGIPoIrEA=;
        b=eWHZgoUiy5P4A40lm9blOO0Bm7jDtizD1qqZd8jSBHWrdBGY+Ye5e7VzJ9GyTxm7hA
         TDkVFTn2UT3G4gLdFXYBX/qoNIKyuoiHvOxFqEKjJTWINfbbCadhG8acgeYu3sg0eigG
         4lBb7KxpJInBjPGyBASpqjCAL8QkTnhisbA/D0/C0NuSqLVaXJp2ctRB/p/xjPSPdZ3j
         oMGbg88WQ+OT6lileUPE49WlWQhKAvW7iduuq5gQ/q1PZkeJ4OslP10h9j0NBm1Rib9A
         4+257/9wM6VmS/t5FbgUyNHIIyzgXmo+h1iZwbL2VPCSft3CN+rqERDZP5Pan2qHZuog
         rWrA==
X-Gm-Message-State: APjAAAXG7fOk35RoOMHbdxdU4Lyxe8P0mhbFJxE9BRzmksqnLFG5NUdW
        /gZiggI5FBPF5YR0d/qoY9A=
X-Google-Smtp-Source: APXvYqwd3lsUy4YXUORUH6O4zXrRAtvfu48SKr7tME97fcZT1/xZSfs0NXD6YNY77yD1ZIYXtwYiSA==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr18640507wrs.166.1555366765213;
        Mon, 15 Apr 2019 15:19:25 -0700 (PDT)
Received: from X555LD ([2a02:85f:152f:6300:9db6:69c:9ca2:bf50])
        by smtp.gmail.com with ESMTPSA id r9sm15807735wmh.38.2019.04.15.15.19.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 15:19:24 -0700 (PDT)
Date:   Tue, 16 Apr 2019 01:19:19 +0300
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
Message-Id: <1555366759.1223.1@gmail.com>
In-Reply-To: <1555364715.1223.0@gmail.com>
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
        <1554489537.1199.0@gmail.com> <1555016970.28872.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
        <1555067632.1216.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4586B2@DE02WEMBXB.internal.synopsys.com>
        <1555364715.1223.0@gmail.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So far with iperf testing

txpbl <0x20>
and no-pbl-x8 gives me the best tx I've seen so far:
914 average, peak 933 Mbps


