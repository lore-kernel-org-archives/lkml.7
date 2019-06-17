Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DCDC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C9021655
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ff3wGzEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFQMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:00:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40364 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:00:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so6284878lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMOobivDUXfkCWR6pjRCOHNvO/6DOagtbl2NP8XjONo=;
        b=ff3wGzEwNI2T2elXEz8FCLpI/REFBeKdKx2zf6MqQfZBtYK8vQlnaHO6bhamdvVbaP
         51fYwx8k+ppTt8z1VI36YDSJNGbtFO+fTiFqKgvlMG2JH6SUrOZmWHHSEe9pkz9Grroa
         U2ZIf1eaVGT8yzhCo/XIfkSXBL1h+j1v9D61pnTFL71nCFMkcsR51HSCAlmUz8ps5ioP
         d/IhdsPtOi99gXcabRDsLtf7+augejt0ZFYXwBWyXLYXTHSZAy7thsLRuoFgcNTx6fn3
         shOA5oRdZ0QqKpetOlDgNaJQZ4jn++4q7/fTwYKK8EaTR9ZPII5fH12B/64j1hiND+PZ
         yB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMOobivDUXfkCWR6pjRCOHNvO/6DOagtbl2NP8XjONo=;
        b=cEIMIrRNSvxew0md7090YIbsGV5NTQ215+AM+LpLH8zcRjEu6mVF4sbCZtUnZYGfAn
         xmQlBmB8X3v09IT8+plgWgVNH3qNfbzIjrFczauXTCjFmsUwW/n73E17Iwgnn8ApIA66
         0nhZn7FIPiIZ6iskR0nrSXtYz6Jg9k6GCTDbPPwser0UwJisKcWpxL8hXTEj6zMO1ZDs
         ijpNsYRevCSxvvUwhh7/D6BQPOr5g7U3P26q05GC5GMZyneXhuthxw4gUD1BjI6m5lEp
         KOK33cgV9JHgJGdNWjP0XtNCBMqDr1TjRVqByq8R7PNNPXuy2zyAcMCeQX6UX/KUGmRT
         bQnA==
X-Gm-Message-State: APjAAAV6MImuQssYnDxzBymrfwr+7BMJYnNmDmgyHXiJhFw+Vodn8a79
        DWColasua8cIFPzpTpiu+RF/RQ==
X-Google-Smtp-Source: APXvYqwj0ZEEUC11brx6LjTF61ISaIIIHQ9Cv7PlQ0vk+DY940LjTUESF8y4LCWjPpp5YS0si7V8WQ==
X-Received: by 2002:ac2:499b:: with SMTP id f27mr29899101lfl.88.1560772847314;
        Mon, 17 Jun 2019 05:00:47 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u9sm1740980lfb.38.2019.06.17.05.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 05:00:46 -0700 (PDT)
Date:   Mon, 17 Jun 2019 04:41:05 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys for v5.3
Message-ID: <20190617114105.fyosfx4gddkhqav4@localhost>
References: <20190527062854.GA19419@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527062854.GA19419@jax>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 08:28:54AM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this update of MAINTAINERS with a mailing list for TEE subsystem.
> 
> Thanks,
> Jens
> 
> The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> 
>   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-maint-for-5.3
> 
> for you to fetch changes up to d7f3f7d847044a111d4abadf9c69aa54d0d05167:
> 
>   MAINTAINERS: Add mailing list for the TEE subsystem (2019-05-27 07:59:03 +0200)
> 
> ----------------------------------------------------------------
> Adding mailing list for TEE subsystem
> 
> ----------------------------------------------------------------
> Sumit Garg (1):
>       MAINTAINERS: Add mailing list for the TEE subsystem

Merged, thanks!


-Olof
