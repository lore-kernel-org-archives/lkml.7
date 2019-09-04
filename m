Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA9C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8526E2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDMIAcZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIDI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:57:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:57:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so20323568wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A6tCn/bL9VqC8vfSP/XnAcqw4FN3+q77kJ2LFpOO3BI=;
        b=tDMIAcZLguralxlzTEyQXyz646kZS1T8wxb1c3TUtS0zhjFyN0bfZ0qmHh+anvKoS+
         enPYK112jjWRrLYQKMrK9FAV6Ol+a8t9mE27jgZSc6NH+8CDzzuVpzvbkxb1KazT7H6E
         IaEbW9VmHOLOXcli6Rp7Y7LPeTKC34geAOvmlUqCWd9271nPAcMr7PzTZXBYJOvPl3ce
         eGLEmEtTX1qgSHVHthfpLj2v2iI8pUBT5dfietW1C81dMAChU/xSklqH/Rf8WLcAdqup
         Vms5onTijGYyKHkeZOoESG3oZgynqZMQV5lndEaJ9q7DPo9NDx5Bn0YXNcf9A6HS7JWR
         LkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A6tCn/bL9VqC8vfSP/XnAcqw4FN3+q77kJ2LFpOO3BI=;
        b=pKHfkk9f+rK7x5xbz2x2LfO2buBnEOY98OdkRXZ27gHrJqGkvw1auYd6J5wXXM2xxD
         fYvkyHm2AY3dInLtl8lihDK3NkmH4eYWYoBr7dkRC8yELVSZ95NLMbXGu48ra77E8TcV
         VaixHcmcaCs6QVHK/92nWzWweU0z6g9AYti5kFOTR9K80GXvQVPMaaV4l19SLRjAXZko
         Ho5MLFdrRs1G9pzP7Qp4R111TT5ZFNhF9ndavtpuQnSdDHxBX8glBORdWFdTIFB4RJaY
         z4+PehGC1T3AoNXnVap83iAS/HsmVlizzKH7zEGgNK1lVsl3gwwiMzkV07gIc2yJPUA1
         acyA==
X-Gm-Message-State: APjAAAW5a02t43iZbDv/vf+CeEi8z5xgXMoPaAe1p13c4inleFgs2QUM
        l0/JAK/jAX+SdftWJwwsyaA59g==
X-Google-Smtp-Source: APXvYqyAhrKvTsVxQ5mpExTe+xZfDqfG2f9kJKPUIqucia30GF+S+u8ulK8WdZil6mhTDfemari2lQ==
X-Received: by 2002:adf:f404:: with SMTP id g4mr46021135wro.290.1567587458844;
        Wed, 04 Sep 2019 01:57:38 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id u68sm3507042wmu.12.2019.09.04.01.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 01:57:38 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:57:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: usb dma_mask fixups
Message-ID: <20190904085736.GH26880@dell>
References: <20190903084615.19161-1-hch@lst.de>
 <20190903131648.GA19335@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903131648.GA19335@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Sep 2019, Greg Kroah-Hartman wrote:

> On Tue, Sep 03, 2019 at 10:46:09AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > the first patch fixes the ohci-sm501 regression that Guenther reported
> > due to the platform device dma_mask changes.  The second one ports that
> > fix to another driver that works the same way.  The rest cleans up
> > various loose ends left over from the dma related usb changes in the
> > last two merge windows.
> 
> Thanks for these, all now queued up.

Did you queue the MFD patch too?

If so (and you can rebase ;) ), please feel free to add my:

Acked-by: Lee Jones <lee.jones@linaro.org>

If not, no sweat.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
