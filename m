Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DCB206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF8Uw4Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfDPKDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:03:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfDPKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:03:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so24695810wmi.0;
        Tue, 16 Apr 2019 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=m67QPfQLc/29crQKofMuilz7bCXKIvlTup1fuyGjKwA=;
        b=lF8Uw4FdPKDuB2JfBM5+wP73nlmTa8CxvQKXa4F01ihwtSYHKpHM8uK3zaI+qd50VW
         RRf6v7TBDR9Ottn8jooYtsBh9D3JoiBN2isSIPts8ZS+b3s1idFmyzqoz00l6AHO2k/7
         6LK59dHu0b56gYgshQjxWQHn3VotijN08aSnK8Od0qi1EDGY6n0iAI37RFvT1dRxwXHb
         RwEPWsbAK0RZmrN2DBXgai+QqmgSAAuer/j3tSY0BKLAIRn9L0NPYUI4B3in/PPnwE50
         UaYREozRu3PaKQa92G8/FXypHSoLxJRivX3pT3FuIGBwZ1DTOZlRdWI++vZqf9y+mCdS
         SeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=m67QPfQLc/29crQKofMuilz7bCXKIvlTup1fuyGjKwA=;
        b=RRzidKatpze4ROF8FA9zmuxe3vAaSVQYshaxAJi3SwApSd+R97pKGBgnCloiNkp9PO
         V4QgJfHRTatatElDJnE0SG18nsTqkxNEcPrpCsRPVj6M6TPj/TX01gHuQ2FjCVKJbnM3
         8Txd6Ob8cjvQ6PJD57dlVfGCBmWNW6ji9FeTvm8jDDoiJsNoYNxNszzzmBOxDKG1/F6a
         fYKtPSHWLB5cKv5cEdi6/WPfwI37UgaaNDWlCFgtqb1nsaAj7O6Ad3TBVa3PdY55CSvt
         3TDavAdtg1cqAmcmMAknyxnHGZxhJHhpzPvT4JHDDmH7zmW6AkKZLekJstjj6dol3x2z
         86fg==
X-Gm-Message-State: APjAAAUs5iNBjf9umU39jZB3GxjUzqvTyhYpQTrBTMBS3iJr+sstChKE
        DUby+j2UUsHItD0fJWwNiPs=
X-Google-Smtp-Source: APXvYqylSEtuQLnodvrb5G14F8Ud+W11WOndoaakzmyMqVBQ5jhcxPsxDn2Oi4inQbHxjGj/MDnagw==
X-Received: by 2002:a05:600c:2208:: with SMTP id z8mr25634642wml.89.1555409023279;
        Tue, 16 Apr 2019 03:03:43 -0700 (PDT)
Received: from X555LD ([2a02:85f:152f:6300:97a3:b238:f8c2:9068])
        by smtp.gmail.com with ESMTPSA id d14sm72763828wro.79.2019.04.16.03.03.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Apr 2019 03:03:42 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:03:37 +0300
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
Message-Id: <1555409017.1234.0@gmail.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B45B252@DE02WEMBXB.internal.synopsys.com>
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
        <1555364715.1223.0@gmail.com> <1555366759.1223.1@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B45B252@DE02WEMBXB.internal.synopsys.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


txpbl <0x4> (without the no-pbl-x8 option) is the last value where I 
can change the MTU without a timeout.
I've also tried <0x20> with and without no-pbl-x8 but in that area MTU 
is a hot potato.

Seems pretty good though, I'll keep poking to see if it's stable.
currently at txbpl <0x4> by iself I get tx max 934 average 916 Mbps

IT does fluctuate at times but mostly there.


