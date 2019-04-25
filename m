Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E35C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ADA20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n556TSWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfDYJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:11:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53799 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfDYJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:11:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so2455999wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VfN3CUkSaPdoS7A8KSZ4/VihmK1M2aNoTuLwkFBF9Z8=;
        b=n556TSWZEnT6QXKvSKr8gIPI2liF0wcoZIhTueLdkcmsETDTe+DNvx9fFtaetpIuMb
         VX//O5NqnLlo8VDpAfA630JcNTqcYhWZwO/ov7Z7t2U9nF24zYteaa8BFuDTH12dh968
         cv86rUd1NsKzREjRaTJSQDix20C8cJlbxnHPg0OqjmdoZo4k9nkz5dDs6MMB3d7EbyHL
         A6+3sPvRiWtIoBSKG7hLDG7SpUOXv2py6f9/G6I58fSbOspwrxCoLN3pAYmGUkDLhber
         6RSSX4s0iajbritQHsxcl3EypfcFaLKdIiFGIzkt1xcgWZWLrNW5XVPDT7ZxUDZAaKKI
         okfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VfN3CUkSaPdoS7A8KSZ4/VihmK1M2aNoTuLwkFBF9Z8=;
        b=F6E+EtsRM39803PuKN3b2kDBAEZNg/QmqRn5jeIWG1FfWg+prDWxVC0DTm3pEBzR7n
         8uU45v7R2d21+WQ8sM9DdRUgr0bNId8PwfTzPW5c47MANORBQpvb65QfblV1QkB1Jgwu
         EQt3fPVgA0OGvQdmWQq4RMCqkn9LUE57V/k8m9eARbHymdSqLAY6GqoBcH//p7J+yaIf
         TTMyeLe3/BOvdMjqd3RfOIpDH7dVKLFDgrNiwcbLKz0qb0b+Zfz0fxlGwV8ahXG/oLzQ
         +ElKE3LBSQ8hpiObqUyFUDw2Q4aVsbveOMn5nC7OgJa6usBL7jkvy+HoDgcWDWZbSqTJ
         jWjw==
X-Gm-Message-State: APjAAAUNQiE0AwJv42UQURjjCrXC3iZTXH+vCjgLNWPCOaed5t5pp5qu
        0Ucb1lDPvrFQBKNO45sFQN4Usg==
X-Google-Smtp-Source: APXvYqyfBaAeEeeqIF9yNJfx+w/kqEhwhpwftPbbZOYsHGjQxinvnQBkbC2ZH8ku+giWEzg3+qWT1w==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr2861249wma.69.1556183506674;
        Thu, 25 Apr 2019 02:11:46 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r9sm20383255wmh.38.2019.04.25.02.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:11:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:11:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Tony Xie <tony.xie@rock-chips.com>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 2/6] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20190425091144.GH14758@dell>
References: <20190102102002.29245-1-tony.xie@rock-chips.com>
 <20190102102002.29245-3-tony.xie@rock-chips.com>
 <20190402063305.GZ4187@dell>
 <518340124.P20tlEWT52@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <518340124.P20tlEWT52@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Heiko Stuebner wrote:

> Hi Lee,
> 
> Am Dienstag, 2. April 2019, 08:33:05 CEST schrieb Lee Jones:
> > On Wed, 02 Jan 2019, Tony Xie wrote:
> > 
> > > The RK809 and RK817 are a Power Management IC (PMIC) for multimedia
> > > and handheld devices. They contains the following components:
> > >   - Regulators
> > >   - RTC
> > >   - Clocking
> > > 
> > > Both RK809 and RK817 chips are using a similar register map,
> > > so we can reuse the RTC and Clocking functionality.
> > > Most of regulators have a some implementation also.
> > > 
> > > Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  drivers/mfd/Kconfig       |   6 +-
> > >  drivers/mfd/rk808.c       | 192 +++++++++++++++++++++++++++++++++++++-
> > >  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 364 insertions(+), 6 deletions(-)
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> do you have some sort of merge plan for this or are you waiting for
> specific Acks? I guess if we're waiting for an Ack from Mark Brown,
> we'll need a resend of the patch.
> 
> All other patches have Acks from their subsystem maintainers (rtc, clk)
> so you could pick up all patches except patch3 and I could just resend
> this one, which in turn could also go through the regulator tree.
> 
> Otherwise we'll probably need a resend of the series, as Mark most of
> the time doesn't keep old patch series around.

Try resending it.  Hopefully he will review in the next week or so can
I can collect it when I return back from Shared Parental Leave.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
