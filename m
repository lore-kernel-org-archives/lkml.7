Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A47C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65823214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573132720;
	bh=Jzpkg0vhgXV/YSE+NaNji+CYYoEgzz/OyqtOEHhZIkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B9apJj8bI1gd5pjZtEzQI2qdZflhC1hIYgZDqxPZn08a4xqWVKeS4yWrKCObynP2T
	 st75AsiiBR9PqwiJVcRw5RR+L9FRRMamKXj5Ph0hzv7iIl1cTMSeLD5694Br/Idycq
	 mCqmAQpfgiFftaI4zZ1xdkS6W/c9Vz/6SzzNQMVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfKGNSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:18:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39579 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:18:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id 195so1571363lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AO8ZtVNK4Hs5L6IdurNw69+Q+5Mp50uSDpRAtmdY3sE=;
        b=N5ZrmwPIw19YgSXfhZN58JuYGZ3aTTghg0u/VwyTW6Xnz1trMKIazGWKKt2lA0O3GC
         HcK5ZouU7Hrmbkb0pVmMOUADkGfcyygd155KhUnA4E6ZHeVZ63fdK89fgeCgP1AlH/bH
         pwtjuk7XSI8ptRwoX8mFzwZjzu7fFjGleMSQ5//nRw7D6D9ChIMBQaTZwf34g0ljTJvi
         nXntYSDfjF75QGAid+ojEA368vZlAF7T2ozCbLZIHxY+SES0+Ig4+8wk8fvGd3l71xNz
         zwkmWO8XQOXG9PtSLGqGfAl/zkSWiJxE9TzdTuRdlrBLgHjtsRy6dE8Q9KxZxFV7HOWW
         Z3NA==
X-Gm-Message-State: APjAAAWmlT4IizG4h+CDhyS07z5fkSgd3jDZGvZ4Vqaudk0ehieppJKV
        jvYgCA4k7uXji1iU9BzMR1TI/pwt
X-Google-Smtp-Source: APXvYqyX5jju0orz6O+zdME1QzWaOMsMvq/gVCgLWlZUZsVnZ1Px99xRxnuQLrwwoH0Y6AYjKeHQwQ==
X-Received: by 2002:ac2:549a:: with SMTP id t26mr2368724lfk.25.1573132715292;
        Thu, 07 Nov 2019 05:18:35 -0800 (PST)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id r12sm2014832lfp.63.2019.11.07.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:18:34 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iShgJ-0000XH-PI; Thu, 07 Nov 2019 14:18:35 +0100
Date:   Thu, 7 Nov 2019 14:18:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pavel =?iso-8859-1?Q?L=F6bl?= <pavel@loebl.cz>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: serial: mos7840: Add USB ID to support Moxa UPort
 2210
Message-ID: <20191107131835.GG11035@localhost>
References: <20191101070150.4216-1-pavel@loebl.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191101070150.4216-1-pavel@loebl.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 08:01:50AM +0100, Pavel Löbl wrote:
> Adds usb ID for MOXA UPort 2210. This device contains mos7820 but
> it passes GPIO0 check implemented by driver and it's detected as
> mos7840. Hence product id check is added to force mos7820 mode.
> 
> Signed-off-by: Pavel Löbl <pavel@loebl.cz>

Thanks for the patch.

I've applied this for 5.6 now after adding a vendor id check and
renaming the id defines.

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=e696d00e65e81d46e911f24b12e441037bf11b38

The device-type detection is indeed fragile, so I've also prepared a
follow-up patch to clean up the device-type handling in order to avoid
adding further id-conditionals throughout the driver.

Johan
