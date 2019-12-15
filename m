Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E37C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 07:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F6120700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 07:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="cLJpjjpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfLOHtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 02:49:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:21406 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfLOHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 02:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576396149;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=td8yBsthjIkGZm9vmnRS/XjA43oNBnSXyXWeFGiQQZw=;
        b=cLJpjjpIxOFSNOmiLtqzsQ6WBbR7oZ+EcMPkaREwllwyRGhUXiLHASK0UE3EwXSiQ1
        bn717uLYiBqgdO2oNHoJ+ALhVr+ng5mULAwneqm8TPlJ/T6R+T9MOqwnh93nbFLP1Hb9
        WTm6STEQGm3zlhF2w8ePF553dM5FAXOKFivvjPg8Ex5MYx27Cul7TiSU+VuHVhMk47zx
        yp+yNbYi+/cOclIz6L3zsagnTnQBEPLoFXrlb4G3cQjWSX1zI6aprtvEbx2BqS50ULR+
        JqUWae+rtNGAsE+D1P67YYIanwRLGQLNYRQlI3X14Wn22Tj3RNDB4Asggx8xGK5dZCi2
        oIIw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PgwDGiVw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.0.7 DYNA|AUTH)
        with ESMTPSA id i03ca8vBF7moD4b
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 15 Dec 2019 08:48:50 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] ARM: bcm: Fix support for BCM2711 SoC which breaks other ARM platforms
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <b209c3dd-0d20-05b1-6cbc-62f40623028c@gmail.com>
Date:   Sun, 15 Dec 2019 08:48:50 +0100
Cc:     Stefan Wahren <wahrenst@gmx.net>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux@armlinux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: 7bit
Message-Id: <8330901D-84A6-4618-A509-477D04A93B7B@goldelico.com>
References: <0d7bef0622d69bd4f1129afe26b358669e639ae8.1576361067.git.hns@goldelico.com> <b209c3dd-0d20-05b1-6cbc-62f40623028c@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> Am 14.12.2019 um 23:49 schrieb Florian Fainelli <f.fainelli@gmail.com>:
> 
> This looks fine, I would just rephrase the commit subject as:
> 
> ARM: bcm: Add missing sentinel to bcm2711_compat[]
> 
> instead of indicating the breakage but not so much the fix, if that is
> okay with you. 

Yes, is okay and indeed better.

> -- 
> Florian


BR and thanks,
Nikolaus

