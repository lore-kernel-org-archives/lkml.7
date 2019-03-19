Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507222085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C4yQIHPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCSO1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:27:37 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:50661 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbfCSO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:27:37 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 10:27:36 EDT
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 2B6CD1E804F5;
        Tue, 19 Mar 2019 17:21:11 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback16o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id cPQ3DZo6jN-L9H0ZhBI;
        Tue, 19 Mar 2019 17:21:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553005270;
        bh=cW4Qle7PxmztoypPoJDzqhzViQoAKy4rzwU1TNUUXSA=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=C4yQIHPGf/X0JmnMO1bJol9v5vIKMTqTNI2xYk8MDqdxymgrLWIfJ5x1xF5djLAit
         t/BL06f/kvf1IHcV31Qx7AXPX3Xha1zErQKGMEwtVW0hUsn1JtchOGsbwYDzd5uZiW
         rAQgLn4ZNDev3G1pjlou4mfclnlpWZsxSjNHA6Ko=
Authentication-Results: mxback16o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-406defa25fee.qloud-c.yandex.net with HTTP;
        Tue, 19 Mar 2019 17:21:09 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Mariusz Bialonczyk <manio@skyboo.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <6836A9A3-AF86-4E2F-9215-647CB36E22DA@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
         <20190318092737.8170-3-manio@skyboo.net> <6836A9A3-AF86-4E2F-9215-647CB36E22DA@gmail.com>
Subject: Re: [PATCH 2/2] w1: fix the resume command API
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 19 Mar 2019 17:21:09 +0300
Message-Id: <9351961553005269@iva4-406defa25fee.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone

Mariusz, thank you for the patch, a small comment on it logic

19.03.2019, 16:21, "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>:

>>  ---
>>  drivers/w1/w1_io.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>>  diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
>>  index 0364d3329c52..4697136b9027 100644
>>  --- a/drivers/w1/w1_io.c
>>  +++ b/drivers/w1/w1_io.c
>>  @@ -432,8 +432,15 @@ int w1_reset_resume_command(struct w1_master *dev)
>>          if (w1_reset_bus(dev))
>>                  return -1;
>>
>>  - /* This will make only the last matched slave perform a skip ROM. */
>>  - w1_write_8(dev, W1_RESUME_CMD);
>>  + if (dev->slave_count == 1) {
>>  + /* Resume Command has to be preceeded with e.g. Match ROM which is
>>  + * not happening on single-slave buses, just do a Skip ROM instead
>>  + */
>>  + w1_write_8(dev, W1_SKIP_ROM);

Looks like this may break the search logic, can you check that with this patch applied
some other single slave device will correctly 'tell' its id and it can be addressed via match rom (like, basically, just reading temperature or something like that)?

>>  + } else {
>>  + /* This will make only the last matched slave perform a skip ROM. */
>>  + w1_write_8(dev, W1_RESUME_CMD);
>>  + }
>
> This may be a subsys maintainer's style preference, but perhaps the verbose comments
> might be better suited for the git commit message. Could this then be shorted to
>
>         if (dev->slave_count == 1)
>                 w1_write_8(dev, W1_SKIP_ROM);
>         else
>                 w1_write_8(dev, W1_RESUME_CMD);
>
> Or maybe:
>
>         w1_write_8(dev, dev->slave_count > 1 ? W1_RESUME_CMD : W1_SKIP_ROM);
>
> I am also ok with this proposed version, hence the "reviewed-by".
>
>>          return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(w1_reset_resume_command);
>>  --
>>  2.19.0.rc1
