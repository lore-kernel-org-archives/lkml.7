Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2223C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FAF2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYG0a1Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCTJ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:57:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42152 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfCTJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:57:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so1971189wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o+yiMutYq4bXEwAZPjUrQh8hPRAxr9F07E2YtXYevYo=;
        b=tYG0a1Tpoa7hmqVGUv3Qh6fLuwTrMjRao8II8pPWlUJMwojv5nclJb3rHKjtaiyqdm
         4SUrqeueA5lGr+fTqiaKOqdQDa0bVPotmRRr+suwdYPcnTV+vObBdA25aKLhA1OeMe0i
         Kcb6K/gBUZHm88XU62NASq5zUOpPuX4h5oxTcp3qlad2KlGDwyGeS6AwgzcSRhlp820N
         yTHJDK/oKrAf8NAuUfpGQiNbzcE8OcBaE5As/Nwa9zKzpsVy+yfhwS9LBUeZrIhWnxpC
         w0kaFinvrK7RWLkEWulupuMWGhYmQACy6y83PtzM8JO+s6C5dKhTmMoo1wFMIuqa+3FT
         xNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o+yiMutYq4bXEwAZPjUrQh8hPRAxr9F07E2YtXYevYo=;
        b=ZA04ad8VSfQjr5KxrgDKDtfcXvpgef3G5srQ7Sm01xaQPZORXvsv4b0D72PGgVLNXH
         kDwLn6liV/iZ4AWgqIRePdvWd/Jo2cgzA1RBLOJjmFsBtxtJHx/RuH1WYqLGm5kyHVRA
         7j/uZNpip9cv6lFZXFXnIXNonKokjQsXrJJFvheDbofTOVQuLklP4S0qY5y9bPUWs/BP
         DLRiuGSMkUWZb98I1CPgwxhy7WmxQ3jV0QXR1TCvDL5oLLxjpx4OqRy2PRzrLaMPPs4N
         49PkF1DjLwzrbhhMGUTV68GocDSThYiATJboUAeL2bjfyLlGWsCzDgW1QyHJbQFVlaOq
         vXTw==
X-Gm-Message-State: APjAAAUmkmwzeeXS7uTsTBNpeS+cQZg2+QaTiIXHSPD33qQlXgsfOFgp
        I648qcuJjKX5IXfyBhGxsfPGiA==
X-Google-Smtp-Source: APXvYqwxp7+3WNOlQjrwM39cV0ZUHL3WJZDsZkUg3b/LCej/bdAMo3vChCvAPbDmM7KuwCvT7Lkedw==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr20020013wrw.87.1553075835992;
        Wed, 20 Mar 2019 02:57:15 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id j13sm1446890wrx.74.2019.03.20.02.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 02:57:15 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:57:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Message-ID: <20190320095714.GJ4731@dell>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-3-jekhor@gmail.com>
 <20190320095648.GI4731@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320095648.GI4731@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Lee Jones wrote:

> On Tue, 12 Feb 2019, Yauhen Kharuzhy wrote:
> 
> > Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
> > mfd device driver.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_chtwc.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I'll fix up the subject line for you.
> 
> In future, please do the following to see what is expected:
> 
>   git log --oneline -- <subsystem>

Applied, by the way, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
