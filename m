Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED1C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6D7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YltDoMEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfG3Vgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:36:51 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46323 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfG3Vgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:36:51 -0400
Received: by mail-pf1-f169.google.com with SMTP id c3so7370651pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=g3jWoG8E30U5+qojKIqjVcWgpi2dLBWaaC0OGApLMpg=;
        b=YltDoMEA7TGTpJBP0zYPNAgUNxhq7jzSZsAK52mTIVCKGFjVeLPDZJw11DYI0a6rFl
         yd/wlrjFeCsJj5+6/qTK44Zv0vr8UMwOMKMWQMNB48XHaTcKcSvZ89r72BCDRQMp+pEt
         Bo0sW1+07QIk1S1JU5VlzAR+EAT3skyV/BnB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=g3jWoG8E30U5+qojKIqjVcWgpi2dLBWaaC0OGApLMpg=;
        b=tMfjim8+AodJupBYS9xnSpopwu1enAQKUQrX9J7cplsBSMxL72CSGPkhuBzOLE/FA9
         4dXdykL/G98BBJ0+cNfkvad9x7RBCj1yXKXGb6Yb4/YGq38y5WNC3okhm6NcJ9kW/QAs
         sMkTQnhZScWZFIRqMvX2NUbflzApML6gDngD7IT86nFyCNCIL1XvX2tBwSNrKsHYwHkC
         8VA1oqnzhlQx+p8h4L5YYaE80UdN3FXgwIEdfpmm9xKXW3n697Zr5Kg+cVz9Ust1PxHb
         kz/7qETIoLkTzVOgJb5eb6Jf5YUxavX6kIZgbWYEG1Tj9MXSFZo8rdcthc0/0l3WNs7b
         j/mQ==
X-Gm-Message-State: APjAAAX+gzlxgKPdA/84I8JWzMttTVJCW4Fo1R1gVAJbsZv8dxj6TmBh
        uyfzVExbuZJc7NP3PVYRsm/nTvLFZx7z+Q==
X-Google-Smtp-Source: APXvYqy524RB0HmU7qCxVspArysfD5Fpt/4gYDQUSEWqmkhvEhPp4yieVr3b+DrvgbPKIl6DiOFXDg==
X-Received: by 2002:a63:e213:: with SMTP id q19mr109255042pgh.180.1564522610162;
        Tue, 30 Jul 2019 14:36:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c23sm60025069pgj.62.2019.07.30.14.36.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:36:49 -0700 (PDT)
Message-ID: <5d40b871.1c69fb81.94f40.c465@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VE1PR04MB668744C680C7AC2498AE9A478FDC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-41-swboyd@chromium.org> <20190730183503.GX7234@tuxbook-pro> <VE1PR04MB668744C680C7AC2498AE9A478FDC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v6 40/57] soc: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 14:36:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leo Li (2019-07-30 14:26:01)
>=20
> The patch looks good to me too.  I can take it through my tree with your =
reviewed-by.
>=20

I split it for you just in case you want different patches.

