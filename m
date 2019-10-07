Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBDECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6B21871
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PWxzNCil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfJGPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:31:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfJGPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:31:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so8399743pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=JZ4ZLhpG0uBtRMl0o3Xeh7toOVYQ8X7X8agStl6yaPA=;
        b=PWxzNCilhqxZx4BInRaEC85RoByjMuhy/v7d51XUHuyPoc2xgtUFa2Dq4rtT/tSg8K
         o/mw7qx2clFS1oYj3pq6+B+546SBKXzyKa8K6+VRpc1eX8uFXe37ryhWGl9v8/Dfcfj3
         HYvUYe7reb+I0oCOS67lxnxPmyia1T24TyWaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=JZ4ZLhpG0uBtRMl0o3Xeh7toOVYQ8X7X8agStl6yaPA=;
        b=hqBuC13qBlXf0FcJOm+MUV892ttBWOiIPfi6PBcQArUGO+JaHlQBD+GlUSDozjEHlo
         Er9wXxN18nUleahQjpPQszcIc78EpmTOC0/o47v3RaMz+jAGQRQyt5vwfRigKJPk9ZFd
         vkx4P5MPILMnWhSlWf+N8wUOcQgM+vM+hUGqjfaXsxcwk/GN/GxceeyFx88WIFlgOUO+
         cIfhWE4QHMKJozxMNR2vFAZpc7CBkq5ljNGxpsNeXdlmz3/W4AFL1DKlKUSSc3dBhA5j
         HXF/eYXC+l2d6qhnX8QITGva6THltO76+jlMXLjnrHS6qecCpyTxHwZ9GJouXDXJNnGf
         CrKw==
X-Gm-Message-State: APjAAAWiup3zhH8uhMU8MUlawlBD8z+BBUhN648kYAlcHykQxYKxIJB0
        4lQqSQmO92vrmFpx/hYKlpfoawFY+RQ=
X-Google-Smtp-Source: APXvYqwxYFF7RQHdC7kZifXplqwZ98J3wRnNwaPRlto+tGJlCXia8cgagHkZUM044+QuC2S+qil0Wg==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr7702950pjp.49.1570462303498;
        Mon, 07 Oct 2019 08:31:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm16028527pfi.95.2019.10.07.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:31:43 -0700 (PDT)
Message-ID: <5d9b5a5f.1c69fb81.842f8.329e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005210449.3926-4-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-4-hdegoede@redhat.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: dwc3: Remove dev_err() on platform_get_irq() failure
User-Agent: alot/0.8.1
Date:   Mon, 07 Oct 2019 08:31:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hans de Goede (2019-10-05 14:04:49)
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> platform_get_irq*()"), platform_get_irq() will call dev_err() itself on
> failure, so there is no need for the driver to also do this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

