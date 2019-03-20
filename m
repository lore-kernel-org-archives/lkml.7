Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD90C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C072B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCD+PBTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCTSvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:51:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41344 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfCTSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:51:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id t7so3117108otk.8;
        Wed, 20 Mar 2019 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XNMPwWvFba4JuAksv3Ts/sq+FdMZEQ3WIMOUGxHjzJI=;
        b=CCD+PBTjFlkwB+0/IrPzvlBko46ds79+Muf1cZOJ92mMMOdNVO5zplGlQ5x6GHYRel
         788HN8hAgErRWvGSy+efoxQ/+TgXpWsf/wCdE625zEVbBB8/4bHYanoTZoTeYocJluxD
         b1Foprou+5lt+IffB4ehTpnactRE4Vx1ZufX2Zykjk24ObmL9VWukIu6G2h9IRSACb9N
         oA3/B/xPDnWwARgdQpD5MYmzoS4eS36k9C8Kelwfkq06Kp2W99qvJet+ArBanpCUTvno
         tVagB+0KsSBzNAS3wHS8usq0VOWUiOwHlcm2Qcd2fDgX3eIl+p6JAqaSFwwfZefMZIKH
         JQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XNMPwWvFba4JuAksv3Ts/sq+FdMZEQ3WIMOUGxHjzJI=;
        b=bwjtqDXm1ePXOun5ypQ+/dgdt+8eh3lRpsU1ekpj13CSOVwfFj/ywUcOQQImdi0xzY
         1KJtbzSUltIQXuIn5qsLCcfAKsu+HXCAjAu1bTtRhPP0jBosF5xw+oW4/gKUMBSCDHZ/
         jH9/Kcg2PU0oWeQKf5L7+D9Yf8Gqes+INmC/3aqlQQ2j5WEMi9IluOlBksCvyPEjks0b
         fghjm/PuVggJvUL+nttxVXyfgMvAW8rvtFO/7aEmaY09hiAp7DeEp6rlsB2Ckg4/f9SI
         FjfuFkNWFijbSgENzmW1g3oSWY+YEBc/XGdfVcUoLvDd5Pz5at/NL9FQfcbefpiUvx9f
         FSyw==
X-Gm-Message-State: APjAAAXWDpYPj47vFYLwHF9ntIWmTeZ5pU6AWdHJ8ngg644ilAPRbzss
        id+M+Tc3T+QFZ6DDAATuI+J+obsjQguKR60tuf8=
X-Google-Smtp-Source: APXvYqx4bdeP/n6pHORM8a+LXrO9DEvxXSmxNZJAC1yVVxzeAuIC05KqKfczN+sSEx57Pg31TnlDlWizYSFOXDvrfyM=
X-Received: by 2002:a05:6830:2118:: with SMTP id i24mr7147820otc.224.1553107902852;
 Wed, 20 Mar 2019 11:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
In-Reply-To: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Date:   Wed, 20 Mar 2019 20:51:30 +0200
Message-ID: <CAPWNY8UmDAKeF+SNMKDxki=-=s+UPx9WXQvSoFqWmUCsNvv=1g@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: fix an invalid condition in tpm_common_poll
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:31 PM Tadeusz Struk <tadeusz.struk@intel.com> wr=
ote:
>
> The poll condition should only check response_length,
> because reads should only be issued if there is data to read.
> The response_read flag only prevents double writes.
> The problem was that the write set the response_read to false,
> enqued a tpm job, and returned. Then application called poll
> which checked the response_read flag and returned EPOLLIN.
> Then the application called read, but got nothing.
> After all that the async_work kicked in.
> Added also mutex_lock around the poll check to prevent
> other possible race conditions.
>
> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikul=C4=97nas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev=
-common.c
> index 5eecad233ea1..7312d3214381 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -203,12 +203,14 @@ __poll_t tpm_common_poll(struct file *file, poll_ta=
ble *wait)
>         __poll_t mask =3D 0;
>
>         poll_wait(file, &priv->async_wait, wait);
> +       mutex_lock(&priv->buffer_mutex);
>
> -       if (!priv->response_read || priv->response_length)
> +       if (priv->response_length)
>                 mask =3D EPOLLIN | EPOLLRDNORM;
>         else
>                 mask =3D EPOLLOUT | EPOLLWRNORM;
>
> +       mutex_unlock(&priv->buffer_mutex);
>         return mask;
>  }

Thanks, this patch seems to work, and I apologize for not responding
to test the patches earlier.

Any chance it'll be submitted for stable 5.0.x as well?

--=20
Mantas Mikul=C4=97nas
