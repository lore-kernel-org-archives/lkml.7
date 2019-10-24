Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58626CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89221906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHYw/9D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393652AbfJXNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:39:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45375 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbfJXNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:39:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so14264217pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suq9Sbqez65nm6sNwjXVb4eVX4KIX9kkoJj8FM98PoM=;
        b=OHYw/9D+5pRDJM5o00TqrXMqaZZHH0YXF8fFIHxdq5w0p9wSW1QT2CM5tKV07TQK9X
         USyRxNJtE78wYc01M3eWTZmGSUTa7Og4HhUAbT18qkFqKvGyUNJrMcuNF2EGJE9Nu1+Q
         jGuVq4mDYULKEiXPnSFYHbVPbUcxxuH2CZgsnfpwAJ3Ouq2wj2tgfIJQCoXVJeBuptxY
         zFDe5ZxaFcvST5tmVOxPFuGVw25Yd7oWCDsO1OxGv01ieE2RLWMNam6EwIlR3jGk+GN7
         AJcGnNRAZt1So7BQSQ/v7BIFMeLCFisLVibyPPH/x8AY1gOHoBcQNzoeq5JKu0APBvQP
         dCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suq9Sbqez65nm6sNwjXVb4eVX4KIX9kkoJj8FM98PoM=;
        b=eth0Y+DAFkL2X90YmoJmWkTIrnEaudJP2/bwNjERsxFOplKbgUO+DTlXgJw9ehmIXk
         Z5uDGSCb5D1oNyUVg3+rwWwCZmt60gcU9DWu/Bq90OAFHOQ2uWh39MnEdvllXY/OkGtE
         n0f0znd6UWzaxT3JAR/MTO5oyOhR343tReulagw/+SLr8iqWaacqxwYlGckwLWTcCV6Q
         ukjr3/LTVUZ50TS88CTihTHHhqAWGqdkkArJr7W0ILK2CmTUt1o0eJP7/U8cJNREmRxT
         kbh7tsfGSgFYYN7ts45KPPDB/UN7HzsTKDO/406YEAKLO+UASvFaJP6MSs+4hSTqNxYD
         Bzpw==
X-Gm-Message-State: APjAAAVoRrEEnWLodlUD4ytkBJE+sGDOAZRQouGg8eVgaasAXXpfPFVW
        qN9aw9E/k2WmV1zl2OyuBiMLphCkmXkJ9kyNJ5zsWQ==
X-Google-Smtp-Source: APXvYqyCMBjaWqJGYxfc2KvlmcpxPxYmygFWjwLlOZ++J3LD4PX1QzcetP3vbmeNZx4vVL82pcs5q5JVkP9MAlrTQ0A=
X-Received: by 2002:a65:4c03:: with SMTP id u3mr16680974pgq.440.1571924355500;
 Thu, 24 Oct 2019 06:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <453d1fe3843d576eeeef6f8536eead59c1e566f3.1571762488.git.andreyknvl@google.com>
 <201910240309.CaNX9Uju%lkp@intel.com>
In-Reply-To: <201910240309.CaNX9Uju%lkp@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 24 Oct 2019 15:39:04 +0200
Message-ID: <CAAeHK+zZszdu9dLNW0UBjCpT4nVW5uiZPMpeMogBqN3T5oTPPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb, kcov: collect coverage from hub_event
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, USB list <linux-usb@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 9:11 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Andrey,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc4 next-20191023]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Andrey-Konovalov/kcov-collect-coverage-from-usb-and-vhost/20191023-185245
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3b7c59a1950c75f2c0152e5a9cd77675b09233d6
> config: s390-allmodconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ERROR: "kcov_remote_stop" [drivers/usb/core/usbcore.ko] undefined!
> >> ERROR: "kcov_remote_start" [drivers/usb/core/usbcore.ko] undefined!

Indeed, we need EXPORT_SYMBOL() for kcov_common_handle(),
kcov_remote_start() and kcov_remote_stop(). Will fix in v3.

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
