Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7512C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BE8218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK/qJza7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfCVPBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:01:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36744 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfCVPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:01:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so1952152edi.3;
        Fri, 22 Mar 2019 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MZnwuiYr/O/l2ezZ36HbghQz2Q+UPDohnQHgFEoCGk=;
        b=sK/qJza7VkhRKGXD+TCdKYb2OTFU3uqMBNyh1uCOgJPo0CEBQ9kh3xTR/6/YaIfZDf
         QJGwj6A0uPEvn93vp/39I0HVeYQEo8UVwTl+ToYuP+6yN6iGvY1SY3SExfT+xn4PhXsZ
         AipWKPJljDmJpCC4P9FABenVsFOz+I3/c7CfkS9othgIoWYXKEEOCA/IblTgwKRuS0F+
         1QT3ST/3LMp2idBVAW9m5P9W6LBMzcfIpYaLdyTytmJNUFRY/WjwQLC+ye+D6QhEOxPq
         9NCfkHuCyiQgNZJ4Qk/rJTf1u8TqqNXdOarrbL07Rg9ygazK8Th3fGjVTe0yPMF9UiE+
         0eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MZnwuiYr/O/l2ezZ36HbghQz2Q+UPDohnQHgFEoCGk=;
        b=fd+NH+370iVgld0akV9kcgdfkvKMncxmC1jjK7/LLizFmLb+bk7Y1O1Vp4TAIKVZeF
         5KBHpMluFP3X3QIy9AfLuGrR4EXtbFFWkcCchXrl3mk0nU5bQTATkAjU5tbbJ2DnuFDY
         jTwQDkL8xfP3Jsm05hNBYlTTjr5v1ubIwsqTgAAZXiTrkImHBiNfdwLh7RSAH654tjnv
         nf9ZbYjdC1TZ7dgmC2P1qhUH0OYJ2VCfy/yefn8o+3OsMrUpPpFkzE7Ti/zvEyGaix0f
         XkhWchWqVMFVeqTxclFTxeY9QMWrmDCp5zaQ/S/ltVBcpMYkfUO8rw6zPK/IDej0oYc9
         fsHQ==
X-Gm-Message-State: APjAAAVXNuJPZC7dmQVCb2eoMTyx5b7lEjKCtBJaGBRC5E6SXKUFwmrh
        L3uPaejA4Kq55LsXRVSaN8g=
X-Google-Smtp-Source: APXvYqzHdosSErdF6rB0Vgth1GLsiA8Yov5OWoaZaXmNhHOqXW2qAEA4DVqkcRtJxJo/5B6TYVAOhQ==
X-Received: by 2002:a17:906:bce9:: with SMTP id op9mr5894384ejb.65.1553266882406;
        Fri, 22 Mar 2019 08:01:22 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id d91sm2521282edc.75.2019.03.22.08.01.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:01:21 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:01:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: avoid uninitialized variable usage
Message-ID: <20190322150119.GC6521@archlinux-ryzen>
References: <20190322140937.341976-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322140937.341976-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:09:22PM +0100, Arnd Bergmann wrote:
> clang points out that 'calculated_time' is only sometimes
> initialized here, which leads to incorrect data being
> passed into another function:
> 
> drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: error: variable 'calculated_time' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (indio_dev->scan_timestamp) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/common/ssp_sensors/ssp_iio.c:102:9: note: uninitialized use occurs here
>                                                   calculated_time);
>                                                   ^~~~~~~~~~~~~~~
> drivers/iio/common/ssp_sensors/ssp_iio.c:95:2: note: remove the 'if' if its condition is always true
>         if (indio_dev->scan_timestamp) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/common/ssp_sensors/ssp_iio.c:84:25: note: initialize the variable 'calculated_time' to silence this warning
>         int64_t calculated_time;
>                                ^
> The data is subsequently ignored by iio_push_to_buffers_with_timestamp(),
> but the warning still feels legitimate and to work around it, we can
> initialize the time in the other case.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index 645f2e3975db..81e8f4844c90 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -96,6 +96,8 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>  		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
>  		calculated_time =
>  			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> +	} else {
> +		calculated_time = 0;
>  	}
>  
>  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> -- 
> 2.20.0
> 

I sent a similar change, which is sitting in Jonathan's testing branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=0643039b4fee4aa54a233ead15dc0b2286f059d7

You made a good point previously that initializing the variable at the
beginning of a function may not always be the best choice. I don't have
a personal preference for which patch stays around so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Just in case.

Nathan
