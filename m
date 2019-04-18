Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA27C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7BE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555615943;
	bh=U1zZ7JZMQhQLgxF6YxzdkZgmeQbfIVO6i6x5ajW4LrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nk3MhvosgDKb0+Dv8lowXDRyWDDUA3izcIdMsUcTmRedZfMdbj38+1L/SUPQwnXus
	 vyY5U8sXwHfJ2Nu/DSDLQRj99+JFp/g4dZ1tYLsaI0ZoRvCtw0mFWjb9hSpaCQu5nQ
	 O9WaAhkU5CvVhX6Dgy1RoOK1Z9znJL/BBeb1VdPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfDRTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:32:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45640 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:32:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so2471259oia.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNVZeiQzlx9AuCsu/G58nKN0IS9t0lrVQRqoPE+cXTg=;
        b=Gl6tHXl14K6DpbKd1JnZ7SZGfT9sQsvzmkeLOH/72VQF+Pr3ZFzkntJh2VVCJSqT1m
         GujYlHoDHhlKcDdnlKQe0AYUMieWPHpYfakdNv1xcXW25/FlG2nNCAQ6usLcrxe5ppo+
         J4jbnCo5xHVzjai8VTjEvO9mJlwisQ2hGPHhZ/zJtgnbKrvpWvVPy5e5A9XqBUGizUp5
         MGL6CrIPqNZIlu2mrq6UEcrttbw2KUnvZpCD9t45y0BqayJe6pN/Y8bcbT8Q9OZPfV3l
         aKXwRsW5XbmA6l7BrWa5YLDfm4AM/X6DsozPUVZRa/nJju4QYlWfGOJwHjAgADVq6mzg
         MO+Q==
X-Gm-Message-State: APjAAAWgreT7AMavdbWbJ/JuMF/ZwPE9N//rzDgyG8abwBv0+ZABMAL8
        DpDthhAHaZjdOAEjwG/lVgUUs7PAZpsRFliMP7xZNA==
X-Google-Smtp-Source: APXvYqzWkrun1IN4Melyol55VFdXzxaA10gI7OI0VsSktgF6Vh3Dk2C/S91dzKChF+gVOE+SPN8cp0H7TauABA1zJjM=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr3373504oif.110.1555615940871;
 Thu, 18 Apr 2019 12:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190418174156.11926-1-bp@alien8.de>
In-Reply-To: <20190418174156.11926-1-bp@alien8.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 21:32:10 +0200
Message-ID: <CAJZ5v0iv5nBTvSW53B2oq5qsDgZvP6Gop=fJywWfBLM7a-FH8w@mail.gmail.com>
Subject: Re: [PATCH] driver core: Clarify which counterparts to use to device_add()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 7:42 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> It is not absolutely clear from the docs how the cleanup path after
> device_add() should look like so spell it out explicitly.
>
> No functional changes, just documentation.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4aeaa0c92bda..fd7511e04e62 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1999,6 +1999,11 @@ static int device_private_init(struct device *dev)
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use put_device() to give up your
>   * reference instead.
> + *
> + * Rule of thumb is: if device_add() succeeds, you should call
> + * device_del() when you want to get rid of it. If device_add() has
> + * *not* succeeded, use *only* put_device() to drop the reference
> + * count.
>   */
>  int device_add(struct device *dev)
>  {
> --
> 2.21.0
>
