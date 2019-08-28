Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90543C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D20233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566999266;
	bh=Wr54NI83bMpyXaEztjls1DUnCnQYPgiyLdE1sjyNxlQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zUo7y7TsvUuvYvkNoDLV4l0/TH+Uib2yp5O2qgyJtz9SP43oFSwyRWrQ+BUyGsneh
	 XYUdlsjGuIgW387kSvLfLzNQAAyuIltwNR5Y9OyDjbdLtYSg9/WNwJ+0Tu8kTFGSy4
	 ftYbCDcBKntczdr3VHmkheq+WuE5ViERDHrXLh2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfH1NeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfH1NeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:34:24 -0400
Received: from [192.168.1.17] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73412339E;
        Wed, 28 Aug 2019 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566999262;
        bh=Wr54NI83bMpyXaEztjls1DUnCnQYPgiyLdE1sjyNxlQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jbiK7gaBFdskrYs8/YWVQA34MqdEEbs+AZKoLkLe4MJrC5JyYaAxq+6tjT2hImJnn
         lw+e1YqKsYHtW2d9eOfxZPo5nVsJyE2NnOMjDCEOsbykLoYkeJOZUtKZBdBGKHQOcF
         1xib9MERTpIW23ahudscdrtFfJB5QaVLufv861Ig=
Subject: Re: [PATCHv5] drivers/amba: add reset control to amba bus probe
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, daniel.thompson@linaro.org,
        linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de
References: <20190826154252.22952-1-dinguyen@kernel.org>
 <30608.1566933924@turing-police>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46bcf493-9dd6-bf5b-089a-be158739a13f@kernel.org>
Date:   Wed, 28 Aug 2019 08:34:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <30608.1566933924@turing-police>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



On 8/27/19 2:25 PM, Valdis Kl?tnieks wrote:
> On Mon, 26 Aug 2019 10:42:52 -0500, Dinh Nguyen said:
>> The primecell controller on some SoCs, i.e. SoCFPGA, is held in
>> reset by default. Until recently, the DMA controller was brought
>> out of reset by the bootloader(i.e. U-Boot). But a recent change
>> in U-Boot, the peripherals that are not used are held in reset
>> and are left to Linux to bring them out of reset.
>> 
>> Add a mechanism for getting the reset property and de-assert the
>> primecell module from reset if found. This is a not a hard fail
>> if the reset properti is not present in the device tree node, so
>> the driver will continue to probe.
> 
> Does this DTRT for both old and new U-Boots? My naive reading of
> this patch

What is a DTRT?

> says on an old U-Boot, we end up attempting to bring it out of
> reset even though they had already been brought out.
> 

If the peripheral is already out of reset, de-asserting the reset has
no affect.

Dinh

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoHhMeiyk5VmwVMwNGZQEC4GjKPQFAl1mgtYACgkQGZQEC4Gj
KPRKMRAArFO9bQ7FCE4oiVgO/sOLm2M/ngGD3Czi6Y8TcAbIk4EylBGVw634Gs4Z
v5vuyxShlfApBb0PqfhLOo5cXrTyMdpWOq9AQ4vEcEU2MPKN8QcyLczvEagyYcwA
ianhTLR21v1Gdfm5MHqpKrNxSrb6Nt6cWmYCXjpabLYZg0gKJnsYl2XheHIdUJ02
kD2P6sQC3mf3OC5Gou4JXZGvDMgEwLG9lHsb7YoFq6tzZW3YQvAi3HcxIZZh4J8b
jFcPR3RxxQgGwESEGDWQu2EzY/d9qStEQ9VYHl/v6QIL77S1oXUAXLbh3e6ZoSgt
M93eK2G9wGCL5JlUbHXQ402OfewHchgQW1bDpjkaZLL+d9jUiGLqALAj0Az2FqX1
HtPPtifB4z6TuaLkxNTZ1Oz7UR0cWtKeSYjsuIwi0XzQMXopgH7oKdzJajNlAfRJ
In6fSVuwp47p43wj2dmUtuCSYvzKTHAg/sVGaufEfsT8ZINSOZJY9ivDqkJIzlDR
nsOclhfOGs5PgL4NPFW5U5O58DzZ5yl9NEotB4ahacuOqJv1PUdT3gABbL5hUogx
QTAPNREbYesG3osFLeEXeachiNChyJ7r+NyWFly7RXA/ukxoer2Rkxt3h0hQib6Q
/jhAsa1ar1NEk8dJJfNO7R5pZkG7ZCbhzuSDKPB2yRZPDeQGol8=
=SFzc
-----END PGP SIGNATURE-----
