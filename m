Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0413DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60A20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWVpe5z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDBGWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:22:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37961 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:22:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so6010939pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5orAWKFfsaS6pht84D63trK5FZ+vOC66globn0/gaJc=;
        b=oWVpe5z1b1ktYsdQAHT+cNsI9fuLhic9r/Z4qZa7KR2SLmvStsPkBdQaPXS1OlVqpV
         GubtxAiNrDqXkUyvb7IlABVjARi0RYvF2Dnywik62G8HSCk3s4AcHKEKUW/ogiQbMKKp
         V1bTbdN+VqRFGweYpA8alPu0t/talUx9jKHsddVLg+HVvocT8nErT9g39RM3UqB+FCNd
         DQkyj3pLQwS2UcNgCdrdOYHG416PAdZHEkJOn5Kr0pRFqJB/qrrgYeo+ez0YA1AvCrh6
         Ufb3hNmqNVPYP4AXkM/T0mbs2gLuLFHFrU50aF8ImVdVY9qTEOUj4RGgnpeD5cnDazAk
         GyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5orAWKFfsaS6pht84D63trK5FZ+vOC66globn0/gaJc=;
        b=pjTvWFMklabdcLxfgqUViyLlTLOaFzkdkzKQOmJiLEKmu0rRYCJLPDF/EGfAWwCBCj
         4PHmhAy/QPe+72OUqb0oPPxLTUMFCW3uAf2+29095JqS1fEFVQu5hRgYIy/DlOHuRrYU
         neyZHO8XY20hyDw3oxsspLpDa3JLoph+78PbUTfPF50hpEqCfFjuhfWi5nQdIb+kDwEB
         t+8i8/AMqiBpBDt91n7KqOuAKTec86dT5ODp5JVicZgEd0YYUuGztuIhQsAstmvUXLUT
         LtGQTkTNBQ8RLWVz5McjQ76ADsfw2W5sJWxyzlSIU2sFpPLVjy03qCGJ3HVeH7OMO0/U
         w7jg==
X-Gm-Message-State: APjAAAUpcZOwnWVbJBtmlrWOMGdqfKDPojEwx0pBk4BwL3DOcHj5Zzh/
        Ho8ExcUJtk18C+8KVkRgfIQ7Mw==
X-Google-Smtp-Source: APXvYqyt7pO+wSy1Wptr7MF41ta+X9qdtx2kwKbGJtmTVqbdOVOk3JCp7vX0WoEcwuebjd2nwVPIkQ==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr753843pfb.16.1554186135316;
        Mon, 01 Apr 2019 23:22:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id k14sm7926027pfb.125.2019.04.01.23.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:22:14 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:22:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
Subject: Re: [PATCH 2/4] Add support for SUNIX Multi-I/O board
Message-ID: <20190402062209.GV4187@dell>
References: <20190319120756.3740-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319120756.3740-1-saumah@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019, Morris Ku wrote:

> Driver for SUNIX Multi-I/O card.
> Based on driver/char/serial.c by Linus Torvalds, Theodore Ts'o.
> 
> SUNIX serial card designed with SUNIX UART controller and
> compatible with 16C950 UART specification.

Serial drivers should live in drivers/tty/serial.

Please move it there.

> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  mfd/sunix/snx_main.c   | 1671 +++++++++++++++++++
>  mfd/sunix/snx_serial.c | 3513 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 5184 insertions(+)
>  create mode 100644 mfd/sunix/snx_main.c
>  create mode 100644 mfd/sunix/snx_serial.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
