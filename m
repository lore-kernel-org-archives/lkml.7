Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC0DC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18B9207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9FqMRgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfFJH1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:27:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbfFJH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:27:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so7067483wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R8PgIT96t8lGMUY7U97jmYq3MA+1zYAtYoGMOzqWwjw=;
        b=V9FqMRghqvvhU4bVdsZmBVGvuywtbmkdlqojjApToLVMurUm0Ac5xclQFauZXhGmQ+
         cxqPV/fxF/+w4N9u6EdWkjlf2CgFP5AoAj1i4+QPavOeAeQ6LWMM8zPfpxR7//jls1dx
         9BEIU4xYhvD66eYnGgbuiyrbR9z1nQahZerefC/hgCw38oXKuFYclAQ5M/0enD+kc84P
         C1kgIAllakzqbodhme6lfIPYOF9fLxS5jeiA7XRxrXNDQ7MFaMBc2u5uRH8r9UJcmMth
         tx6U/t4Q68yV+Zzc4Oj1q/wAYipgQqitKhqh6X8qBmVLGQp8yOmO6P9zCcln5TZ5YbVq
         9Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R8PgIT96t8lGMUY7U97jmYq3MA+1zYAtYoGMOzqWwjw=;
        b=YMfLd1d3jTkKNo/wYQSKqvlAVmhyAyyL/C8Vaj213K9knYTR6zylNR7xQX/coLEFWQ
         yL0A4byf+C9dy52itrbNBEksTU/k/04SYbqYQ6b/lOWcdYAkvVXdu7VOQhzj6aig/eAy
         gcJ3wEVOqc9+DyqLq13BWJIq3sW+lDVAY/lEwxPJ0Nai+79H5lh1nVLtDsWfE5TMd2Bf
         8stjAzOTqr8r1dR3RWKSFo12iBpBwX/xGOhYzsviZWT29/7AzWHOx8qpD0Ei+0tJa+/t
         rczCIAAaa84E1U304rAfv6v5DDSbAR/OCCWNl67VkA5R6faEYsuHrlrJHjXly3fzISDy
         isRA==
X-Gm-Message-State: APjAAAWSS4AcFs7Mydppp1ShBRGaNo1AEBc2rFfG3NrJiMz5/nTccEGY
        2I+iZo0ldymjmnY0VkJkaEKXGg==
X-Google-Smtp-Source: APXvYqyFRGUIZWa2M57OBy/15G5VEX914bVApwUgZ5leXz9nQsLPIZCRoroqFCE1iICmNdKegKxTZg==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr12147273wmh.102.1560151637738;
        Mon, 10 Jun 2019 00:27:17 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id e9sm236071wrr.56.2019.06.10.00.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 00:27:16 -0700 (PDT)
Date:   Mon, 10 Jun 2019 08:27:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
Message-ID: <20190610072714.GG4797@dell>
References: <20190604152019.16100-4-enric.balletbo@collabora.com>
 <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
 <20190604183527.GA20098@kroah.com>
 <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
 <20190604185953.GA2061@kroah.com>
 <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
 <20190606145121.GA13048@kroah.com>
 <1cfc4bfab8d9d8a47e5dacaca88a7fe30ae83076.camel@collabora.com>
 <c577a7f8-b4d6-0574-bc0e-993637ced41f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c577a7f8-b4d6-0574-bc0e-993637ced41f@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019, Randy Dunlap wrote:
> > On Thu, 2019-06-06 at 16:51 +0200, Greg Kroah-Hartman wrote:
> >> Again, don't be noisy, it's not hard, and is how things have been
> >> trending for many years now.
> 
> Ack that.

Not to say that this particular print is acceptable, but there are
places where a low-level (dbg/info) print on successful probe is
helpful.  Driver initialisation is important!

There's a big difference between drivers 'being noisy', spilling all
sorts of information that may well be useful or interesting to a
driver developer, but has little value to anyone else, and providing a
single print to say that a device has been detected and successfully
initialised/probed.

I recently fell victim to a silent, but fully functional device.
Successful device initialisation should not be silent when debugging
has been set to the highest level IMHO.

And yes, of course turning on debugging for Driver Core works, but is
not practical for all cases and is certainly not the first port of
call when figuring out why initialisation seems to be failing for a
single particular device.

Truly surplus churn should absolutely be removed from the boot log, or
at the very least downgraded, leaving only truly useful information
such as highlighting a newly detected device for example.  If the user
wants an even more silent boot log, they should turn the log level
down a notch.  That is why we have log levels after all.  Simply
removing all useful prints regardless of log-level is not the way to
go IMHO.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
