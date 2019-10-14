Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADFC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324820854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QclHqXW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfJNHDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:03:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfJNHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:03:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so18309185wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kARX9+0BKAD7qk3BjARPSF4hECeeh6Sx7CLH7T+oTb0=;
        b=QclHqXW6ZKzWj9AvwDjjpURbYYwL2ehXvGg3U3vqXoz2YaRjsROg0JGyTwNk9g54Zv
         i3LukqN94drT2bwK8oQISHzBug4ZZWS4VT9Qn1fuzrxXgFZTgCki5XLSh/Cj0ateWNpx
         ffCsL9UWjm+ECWErvYzruTNMykHx639hORyyVVYP3O4vrFdFh27UZikVmP8b5xOE/b/I
         Tksm6CH991VoJXwUi1GbASr/4TIHNxj5jwv7g1Cu512PvGVfxwESX+puUNCe5+WtXIZs
         i7lDirHUD87ahyjWEqfbY+NoRne58RmejCjpyTnOAa/PBCJDtIGBf7vrS6ZRu+q0G2me
         JG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kARX9+0BKAD7qk3BjARPSF4hECeeh6Sx7CLH7T+oTb0=;
        b=TPgCzaSbc3E4QDNZ+A3MY71nPwVgYXfq0u9ek/3NhjU19N9In9tcxd6LsmI3XoGiHA
         x93pm0GZPKsi5dBcE2AW3MAMedIb+iwAgHRpPUaBKO2xn9yAXkrBiB4uKgpcu4ZtXr+I
         JyJe5u1DBMdLLHG1tdS/7OhRCe3tYs7qNzHz6egjdkW+MnZX38IqK4rmq1//UGqvhM3k
         m16w//JJnAEI3zMLAncBQ7s57yixpry8fmcxn3E7TCBACJOChw4Ia8kwAy0qRRXr+YUo
         5Tek89GofoUtND8fLXcKk2LAXXArLMTbwi6qJnn+sJ8waD7MMaPfQfA+sgvumD5NCcjT
         iHdg==
X-Gm-Message-State: APjAAAXMIcpCgqrWTvkjdgbrBCRqfNNZqGJSOYb8xGJ9o/A8YsI8NGUe
        H/bMpbeM0RcKfPcCPOPJNUsG9w==
X-Google-Smtp-Source: APXvYqzYx84rDsCIL+mfTwQbJ8TVHerC4FF8I0+AOYTGhsCPHzwLJ/Hj+UoebQyNvEYHO7chm9im1w==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr8881658wro.253.1571036601043;
        Mon, 14 Oct 2019 00:03:21 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id g185sm23439606wme.10.2019.10.14.00.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:03:20 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:03:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Message-ID: <20191014070318.GC4545@dell>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell>
 <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
 <20191001120020.GC11769@dell>
 <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002123759.GD11769@dell>
 <BN6PR12MB1809451A3152488F3D8D1371F79C0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002133553.GA21172@dell>
 <DM6PR12MB3868561CDEEF9D21940E8F57E7940@DM6PR12MB3868.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR12MB3868561CDEEF9D21940E8F57E7940@DM6PR12MB3868.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019, RAVULAPATI, VISHNU VARDHAN RAO wrote:

> Hi Lee,
> 
> We have two instances BT and I2S.
> We need to create devices with same name added with number of device
> like example:
> acp3x_i2s_playcap.1.auto<http://1.auto>
> acp3x_i2s_playcap.2.auto<http://2.auto>
> 
> by using MFD we can make it happen automatically by giving
> "acp3x_i2s_playcap" and other extension will be added by MFD add device API.

The auto extension is handed by the platform_deivce_alloc() API.

  platform_device_alloc("acp3x_i2s_playcap", PLATFORM_DEVID_AUTO);

> This helps us by rectifying the renaming issue which we get by using
> Platform_dev_create API`s.If we have to use platform related APIs then
> we need to give different naming conventions while creating the devices
> and cant use it in loop as we have 3 devices we need to call three
> explicitly.This make our code lengthy.
> If we use MFD it would help us a lot.
> 
> Please suggest us how can we proceed.

You have 2 choices available to you based on whether your device is an
MFD or not:

If yes, move it (or a part of it) to drivers/mfd.
If no, then use the platform_device_*() API.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
