Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA358C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7512075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gn6Fuv5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDCREd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:04:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37664 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:04:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id o19so1904339lfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKWpnIGGkyZiM2OF3pT2JwvdTxkrzscY9OFKh0zD2tE=;
        b=gn6Fuv5nq/MLDnKO9EGCxli5uuOoc13ZQlu3QRMboTuDAQ3l5ZFkS7B/3JFuJQyit4
         +k66d7Hfdm6foeG2o4WRcVJzAMjOxFizvGhCfIjYLvEBzjTFmjHHbpS/sPUJAFoWEN09
         hx3oZ07K62Zd/BxPeGRlO4sxFAMsCy0m10zkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKWpnIGGkyZiM2OF3pT2JwvdTxkrzscY9OFKh0zD2tE=;
        b=Bo8doJt4vaiT0nm85fCPtFPI1V2aeINp0ns9chvSArE5P7pm12bbAzoe+vMGrWUsFs
         N42eHE1HzLXLJbDWGmwKRQE9b6OW0y9Pokq2J94uQbyBfBEiK7HuUBhV0rUmk8fHIYnb
         cBEv3MGoDH1UGOdiy6/bxWPX87H3gYXWFTxk2XGd06Dsyamk9SHHLbjB5ieAOsEg8Lbw
         B+tKON0jD6b9xNJPpNgvrZ6h/iiSDCAQfmS4p4lIxZ6Pq0LPk41DWDlDXzo4b30MipuX
         qlQfP0RRN8/WRjybJJJknJCDhKJ4Lv7X0xj5Zpms0/HseOIz43V/viPPgd1K05o+26FU
         LaUQ==
X-Gm-Message-State: APjAAAX/lv2U/kQU5BDYAlp53PayMkjw1MU94s1pKOz0NmAH4yiKbuHw
        4r1mi+qfeowVySg4PyKmtJw9HwO4eCs=
X-Google-Smtp-Source: APXvYqx9w4V4uWcZLixw+RDCgh03ISO/2QanKXQ+4O042vxtfmdm4P6JRTXyZ1WNRKDA/YlYJtVkzw==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr452634lfk.25.1554311070344;
        Wed, 03 Apr 2019 10:04:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q26sm3325542lfd.27.2019.04.03.10.04.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:04:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l7so15540670ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:04:29 -0700 (PDT)
X-Received: by 2002:a2e:8719:: with SMTP id m25mr512279lji.50.1554311068598;
 Wed, 03 Apr 2019 10:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190403160526.257088-1-dianders@chromium.org>
In-Reply-To: <20190403160526.257088-1-dianders@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 3 Apr 2019 10:04:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
Message-ID: <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, ryandcase@chromium.org,
        rspangler@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know some of this was hashed out last night, but I wasn't reading my
email then to interject ;)

On Wed, Apr 3, 2019 at 9:05 AM Douglas Anderson <dianders@chromium.org> wrote:
> +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> +                                struct cros_ec_command *ec_msg,
> +                                cros_ec_xfer_fn_t fn)
> +{
> +       struct cros_ec_xfer_work_params params;
> +
> +       INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
> +       params.ec_dev = ec_dev;
> +       params.ec_msg = ec_msg;
> +       params.fn = fn;
> +       init_completion(&params.completion);
> +
> +       /*
> +        * This looks a bit ridiculous.  Why do the work on a
> +        * different thread if we're just going to block waiting for
> +        * the thread to finish?  The key here is that the thread is
> +        * running at high priority but the calling context might not
> +        * be.  We need to be at high priority to avoid getting
> +        * context switched out for too long and the EC giving up on
> +        * the transfer.
> +        */
> +       queue_work(system_highpri_wq, &params.work);

Does anybody know what the definition of "too long" is for the phrase
"Don't queue works which can run for too long" in the documentation?

> +       wait_for_completion(&params.completion);

I think flush_workqueue() was discussed and rejected, but what about
flush_work()? Then you don't have to worry about the rest of the
contents of the workqueue -- just your own work--and I think you could
avoid the 'completion'.

You might also have a tiny race in the current implementation, since
(a) you can't queue the same work item twice and
(b) technically, the complete() call is still while the work item is
running -- you don't really guarantee the work item has finished
before you continue.
So the combination of (a) and (b) means that moving from one xfer to
the next, you might not successfully queue your work at all. You could
probably test this by checking the return value of queue_work() under
a heavy EC workload. Avoiding the completion would also avoid this
race.

Brian

> +
> +       return params.ret;
> +}
