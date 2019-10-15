Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E2B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZEIMKnTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfJOQQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:16:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45155 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfJOQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:16:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so20858150ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Mxk+Wx7DBRWAItFriOGDg8287W/Km/OXrRlXd/sfSuk=;
        b=ZEIMKnTqbmCbUHxlevy2Q3QkL6Vn2hA2SImGas6O+FBL85pXTNT5v3UK7pXhorDQj4
         H8ukVExRa8kzLlAo8ye4jXO1FonkgIO+0iXeXoBf6zzNS+xNIxFmsLezRLwDbtBbA9SU
         mEIRZmcw0FGPB1HZOvRa/inMVrU5SNabHwR4/B2LuseK8QKNCxnBZu0l1ZlpZt+ch6E4
         wJyaURB1Bu0rnXOxBpi3CdeowyBJ0Nq9KI4Tel9ZLTT2KAUC2tqFXaBU1qeEdnm6tMLW
         6o1C0kq+24tbmTLBvKdbI+L3+KydF01+MMiMObCxyQn2uJwKt1PgpS5ik4O3w6VsdidV
         9ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Mxk+Wx7DBRWAItFriOGDg8287W/Km/OXrRlXd/sfSuk=;
        b=eoJECbXhbgaQPoykBGGJNU/72ZVzyYfWrTIO9MAxDqHx3YqJ/2pJSuZQZy3Uw9wUg8
         ZX4b9j/Jf59DkZmaDEYMSq0ASkrZrzPY1TZ5SVAfdFMbtVOPffbDUEyD7Fwg+S9jb7tD
         QhlWmbrq1wJDvQj9+tIKLWZY5khk5f7xOYxc/xijGlTLEkHO/hBpSVzfplriovfAVCo/
         hAH2HHdndCRtdmrUj6Ed78/CiQrIEB9ypBLsFjQiGoUkirupTdxJWHOrJP0OD6J6om/6
         OdXfb+v/koRh1ydYMzugHE0YUURKlf6Fftrvj45QEe98s2dYTG7hwwJQy8sVSmxRVLnS
         EwEw==
X-Gm-Message-State: APjAAAWPdCglStku7mQ/E9qaaQ+/nt6tBdp4gUPv/HQZEjaLvx3DEpT5
        jH5PV6E3IKn0F1VHUUY7Ojgsjg==
X-Google-Smtp-Source: APXvYqxubMYZ0x2MK2JVRP27XGEwNh9IrCExtJWpcMVw214R9IuLahJGJq61Kt5Sul4BS7kIV1KXqw==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr10991863ljk.147.1571156210561;
        Tue, 15 Oct 2019 09:16:50 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v6sm5117278ljh.66.2019.10.15.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:16:50 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:16:42 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Jilayne Lovejoy <opensource@jilayne.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:NFC SUBSYSTEM" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v9 4/7] nfc: pn533: Split pn533 init & nfc_register
Message-ID: <20191015091642.6f49dd8f@cakuba.netronome.com>
In-Reply-To: <20191015095124.GA17778@lem-wkst-02.lemonage>
References: <20191008140544.17112-1-poeschel@lemonage.de>
        <20191008140544.17112-5-poeschel@lemonage.de>
        <20191009174023.528c278b@cakuba.netronome.com>
        <20191015095124.GA17778@lem-wkst-02.lemonage>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 11:51:24 +0200, Lars Poeschel wrote:
> > > -	priv->nfc_dev = nfc_allocate_device(&pn533_nfc_ops, protocols,
> > > -					   priv->ops->tx_header_len +
> > > -					   PN533_CMD_DATAEXCH_HEAD_LEN,
> > > -					   priv->ops->tx_tail_len);
> > > -	if (!priv->nfc_dev) {
> > > -		rc = -ENOMEM;
> > > -		goto destroy_wq;
> > > -	}
> > > -
> > > -	nfc_set_parent_dev(priv->nfc_dev, parent);
> > > -	nfc_set_drvdata(priv->nfc_dev, priv);
> > > -
> > > -	rc = nfc_register_device(priv->nfc_dev);
> > > -	if (rc)
> > > -		goto free_nfc_dev;  
> > 
> > Aren't you moving too much out of here? Looking at commit 32ecc75ded72
> > ("NFC: pn533: change order operations in dev registation") it seems like
> > IRQ handler may want to access the data structures, do this change not
> > reintroduce the problem?  
> 
> Yes, you are right, there could be a problem if an irq gets served
> before the driver is registered to the nfc subsystem.
> Well, but the purpose of this patch is exactly that: Prevent use of nfc
> subsystem before the chip is fully initialized.
> To address this, I would not change the part above, but move the
> request_threaded_irq to the very bottom in pn533_i2c_probe, after the
> call to pn53x_register_nfc. So it is not possible to use nfc before the
> chip is initialized and irqs don't get served before the driver is
> registered to nfc subsystem.
> Thank you for this!
> I will include this in v10 of the patchset.

You can run nfc_allocate_device() etc. early, then allocate the IRQ,
and then run nfc_register_device(), would that work? Is that what you
have in mind?
