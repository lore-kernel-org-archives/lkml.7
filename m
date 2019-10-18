Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A897720854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3ODp2LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409305AbfJRQyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:54:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33972 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409276AbfJRQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:54:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so1866299wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LS0jfvIIecs+OvBAsmjsVuR4UJ3S5OKog133XvRo+zI=;
        b=G3ODp2LYYhc7I9PzVDJ1ElXhV/36MfDO5Zo+vFWbkekAoLjlWkEoBffhS1py5i3bS2
         jAQtktHkDGE1f1XfFkeEXYYvsQoB4ESDm8sIs/CERJdxv+3OwYAAJRgmKnsPeIEJ1ygB
         SFY96EOTdAs5J/F8BWWGtlAGW0TJ+2eIxcgUI6Epe4ECaeqI2fsxfRqI7gJ5jEKoUY8k
         zWVzSBLaKivNJjdM7Wx9nfJjmP7vy9ZGYobrHtRh1UUOUZHzstZpT3xkkeRVA5zciy+I
         7Y22kqvci3fiWIDEspwZezDEVqouts6IsWsQoRRP0SGO6kK4Y4r4QEs64g65gedgA4th
         B5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LS0jfvIIecs+OvBAsmjsVuR4UJ3S5OKog133XvRo+zI=;
        b=eQxHNsvQifCYct4YyE2Cqu8RnqacqdPm2aI3uR2gjBsZoXL0M9dTCztIo4vimHqp0x
         cmGb4/wks/y0EI8xD2ob5cmv5kgoV8D25wSzSKBCFdgB0qdZbjBIhubITrRBMVyhKLI8
         H1IFU9tkn8cJwjWsxop1xSsKWxaJl6HukfGx1+NUnJ1nvdnvagV0vpsdam4Dq1Cf/ALl
         ji/zLAJb0HeKH/eEPEGCUXlaUfA4+mygcSbP1996qrAwuTWebMla5gYQMEU251RTxRWT
         FgtUH4pSi6t2skFTwpiSRX12IawPpzJlbhMYqb+HiWP+mYa2UGjAhbh3l4aQp7/wRXek
         UagQ==
X-Gm-Message-State: APjAAAWZXFhfBe9x3cUKiTC6NqqfPNSWOoenM4uWARSfYomZnhH/yJBe
        GgEF8dFrIWwoK1tZCrvZyG/46Q==
X-Google-Smtp-Source: APXvYqzO9oMRXBG5Ptw9stadi08HLw+TY4CT3ikXjwfWs4hMqXSJMurl7l53TfvcJx1KTtMRY2ITzQ==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr8293096wrh.138.1571417672706;
        Fri, 18 Oct 2019 09:54:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c4sm6007302wru.31.2019.10.18.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:54:31 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:54:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net
Subject: Re: [PATCH 2/4] mfd: cs5535-mfd: Remove mfd_cell->id hack
Message-ID: <20191018165430.abyhbdodrjurx6g7@holly.lan>
References: <20191018125608.5362-1-lee.jones@linaro.org>
 <20191018125608.5362-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018125608.5362-3-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:56:06PM +0100, Lee Jones wrote:
> The current implementation abuses the platform 'id' mfd_cell member
> to index into the correct resources entry.  If we place all cells
> into their numbered slots, we can cycle through all the cell entries
> and only process the populated ones which avoids this behaviour.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cs5535-mfd.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index 2c47afc22d24..b01e5bb4ed03 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -115,16 +110,16 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		return err;
>  
>  	/* fill in IO range for each cell; subdrivers handle the region */
> -	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
> -		int bar = cs5535_mfd_cells[i].id;
> -		struct resource *r = &cs5535_mfd_resources[bar];
> +	for (i = 0; i < NR_BARS; i++) {
> +		struct mfd_cell *cell = &cs5535_mfd_cells[i];
> +		struct resource *r = &cs5535_mfd_resources[i];
>  
> -		r->flags = IORESOURCE_IO;
> -		r->start = pci_resource_start(pdev, bar);
> -		r->end = pci_resource_end(pdev, bar);
> +		if (!cell)
> +			continue;

cell will never be null. Should this be cell->num_resources instead?


Daniel.
