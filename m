Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67421019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYYjzH35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEHL0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:26:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfEHL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:26:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so26726487wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S0qOD/dRlBV6N/0vrEIWcihFKCIIXXbBX2yJx7XCiQM=;
        b=VYYjzH35tO/H40j6zelv8gEoHoQ8oIRkjay/VS8EA6SvcGUn9o1NfvIA3WF9O5GKwW
         //hHHH3OIF88FSXysJCjFk1IfpON6Oo9qlmh8LFEhZnsEAKD0YXxqc0oDcDG8Lq/hfct
         289osFew12Da70n86PY51N3LIeOSVMyGm53LPZlUh3003TAZWf4XI9raFUXNA4tom+M0
         sWv9+QLPJEgs+S4+Zn4IPP0HjIWvlVcXEPbh3XLq4wCSgKhyc4v1yJ1PHkbmBoM3alrY
         16jiJqCjzPqZmTdWelloYAOsQ6rs/7MIQ8F0w0MTY4W9yVQ/B5jLxIplFEyz3LVtdbjr
         DTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S0qOD/dRlBV6N/0vrEIWcihFKCIIXXbBX2yJx7XCiQM=;
        b=VAmKKvGlBwu2s8T68D2q+FwSjm1M61DCwXUx6eUImOgIbiXUsVw+28umlIIQvfxThE
         9uzjWqvFXGHT0UglhzdRr9haztu9ugUDCjWlOyYjNROBMp8wUMpXYbfKMDSCqKM9SQfM
         zs4qG4jVdcoVvGB/9kzpRC/iUHg6Mwk3w1OpH/P/cDL7vx2rRd6/SC4QWLVaIoOtD1mu
         9dhgphiDymh74/0ZC0At4/cq4+CUJh80mimvM8t5eYJC+aAgsmxMioxlImaRipP+M3hP
         PBKTwdXVejSt2wnL+j+WVA+Ss+6NHYdt0jeyDptK4b0AmpK+D5ac2R+MP9ea7M7Nzx2Q
         8RxQ==
X-Gm-Message-State: APjAAAV6BiynUK6fFs8Lpp7L/K++VIckKfsrINCXFwUsTmAgWa6rAkML
        ffsBUZpjU4+QvN3ONfQlwyqusQ==
X-Google-Smtp-Source: APXvYqy1jPgGrWuGM/LzibbEPRUUPdDHj3BXrU4f8DLjFMLaP1xchN8lc7M8BRBArjNL0ulCxPNtXw==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr28179578wrn.9.1557314783927;
        Wed, 08 May 2019 04:26:23 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v189sm4051781wma.3.2019.05.08.04.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:26:23 -0700 (PDT)
Date:   Wed, 8 May 2019 12:26:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
Message-ID: <20190508112621.GW3995@dell>
References: <20190430165626.31639-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430165626.31639-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Andy Shevchenko wrote:

> Intel Comet Lake has the same LPSS than Intel Cannon Lake.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - update i2c info
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
