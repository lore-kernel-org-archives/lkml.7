Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD4CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D25120645
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUcKqWfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfD3Q2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:28:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39040 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3Q2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:28:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so7076991pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jOWjc9sv7NsGDbJtvu/TnPU13dJOvBN74NeQMobQak=;
        b=aUcKqWfe1AePUG3HV2kyOdwdr0VGaKqoEbIYWixjNLaiL8G5+KRY6tkNyDCWS60iH3
         HbylEF0Ymk5FdzhveDSHC5wR1sC6y2hQcgZE3xia98Mu7/EUSt48g0HkGJGpMYBGjKt6
         Wti509HNf2nx84Sbh0WRbDRiXk0xZ+ajevdIMK2LUXfZj0kdEPONrSuC7+TCY8eam8sd
         KDyVXFVzJ1epQxuK8H9pUutHdRw8KmEAiGyQXUGEBzN/SJKzf3MHa383CWMaY9+Btc8v
         tWjCvkbo8CC9UtlnZpb3Z77HV+20mDRfzVlQeN7XM1d09TajBMW/3iqZwSYGm/ChTMXX
         oLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jOWjc9sv7NsGDbJtvu/TnPU13dJOvBN74NeQMobQak=;
        b=Hio/F67bP9uHsFKPWQSwW42oZTvmf4wD8YmXCW186jjLJdv1TeJ99L+DB+D6be9wXN
         2UlYuWgz4HZQ3iKUmZzoPaXFQh7OTURRdak19H8ApgI4hcdcfkyB/S1zcXbPMr4ARpJt
         zX0DUo4pFXUWBd5ygIikyOCl2bH9ky/OJux1EIgaoxdRLQdhSvM2mqhbCMCat7j9NSr4
         MeFPGxeC/M0iEbAnZJ1RuKApTpg/+qlokr/WMjT5YSfJJR8Dfv9KhCHzPaeWsxn3MmlK
         Ipb+qoQ69P9gedHfcUrJOVKAAHcP/E5Sqtq/6qlcYaewmrb6b3kZOaS3i1e7oDYckhAs
         hvYQ==
X-Gm-Message-State: APjAAAW9vQn2yGsDifBTqctwrrpRJa3wDByUIh9hro1kf1TOru20E3PS
        nUx0ruT9edJJZUzHIbD1JKmNd0NLeYrVrz9pIiwxpg==
X-Google-Smtp-Source: APXvYqwXsmuopCUIMKHrBDPBKxlS+tGIhXcAOqEEvvQNthFUz/mKPjHw7icNYsMv2vb4BFMqoDOfEBYTbI8DbVKwjms=
X-Received: by 2002:a63:f817:: with SMTP id n23mr25948490pgh.302.1556641726271;
 Tue, 30 Apr 2019 09:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com> <20190430145624.30470-1-tranmanphong@gmail.com>
In-Reply-To: <20190430145624.30470-1-tranmanphong@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 09:28:35 -0700
Message-ID: <CAKwvOdmvA4sO7UsXW4DapO_HKodeWFwA_5FsNe_wVjneZBYYdg@mail.gmail.com>
Subject: Re: [PATCH V2] of: fix clang -Wunsequenced for be32_to_cpu()
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     robh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        pantelis.antoniou@konsulko.com, David.Laight@aculab.com,
        hch@infradead.org, Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 7:58 AM Phong Tran <tranmanphong@gmail.com> wrote:
>
> Now, make the loop explicit to avoid clang warning.
>
> ./include/linux/of.h:238:37: warning: multiple unsequenced modifications
> to 'cell' [-Wunsequenced]
>                 r = (r << 32) | be32_to_cpu(*(cell++));
>                                                   ^~
> ./include/linux/byteorder/generic.h:95:21: note: expanded from macro
> 'be32_to_cpu'
>                     ^
> ./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
> from macro '__be32_to_cpu'
>                                                           ^
> ./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
>         ___constant_swab32(x) :                 \
>                            ^
> ./include/uapi/linux/swab.h:18:12: note: expanded from macro
> '___constant_swab32'
>         (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
>                   ^
>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Thanks for the patch.
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/460
Suggested-by: David Laight <David.Laight@ACULAB.COM>

> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992e5cb6..71ca25ac01f6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -234,8 +234,8 @@ extern struct device_node *of_find_all_nodes(struct device_node *prev);
>  static inline u64 of_read_number(const __be32 *cell, int size)
>  {
>         u64 r = 0;
> -       while (size--)
> -               r = (r << 32) | be32_to_cpu(*(cell++));
> +       for(; size--; cell++)
> +               r = (r << 32) | be32_to_cpu(*cell);
>         return r;
>  }
>
> --
> 2.21.0
>


--
Thanks,
~Nick Desaulniers
