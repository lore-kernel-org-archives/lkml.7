Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F842166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/LA5Fmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502378AbfJXNLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:11:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33566 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502360AbfJXNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:11:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so3339301plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo0WkUjWDnE/H4X4N+cQZqf98SENyk0SBmAI3sBPGIg=;
        b=t/LA5FmdSWO2uLJcRujTTOOL5Hdq4SSWNNzt8gtbUWoxM6Wsx5tjOqE1izAXivO0Ia
         AgBOnEXQDAWeIqWePIuwWicCQbMmdWgCUgf1Kf2Lc1UZeDBLyXaf1AvQU3D2yMVaUuAv
         OBi7x+7VaZjtscab1aWVmwprqqv5CNubZTit1UUJ+JmvUHKvn1wFiTszs0JauF//be0+
         g/ppiwm/nlPZ141Zc5VJWQUcGu4YM/wzRRzGmeQsFB88P9FJ7Xn5fiZfSuPsLf0v8fEW
         BlW1Cm5bvXgD6AP/CydfVi4ccRS1AETvzKQs3ZofIEK0GOtFu0LtgzTPc0CMPg4H2g1U
         uxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo0WkUjWDnE/H4X4N+cQZqf98SENyk0SBmAI3sBPGIg=;
        b=ivOyjGiAUH9RoDA8wq9SGgTAVTnPfqRWEq/lMbMo4UY6tp5dO+JKxna/pNwo/zKwEs
         NBiUgbp4LzzXhgpCKVTLn+AOl8sY5yRRpQad/TVk2tRXV7uPhejvAwt/w6nl2N/NhT1l
         yl7HrJWpzpFsqBQ3kemsbE7nAm2PZvLCD/Se/GckbxjkcwGygrIRq3WAJKtyyZKDASX5
         I8iSKw6uYJn5pJGrkoWzhsTUDizh4DAGnYB6CriRAOqWUD0fgNKFt1ZwctrpM7XQ4x1R
         J/lCWAXxc4zXVWnJBdHy7RxTNlcuN+8MKxI+IoxxskRdms1cQ0YqjC8lUBnqz3mSeZpB
         WK6w==
X-Gm-Message-State: APjAAAVzUeoajlWrUQhykLtJIeMMrPC0lxpsHACwZwcR9tU2ByMrPR80
        Txk8LWl0o1y2Qnk0RTklq8xhdASQ5ZSapA9Gvsap+Q==
X-Google-Smtp-Source: APXvYqyy5qlLBB9opQM1zjilQUiju2zRB6OI/DofEJGzghw2O2H+RqiQobefmx7Itav5M1rRYtcWroC7W5dIZdO1IdA=
X-Received: by 2002:a17:902:9696:: with SMTP id n22mr14759199plp.252.1571922666109;
 Thu, 24 Oct 2019 06:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <df26802a60c09d155291c2abbcb51e4530eb19d7.1571762488.git.andreyknvl@google.com>
 <201910240119.fyrtJQLH%lkp@intel.com>
In-Reply-To: <201910240119.fyrtJQLH%lkp@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 24 Oct 2019 15:10:54 +0200
Message-ID: <CAAeHK+zeY2YLkf8+T2PQ6Q288XYphCnj6bP7EKdsfePAXrS4mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kcov: remote coverage support
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

On Wed, Oct 23, 2019 at 7:20 PM kbuild test robot <lkp@intel.com> wrote:
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
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/kcov.o: In function `kcov_remote_stop':
> >> kcov.c:(.text+0x1094): undefined reference to `__aeabi_uldivmod'
>    kcov.c:(.text+0x1144): undefined reference to `__aeabi_uldivmod'

OK, looks like arm32 can't divide 64 bit integers. Will fix in v3.

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
