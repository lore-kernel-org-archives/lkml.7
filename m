Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37849C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFEC20880
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="nfcjjxvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfDBACT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:02:19 -0400
Received: from onstation.org ([52.200.56.107]:38954 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfDBACT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:02:19 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 9F5C245704;
        Tue,  2 Apr 2019 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554163338;
        bh=y7iEqauR67kgzRG4IAm7A+BU3inkDxDrQ98y2k+VrEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfcjjxvIENf00bM69EFcOsx4MjSmc2tQcaFV0V5pTZExczAthcevk9spKbmIaeN3m
         OJLuxVWu3oOSB73WcFdUq3u4FghKQSLxedyZS//JI4l/4hBe92oDzaQ38sN6aNpGUv
         39miKjFKVlexhgcwejMblZ0wwVJ905jGC6jAgCSw=
Date:   Mon, 1 Apr 2019 20:02:17 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-ID: <20190402000217.GA8315@basecamp>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
 <20190401214847.GE14681@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401214847.GE14681@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:48:47PM +0200, Pavel Machek wrote:
> So ... we can have multiple LEDs, each can have up to two
> sources.. and the settings are really per source, not per LED.
> 
> But you do not test for overlaps. What prevents me from having
> 
>    foo {
>        led_sources = <0>;
>        ti,linear-mapping-mode;
>    }
>    bar {
>        led_sources = <0>;
>    }
> 
> (I.e. conflicting settings for a source?)

In this case, it will go with the settings for 'bar'. I didn't check for
the conflicting settings since I was going for consistency with the
other two backlight drivers that already have the led-sources property:
arcxcnn_bl.c and sky81452-backlight.c. I can add the additional check
to fail if a source has already been encountered.

> Plus I do not see parsing of led labels etc...

OK... I can fix that up plus your other two comments.

Thanks,

Brian
