Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457CCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A56C2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qy+CByoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDBWsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:48:24 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39157 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBWsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:48:24 -0400
Received: by mail-wr1-f45.google.com with SMTP id j9so18691571wrn.6;
        Tue, 02 Apr 2019 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=kjT+zU11EJ4z6Higb2Gj5XdIkww2cYf4jwrlt2RS3u0=;
        b=qy+CByoa4/M+HHrBfrWvgzY+mvoT+z0bROyLGaOkLEBL/ZBV0kJAlEMwggp6UHR+NP
         dAHJyvQs15SE8omCVgjQzW1t7TI746j3gxBochEHIen6BU3DRnE7iAoQWYpmYj/9yBYH
         dchNopf2RbRKqDsxlsYfUFkLyjQtDTaET339p22Tb8bMWJ6vbEZpfdIIxi5KZbNBRNbX
         BmdC0r0IYKwGr6eIqtj9pbqmJayp/wfZ86LrCltXfOzUDo/5942yAm34x13/bYJXLmwS
         BrNW/34XEoITGXCb6lvRuOIawcEbOtw4pVv71OzLI80m99kslL8T8lb/N511spitrVii
         cJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=kjT+zU11EJ4z6Higb2Gj5XdIkww2cYf4jwrlt2RS3u0=;
        b=R8RU/+UPvHHMWK3X+PAFGbo5t9a8wv047dE5QCGRA/8j7XxL2GNCQat9xSbp3ju6Km
         KYnsA32Yvi2dCZvWdlB1zJad9iAupAYYqKeu1K0bgzAFtzVsQgGHSDHW8a44ak+5amzD
         NMkocPWx9LnH79PPlHGZTjw9VjRhggTITKy/D4eslxPhn0R2gxs9DJmGWmkpjJ9F+NTi
         xuMvexlpumQYOUptYVNSnOF0Yk6Gm6hz7G3rLQqmo3GdDBAgq0lKiRvomU6AzRItOe7G
         3CegGrdgKPqiUYMp5Y9jiUGFoMg+tJPWezVTVtHwUVVgaSI/Bvujpu0xKEomuqAd6g9d
         R9fA==
X-Gm-Message-State: APjAAAVddo1ZzW8S2mbdF7uY1Isplv+PKiTwOSGx/ujKXBTFjapJnGwD
        aGtG+hDR4thMipfLfFFRt5M=
X-Google-Smtp-Source: APXvYqzCuvIgbjnLuCaJekXBlRBljErgYkgNcxTUfGL/8pKyJqA42SUK6Z/6STPH13WjDHROF52N9w==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr49358691wrw.138.1554245302163;
        Tue, 02 Apr 2019 15:48:22 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:f279:59ff:fe0a:7f16])
        by smtp.gmail.com with ESMTPSA id e9sm23432964wrp.35.2019.04.02.15.48.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 15:48:21 -0700 (PDT)
Date:   Wed, 03 Apr 2019 01:48:16 +0300
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
Message-Id: <1554245296.1271.0@gmail.com>
In-Reply-To: <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that snps,no-pbl-x8, currently set by uboot for the fdt
basically fixes the tx-checksumming issue.
I get 700~800 Mbps myself but that might come down to the setup.
You could say it affects performance slightly, as I saw in a previous 
email.

Without the setting The rate consistently drops to 0.
ethtool reports tx-checksumming is on in both cases

Pretty cool!
Does that give you guys an idea on how to tackle it "officially"?


