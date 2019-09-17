Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B16206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404542AbfIQH5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:57:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46393 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfIQH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:57:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so3178461qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUxRgSOM+RJMXGGjbBYzlx3MiAC/rsxDlK8JSS/iIDg=;
        b=FXY49tp7J4YPRtYpkrH4L8WxLOEWjgqeGsZtNqqyLuK1bcB8iV9ghe/IQFL6HsC3Ab
         2EszJ6LB/o7Owz40vQKxRD0xDE8kXVS5F/91JxwsOm1iWG0Y53tROV4yILTb9FKgzKIz
         OFerpqYGgMdrVYioQ1VYGTJxc82nEdXInILtCTIlgTEuRgsEeacculYRQ706qKYunNIz
         R7xUPdhf3MsGMB+2aO38lpSRvDLx4v0H8hZb6EX6IXtRR+up9L8suHirZWBMgNo+KyVu
         dhc/Hgl6OR+eFj5r/JRVY+hUhOMQtW/LvKQYJ/q1Mp63SuN8bQkvkOEUj1qkhjmzyO2c
         HeXg==
X-Gm-Message-State: APjAAAVWlDLwNN379UEcn8dO8ZKa6et9ZFvNeRgJNBi7mA7fpBJgfnI5
        98k51KChA0RWhqfpQY8WHlad3iDrbZdMRXFyKEs=
X-Google-Smtp-Source: APXvYqyVW5uR0zr3Z4l4/OWxGXKS97Xq2SxHgSFCrmgwNlMskha2F2/FD8IbbBZ+v65enZvrXs6deER9V4k50OjcFT8=
X-Received: by 2002:aed:2842:: with SMTP id r60mr2342063qtd.142.1568707052075;
 Tue, 17 Sep 2019 00:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190908121038.6877-1-sre@kernel.org>
In-Reply-To: <20190908121038.6877-1-sre@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Sep 2019 09:57:16 +0200
Message-ID: <CAK8P3a0rqeksffu4swv2BGzhd68Brb76VFUCyfqtFAu6QppVgA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: fix nvmem_cell_write inline function
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild test robot <lkp@intel.com>,
        Han Nandor <nandor.han@vaisala.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 3:45 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> nvmem_cell_write's buf argument uses different types based on
> the configuration of CONFIG_NVMEM. The function prototype for
> enabled NVMEM uses 'void *' type, but the static dummy function
> for disabled NVMEM uses 'const char *' instead. Fix the different
> behaviour by always expecting a 'void *' typed buf argument.
>
> Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Han Nandor <nandor.han@vaisala.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I still see the issue in linux-next, did this get dropped by accident?

      Arnd
