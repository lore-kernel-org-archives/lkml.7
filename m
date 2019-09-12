Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AAFC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D835208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVP7wsm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfILGCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:02:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34173 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfILGCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:02:00 -0400
Received: by mail-yb1-f194.google.com with SMTP id u68so8254256ybg.1;
        Wed, 11 Sep 2019 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9+ntv9uSx3Ki8PaxHviLAmn/U1312pdl1Nqx/+XVGM=;
        b=tVP7wsm0JfXajQjrOHCeRwkukET9lg/523L2R8yTSA4O0Nq9JeeInDt3Zw36cLUrd8
         5KCHvyEE4/nlb+No8OIw9JQwmRZVhOFlMhA/QgBm1Hj1qcDOhQq72hwNruMj5FBH+ygO
         jzMGidmPg4WkyG9arHkShiFTth1mYO0p8nznQpYQT2x+CaifQc6xif0vtgozNg/wrpIf
         1Jf+Gf7CaXwYzZWYOS5Mn1jUnt5kg5p6ppo5gU/46X99+StZJCY9EEAG1Qt1hkcO+Yh/
         TszAGr2OiHsnOkpP2ArPFBEf148may6uNQebpdhCMJBYehOLRvconyp50TpSosogMutw
         YO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9+ntv9uSx3Ki8PaxHviLAmn/U1312pdl1Nqx/+XVGM=;
        b=mi27gup7Kd7Uuzyz2GWQA++QvYc1vG6z3DLUc8buHRybhAo7zb4pm4TA81XfPkL+T0
         YN1Fe1PgpnsOjCLfv7FG7SigmjQM5WvZ5IN5QywlHuTKOGE9Znd3neMIgjT1Xw2BL2Ut
         NXGJYeouWR5NrIgcho6qVhoXFQGXIMdzBmBkgYFPwTp5RyNQ5bzoE+m+x7XgW+vttjow
         Pfxlg+r+QwUXsufVmRNgiecp2F3nyHy0lmsLEXt4/cexIWMsQjDfW+8Ta0vw88ey5po+
         KDPxqY89b/aW6ZJ0E3HQSR3R1rz6OMLAX582TVqGaz/GoIaORxwsGl7lBe/shoksE56L
         G1Kw==
X-Gm-Message-State: APjAAAWNkK/bVj/4fLzeHI9dI0L7cHo46DJnuarc5KqlFRQ9uVXYmmXm
        xyZWfH9bwXO8iTXXw/A6NUDTju29Jh4LnLuua7SKOZOM
X-Google-Smtp-Source: APXvYqxdVhyBvRhD5pEJMq5IPO8fSYIR8HTJxLA2DfYt/FJI/9GZhI08OSl63c9NvR5tcb6QfPUG2HRwf7qrjyFes7k=
X-Received: by 2002:a25:d44c:: with SMTP id m73mr580540ybf.126.1568268119580;
 Wed, 11 Sep 2019 23:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Sep 2019 09:01:48 +0300
Message-ID: <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com>
Subject: Re: [PATCH V2] ovl: Fix dereferencing possible ERR_PTR()
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 8:24 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:
>
> if ovl_encode_real_fh() fails, no memory was allocated
> and the error in the error-valued pointer should be returned.
>
> V1->V2: fix SHA1 length problem
>
> Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  fs/overlayfs/export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index cb8ec1f..50ade19 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
>                                 ovl_dentry_upper(dentry), !enc_lower);
>         err = PTR_ERR(fh);
>         if (IS_ERR(fh))
> -               goto fail;
> +               return err;
>

Please fix the code in warning message instead of skipping the warning.

Thanks,
Amir.
