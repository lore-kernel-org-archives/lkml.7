Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F13C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3302063F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5RFetQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfDER64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:58:56 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37075 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDER64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:58:56 -0400
Received: by mail-wr1-f44.google.com with SMTP id w10so9044399wrm.4;
        Fri, 05 Apr 2019 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=5XQVS7t9m90qdPGpy4MI72WNqmJlj0KlB6QjPVJbtik=;
        b=J5RFetQe9mWtcazqoTkqbDlgl1dulNZGqjluyuRxf9e857Q+3HO2jORVv4djfLq2+9
         FOsNap9hHQQ2/t0/mi1NEscqXl7fC7japUQ+dAaP2r9d51ZQs+zIRrEJmnrP4a8yRQZ8
         PHN+8Fi+ST/oo6igY2T712C9cIMlT5ETAysUnd2UrX554EeYmBgyBUNRwo2koFhHjnen
         2LlolljrjMGRq5CM+YwW8J1o6UxanY8JffXuPtjRFqgbGYtgmAGC9t3aaN4aC6LSSPg0
         lqZfnNlunQBUecorb4JFy7f52JMjgLuwQmNvLM2gJFFbnRabyfEQWiPVFKfZrBKAqF8L
         UxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=5XQVS7t9m90qdPGpy4MI72WNqmJlj0KlB6QjPVJbtik=;
        b=Bn4JEJ08i28eh/CT4HRndSlwG1gGyaID0GOuOIzVxj4xUYIo+N/pLRtz6CP1Fowt+I
         r6as47SJQl1Ropk0n6sCgormkln4lz9dJrsXG8evmvVcUWztSKRMenDWYhR8LVQvYuSW
         meJPRQrj/EjKOrSTrp4zMC/hMTcuTep+ajsDslHL9phCiYBa7nJPLsnZ5+cz4Nm3AKbH
         FLGLSN6QSUxyBDfrY8OMmWptdyaMu59Rb6zHGZ69/uXtivZqXwAstxNv7F7jEwVNUtK3
         d50+LAQO3DY97/+qJGOh99kTp9HTTXx3F7PGYddXbquthr6me+ANURlsKh5FlJhZyAwO
         e4SA==
X-Gm-Message-State: APjAAAVSkcQRZQfBng65mY+m2eAkVq0SNhtKTqGJS/qwVzXI/uxht7Vu
        kvAEpFXKBuGfOdIGMWjLDORD52dvNNAKtw==
X-Google-Smtp-Source: APXvYqxGgdoFHF6mR9jHdQsNuen/gmlaOrYV2DZ9uOHkg+5VCA8kqhDlOcMTbaz2NMp8z+VvVrFM+g==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr9186221wrs.291.1554487134218;
        Fri, 05 Apr 2019 10:58:54 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:9cd8:5174:23da:3e1d])
        by smtp.gmail.com with ESMTPSA id o4sm5325874wmo.20.2019.04.05.10.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 10:58:53 -0700 (PDT)
Date:   Fri, 05 Apr 2019 20:58:49 +0300
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
Message-Id: <1554487129.1193.0@gmail.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
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
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> You can play around different PBL values without using the no-pbl-x8 
> option.
> 
> I would start with PBL=0x1 and then going up. If PBL=0x1 does not 
> work then
> add the no-pbl-x8 option and start with PBL=0x20 and keep decreasing.
> 
> Thanks,
> Jose Miguel Abreu
> 

Okay, so setting snps,txpbl = <0x1>; seems to work. Is that our best 
value or do higher values yield better performance?


