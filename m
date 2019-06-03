Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE907C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A3627F5E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTu3itVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfFCNFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:05:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44936 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:05:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so11956014wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xFD+U0dBeslY3ue8+myEMtSBz10lKWAKa0J7f56lYrY=;
        b=fTu3itVzP4DOlQsORHeIUunGjTuGF9qM5FvxRmAuVC+7KkIEJeJjDPevNLQPFqgDi8
         vGza/hRM1ZbiS02iDMOeziKt/5CdIB4fU9WxYFyFVxqolWV8hwrTq7x7dx9YeopQSyy0
         xRvpMnrppafOasWC/Z4/fl7qLGxHYvEo9i3Zy1kIw4UWLZi7aaFB6My/ENZq4Io8cfHR
         by1+9u1zyIvj+FCRDugI5nJddJqWRn+9o/MVhYOgoK0llWbg3H3B8Kj3L1CHH+rjoh9t
         EFLgN/tAzvwZNG7OU1hlTuQF8lN02h8OBQvPT10mN448N8dc8n1GRrobMtS9B9FVATND
         VeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xFD+U0dBeslY3ue8+myEMtSBz10lKWAKa0J7f56lYrY=;
        b=IX+YgK9xoMmlnolY9942do87whggUQZWlBrHZljIECYFdi+Ieksmjo0IqwGoUvKkbQ
         AVgkY2Cvenp5cOulvWu7zDNMMb3G5vmnAKJwjXYihRAnH0B6yV55k+pBdI7PQaUS/OlI
         9HQWKedFK10A/AcDwp2j8Sk9CobBXHXgvMM+8HvwpEbwbKQKZD9N6C3JjVLhgtjIPghF
         kVBA0QhhmbAl3zx98ucxOKrYcJ3AC7gbiTtT3Rp9suNC1TNIBOyhGtbUz0DXppsqaGdX
         IUtpf8L4tpLvbGdQo2EvWspK3z+vluS23JT0WTvDw9YH/rATWYMIOpXSKbIUIRYR40gY
         iKLA==
X-Gm-Message-State: APjAAAWkTvUkPhTR0+UWL+m6e6mEuJe3dmn2txdoa1/S6ByYZ/L7DF6g
        1l4QWOMdCvkGC85tbDflhIXT6D5URkc=
X-Google-Smtp-Source: APXvYqwF0AEloQRGLwHGwVmPbmIhrNzuTM5ARF0vbel1R5wsQC5aybtZnky7fAgs5ut5WwysAaAGlA==
X-Received: by 2002:adf:afd5:: with SMTP id y21mr15978606wrd.12.1559567102834;
        Mon, 03 Jun 2019 06:05:02 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 67sm26500429wmd.38.2019.06.03.06.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 06:05:02 -0700 (PDT)
Date:   Mon, 3 Jun 2019 14:05:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Keep device tables sorted by ID
Message-ID: <20190603130500.GY4797@dell>
References: <20190524181344.70653-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524181344.70653-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Andy Shevchenko wrote:

> Easier to find and maintain if the device tables sorted by ID.
> Do it here for intel-lpss MFD driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
