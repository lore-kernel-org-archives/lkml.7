Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A864C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D215206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBFWfDzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfKMRXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:23:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36238 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKMRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:23:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id m6so2620521lfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFRHzdnlMNniuFWtD+rMaIpPH7jaZVSWgKgjW/UDtWA=;
        b=oBFWfDzU/yX8hkGLN2ysyjY9x0MHdixc+4lGj1pc5Ccjhg3EdLRCJPN70P1XDRy7Wa
         I0nyR13k+GNRGPQ1xL4nMtD2DrkPxS8V8jsfNor9AqKYcf4yAynx2pVdLkikSRPYjKSO
         fPX8+YqhU3rtScCqsgUhAMJKuN86SR0uopvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFRHzdnlMNniuFWtD+rMaIpPH7jaZVSWgKgjW/UDtWA=;
        b=oj7ZpOa1vPLcdiWuyPMQ0kXlpNk6VnTqZPVM2pUnQwyyDfSWu+RL28mMzms+kICE2K
         R0IhFqF+tU8znCQjSD8xKMu78Yb+cyhil7BuUIvwFvcg1K6R+WD1hGFTf9vCqc4slRXz
         KlMMPVt1MDVmxu4McIplSD7tl0wA1pBdVH+ha/4QfJJawe5xrg6tk95m7wqaaYz+SbaA
         nVbgXkAqTgtRuZt5k5gIcW9SLljpxrwr7FnuzFb9c0yz3rDoMBSPcNwVpVjF/1NSiPaM
         OM7qVcWdAb4SOpqb992Ztm9P/v+cMCaFA1ahwO1ilX7Aqz0MSRHHHl6zafA6UU0MYMUQ
         Dn4w==
X-Gm-Message-State: APjAAAUw1uCvI3BnE2TMgSiu/44MNpfmxYQSIDj+taoAWHsld1nWGhSt
        dH4Q4ChQtvtZ6Z+32H2QGzYykJL37mc=
X-Google-Smtp-Source: APXvYqxO8eEdAKlTS5ac0aWTVfee9zxhpTfSrEci1wrvjfSkFH01jUWJUYMn86wPl60sKCZdWz53xg==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr3423118lfg.129.1573665800913;
        Wed, 13 Nov 2019 09:23:20 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v21sm1173443ljh.53.2019.11.13.09.23.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:23:20 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id d5so3488577ljl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:23:19 -0800 (PST)
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr3580388lju.51.1573665799180;
 Wed, 13 Nov 2019 09:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-4-jflat@chromium.org> <201911132033.3UoCbltt%lkp@intel.com>
In-Reply-To: <201911132033.3UoCbltt%lkp@intel.com>
From:   Jon Flatley <jflat@chromium.org>
Date:   Wed, 13 Nov 2019 09:23:07 -0800
X-Gmail-Original-Message-ID: <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
Message-ID: <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform: chrome: Added cros-ec-typec driver
To:     kbuild test robot <lkp@intel.com>
Cc:     Jon Flatley <jflat@chromium.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 4:55 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Jon,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on ljones-mfd/for-mfd-next]
> [cannot apply to v5.4-rc7 next-20191113]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Jon-Flatley/ChromeOS-EC-USB-C-Connector-Class/20191113-193504
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> coccinelle warnings: (new ones prefixed by >>)
>
> >> drivers/platform/chrome/cros_ec_typec.c:223:9-16: ERROR: PTR_ERR applied after initialization to constant on line 222
>
> vim +223 drivers/platform/chrome/cros_ec_typec.c
>
>    206
>    207  static int cros_typec_add_partner(struct typec_data *typec, int port_num,
>    208                  bool pd_enabled)
>    209  {
>    210          struct port_data *port;
>    211          struct typec_partner_desc p_desc;
>    212          int ret;
>    213
>    214          port = typec->ports[port_num];
>    215          p_desc.usb_pd = pd_enabled;
>    216          p_desc.identity = &port->p_identity;
>    217
>    218          port->partner = typec_register_partner(port->port, &p_desc);
>    219          if (IS_ERR_OR_NULL(port->partner)) {
>    220                  dev_err(typec->dev, "Port %d partner register failed\n",
>    221                                  port_num);
>  > 222                  port->partner = NULL;
>  > 223                  return PTR_ERR(port->partner);
>    224          }
>    225
>    226          ret = cros_typec_query_pd_info(typec, port_num);
>    227          if (ret < 0) {
>    228                  dev_err(typec->dev, "Port %d PD query failed\n", port_num);
>    229                  typec_unregister_partner(port->partner);
>    230                  port->partner = NULL;
>    231                  return ret;
>    232          }
>    233
>    234          ret = typec_partner_set_identity(port->partner);
>    235          return ret;
>    236  }
>    237
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

This patch is based off of the chrome-platform for-next branch.

base: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
for-next

Is this incorrect? I'm happy to rebase if necessary.

Thanks,
-Jon
