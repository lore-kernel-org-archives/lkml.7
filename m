Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ADC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957CD20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcyy/t+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfDESOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:14:19 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35497 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDESOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:14:18 -0400
Received: by mail-wr1-f44.google.com with SMTP id w1so9101724wrp.2;
        Fri, 05 Apr 2019 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=GJWWs7dXtrwRrhQX31mq/nAJ1D7m2/h4LZkcNli/3Gg=;
        b=Xcyy/t+m5JWKfafGZzdMa+Y7PQMslweWxCOUbQgtXW2lCbRn/tqnq+8FuXXHffYQGh
         rdAqA0ui3ThIhpiSw+J8E/BEDCLtwCHUa0bcWW6ue9xF3oloJVPUZ3umP0u0rQJTTO79
         sGrxFPQroKDBLJEj1VJ/y27liOi4/uY1+C9IBZwWIQpRJ08VDbx4JTTmgjxeZCFRyzv4
         IoOiqGsc5okDVpL6GAax+ey68quljzByXmxYyQP+uD/T7RCFKyGFS/L2l4O7JhPoHDHP
         HiYViyFn+Ob+EKTPut/u2TXBlkRzUyDczOHig+C7k4Ihh+jzK8Fcf1107u1yc8Bw+9D1
         9iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=GJWWs7dXtrwRrhQX31mq/nAJ1D7m2/h4LZkcNli/3Gg=;
        b=sejum+UdDUxGeJdpcs4WaILZ4vHuxCx89khnjXlQMnMy9plTKl1GJBEM5E/gDplADp
         WL9MO0jC5NT0fAf/V4nNeNEywEIWuHjDZMdlTN2NmagbucKofQSG8J49rRKqZZg0J35A
         GKIC5s9bjd1EzNRQfBhkoJjwreRmiEWcCm9sNmOagTEXPWh2aDZIZpsGTR5hz3bEwBhh
         0sCuZn92W5unnhwOvmusrbYwh5Fmxz56rQpMpwh0xCWXWvkSNTeEaUZRAyNOfjf5CF3M
         Z2OKCbBrN95LG4SOEKuE5UvcOY2wJnAmFInpfCTuBJDNWWevRBVGAmAJBeFjjaY6MqQh
         zOqQ==
X-Gm-Message-State: APjAAAWc/rXebWdK4ib8Fubd0j3o++kCZyzwr7s+olBPA/+7kenqzQ5N
        mKPefGs+XJRcfSuA7Jgxay0=
X-Google-Smtp-Source: APXvYqzg3wiYY0EpTEIfFL6WNF7co1lZ2BQagN6zuFYfL/3hczTelm1SO4hDspYBuZzxBAiRwCiwew==
X-Received: by 2002:adf:9dcf:: with SMTP id q15mr9154797wre.205.1554488057138;
        Fri, 05 Apr 2019 11:14:17 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:9cd8:5174:23da:3e1d])
        by smtp.gmail.com with ESMTPSA id q3sm31140943wrr.75.2019.04.05.11.14.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 11:14:16 -0700 (PDT)
Date:   Fri, 05 Apr 2019 21:14:12 +0300
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
Message-Id: <1554488052.1193.1@gmail.com>
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


Seems like snps,txpbl = <0x20> gives me better performance


