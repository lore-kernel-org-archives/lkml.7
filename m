Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE5320715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ1o3iwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNFeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:34:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42516 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNFeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:34:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so2100691plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 21:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnPnwB7+tEaKVjCeEYFNQsf68FzMqh6+Atc4G5a3DV4=;
        b=dZ1o3iwZaKoXYDcRarBQMQQIbKGvT1/uZMV5QvrQzNLfSdAlLK+2QdPZBIew6mpaIY
         ruDLhVoQIQuzH9BzmKaFISKbu7tXlHil6mvxPX4h193BiRyUDIVhoOwxo9Ms1DSYFAMz
         Qfl9hiELr7/Vdh03dNvG13EPY6DxW7wQWCYyv9z7WmLmSyPZeOqi4526TduGbdAn2yc4
         rvMg1Q59MQrClfg07Gi843S3HAFvF0RDhFgagkoOhYQmSmWun4jIJJb24rEQjAn5+Gjs
         vTmpmTYRiv7Cd6qupBYjpBhwIKYiuoDVbs07gtDUFF+f2LDw3LtSWjIplL1VUpkjSt4W
         Od3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnPnwB7+tEaKVjCeEYFNQsf68FzMqh6+Atc4G5a3DV4=;
        b=D/3nTGP2hcQ7pikoiB+ainv3TcIv3WOeokCfqfRY8n4OtGA2NMeqPqN5IqMAlOt9x0
         ZRuBU3AjKTP4IRIYdft2eWFp/MMNMiHcWv72mjrIQojfQc2ZNHoArbRSNeofhe/w79Cz
         oQq+i/twL08j6Hnjm5ejtQqPHZ+/2G/KQCRbtdzJMa+sbZcpvz19PEmvb0i+zDCHrOZq
         mJboXV+Y9NwXSgS+LS+bPFPYSMKuyzTJNM46cBd7Phn1aGw8SDim+/Gc1DmQdkSHDxIZ
         T/bSoQsl4hs/qWtbNDfx5fXRHdNzaEvPGDuwgkjOioJwjZDykFrMV3hVOCF+tnIXMQxu
         lyrg==
X-Gm-Message-State: APjAAAVtrhRmS3DY1uzdGJBq82ybv0zgzBM5cP0bH7Rb2XN0cSxyR0GZ
        PUn8G95SPTrSdebTn6f2cnRk
X-Google-Smtp-Source: APXvYqyBGC15lugybXpYqMOdeznxM2kQyrl4gUr+Lq6xXQOeIbhXd1uM0KupL0ilL7lwC4fL9OOk9Q==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr7529922plt.329.1573709654189;
        Wed, 13 Nov 2019 21:34:14 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id a16sm4520474pfc.56.2019.11.13.21.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 21:34:12 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:04:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v6 0/7] Add Bitmain BM1880 clock driver
Message-ID: <20191114053404.GA8459@mani>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
 <20191113222116.E5E9B206E3@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113222116.E5E9B206E3@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:21:15PM -0800, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-10-26 04:02:46)
> > Hello,
> > 
> > This patchset adds common clock driver for Bitmain BM1880 SoC clock
> > controller. The clock controller consists of gate, divider, mux
> > and pll clocks with different compositions. Hence, the driver uses
> > composite clock structure in place where multiple clocking units are
> > combined together.
> > 
> > This patchset also removes UART fixed clock and sources clocks from clock
> > controller for Sophon Edge board where the driver has been validated.
> > 
> 
> Are you waiting for review here? I see some kbuild reports so I assumed
> you would fix and resend.

I'll fix it but I was expecting some review from you so that I can send the
next revision incorporating all comments.

Thanks,
Mani

> 
