Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B84206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3y4DByh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfDOVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:45:23 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46850 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfDOVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:45:22 -0400
Received: by mail-wr1-f51.google.com with SMTP id t17so23870545wrw.13;
        Mon, 15 Apr 2019 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=dgCNYqaKpHw121pjOp5LD5JTfiVzS9vpk+rD0XgafPg=;
        b=p3y4DByhxYvaXECpITqNgSLoHdtAhAHHbS3ELyDnR0ONvnYo1BFiJQDM0sxlW2+kTh
         OR3MPAHB1Qxd40b1fcLehrV0tU8RW4x9V75R0uMpc5g/Z3v3cjsf6mINuKLozhJvT/sT
         oHFmWU7H3FvOPJmOUGXTg8x5myXPXpYyV6XFlLB0tNQOoOvHa17AN/1a2rnIKio3DlHe
         Y1MriG/8r5a6iRLB+5pZsAykSlW6P7R/49sSZuwTtdk+h0409C2FcyoVNzdL1SVk3xjx
         F+piLtG4+HNEW3+17P0reddntzfkFXRN2OuOGCKN6M5jUeGPfcds446SAW4sD0Ensdfq
         oKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=dgCNYqaKpHw121pjOp5LD5JTfiVzS9vpk+rD0XgafPg=;
        b=RbZx/CSOOaZ0dqnDQSltLQxuy/cBd4lx0sht5dh6FQgIqiF47C7XW96Ld3sa/q+RRr
         z9cP9RxZhPusB/gnIlcFX84CN8DzFftOrXgxZffqBsMsydB0/UkBPNjsA+i2mq4MC6yk
         U6Tcno2o6KrwugbOIVNbnOlpLc9cuB/GOk+JuKHQSTQ9BwRlcWUCLiaAZf94Gkbe8Qnj
         nc3N3GUNYbkH9ToOeYlSx7FSPAlfjL3l6bwEUyapICBCTjGUj0BAU4zFmH68OlQxoF++
         zdx+AHyZbPP90tbnFcEG1IjLnrSmYYXHzYnvYLVgm4e8YXBXfSDosDGpimQCZwBSCJVg
         zJmA==
X-Gm-Message-State: APjAAAX/YG6PlvObixKknpPCHsbmHieaUzP2BuVuMXr6q5dHnP1liDW4
        cJDxg7wgy32HuzelwMErgjc=
X-Google-Smtp-Source: APXvYqw5H5pUkd9dic1OmXAtOY7+JD/PZPBOyGGk0viA1ghSxcLABnlSan2vtRFy0oP6yaNf+30Rxg==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr50514110wrs.243.1555364720839;
        Mon, 15 Apr 2019 14:45:20 -0700 (PDT)
Received: from X555LD ([2a02:85f:152f:6300:9db6:69c:9ca2:bf50])
        by smtp.gmail.com with ESMTPSA id y1sm143770695wrd.34.2019.04.15.14.45.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 14:45:19 -0700 (PDT)
Date:   Tue, 16 Apr 2019 00:45:15 +0300
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
Message-Id: <1555364715.1223.0@gmail.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B4586B2@DE02WEMBXB.internal.synopsys.com>
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
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Notice that incorrect settings of PBL can cause Queue timeout. Can you
> try with PBL = 0x1 and no-pbl-x8 and let me know if the timeout still
> happens?

Seems like the timeout (and subsequent stacktrace) doesn't happen when 
using those options.
That said, with those options the maximum transmit to laptop is 185 Mbps


