Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7AFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B059320879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="OG+FV0Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfENPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:40:35 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46933 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:40:35 -0400
Received: by mail-ed1-f46.google.com with SMTP id f37so23461851edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoeWrhlpyL/PtfeSforodNbUO2D7CZqKr1lDbVMDE8k=;
        b=OG+FV0LtlLMgmxpBp5sORd2PhG23czKuCX8KiE3TJEl8Ip2BxDLPWdM4OB74dVB3ls
         0QcdRp9EMy/cipAGWvWvFn01qJhwVhdan2lJ9Qrb36p3yuIb5xcT+BUMjgr/nvFL5UJc
         PIZIhChczpaOCKbLGyHh+gu+Qkvf5OY1XsHAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoeWrhlpyL/PtfeSforodNbUO2D7CZqKr1lDbVMDE8k=;
        b=LHlbiOAV5Vy9hjVg7whoBosIjuUB5NBhiUxOmAQSoV+HLiqsQGjvcXXP6kHzKxikhz
         8SYGbzL1zRVnR7bVXg39HFoIS1i3FZFrWh0Vxf3Y2ImMN1wvXjk6ic+n6RnJSdZz4dZW
         oXLmIv18D2huvHLZLBKmfVTe0P9heEsWS6Xr5dTIvn2iMJSrZeMuIS9kxOC6CTmDkv2U
         pcXxxFnbqm9WJyeqpG1V/v751SM9w5TCCUJ0RKLaJQV0T0NfXEfM6CfV57zXAB/csd5c
         n73J2ziNkyLrRDggSM0+HKX8Z7kuk4n7mS5TYdi/ZDuUOzJlMe6+XWPguMO6ra1MprOl
         JzIg==
X-Gm-Message-State: APjAAAXPOfJewM6JZuI7B64wxyEJi6zdDQfp24p4ljcu+IDCQJO6sTnw
        +Vz3BRYfYrTfVrpX1My5z9WkUIQXfziB2bNtWkUv7Q==
X-Google-Smtp-Source: APXvYqz4afOhoNfwX+3+zPjhDZ/7R5DYWA5Jc6tM9kJvjkru5alnyUYFoo3qNJUjbwWu1dHONpEI2tdqutwfRfTmzBA=
X-Received: by 2002:a50:f4fb:: with SMTP id v56mr38328249edm.13.1557848433450;
 Tue, 14 May 2019 08:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <mcmahon@arista.com> <20190513160335.24128-1-mcmahon@arista.com>
In-Reply-To: <20190513160335.24128-1-mcmahon@arista.com>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Tue, 14 May 2019 08:40:23 -0700
Message-ID: <CAJieiUgHp_uhaH3rL783Ch_PNDq1cVeb7aG+bHerUR7b3SwHZQ@mail.gmail.com>
Subject: Re: getneigh: add nondump to retrieve single entry
To:     mcmahon@arista.com
Cc:     David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, christian@brauner.io,
        khlebnikov@yandex-team.ru, lzgrablic@arista.com,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mowat@arista.com, dmia@arista.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 9:04 AM <mcmahon@arista.com> wrote:
>
> From: Leonard Zgrablic <lzgrablic@arista.com>
>
> Currently there is only a dump version of RTM_GETNEIGH for PF_UNSPEC in
> RTNETLINK that dumps neighbor entries, no non-dump version that can be used to
> retrieve a single neighbor entry.
>
> Add support for the non-dump (doit) version of RTM_GETNEIGH for PF_UNSPEC so
> that a single neighbor entry can be retrieved.
>
> Signed-off-by: Leonard Zgrablic <lzgrablic@arista.com>
> Signed-off-by: Ben McMahon <mcmahon@arista.com>
> ---


I am a bit confused here. How is this different from  the below commit
already in the tree ?

commit 82cbb5c631a07b3aa6df6eab644d55da9de5a645
Author: Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Wed Dec 19 12:51:38 2018 -0800
    neighbour: register rtnl doit handler
