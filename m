Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6242086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZZLETcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCRAqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:46:48 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:45966 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRAqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:46:47 -0400
Received: by mail-qt1-f180.google.com with SMTP id v20so16102339qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0TUAiQ/9Mlm0/1B55yQUn2DqQLqAWp9E09aN/14RNs=;
        b=ZZZLETccXvVYEwMlCZrZbna4RuGA/IMycESx13Cs2b1t+9XDYJa5aLRULnPVP0F53D
         f38hcniYd84OBJMUHD0XuBWIjPAxNjVQhYwhZ+72jzH9hBMlvmy9tAduIQe41I02cHsg
         a515S2wHwIHwFnNK5fzjc4V5QNJrxSdSmG+/O3zrvEGzNUYR7+1xZQ9mkSqXE9/i2MpA
         cX62OF9uoqCavROFPZlbZIgi8zfxewJxTkbWBhRc3/Av8A+UuMP3ZIDRxWu9VHb+sPLF
         fX9GECPBoimtKVnVVu8x5/ruySxhYnkzgLuWsP2S8waYspiALJCKN50zBpfA07Fri33K
         qh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0TUAiQ/9Mlm0/1B55yQUn2DqQLqAWp9E09aN/14RNs=;
        b=rVOXxYQGUXUB5V0QgKpI5VCm28aV05WGtW4hl6nMmO7rmgMeBBied4m8NZlV5t240T
         92htduvoyaW1N7rR9tgFWnBWuCXTX2SYc8+e1UbtraaJnv9cl0mTrjCUKGa1ZCak1QwY
         x14xXYRh+24Dbb8Zc7ZmXNtdcW4MdvShgbqQnxsfX4ZuGYcg+wrfUAsu282kiMvI2ARV
         0useeWf4XVfs2kWi2ov874wd46WBP3H5+CjOdJvvGoEZOEV7sw39+IzViRjN5DTpi4zL
         ELqle8Bdnuzz2CKyrWdWpkA309fMDtBmePeeDCFtwAbGgS8AqZ39ZvNqu9E9Kx8OmWty
         RWyA==
X-Gm-Message-State: APjAAAV/e0GSo0bTKTdMrRbH6kWdXIISAUwCADAVd4WCRuPuNFPmAn56
        nDpVAih5l05GkO+NOTLyxfXpaJhY
X-Google-Smtp-Source: APXvYqxdTpOhIwIOsdz1PPfYUO0Iq+U/FAmFDIeoye9jUehyCQyXaMClmnekL8RiZ3z8+/ZQ6CoaZw==
X-Received: by 2002:a0c:a582:: with SMTP id z2mr11247708qvz.81.1552870006701;
        Sun, 17 Mar 2019 17:46:46 -0700 (PDT)
Received: from [192.168.1.196] ([190.19.63.64])
        by smtp.gmail.com with ESMTPSA id p68sm777185qki.31.2019.03.17.17.46.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 17 Mar 2019 17:46:46 -0700 (PDT)
Date:   Sun, 17 Mar 2019 21:46:51 -0300
From:   Ignacio Losiggio <iglosiggio@gmail.com>
Subject: Re: [PATCH] staging: gdm724x: Fix alignment in gdm_mux
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org
Message-Id: <1552870011.773.1@gmail.com>
In-Reply-To: <20190317112339.GD4614@kroah.com>
References: <20190309175614.15354-1-iglosiggio@gmail.com>
        <20190317112339.GD4614@kroah.com>
X-Mailer: geary/0.13.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El dom, 17 de mar 2019 a las 8:23 AM, Greg KH=20
<gregkh@linuxfoundation.org> escribi=F3:
> For some of these, there is no real change needed, it's all up to the
> author's "taste", so they are not needed.

Thanks for the feedback! I will send a revised version.

=

