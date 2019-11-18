Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B714222A0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574108180;
	bh=1bGCPu7qvK5NWZIqCQx0gPIIjWajS9pBjSW2j6P92HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MoWU2KYM2g1am+KWnbH5TZd2ZWVPrznUug1OdmzEsIZwVhtz+5m4/x8bKcGonGozY
	 6x60eI8N2RfpJinJ467lMqZtFYcQ8Aw2XhLg3lGy7Kp2KZD26GUPG2HENqqux/wr+m
	 AmoVmiq2mN3vGtHks20U7JYBitCN1WrF8nAIpNsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRUQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:16:19 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38119 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:16:19 -0500
Received: by mail-qv1-f65.google.com with SMTP id q19so7115455qvs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yq7QGynt8Nvw2z6nbZxw2FGwv0kFU2JGRirg9eYfqhM=;
        b=sgx+OC4Cmv2Kv8P2WZy35hjvdZrjVGrc+K0J1w0yohKJe1OJtFNA57GPkOwXuoXQqR
         ZmFTjhC8z5OQLmFa4eSfD9KFajbqQTxn94QpkzuvtWv+e25mcsUq50XNVMpUO8zQqEYO
         zl3NdvPytKwB2p7hX8i+25J4iszK2sihgN0UX+BakHvPIcwVVw/pgxB+i/MWrDEg6R7C
         bwBIyW/cBWZVGG8qQvPhUldbkudJAlCimK0SjvK96F2BtSG8hjS0MMCGQnaz+KxgVr01
         cSOVO70pyJokisDOkQ88q7xlW55uBvLVqh2eCwwKch+3/Wx/KP2g3DuG7TCOhwbo7kDd
         238w==
X-Gm-Message-State: APjAAAXq6J4TM5SThLbF2Ih0T/mjNMYkYGTUI1Vht5tKhWxqNyJ1Hzz8
        1TCZPt1IWV/RorwcI9RoXsU=
X-Google-Smtp-Source: APXvYqyTshkDGVjDZZB0qRVoQR1tw9ajKDdIey3wO5i7tbkrnhBirpNqTAriJ8bqv8wfgEf6B+2A4Q==
X-Received: by 2002:ad4:4c4d:: with SMTP id cs13mr28450777qvb.165.1574108178055;
        Mon, 18 Nov 2019 12:16:18 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n21sm11460409qtn.33.2019.11.18.12.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:16:15 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BC014401EA; Mon, 18 Nov 2019 20:16:11 +0000 (UTC)
Date:   Mon, 18 Nov 2019 20:16:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] firmware_loader: Fix labels with comma for builtin
 firmware
Message-ID: <20191118201611.GG11244@42.do-not-panic.com>
References: <20191115225911.3260-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115225911.3260-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:59:11PM +0100, Linus Walleij wrote:
> Some firmware images contain a comma, such as:
> EXTRA_FIRMWARE "brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt"
> as Broadcom firmware simply tags the device tree compatible
> string at the end of the firmware parameter file. And the
> compatible string contains a comma.
> 
> This doesn't play well with gas:
> 
> drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S: Assembler messages:
> drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:4: Error: bad instruction `_fw_brcm_brcmfmac4334_sdio_samsung,gt_s7710_txt_bin:'
> drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:9: Error: bad instruction `_fw_brcm_brcmfmac4334_sdio_samsung,gt_s7710_txt_name:'
> drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:15: Error: can't resolve `.rodata' {.rodata section} - `_fw_brcm_brcmfmac4334_sdio_samsung' {*UND* section}
> make[6]: *** [../scripts/Makefile.build:357: drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.o] Error 1
> 
> We need to get rid of the comma from the labels used by the
> assembly stub generator.
> 
> Replacing a comma using GNU Make subst requires a helper
> variable.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Loading should still work after this patch given that the original
firmware name is kept in a different variable FWNAME, and used as a
variable for the object entry.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
