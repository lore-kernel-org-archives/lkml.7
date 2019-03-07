Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5153520643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOs8WaPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCGLlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:41:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55067 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:41:25 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so14731070itj.4;
        Thu, 07 Mar 2019 03:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yt4ImMd4UiUr9L+1JpyytFPDRP99tjCCtRs13V82BNc=;
        b=iOs8WaPpeTxhn8OW4awB1rHzd2LfUVEuX991FKpaviDo+1uslE1DK6qMXjIkbC6n5c
         1nU5ugBWIAnyXQGUnzYLkOMTZepz0hfHQQMJ4AoT5RT6vVMt1vfquB7tniwsCdLSBKXO
         FEoyqx7936ZjUHBH5c0mHi/o+BqimlrU8hbpwZfWAuakXbl+Fz9avxdKslm51AfWLYLJ
         M5auj9nLpzZvQdtNsuSPbQobHEhlb37rc4V98RoAHNPNt7ZoM5RDQ+yXJwUPop+BLTGe
         K29IU0e19u7JDYJ9rLc+R+yUioECknV/V/JRXcn7B0f/JFcn7L49J6isLDd6WY+muTYG
         IDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yt4ImMd4UiUr9L+1JpyytFPDRP99tjCCtRs13V82BNc=;
        b=Rtt6bStrXinRCZ5/Co6KY+d7BDCKwZD7UM4hhOXHxyPAmUnBWna3JPoByXflp3/UJ/
         IZFQbBIFmAr8dbzgAGpfmZqqkZVvMv8ZqyeBySSte/tZOTgiH3dPC/QlbRxZeH6CQ1j+
         15G2FOvcKKAQoX0Wg1IlnpAbBQDUs8ev1G4QrABpV9Hw57HZc/uo1cOV+c66efEYiwGN
         D7tolMHd54frldno6AL/+fsMRT/RkyIB3Q+BLxP498RL1mMtE00tMhSoMwTfcy8qfUWg
         1xZadH+Mbnfrt+TbIjWsFVIXejv43fbmsA/p3FsgCjEoKg4julZiBdXB9D6mayEwbKQG
         ktQw==
X-Gm-Message-State: APjAAAWgnVKhEiso8dWQZnMTsm5bURoAfyKgp4xQk8uK2uyvsbx0rQAN
        AMMxFZkZziC4hGLv6me84yM=
X-Google-Smtp-Source: APXvYqw+Yg5zPLnreoTZdp/pQrUgsZapB0fDJBYFqQ5oqvasP/UiCmmfN/lxAKmQXwyfsajuUFui5w==
X-Received: by 2002:a02:308:: with SMTP id y8mr7405988jad.142.1551958884079;
        Thu, 07 Mar 2019 03:41:24 -0800 (PST)
Received: from icarus ([2001:268:c0a4:120d:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id x84sm2241979ita.32.2019.03.07.03.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 03:41:23 -0800 (PST)
Date:   Thu, 7 Mar 2019 20:42:16 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific
 counter sysfs documentation
Message-ID: <20190307114216.GB7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-7-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-7-patrick.havelange@essensium.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:12:07PM +0100, Patrick Havelange wrote:
> This adds documentation for the specific prescaler entry.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes v2
>  - Add doc for prescaler entry
> ---
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> new file mode 100644
> index 000000000000..2da629d6d485
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delimited by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure the prescaler value associated with Count Y.
> +		On the FlexTimer, the counter clock source passes through a
> +		prescaler that is a 7-bit counter. This acts like a clock
> +		divider.
> -- 
> 2.19.1

Hmm, prescalers seem common enough among counter devices to permit these
attributes to be listed in the sysfs-bus-counter documentation file.
However, I'd like to wait until we get another counter driver for a
device with a prescaler before we make that move. From there, we'll have
a better vantage point to determine a fitting standard prescaler
attribute behavior.

So for now, we'll keep these attributes documented here in the
sysfs-bus-counter-ftm-quaddec file, until the time comes to broach the
discussion again.

William Breathitt Gray
