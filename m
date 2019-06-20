Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A04C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3622080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEA1L3F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfFTJPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:15:34 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34063 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:15:33 -0400
Received: by mail-vk1-f196.google.com with SMTP id g124so435509vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVEBadlmAqvAbvjrHtPKEhl6sy5MiRg1y/WHqaW1MFk=;
        b=cEA1L3F3tm4jC6qMJtPjGbKzkv2maSEguj7rZacN6SN4Jk9/AMtS2MNF2eOFHyvKxs
         pfeQ+CI0ywkDGj9+imLlZycMDNflpxNP++u+UXTVOgnLAstuQsPZX4gkDBjsTYij4ADb
         /BBc2+hsBf2JkLRNWU6Fqd51xw7GC79O4owGhultlCSlpGReVzvDQgy6AgiacpmmM5t7
         d1+Egi3EnVBwrSBfPl7NUMIp2EKRrR96ZBeKhrr9qjN5eQ+bzQSJ/z4zMcZNXhBEc0wi
         sNMH7Mj+o87T3mCuhXr/o8dETxZCcTzcLg/I5sngBwtCxf+AFebNb/dUtY/MbqdJ3MJT
         5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVEBadlmAqvAbvjrHtPKEhl6sy5MiRg1y/WHqaW1MFk=;
        b=tY0OaHNJT2KG1pi83Lzi7WaxaSdjp6aY9IuQri0hvkMtp0dQc2Pk+mSwnpiB6aMC7E
         jdRUYtpZ3eRIB5YtBxRQ6l2V59ohWTPM9LYbXZrjuLqNKc8QtIAb6D63yBXHHO1AUllP
         te6Wg4sMpOBRYIuwELwtYgIyPSUKnB3wkwxqUO+KcKupKijZ0+Rwg0vuRho44V8HtUMF
         yqj9+AAY/WXz9RSh0MbAmuvCalsAN17+DdrV8c/nRdU9wJAGQEdv9qYaTnK9mUK6fPZj
         6RkqnosV87XUl3RhnAsGYJv2tRGt45X7exqw+Np+jn7KGo81JI847tLfsuRqnCTYzPZj
         AVMw==
X-Gm-Message-State: APjAAAU2sRjoav5Oph4u+UkYGLI8YFD46W0886JmJU7U3bYoZ7C/oNBR
        TK2cS8IjtS1QtxRSzL3CgeBjqZpmsQBm++yv1YEaLb4XkBY=
X-Google-Smtp-Source: APXvYqyPESBDQzVs2eQMsn5+hOSq/k6+/7ihvhDVrl/YTa9c7uIC6OLNGMjx050tdl17kdMYPaV9PehEtZFCtaN9eJM=
X-Received: by 2002:a1f:2896:: with SMTP id o144mr6607492vko.73.1561022132558;
 Thu, 20 Jun 2019 02:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190617124150.989515-1-arnd@arndb.de>
In-Reply-To: <20190617124150.989515-1-arnd@arndb.de>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 20 Jun 2019 12:15:06 +0300
Message-ID: <CAFCwf13Dwq25R88Sdd6cM2whJvzSaHXpx4ShXoTLDmG-91wS7g@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use u64_to_user_ptr() for reading user pointers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dalit Ben Zoor <dbenzoor@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We cannot cast a 64-bit integer to a pointer on 32-bit architectures
> without a warning:
>
> drivers/misc/habanalabs/habanalabs_ioctl.c: In function 'debug_coresight':
> drivers/misc/habanalabs/habanalabs_ioctl.c:143:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    input = memdup_user((const void __user *) args->input_ptr,
>
> Use the macro that was defined for this purpose.
>
> Fixes: 315bc055ed56 ("habanalabs: add new IOCTL for debug, tracing and profiling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/habanalabs/habanalabs_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
> index eeefb22023e9..b7a0eecf6b6c 100644
> --- a/drivers/misc/habanalabs/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
> @@ -140,7 +140,7 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
>         params->op = args->op;
>
>         if (args->input_ptr && args->input_size) {
> -               input = memdup_user((const void __user *) args->input_ptr,
> +               input = memdup_user(u64_to_user_ptr(args->input_ptr),
>                                         args->input_size);
>                 if (IS_ERR(input)) {
>                         rc = PTR_ERR(input);
> --
> 2.20.0
>

Thanks!
applied to -fixes

Oded
