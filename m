Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0836FC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE96D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHSQnPK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfETFu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:50:57 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43230 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfETFu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:50:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id n145so606529ybg.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVxAZEAyj0cKtRTqCE+l9X36eaHh9iSb4M4F2vHx3Z4=;
        b=eHSQnPK4iuol6x0PPMY+riUaWqnhGdd5hikQvFGV83peOCCc4oGOYUd0DOWnBntw8y
         sSTtqHqCEkAJze82fatN6Z1w0Yx+TkgrcC/TvHDSXYKdw2FbyfnbmQqgXpZPlPifcWuD
         KMDu2FaKEBf/Xz5qiRFt/H4za1242RkEVOdakJ3WS1H2Hs5hqnGbvM9IDzYLjKF9zU6o
         0/GjsxiIlwj3LWPbU3mVak9up9zBn7TffCzvZJ2Cjd+poesMuGNLn97ar23iTD5zmQv7
         bcPakZK4+OUvsHYTNnCe+/acNPcLWReIyXRHr8R50DeJUT4D7AWL/nmofjcDFHF+zrNc
         NXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVxAZEAyj0cKtRTqCE+l9X36eaHh9iSb4M4F2vHx3Z4=;
        b=AEUSMfeorrQDgE/QW/ca7x6rHNbGUmPSKcUhmQ0zOX3ATMaHvjnzIHpd0qIWsaXOST
         xueIem4zIbE1CgULJtPGnDtpyK4+Y+AFCk3zLFJ0yYUl2k2PCt0O9gK7OBpbt+9KisPp
         SWcUphhRdPpySx18eN1z/d/dM4Y2S8TIgtwU5Ky1NezPk66hKQSqpqUb0rYc+ezCKKZS
         qKSnaYnId2UxUJU5FYGGpIu2AFgT9mgYa2LcYRg5HIA6ZPI2g2QEI0KTvLGGwZvM9cjM
         byi5dmVtL3omKXt6meVdEJmiE466gI1sHy5DTpVI0XhjXjVLUZens9a95qIUPQB5efkt
         HMNw==
X-Gm-Message-State: APjAAAUV3URhgVK80Sr8eOMpPqK3MdAYpvaXwZW6J83y4pmS6+ZYybVS
        aE8HzNM8Sh5IZ0tYZzYGjuIEPPgfmFH8EUJ+yfM=
X-Google-Smtp-Source: APXvYqzTM+6QlpBrQ60bGZG9JAIyQ/yttZZ/JyGZKLuc/Zo11hZX3uuZPRk+Rv45Iz/diqpWhDiBn5dIrtE057jFwqs=
X-Received: by 2002:a25:74d5:: with SMTP id p204mr5333906ybc.329.1558331455487;
 Sun, 19 May 2019 22:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <201905201259.JxEFGvZU%lkp@intel.com>
In-Reply-To: <201905201259.JxEFGvZU%lkp@intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 19 May 2019 22:50:44 -0700
Message-ID: <CAMo8BfJnr8j+uqOAMb5FE4ParRYCURqfTdb_1kh0iaqboxpMdg@mail.gmail.com>
Subject: Re: arch/xtensa/include/asm/uaccess.h:40:22: error: implicit
 declaration of function 'uaccess_kernel'; did you mean 'getname_kernel'?
To:     kbuild test robot <lkp@intel.com>
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, May 19, 2019 at 10:39 PM kbuild test robot <lkp@intel.com> wrote:
> Hi Matt,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a188339ca5a396acc588e5851ed7e19f66b0ebd9
> commit: 7df95299b94a63ec67a6389fc02dc25019a80ee8 staging: kpc2000: Add DMA driver
> date:   4 weeks ago
> config: xtensa-allmodconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 7df95299b94a63ec67a6389fc02dc25019a80ee8
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/staging/kpc2000/kpc_dma/fileops.c:11:
>    arch/xtensa/include/asm/uaccess.h: In function 'clear_user':
> >> arch/xtensa/include/asm/uaccess.h:40:22: error: implicit declaration of function 'uaccess_kernel'; did you mean 'getname_kernel'? [-Werror=implicit-function-declaration]
>     #define __kernel_ok (uaccess_kernel())
>                          ^~~~~~~~~~~~~~

I've posted a fix for this issue here:
  https://lkml.org/lkml/2019/5/8/956

If there are post merge window pull requests planned for the
staging tree please consider including this fix. Alternatively
if I could get an ack for this fix I'd submit it in a pull request
from the xtensa tree.

--
Thanks.
-- Max
