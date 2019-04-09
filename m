Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A78C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E22520857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554844724;
	bh=kDgcG+mcudGYXegJqDdhMmoYMnIgAotj8rLme63ftCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QzZw6POyUvLQN1tOjhsB3cg7Gt+50ZHR3woHGXqGFTCDtIJh/ooxNq9muPccCeJV9
	 jDf6uyBLhqACQkpUWyOdFpZuZJQ2FlxcjugtoQjUBM07PagXHtWjUubuh33aUJftrJ
	 wbG1R64bU713yFoZLaO1KaJU+ZgWz9BO4MkhxIMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDIVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfDIVSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:18:42 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4262147C;
        Tue,  9 Apr 2019 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554844721;
        bh=kDgcG+mcudGYXegJqDdhMmoYMnIgAotj8rLme63ftCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UpSdosAPXodQuGjD+VpcX4rNodPEVLJ1K3jGeT8ZJHy8OFAWsZKPBBmq/1KDBe7sj
         xSIhgHDRtsdv73i9Tf8GEzOfcjYC1wEvU7vpipaWU7L8iQIAgC/iIDcKEQqvQTbgDk
         utvhNJCzpDLSSjLsOhq3EK3IuazbQSBumOhWZ734=
Received: by mail-qk1-f179.google.com with SMTP id w20so11233624qka.7;
        Tue, 09 Apr 2019 14:18:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXq0UtWJ06hOrXqZ+6i+IkGebC+YMJfMr8zCDhu3oJCqZihSnMp
        Yk+SOsDMa20D9+pDdKeeGzI26laVL7H78e/RJA==
X-Google-Smtp-Source: APXvYqwSrz5w1Y2ZNAFJzaY8Geq8S//cGip2G6MbAct9QFosdCplsdZF1bfA1/BlPCib/PyFMhScXlYod/dJlupre7E=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr28457559qkf.153.1554844720564;
 Tue, 09 Apr 2019 14:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184958.7476-1-sashal@kernel.org> <20190409184958.7476-2-sashal@kernel.org>
In-Reply-To: <20190409184958.7476-2-sashal@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 16:18:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
Message-ID: <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM driver
To:     Sasha Levin <sashal@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
>
> The parameters are similar to the ones used by IBM's vTPM and the
> various I2C tpm drivers.

Bindings describe h/w (or firmware interfaces in this case), not drivers.

>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
>  2 files changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> new file mode 100644
> index 000000000000..20fca67a56c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> @@ -0,0 +1,13 @@
> +Required properties:
> +- compatible: should be "microsoft,ftpm"
> +- linux,sml-base: 64-bit base address of the reserved memory allocated
> +                 for the firmware event log
> +- linux,sml-size: size of the memory allocated for the firmware event log

Firmware is defining linux specific properties? What if I want to run
BSD? We should use 'reg' here instead.

What memory is used here? This should be under /reserved-memory if it
is part of "main" memory.

Really, I'd prefer to not see this in DT at all. Make the firmware
discoverable. Why repeat the mistakes of non-discoverable h/w in s/w
interfaces? OP-Tee at least has defined a mechanism to enumerate TEE
functions IIRC.

Rob
