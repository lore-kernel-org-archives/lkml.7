Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47813C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151A2208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVBQ6nLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfF0WPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:15:22 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42668 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:15:22 -0400
Received: by mail-yb1-f193.google.com with SMTP id w9so2402866ybe.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=854kgvZIGVmpx/zJerLitPu72zAj/sPCDRSpo5mcVm8=;
        b=UVBQ6nLgJ7hyBK0VTX31wB+Js1VvwXnP/nwFcgPtwaFJewTCuj1osJwrFqHfTvwRhj
         oIEIEkV6bUU7HdJznqd+1RtNHgQN60jvIObmjdR9ZV6sXOox4bxgplduaGihqvQpxbvl
         /CXqzEI/lNWPklsLCFGyCyO1foahYXwHMW0q74DVX3P0B/psWgckT6IoYyN0X7S0cTQC
         9Iymb0dP/l61XFeczgOkCa0eM7NbRnqpXJTxNSm5iVfCS2ry7VGHBJveWCE/2qDtz0bf
         HRZalvnhhWyQm037wDc+4cY+nzn9yf2PfyzaG8fcy2SYeTDplVyStgoCZDdma/1jWHz7
         5xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=854kgvZIGVmpx/zJerLitPu72zAj/sPCDRSpo5mcVm8=;
        b=fuBEn+MnVA4Nqbz6FdD2iC7HRyOw3yg2uj35Jy4vJQSR9kIDFXFwJnnDcZecAxlAL4
         fp3Xg7JsydbrZiWhTVIk0wv0TxVwMdU42dvSKT/harDXQCv8e4NPa8IudcUhfkkBJqLf
         DBUdSCsbj11dlgOcg7OcB9sqCVo1zy8/ae+4joUVcyCXNVCJQi5zmOqtE6xBZLAXp+2a
         09XTZ5ux6Xo4OYtB8IioJuj99xLSYr8uLXY/FwiJRETMinS6hHdnbc44NCWSTdu/tWnx
         4EPxyn5nQlrr30EzzlrD5rlr3MACEo4m+H9U4dkEtGLFqwV8J//DC+G2/VeFVRouQZPv
         OBLA==
X-Gm-Message-State: APjAAAW3keVNOtMLXdjdvpWDh1iIWsfZ49aVZwt863c758NW6I1iA6OW
        oWX/64DwnQ7tWLKbyTe/r9a4R7GLQ2WvDuuTggbf2Q==
X-Google-Smtp-Source: APXvYqxMzrMu9bHCfF1krZKE2+fiz57EFVSx8H1XhM1TKzJ4TURRZ421f3iW3YcRI3sBA2MZJWPVsd1sDFh4dqVLNZQ=
X-Received: by 2002:a25:d156:: with SMTP id i83mr4645824ybg.67.1561673721316;
 Thu, 27 Jun 2019 15:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190627214738.112614-1-rajatja@google.com>
In-Reply-To: <20190627214738.112614-1-rajatja@google.com>
From:   Gwendal Grignou <gwendal@google.com>
Date:   Thu, 27 Jun 2019 15:15:08 -0700
Message-ID: <CAMHSBOWrzQ6NEDEML-Jk8Y+M5iE6yHXn8FWpUP77VZAV7HGzhQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: lightbar: Get drvdata from parent in suspend/resume
To:     Rajat Jain <rajatja@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        rajatxjain@gmail.com, Evan Green <evgreen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>


On Thu, Jun 27, 2019 at 2:47 PM Rajat Jain <rajatja@google.com> wrote:
>
> The lightbar driver never assigned the drvdata in probe method, and
> thus there is nothing there. Need to get the ec_dev from the parent's
> drvdata.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/platform/chrome/cros_ec_lightbar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index d30a6650b0b5..26117a8991b3 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -600,7 +600,7 @@ static int cros_ec_lightbar_remove(struct platform_device *pd)
>
>  static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>  {
> -       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>
>         if (userspace_control)
>                 return 0;
> @@ -610,7 +610,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>
>  static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
>  {
> -       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>
>         if (userspace_control)
>                 return 0;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
