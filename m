Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42581C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128E0206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281045;
	bh=chlWf/RWTAZL3U16E4MCgfIgdHI3rZbqz85ybHAMAP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lU1AYKvl4rjLu6UJz6iwqbIdYPZve0PLwoxA8Z0yZAz6mGsmJE9BkK+KvDCGAKXKM
	 tflH4LxXQsOswIqc08fm0fC2Jxrxqx01QBCslpIZKgp3POpBnOjTiNinqpetwsaC2M
	 xATpstDR9T91GlGjI1wcxZRB/PWN680rOeTz9c3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfDCIoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:44:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34337 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfDCIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:44:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so11082331lfe.1;
        Wed, 03 Apr 2019 01:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EbCew/WSzhbEM/eiMyTtaND34Yc3ob4fWHrPq1t/bBI=;
        b=PLtNoq6iJrPh8Evqrs/Ul321aqxOZ7cuTuY7DALUCiEZteoMoHzrfubmnw0rQREF7o
         nb+yc7obM8UUnFk0+fs81lVTFluia0xPwOjeCEJYtdoue97OrbRCP2j+fpIruisqYQs1
         OboeJiIHG5ZUSgFXBKIZEFtqNAg9dJ3GzMNo+eFpVit8sGhAX8G3QJ4GWcaKIlBb7BNz
         Aq6G1JNJ7ET1ACPFeGxhlu8UF1rNWYo5ea78i1eYEjTye3a3/Qq8vsrwhNFCvSwzl2ue
         v5EahAlJZirRIfLmr7BQhLxkkQfyYaLgqEvqud8XeAEun2m5HaVwzUUsr//Oevw0bkIb
         ij+A==
X-Gm-Message-State: APjAAAVtXTyRWO61zswa+JhhzGDjp5wKyTPYsJTV+2QOsqtKInCR2+9k
        eIF4BsuyDQryWPlL+Zrw15CD3KNB
X-Google-Smtp-Source: APXvYqyTVkR10QDxKKi6JMqF6/oj/wm66+NnrPAqSkvvIJwaJsZHYEt9ITWQBsdicpPHSe9a07ru3w==
X-Received: by 2002:a19:f707:: with SMTP id z7mr5904080lfe.61.1554281040491;
        Wed, 03 Apr 2019 01:44:00 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a7sm2832903lfo.8.2019.04.03.01.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:43:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBbVM-0004gK-QR; Wed, 03 Apr 2019 10:44:20 +0200
Date:   Wed, 3 Apr 2019 10:44:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
Message-ID: <20190403084420.GH6734@localhost>
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:47:19PM +0100, Fabien Dessenne wrote:
> This driver exposes a standard tty interface on top of the rpmsg
> framework through the "rpmsg-tty-channel" rpmsg service.
> 
> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> per rpmsg endpoint.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/tty/Kconfig     |   9 ++
>  drivers/tty/Makefile    |   1 +
>  drivers/tty/rpmsg_tty.c | 309 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
>  create mode 100644 drivers/tty/rpmsg_tty.c

> +static int rpmsg_tty_write(struct tty_struct *tty, const unsigned char *buf,
> +			   int total)
> +{
> +	int count, ret = 0;
> +	const unsigned char *tbuf;
> +	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> +	struct rpmsg_device *rpdev;
> +	int msg_size;
> +
> +	if (!cport) {
> +		dev_err(tty->dev, "cannot get cport\n");
> +		return -ENODEV;
> +	}
> +
> +	rpdev = cport->rpdev;
> +
> +	dev_dbg(&rpdev->dev, "%s: send message from tty->index = %d\n",
> +		__func__, tty->index);
> +
> +	if (!buf) {
> +		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
> +		return -ENOMEM;
> +	}
> +
> +	msg_size = rpmsg_get_buf_payload_size(rpdev->ept);
> +	if (msg_size < 0)
> +		return msg_size;
> +
> +	count = total;
> +	tbuf = buf;
> +	do {
> +		/* send a message to our remote processor */
> +		ret = rpmsg_send(rpdev->ept, (void *)tbuf,
> +				 min(count, msg_size));

Just a drive-by comment; it looks like rpmsg_send() may block, but
the tty-driver write() callback must never sleep.

> +		if (ret) {
> +			dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (count > msg_size) {
> +			count -= msg_size;
> +			tbuf += msg_size;
> +		} else {
> +			count = 0;
> +		}
> +	} while (count > 0);
> +
> +	return total;
> +}

Johan
