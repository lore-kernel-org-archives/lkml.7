Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A268C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6DC218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555245066;
	bh=QhjNdVTVKIuE04j11ik81DOBHLNyIDQGvDny/d3lUec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QGqmsq0/v6Zv82/OgE3xMQRtOXGnACgmOvRK3jefY5ddLkNKitEPX1kUtGel7kw29
	 nKuyGVDz//XcawYy12wNnwzAfjhoG9gNd4ofOEezqAElaBNCuotMT+ym3aTqMm0usu
	 o6MsAn9dwAu73G0sDfhWZvXP/wYKtAYpvbnqSd2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfDNMbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfDNMbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:31:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE2720896;
        Sun, 14 Apr 2019 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555245065;
        bh=QhjNdVTVKIuE04j11ik81DOBHLNyIDQGvDny/d3lUec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kaUwjq0eqMZNYSmId17f8zpeYIvzXZTOHjPjIzukHbmKmcUAbEK4DPv7t6tIZWGvZ
         2cNsdYbWylIVLk0JFd7goSRydbOPyzZSH7/WkhrBn0pb+xyUByXaT/VJP63timq6+h
         LMPVcMfp0THT17z/xxG/qkPegfLBDSpzwRrf1fxs=
Date:   Sun, 14 Apr 2019 13:30:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: linux-next: Tree for Apr 8 (iio/adc/)
Message-ID: <20190414133059.4e25a574@archlinux>
In-Reply-To: <47db3c7b-eb05-c4cd-ed03-f03e6754d5f8@infradead.org>
References: <20190408154140.515139e3@canb.auug.org.au>
        <47db3c7b-eb05-c4cd-ed03-f03e6754d5f8@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 09:09:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/7/19 10:41 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190405:
> >   
> 
> on i386 or x86_64:
> 
> modular:
> ERROR: "is_stm32_timer_trigger" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!
> 
> or builtin:
> ld: drivers/iio/adc/stm32-dfsdm-adc.o: in function `stm32_dfsdm_postenable':
> stm32-dfsdm-adc.c:(.text+0x878): undefined reference to `is_stm32_timer_trigger'
> 
> 
> Full i386 randconfig file is attached.
> 
Thanks Randy.

So two possible fixes for this one.  We can do what is done for the
stm32-adc driver and select IIO_STM_TIMER_TRIGGER or we can add a stub
for this function in the header to make it return false if that
driver isn't built.

I personally favour the stub option but would like Fabrice to say what
makes more sense.

So Fabrice, which of the above? If you are busy and don't get back
in the next day or two, I'll add the stub.

Thanks,

Jonathan

