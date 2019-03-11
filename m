Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C21C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B9206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3MtkoTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCKSBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:01:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:01:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id 197so4140496lfz.3;
        Mon, 11 Mar 2019 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+SdCLIuhpcmrikRZBEqNLVD299M+XmjQ/x6GgQUzO38=;
        b=L3MtkoTdHBCRN6CfMIpbFERqEEAep41cZ1Kz7rrUDteFJ6PBr2SVnh6ei5K5c71z9Q
         OwS/ZFIt/OpQgMeBZvpjzeyNCDbCM2AsdpbVIPFphY3C++3bWqtTOb630BL5EXrLku3X
         8ixzQaGwvuYEAWW1ZDZP75uaR4Uz5b8obrsUgc9r0Yff3X4nXP7bOFBDSVt/M+oAyeBL
         ul2FWIDs2CVqD84G7U4QyNoOQvaUwSIsDxafnH2PZBRvuw87MzIO3D5/z8QzZO7qC18L
         KbGKYW+GhyAMgQPcM8T9PAaroq02jCywdPE3TrC3cZMpTvP4ZN7j0KicLJVkwYXiy3tE
         A8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SdCLIuhpcmrikRZBEqNLVD299M+XmjQ/x6GgQUzO38=;
        b=rAXaOlftmQnBHgDd83NVC6Bw07djlN+017OyV+cFHWXwWgbQw9JCj2aO9b6sdk9uXw
         UDBdZYllI051g/S2bVhgHmmkiBZrC0KcsSMsuzPHpiblp2MhVqVyySBTLgPQsNVVzRs9
         FfUkjA9Vnki8STJYxWpJUaudu8TFzqUMkGupvKHjFumZk4f+jLFUZTQnEZeOuhbKI+GW
         aO2TNlcs3jASBPHHhV6Rcr+NmZVbkCSAl58XPZ1yJ105lZ0EkYincTuA8M5ba07FxNWG
         aw5NwbwKKM4Q55DivWnqUYzzE21opiFFkiWxAUDqNLbKd8okiA5VtzRhGnF4taleHagJ
         WRZg==
X-Gm-Message-State: APjAAAWoYKRuKKma9xHTQS1kivaIUicGhRS72IhEzivN7/LmBTSF/6ok
        A8CZYCkMVwIJZXBTkAtWWpKVK0IOT+w=
X-Google-Smtp-Source: APXvYqy3tE5DWa5+Jxqr52dnTBqg3A8oESa7xhVy7stmS9VRXhNmL5rJzgdgs8LS6M0BsGR7/n6Qow==
X-Received: by 2002:a19:d602:: with SMTP id n2mr17896764lfg.165.1552327270932;
        Mon, 11 Mar 2019 11:01:10 -0700 (PDT)
Received: from localhost (89-64-59-228.dynamic.chello.pl. [89.64.59.228])
        by smtp.gmail.com with ESMTPSA id m16sm1040421ljb.50.2019.03.11.11.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:01:10 -0700 (PDT)
Date:   Mon, 11 Mar 2019 19:00:44 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: envelope-detector: fix use-after-free on device
 remove
Message-ID: <20190311180042.GA17880@arch>
References: <20190310193246.31761-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190310193246.31761-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 03:32:46PM -0400, Sven Van Asbroeck wrote:
> This driver's remove path never explicitly cancels the
> delayed work. So it is possible for the delayed work to
> run after the core has freed the private structure
> (struct envelope). This is a potential use-after-free.
>
> Fix by adding a devm_add_action callback to the remove
> path, called right after iio_device_unregister(), which
> explicitly cancels the delayed work.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/iio/adc/envelope-detector.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 2f2b563c1162..2f1c78b3ff44 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -321,6 +321,14 @@ static const struct iio_info envelope_detector_info = {
>  	.read_raw = &envelope_detector_read_raw,
>  };
>
> +static void envelope_detector_stop_work(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct envelope *env = iio_priv(indio_dev);
> +
> +	cancel_delayed_work_sync(&env->comp_timeout);
> +}
> +
>  static int envelope_detector_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -395,6 +403,10 @@ static int envelope_detector_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	ret = devm_add_action(dev, envelope_detector_stop_work, indio_dev);
> +	if (ret)
> +		return ret;

Just a random thought. Wouldn't devm_add_action_or_reset() be a better fit?
In case adding action results in failure we will not get the chance to cancel
work.

> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>
> --
> 2.17.1
>
