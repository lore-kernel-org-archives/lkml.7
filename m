Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED77BC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B9B206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLqJztNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFEIlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:41:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43539 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFEIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:41:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so12005723pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of66HISeBHbGXVTt6r8XmW0SQD2//sxmzE7ajnq8+VY=;
        b=jLqJztNddE4ASMQCZ4oIbM6zJCju7pciSxDMfJDOS1jlm9qFl4nTQXYrCV5wtD6Z9y
         QAdIX2dASyE5g9kYNNl2DOMD7ZISEzjZSpg2Ua8+CE0eFch8lpoCf2ELZncUrn9Duujm
         hTxp/O127500ED/VBydrL0tAXClUXL5WsFmZm9LeL9GsIQSciI9V9AI6RxodZBx/duDL
         ZFUnScFpSKK8UEoKPvXVn1Xa2b73DTasjNSe/u2//l/jzkKBKPlI39d4hVdnGS7oYuU5
         cUA0LtE4aXXBxUIGxqViLtyqDiqKlr/Z9H3b1e17EsAEJ76py2cdSaVoAXuV5m2yLPNO
         jISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of66HISeBHbGXVTt6r8XmW0SQD2//sxmzE7ajnq8+VY=;
        b=lIGwZrTBnSnB2aEG8YNnAhzsUbKwh8E47ftdlLuFEwIYxiAIdtzc+bVuid6yNMnMGD
         DS6JZNd0nBaAfaJYpR3/uuOaMTEFcoZoL/orgNuNhjRDZ7dK8RPuHdKm+hLG9lE7k0kW
         HxplAMhtuxcYevarMNvSTJ9117av8fAzxkRkVPGOe0UwCpXn5hZHSBrhH1EwMUX6FGkt
         /cu8pOryJLWqOuK0qM2xG5dkZBeHA9g7x1jfMSreBjWb7+D850d/+5UAKlLdecKkX9cq
         fjR2LdJmMyJeW3tnIoeWqcDg0d9BAqhGmWxIF5fcQvIpbGSw4PLp9dDGgnWrp3UenB+7
         TiBA==
X-Gm-Message-State: APjAAAUqxwmTfQOcpZEI1GkBBjY1YfJO8t0zhKZq7IpzGSOXSjvam2c9
        54/1HLe28CiXTariaa7oXjhVsXkxx3okRH58bdg=
X-Google-Smtp-Source: APXvYqw2cGWfqNk2TcNR1wnnhGY1S425oBQZz+W+/xP2oadAUadHPqsUOvfw5GT9ZCMAE1dBGWbCsyb58V90sSPgSOs=
X-Received: by 2002:a63:fb05:: with SMTP id o5mr2929532pgh.203.1559724074704;
 Wed, 05 Jun 2019 01:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190602162546.3470-1-benniciemanuel78@gmail.com>
In-Reply-To: <20190602162546.3470-1-benniciemanuel78@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jun 2019 11:41:03 +0300
Message-ID: <CAHp75VfEREXJTr_QpADTsqBr10t16SaJqeM+tbxp6QZgc8Gfjg@mail.gmail.com>
Subject: Re: [PATCH] pci: hotplug: ibmphp: Fix 'line over 80 characters' Warning
To:     benniciemanuel78@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joe Perches <joe@perches.com>, Lukas Wunner <lukas@wunner.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 7:25 PM Emanuel Bennici
<benniciemanuel78@gmail.com> wrote:
>
> Fix checkpatch.pl 'line over 80 characters' Warning in ibmphp_ebda.c and
> ibmphp_hpc.c

I'm not sure it's needed.
And actually some of the changes are the regressions in order of
readability ratio.

> +                               debug("dev->device = %x, "
> +                                     "dev->subsystem_device = %x\n",

Don't split string literals like this.

> -       if ((pslot == NULL)
> -           || ((pstatus == NULL) && (cmd != READ_ALLSTAT) && (cmd != READ_BUSSTATUS))) {
> +       if ((pslot == NULL) || ((pstatus == NULL) && (cmd != READ_ALLSTAT) &&
> +                               (cmd != READ_BUSSTATUS))) {

No, no, this breaks readability a lot.
In the former it's clearly shown the logic between conditionals, while
in the latter it's a mess.

> +                                       err("%s - Error ctrl_read failed\n",
> +                                               __func__);

Really, no advantage on this line even for 80 characters.

> +                       err("%s - Exit Error:invalid bus, rc[%d]\n",
> +                               __func__, rc);

Same here.

> -               debug("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n", __func__,
> -               ctlr_ptr->ctlr_id, (ulong) (ctlr_ptr->u.wpeg_ctlr.wpegbbar), (ulong) wpg_bbar,
> -               ctlr_ptr->u.wpeg_ctlr.i2c_addr);
> +               debug("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n",
> +                       __func__, ctlr_ptr->ctlr_id,
> +                       (ulong) (ctlr_ptr->u.wpeg_ctlr.wpegbbar),
> +                       (ulong) wpg_bbar, ctlr_ptr->u.wpeg_ctlr.i2c_addr);

Here better to fix explicit casts (perhaps it means wrong specifiers
being used).

> +               if ((poldslot->status & 0x20) &&
> +                   (SLOT_CONNECT(poldslot->status) == HPC_SLOT_CONNECTED)
> +                   && (SLOT_PRESENT(poldslot->status)))

Here you are not consistent in a way where to put logical operation.

> +                               memcpy((void *) &myslot, (void *) pslot,
> +                                      sizeof(struct slot));

Why spaces after ) here?

> +                               debug("%s - call process_changeinstatus for"
> +                                     "slot[%d]\n", __func__, i);

Do not split string literals like this.

-- 
With Best Regards,
Andy Shevchenko
