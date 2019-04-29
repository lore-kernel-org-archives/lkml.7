Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155EC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C462147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="C3TvIbUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfD2RI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:08:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38438 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbfD2RI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:08:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so8590459lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BwIJ9jvJjTPtmIuNUi+jzS5O1ffE19llaBGI2OHGpyA=;
        b=C3TvIbUV2AijVn5AwG6jRxwbopqcktl4R+7ospfgsMnnUWs6RMrReD1E7e4xF/ay57
         lIftkCeL4D+LjT249H6ib9HRra9Wg1UYBWeE209CRRRR7/KFkqhw0JAabguc/yUVw8b7
         XzOa/gGBCSYKg9GoEEdSfOEHeobtvQHN2XJq2A263aHcT9gK6pt+n0E7YrE6U+6LchDU
         A1T/BF5Om+L7YXRMIEwOiU475snjLoY2N8GGvd07MbLHMr0x7gSGnUwuXqVlJVrRRUTO
         JzyzGJF4Kf2ct2IKIuPbP3Bh2YYtp0Xjr32hgyWNd4P2VjnHWhN2YByrJltOS1TZkmut
         l0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwIJ9jvJjTPtmIuNUi+jzS5O1ffE19llaBGI2OHGpyA=;
        b=U81sfUcD1xy0eSQzEztx9hgeAux+Frh01nPK2G0S4SUDyTNQPG7mSoP3UTfinKroLE
         beDQAC7GBmPT6uZJ7njjXSMJyTYi5e0wY5LiHEOxJYWz4ZNtYJ88Fsq87S4l9Vmn/cpY
         3clq+nJ7fAxMvKPGiGI+LiYNuXlYbFEahRvVd8izDhZvSepx/vfaGU17kbHEVgrerhWW
         r54SHPuADsz3LY+7p2c13YXQQ3OaVteJ0YOtkZGpjz25wYvEr3pcUWqo9om/awbzOLmA
         3RwGIasT22j4BaGMU6Ktj0+FMS3+6QMvLILno1HuBiG4f4rRzx5wWwjhBjFQOD+RjF0a
         gV5w==
X-Gm-Message-State: APjAAAU0E4/GslvaJcZGVZHb/EQluT+9TtvLb1F+Q55Kmnf7lNSZcdb8
        6oIdZdEmIbIZalow0oKXL64RMw==
X-Google-Smtp-Source: APXvYqy5qf0XrSG7O2GG1ImVUzHdDiyIR/8Jj398WH2fEnvqatsTeaX+zp2kBDUyUvQDzXXXygPHZw==
X-Received: by 2002:a19:ee17:: with SMTP id g23mr33952790lfb.43.1556557704787;
        Mon, 29 Apr 2019 10:08:24 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id c17sm5330056lff.84.2019.04.29.10.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:08:23 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:05:40 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Patrick Venture <venture@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
Message-ID: <20190429170540.27bc3fu6nvab2vc5@localhost>
References: <20190425194853.140617-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425194853.140617-1-venture@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:48:53PM -0700, Patrick Venture wrote:
> Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
> disable the PCI-to-AHB bridge and then allow control of this bridge via
> ioctls, and access via mmap.
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Patrick,

Please send these to Joel and Andrew (and cc the mailing lists). No need to
send patches that there are active maintainers for to arm@kernel.org directly.

(As a matter of fact, drivers/soc/aspeed should go through them too, even if
I applied the first patch directly just now).


-Olof
