Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ADBC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C493208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PpjWXm1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFDRbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:31:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36966 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:31:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id 131so7962392ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Bc8vPbFX2tliT9MrCWMKPuMK6hgmMamCpZ5rNAKRQw=;
        b=PpjWXm1jVPIsRz7rulWNvQn99keNFaa71SZ17GTZf1SYK/jEtb5wWtm5IBbo5AVEMi
         ByaWfyVjsM9XfsE9TmckhXdg1Riz8kFWR/ZvaYEZ8VKjx2JtGKOELtmijpjpjann4eLE
         fkmg3y+jJjn8JdWU1wYsVAGZOg/W4AVA1+ZrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Bc8vPbFX2tliT9MrCWMKPuMK6hgmMamCpZ5rNAKRQw=;
        b=IQ7rsNMerSWuSiaR3kpLRdAaKoeM6GzUMIQSnGxWl070EsUjpyygh9OMgcFufRWYnt
         AJDHllJjaJh8/14R59IDaO8cIpCqMV8VXHInBszXP+z6MHrgEcBCb8dcLmNwITFgeZ2r
         WangHn9BqboTfAsOtN4QUuV05sV4KKLYG93ikh/wcIWL4GJk86EDkqDQzUkNf35y79i3
         WEaGDyu8GgVIJ942Rta9TNMOVnnjw9LSRQ37v47PxmCSKVsUMluRf+44hZ6Re2rb1/il
         26jjPooPpJpuxGamYtBhqNFMKD0OrxdMHUJUVGimC8IqcQc8Y3K49yupxVHLsjZnBJpU
         GkJg==
X-Gm-Message-State: APjAAAXvQZ7wXFicz3u7Ve+I0PFMa4DBQqPVyRD4d+wQpQ+xpXiHGTPF
        4Y+gbFm4EvBnoyFYhBixxb3ChYc1ETo=
X-Google-Smtp-Source: APXvYqywlFnyX3ClrEq3wZ7PMe1SOUFkuh7cOMapQGQuYXDikAm39N5uG/3Dwz/a6cR//yo4t1M7vQ==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr3016840ljc.42.1559669491706;
        Tue, 04 Jun 2019 10:31:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t3sm1514851lfk.59.2019.06.04.10.31.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i21so5950330ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
X-Received: by 2002:a2e:9582:: with SMTP id w2mr2373368ljh.136.1559669489250;
 Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190604172910.107199-1-briannorris@chromium.org>
In-Reply-To: <20190604172910.107199-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 4 Jun 2019 10:31:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOBhe81Z2V-s_-=briPhXGQys7YcRyWZ-j=F07b_X6zWA@mail.gmail.com>
Message-ID: <CA+ASDXOBhe81Z2V-s_-=briPhXGQys7YcRyWZ-j=F07b_X6zWA@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:29 AM Brian Norris <briannorris@chromium.org> wrote:
>
> This message is pointless.
>
> While we're at it, include the error code in the error message, which is
> not pointless.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Oops, I sent this patch twice. Sorry!
