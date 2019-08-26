Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452612190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKzlF5Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfHZFvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:51:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44858 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHZFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:51:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so9887891pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jx/PkJ/HJBNahQz742EujlxvyiLYErUOYWblJG5jYR0=;
        b=EKzlF5AqSU+PlCLC6HmJxvQaiOrjlE8PoytIrpsFNHDFnqTOZ8oq3vzueZn2CwfC9W
         HEvHbvS3PilvaZ8JKOwD7xZLXexQB0iKL2qQ1BS4qcQrABHSU6bC2fh/zwVdGIBXWHJh
         AVs+9mt7DXJlDBbab3t+X9hy/p+7pxDzP8vhqXEAFRMw1HJqSRCLOZWd7WyQSWElJl1M
         W7cgVY/hi5kCp8Z6lIcmUh0wUsKVxZgK8z3GQ0yg08Ge0G+HC94J01rZHyPquSKS127L
         FZxJoKWo2+k3Km6zIpHspoh/WVfi8dqJecwcjJdx0dRnFR2J5a2rP67DjZ25JSA+u9gM
         DlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jx/PkJ/HJBNahQz742EujlxvyiLYErUOYWblJG5jYR0=;
        b=K5DVxDNiAxWtL4RX0V3gDVjIHjyKI4Ec2M95LeFVd1W8MpaDIxrqyUKGB2bOJp70Ad
         0LTFjQdaJf3dqZCqy6vVe0NEBGapRIC4Wo/uKU2kN8hFUzeB8IBtp7sGlNHRGl7jleeU
         9OKRawVdoOQv/y2pabCI7e6jmj0ur7EVc2Ah2mVfxULAY3q/gvtMUZoGA2/acaCQ97TU
         H2hX8T9Q48Gi8yOj1fDJUNBt/Jtqbz328Vi5mFqz4tfE0Pwr8Gw2B2IaKFsheMEmmOMt
         XfCZVh9KEFItF99cERwuu3uT/ClfLKnaIBZlsEZCzf/vVmY1/xL63SqQfnGYoaP9WoT3
         dlRA==
X-Gm-Message-State: APjAAAWvmAmwn6EoMsfuqCsKZWLdeHQABWOD/Kj9d3KoYHqd/y8ybyN2
        iwwdodtA3PziooZ08sy5TQPf1w==
X-Google-Smtp-Source: APXvYqyZS3q8Z1jqdApzu6vN+19iGZkteWLqaQFf2scHB66MCoGbivmSuGfgws3sJMzg9v6omIfd0A==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr15141553pgk.355.1566798683198;
        Sun, 25 Aug 2019 22:51:23 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id q8sm22820482pje.2.2019.08.25.22.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 22:51:21 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:21:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH 1/9] staging: greybus: fix up SPDX comment in .h files
Message-ID: <20190826055119.4pbmf5ape224giwz@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-2-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> When these files originally got an SPDX tag, I used // instead of /* */
> for the .h files.  Fix this up to use // properly.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/firmware.h               | 2 +-
>  drivers/staging/greybus/gb-camera.h              | 2 +-
>  drivers/staging/greybus/gbphy.h                  | 2 +-
>  drivers/staging/greybus/greybus.h                | 2 +-
>  drivers/staging/greybus/greybus_authentication.h | 2 +-
>  drivers/staging/greybus/greybus_firmware.h       | 2 +-
>  drivers/staging/greybus/greybus_manifest.h       | 2 +-
>  drivers/staging/greybus/greybus_protocols.h      | 2 +-
>  drivers/staging/greybus/greybus_trace.h          | 2 +-
>  drivers/staging/greybus/hd.h                     | 2 +-
>  drivers/staging/greybus/interface.h              | 2 +-
>  drivers/staging/greybus/manifest.h               | 2 +-
>  drivers/staging/greybus/module.h                 | 2 +-
>  drivers/staging/greybus/operation.h              | 2 +-
>  drivers/staging/greybus/spilib.h                 | 2 +-
>  drivers/staging/greybus/svc.h                    | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
