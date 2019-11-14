Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5B206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKCk8MF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNBIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:08:00 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:32793 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNBIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:08:00 -0500
Received: by mail-yw1-f65.google.com with SMTP id q140so1332641ywg.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydnaeANHQEhicw8ps/5ADrrzqJDVC8ehSIKm3ZEsYec=;
        b=HKCk8MF62E0LPOPcdetRcNdW6RmmuPalngquz1nXz5j4SDf+aD5YdFAa93vQnYM3DA
         9Nt8QP1etU9tQQ549wGvpEKT8j1GdazwVbVkk/wV4AXewlsAadX5pzB9IXjcNWrRQlSA
         IrZlP9lzEQrnH896VQfy0x+0KBvdGY5azLmRlnW2CNxeMCfGSBbIKFmMAILtsX1WjkiN
         Fd0IUdJeNDxOBne86+cxeprIaOssd7/U20EOMIxVGA7ubkRdznfWba+/zeK8KqbsZrsj
         zWBprnQkJ3nKQ9AVGedKVu7BXmZ9CkwFoChVwCXMAjuL6klbpBjhqL5uj4Y3sWO7dTnW
         /dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydnaeANHQEhicw8ps/5ADrrzqJDVC8ehSIKm3ZEsYec=;
        b=KlW/O4q4e6+tD5koq+JbCqTXaDwWwlDrOKBbMiL8tCc68ttJBk1/XiuvplOTNxt3MV
         5wSjFr8weEVueCQ/FbJJp+InuUq5v3tJS9wOoskVTHhdsRj5oeCfU2WEwwZ30s/+blKt
         k1/+KIZ05NwAuYZAwkHzG1jjASbvG9NyKDGcjrsqmBRty9CiQLNNM6xDi/WoI6hSlr1J
         M0qVyiIfY+4r/ToBYntpa75rYBcRFZi+rg4b85yfnY7unGy1Csd8Hx/RT4Uu72vPy+zN
         UHYWc/Azfcyhfi1Hz7ceuWwAdBTBrStmZ1sZ0iT+i82zfdXuMOsuD1hmZPpy3xmgVatT
         TwUA==
X-Gm-Message-State: APjAAAUEbYUsje5MjqW3FzDIfReyVzR/xtWTvm6NRevfISCbT9U2y7bu
        iI/4DN2rJZ64TiHS2FeEDcwoxEMI84me5tKqJpmmGQ==
X-Google-Smtp-Source: APXvYqydep/2MYS1JMR436w88tkI4ovAWbRCP7vaGBLM0llAd8aWhREHtQEULOgEqbP98VIYUTpZBY9VTqZoxJsX4PY=
X-Received: by 2002:a0d:e891:: with SMTP id r139mr4379793ywe.232.1573693678724;
 Wed, 13 Nov 2019 17:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-4-jflat@chromium.org> <201911132033.3UoCbltt%lkp@intel.com>
 <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
In-Reply-To: <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Nov 2019 17:07:47 -0800
Message-ID: <CABXOdTeTxfQ1=5iE0f_0ZMspag5uHYmTJkrzyLS2yBhbLOdBiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform: chrome: Added cros-ec-typec driver
To:     Jon Flatley <jflat@chromium.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 9:23 AM Jon Flatley <jflat@chromium.org> wrote:
>
> On Wed, Nov 13, 2019 at 4:55 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Jon,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on ljones-mfd/for-mfd-next]
> > [cannot apply to v5.4-rc7 next-20191113]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Jon-Flatley/ChromeOS-EC-USB-C-Connector-Class/20191113-193504
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> >
> > coccinelle warnings: (new ones prefixed by >>)
> >
> > >> drivers/platform/chrome/cros_ec_typec.c:223:9-16: ERROR: PTR_ERR applied after initialization to constant on line 222
> >
> > vim +223 drivers/platform/chrome/cros_ec_typec.c
> >
> >    206
> >    207  static int cros_typec_add_partner(struct typec_data *typec, int port_num,
> >    208                  bool pd_enabled)
> >    209  {
> >    210          struct port_data *port;
> >    211          struct typec_partner_desc p_desc;
> >    212          int ret;
> >    213
> >    214          port = typec->ports[port_num];
> >    215          p_desc.usb_pd = pd_enabled;
> >    216          p_desc.identity = &port->p_identity;
> >    217
> >    218          port->partner = typec_register_partner(port->port, &p_desc);
> >    219          if (IS_ERR_OR_NULL(port->partner)) {
> >    220                  dev_err(typec->dev, "Port %d partner register failed\n",
> >    221                                  port_num);
> >  > 222                  port->partner = NULL;
> >  > 223                  return PTR_ERR(port->partner);
> >    224          }
> >    225
> >    226          ret = cros_typec_query_pd_info(typec, port_num);
> >    227          if (ret < 0) {
> >    228                  dev_err(typec->dev, "Port %d PD query failed\n", port_num);
> >    229                  typec_unregister_partner(port->partner);
> >    230                  port->partner = NULL;
> >    231                  return ret;
> >    232          }
> >    233
> >    234          ret = typec_partner_set_identity(port->partner);
> >    235          return ret;
> >    236  }
> >    237
> >
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
>
> This patch is based off of the chrome-platform for-next branch.
>
> base: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
> for-next
>
> Is this incorrect? I'm happy to rebase if necessary.
>

You are missing the problem.

              port->partner = NULL;
              return PTR_ERR(port->partner);

Does not make sense, and always returns 0 (no error).

Guenter

> Thanks,
> -Jon
