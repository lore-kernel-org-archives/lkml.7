Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D56C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A518921743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzenRFxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfGQQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:49:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36993 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfGQQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:49:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so17000662lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOMvU9L958BHBqQb0I12kZPWlzo6THyhJjrxTBppcCE=;
        b=gzenRFxnGbEsrSVDCBeofQIBjg80Z0jettMP5BgEqLf5UBKUzdp81woCAwwUgDUnZi
         zAO2Z+vbCrRfBvSApHw/qDA1drzbBkiX/CFu6klg9QYa2SY+fzgWcETJL1AZrZpikzXx
         712u+2GHTMRuACaTM6Zvjp5rnn075/9RCRPsjLeP1nsNULVFiSwHdHU0gu5UOQeacuor
         Zaizh7UuLtQO98lO5L6ITmTWlDZqm84fpmz3alJkq0l6NBzZ7lRFCqzO3imFXwYmCB+q
         ZKZ6GvzihYQVXPutCWJOYcXNnTkWJqKBvtsvEcTQig3xrcUp9nI7BKKoe2tNt97palJ1
         gsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOMvU9L958BHBqQb0I12kZPWlzo6THyhJjrxTBppcCE=;
        b=k4d8/ECrlJvK2jvLXjr4VPg4n6tiiqtect0JGFzcJWf7Us/LjhOAcncOXoNfGRDxqI
         DLG1FcA0clln4Ur35WafdsBQvL+ZtbaSQwRT5pNP095IyU+9xCcOn5YV6PdMSxgLO8Ax
         uwuP7mwLo1unvV+tsmC7QBVII3GE9MlJBkTSmHrHvzWMlFXMpojUiIoR5vvLKdEMTO6K
         qTT77JZMHT0cNIY3UnB3aNxEC68D6hse0HXc45kqtL3gO0pDU/jA9rGzqIPTgIeYJRRz
         fEqapPGiqTKfjP6xWl+Z+GKTpbOOP4CCBRjbWKit7Os0Cgk+5LbhDNB3dwYO8ELIdlW3
         4Drg==
X-Gm-Message-State: APjAAAVg6/y1tGWrx6wWPHXw7tAF+RiZxvKqatao6BWeEoCaPPNAgw7W
        GXBYIngT3KsWmH51753jFUlZcnIKuK1/YzZtgeooP7+P
X-Google-Smtp-Source: APXvYqzW5vqvmOthhYptcgvGOc9Ub/0ACOYeQRavNcERT5B9nkmHawHZGEhS4UN2ZVaM+SKvOR+k0UrJRGV/Dq+9gpI=
X-Received: by 2002:a19:6557:: with SMTP id c23mr4869824lfj.12.1563382151092;
 Wed, 17 Jul 2019 09:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-4-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190717163014.429-4-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Jul 2019 13:49:00 -0300
Message-ID: <CAOMZO5AGL_+NOMP4JcPS_eSJSXTNSYDf4A0m=zdgjRd7vhnhGg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
> correct definition makes device probing code more clear.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
