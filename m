Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfDPJJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:09:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfDPJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:09:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1F17C26070C
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
References: <20190416143030.07537982@canb.auug.org.au>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3023bc2f-950f-0f78-166a-b54542cc3680@collabora.com>
Date:   Tue, 16 Apr 2019 11:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416143030.07537982@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/4/19 6:30, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the chrome-platform tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> In file included from drivers/platform/chrome/wilco_ec/debugfs.c:11:
> drivers/platform/chrome/wilco_ec/debugfs.c: In function 'fops_h1_gpio_open':
> drivers/platform/chrome/wilco_ec/debugfs.c:210:59: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02x\n");
>                                                            ^~~~~~~~~~
> include/linux/debugfs.h:45:29: note: in definition of macro 'DEFINE_DEBUGFS_ATTRIBUTE'
>   __simple_attr_check_format(__fmt, 0ull);   \
>                              ^~~~~
> 
> Introduced by commit
> 
>   db6c540a0018 ("platform/chrome: wilco_ec: Add h1_gpio status to debugfs")
> 

Fixed, I need to automate my builders a bit more to catch these things. Sorry
for the noise. Thanks.

Enric
