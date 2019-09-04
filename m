Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3654C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACAB22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="enCoL6P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfIDInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:43:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33096 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfIDInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:43:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id d10so7319850lfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=22aBvTjn7JhApRUIycE5rK4HDJAGLo24z88Hc1SRWA4=;
        b=enCoL6P3SBeQS9D5xyYEBAdoddJ9z61maY/T5ThChXtVQrjpuUkF5viAUSVLEqrTOO
         ImWc5C+mcF/HsSThCxP2TK3SROQw3OclyEPfVNNm6K9gCy2hr99P/uyRk4d5qgMX2mRG
         B8+d2fF3E38Wj7G9stSoSDf+B1kzactV+peRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22aBvTjn7JhApRUIycE5rK4HDJAGLo24z88Hc1SRWA4=;
        b=L6G5O831ShWmnpSDuREAp7jCkGfWgN2K+zBtOij+7QlTFbBCqcp4lgTomj6g3mQUay
         X29nAiyAn7wvOBXNopsCk19CWq1wvFp1k1OOLDaaFks8i7XxT62ml7ZNJmhwh3EqWgw0
         bZzGQPspAsOXXCs0oyuWmqTZn7B/t5+sJolOkTPImuIa0ida0Asxmlj2CXG2RXWH5Qg+
         d+DKfCUOVHfthPqIzVWhZ+pYR3vF+rkPvMEAnmhO5fcZAcxlM53rbNah6RBmXZP5K27Z
         r8Q3Sbio7EXflSN15YybtWMJ1yYCwV/W6TganRw9XAIRLcYsWnsfVU2QaTrlOS5BNMVs
         rneA==
X-Gm-Message-State: APjAAAWJi8qeuZfBeSIEnXcILEgJvg64g8F5TMuRLtY7HUbTGGE+pybp
        BjtVuTJHE762TkH10mI2KUcDcywkpbIK43xk
X-Google-Smtp-Source: APXvYqw8OMMGAjW/bDQMQDkYA6XzdbLEjLxRR0ppAW3/TaJg6XOpuLFWIOJqftYhJvqXldXvtkGrIA==
X-Received: by 2002:a19:6455:: with SMTP id b21mr23773070lfj.167.1567586602413;
        Wed, 04 Sep 2019 01:43:22 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z72sm1146467ljb.98.2019.09.04.01.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 01:43:21 -0700 (PDT)
Subject: Re: [PATCH] media: meson: Add NULL check after the call to kmalloc()
To:     Austin Kim <austindh.kim@gmail.com>, mchehab@kernel.org,
        khilman@baylibre.com
Cc:     mjourdan@baylibre.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190904082232.GA171180@LGEARND20B15>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a9ca05ec-55a9-a58c-267a-334771a1480a@rasmusvillemoes.dk>
Date:   Wed, 4 Sep 2019 10:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904082232.GA171180@LGEARND20B15>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 10.22, Austin Kim wrote:
> If the kmalloc() return NULL, the NULL pointer dereference will occur.
> 	new_ts->ts = ts;
> 
> Add exception check after the call to kmalloc() is made.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index f16948b..e7e56d5 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -206,6 +206,10 @@ void amvdec_add_ts_reorder(struct amvdec_session *sess, u64 ts, u32 offset)
>  	unsigned long flags;
>  
>  	new_ts = kmalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts) {
> +		dev_err(sess->core->dev, "Failed to kmalloc()\n");
> +		return;
> +	}
>  	new_ts->ts = ts;
>  	new_ts->offset = offset;

No need to printk() on error, AFAIK the mm subsystem should already make
some noise if an allocation fails.
This is not a proper fix - you need to make the function return an error
(-ENOMEM) to let the caller know allocation failed, and allow that to
propagate the error. There's only one caller, which already seems
capable of returning errors (there's an -EAGAIN), so it shouldn't be
that hard - though of course one needs to undo what has been done so far.

Also, unrelated to the kmalloc() handling: amvdec_add_ts_reorder() could
be moved to esparser.c and made static, or at the very least the
EXPORT_SYMBOL can be removed since vdec_helpers.o is linked in to the
same module as the sole user. That probably goes for all the
EXPORT_SYMBOL(amvdec_*).

Rasmus
