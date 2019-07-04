Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D66C46495
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D731E2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2gavV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGDSq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:46:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38975 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfGDSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:46:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so6972263ljh.6;
        Thu, 04 Jul 2019 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsAlp4ULFAEt/KZTRgfVhPSsETI930mXTk+ASwru2g0=;
        b=Du2gavV9vIL+NiWNjpFjWlWz6iH0UK/3brqTvuQphGXknMO5DsiAZZa8MxmKb0kU5U
         YWmgI70B0W4W8McXIhRbODaxAbNj/jYaUrDnHk8t27ZIvw9dfb1o4tVujqGbez046BIt
         mD9vG1ZIhmInvVy5Indnuq1PXqq5tr+RXWdB8uooX7y7KAcDcXy/AkXN0ilpQY3mtA8q
         XcMq9Hd8tZW3x3VDQhcblFzledgW2dcGkp7ej/kDAcZ15GtgCpKh9zTcyPfvd4ns3XDu
         p+d3zV+S2QnXYzY/cs6Ho+FIav3Pm537gJ4v3/DnoFTJXro6Myunq0yk/j8tBasKSWdg
         oldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsAlp4ULFAEt/KZTRgfVhPSsETI930mXTk+ASwru2g0=;
        b=tc7CcFLIUZ/DYOGKPrZ+MiO7TbArZjRofNG5IiQYD6SieWy8F+oA9QMPv8w7BfTZS6
         8EEo96xPgjts2M+mLZjqVBvG3Q7vb2bOfGKnjl59w8q7dq711HEzfBGztv7GAdHO0K5O
         YHiqWdo8o87R9rxDN696GG0FJ8v6Jj4URNthrVjLSpqGNJb29ZQwwnN/I2GlmZlgz7JI
         z4FOYnJ1Yk3FRqKe254sN0ZxFqLt3iTY4eeZPw4L1Y2ag/saxrbhGM4tP2RlVWlnQ8+i
         Rv/pb1r/zT0RpM+H5nC5lE14hhjy5dCQK48soHyyAsfKYFCrtKcRzFr3cfLCYNz8/Po2
         TMCA==
X-Gm-Message-State: APjAAAVrcrJWBfOF3N548tzfGmdtYOo9RWwDmYosfLF2PK1jeh9alzj4
        pkF2HOH9de1i0HrRoNLQI39MUUFS3GU5w5dxeKgwVu5T
X-Google-Smtp-Source: APXvYqwCTnITXTmicj0f+oMfvruft9l7GRXeaNd8zZSphtS5ItOx2Mbs5YLpCsoa0aiqrH5/ZTDyeYO9CtsIQPZjmAA=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr5687877lje.214.1562266017051;
 Thu, 04 Jul 2019 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190704170422.GA25633@luke-XPS-13>
In-Reply-To: <20190704170422.GA25633@luke-XPS-13>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Jul 2019 15:46:46 -0300
Message-ID: <CAOMZO5D0ti3o_8z4+b5L7ht55z582CRZWybiYK+feRROErUxuw@mail.gmail.com>
Subject: Re: [Linux-kernel-mentee, PATCH] media: dvb_frontend.h: Fix shifting
 signed 32-bit value problem
To:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On Thu, Jul 4, 2019 at 3:22 PM Luke Nowakowski-Krijger
<lnowakow@eng.ucsd.edu> wrote:
>
> Fix DVBFE_ALGO_RECOVERY and DVBFE_ALGO_SEARCH_ERROR to use U cast which
> fixes undefined behavior error by certain compilers.
>
> Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
> ---
>  include/media/dvb_frontend.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
> index f05cd7b94a2c..472fe5871d94 100644
> --- a/include/media/dvb_frontend.h
> +++ b/include/media/dvb_frontend.h
> @@ -144,7 +144,7 @@ enum dvbfe_algo {
>         DVBFE_ALGO_HW                   = (1 <<  0),
>         DVBFE_ALGO_SW                   = (1 <<  1),
>         DVBFE_ALGO_CUSTOM               = (1 <<  2),
> -       DVBFE_ALGO_RECOVERY             = (1 << 31)
> +       DVBFE_ALGO_RECOVERY             = (1U << 31)

You could switch all these definitions to use the BIT() macro instead.
