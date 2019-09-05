Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13684C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3F0206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567667875;
	bh=3E6du29PgUZEnItqNmi6Hp1DNg1m+jhlyBt80drRha0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nDvXoyKir24nsesSaqw6PHbMGObrzaoPt7Ooc3/mkOcY3DxF5JHyFaNo6iOdIBwum
	 Obv3Cizim97In/6bnyLaqRwv4+1yjTah9SVsvilNG12llopEDfKn5nipI4tFMp6m/n
	 OHWDArNDCcttsDuwR1ka3BlNFWu02ANk26uoviLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfIEHRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:17:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42193 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730737AbfIEHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:17:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id u13so1062715lfm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RTxQxEPMu/S6pvKFwk3GURZ2Pv3mdgBCFDIodIwFr0k=;
        b=ZY3EIwXVPb/Q1Iq3Vs5YDTuOECN3XhaQl1boSKLTL7tAsZJbBHLc68WwNZwgynHyaj
         fYPHaqTdZRGUabvhiYulOpv33unr4LVEJ8/RJk0LrauN4Gdk32bKXRmcm0T9qeJqv07X
         WBV/r8rAMgm9MFqaRlhu9xsdcNyqII6v0O3SaDz8NeWcND2zyLPSLDIUYrR7+70aeO7j
         BY0tJbaMAOnXnK++zbQwgmPJi2CxB3e2okEOcrjdJ/sc73/GiglSpeVk1K4r2wTuAhY+
         7z/LiM2RbCBR62tunCNnWGezlFa4KPIpJ/AGj175gpXzWn81b3aWd7LCtx67AF8tINoN
         heBg==
X-Gm-Message-State: APjAAAXsgCayMhVjeOnQgwRhzSNcTdioJeNErg+IIddfauJb9IVmQh4k
        R1xjuhX37Ckht3wmkrPAZ8I=
X-Google-Smtp-Source: APXvYqwYrRtF5ta/sNfxWtl9EmJfjp7gB1SroU3Sbkzpe/nf6vYGuQdoCKOrdZisMXsHRIeGrVG0MQ==
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr1235343lfq.83.1567667871895;
        Thu, 05 Sep 2019 00:17:51 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id i17sm96012ljd.2.2019.09.05.00.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 00:17:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i5m1Y-0007hH-Vh; Thu, 05 Sep 2019 09:17:45 +0200
Date:   Thu, 5 Sep 2019 09:17:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     joahannes <joahannes@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        jevsilv@gmail.com
Subject: Re: [PATCH] staging: greybus: remove blank line after an open brace
 '{'.
Message-ID: <20190905071744.GC1701@localhost>
References: <20190904205558.27666-1-joahannes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904205558.27666-1-joahannes@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:55:58PM +0000, joahannes wrote:
> Fix checkpatch error
> "CHECK: Blank lines aren't necessary after an open brace '{'"
> in loopback_test.c:742.

Please fix up all of the blank lines before/after closing/opening brace
checkpatch CHECKs in one go. There appears to be many of them.

> Signed-off-by: joahannes <joahannes@gmail.com>

We need your full name here and in the From line.

> ---
>  drivers/staging/greybus/tools/loopback_test.c | 1 -

Also, please include the component your modifying in the subject line
even if you need to shorten the description somehow, for example, 

	staging: greybus: loopback_test: remove unnecessary blank lines

>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index ba6f905f2..251b05710 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -739,7 +739,6 @@ static int wait_for_complete(struct loopback_test *t)
>  		ts = &t->poll_timeout;
>  
>  	while (1) {
> -
>  		ret = ppoll(t->fds, t->poll_count, ts, &mask_old);
>  		if (ret <= 0) {
>  			stop_tests(t);

Johan
