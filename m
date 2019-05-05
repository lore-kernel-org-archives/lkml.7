Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E9C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA382082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="K7VloYej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fASu4D6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEEJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 05:14:03 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36737 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbfEEJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 05:14:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 990A52E2;
        Sun,  5 May 2019 05:13:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 05 May 2019 05:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6p9ecUhs/1LRELvXO98XJrQopqy
        XMX/WujYOzDVV0Ps=; b=K7VloYejapOn30KmRpbaCwUm/S+mMXffG/sSvdicCiS
        lQJKBBWx9fAlxBfd9YXII+Txw2LecF21Nro/VQ5OvDtn5rlhjOwpT93xSHUAXWzX
        f3ZLlzGY1jTdKswpk/ZHKsZMCTvvTlOqY+mzuWBrH0DY1CTHLTINEB6qEO/lywtv
        p8N3HcK08oI6w/d5f3iNEKyxDj/h+naA4m08aRweIT6tA1jrw0Th39C6UsNY8ifD
        c0xnGJ5bsAoSMWVmCskHxzgLYPkmTLdAPpOYXMikyFFU6V3FDlgZXNbbo4KZuI22
        f/kno1ro76wabmScmTO9DvJxqU9o1CWWJjwtWxrxpxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6p9ecU
        hs/1LRELvXO98XJrQopqyXMX/WujYOzDVV0Ps=; b=fASu4D6bAkg0bYJJkCiQRb
        anI49ApkgRuked0/V0k6Ar0n3TP8E/kiC9YZF9arqkjsJX47r8JqfItBLKhqi1iY
        uwgOvmdBrRXewInh73m/hXuw1FWone52xJGaT2+GK12DsbzGRJl6mRSwC74M8wHz
        zWyLU3XbDk+l8bdCH8xyXQ0ECRyS+yHBD1M1neE2lh7lAgFyynE48OuN7F7uNDDy
        l+YTm9DkHh8TCiPHhM6Onn8rAFvNt1FkLbT9ZwcH0XChbuOZ6DGjittKibQddNZ/
        uHH/3YLf2kdfYqVfm1zAcdKwsjpcpUgqdG47G1k0ezYwmJwJldu067t5XdPL4DIw
        ==
X-ME-Sender: <xms:VqnOXPn7wh9w2ADcone883UleKkO_e3250Pd7OujJFepCjKtdv6IlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjeehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepvdejrdhsohenuc
    fkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:V6nOXDG0lLZdXCQzP35lOY0GYgkN9C95KSIgNqkGxc_DeZ_XnHQP6g>
    <xmx:V6nOXOhxj2xzDqHYnWyrcIumg66Jjp4AxdtwqHeq68GkocYgIQbxlw>
    <xmx:V6nOXLfUt333_9rZmPFcfqtoh03bKaAfkG4lBXdMTMLtkH56Yr7uLw>
    <xmx:V6nOXJhdbx1UJP1-q5rkn99lzIKyZ2QtmrOEM8jZuZShiDVHzbsezw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E7F0103C8;
        Sun,  5 May 2019 05:13:58 -0400 (EDT)
Date:   Sun, 5 May 2019 11:13:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
Message-ID: <20190505091356.GB25646@kroah.com>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502194740.15344-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
> Add a sleep between detach and check for exportable devices to avoid
> the following segfault from libc-2.27.so
> 
> [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> index 128f0ab24307..beacf24a8df7 100755
> --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
>  src/usbip detach -p 100;
>  echo "=============================================================="
>  
> +# let detach complete. Avoid segfaults from libc-2.27.so
> +sleep 3;

That feels very "arbitrary", why do we "know" it will take at most 3
seconds?  I guess there's not much else we can do here except maybe
somehow watch sysfs until the device is really gone?

thanks,

greg k-h
