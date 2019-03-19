Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AE820863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lKYO/dvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCSRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:11:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37490 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:11:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id a17so18061818ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BZxT4/FFuvu4yPHmqde50pmWQhZvfQoeT6hoCt6Jjw=;
        b=lKYO/dvyIfEsJBUzEB0cLCTuS4jM+/7rVJ5gwW4KFHMKdnwL9ZnFC2urC2C79bZBI3
         0wQ5fComSD0fBVDczOYKKDhYgWke51omgTeGnrt9kwPo19sdREb9Bnnm2IgtAQ73nF9b
         F90889XziiGX6VR2NsWR+WU9jeDvJ0cjwAOU8fsw37ZIyUBUYQGWLC2/7Z0IjQ5FZZuX
         lS0JPAYWgp/uui7PR7IIP6k6xcHD8nXRAmRu7XNByoUh88qiCYwAayd4rZObgG+vdes+
         O9GiZf4bVaUd8vX1MdQo3Dixma+aiHLN5/G36RB/QnH2zjrRj2DinLXTh42+zWxw4HK1
         p/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BZxT4/FFuvu4yPHmqde50pmWQhZvfQoeT6hoCt6Jjw=;
        b=tNOAAUdJ/2dW+1hmoS3TusVlu1KNaFhDA4ILPEHlMkhsKbT84L7vtOHZBkHONxia8T
         XTyaH5m7fQmN1n/tI+GFhUWQHzGOsL7vyAyixIcms+B7THKB6pYok7rcX7LdEgwRdpEq
         SeeAtFA6dYJQ+S/jfy81urlFa8C2qKnVU9/TsShY6rqYhTIyO53fhF0aN1Ux0JyjaB5s
         vE4esXozivp0EyV+3zYNtWgR1Wbq59mDROthhUoe01Q/nhQ6AuUEyp2GRJZqA7ohYbn8
         4LGaDzw2IwYBfgemGOHBTrVkiYzEh6cxxtCTb6WlfkFNHSyrcLrGnNLgRxsyquulogeC
         iPxQ==
X-Gm-Message-State: APjAAAUuRWfYN6IOpet29AUPdP5fcCmWzzQ+S8FmGamGtMsahMfc8y3a
        IlscI6jL/hds5ZKGEcT7wknuFgEYZtPWGpChxDwT
X-Google-Smtp-Source: APXvYqwaswCPJZnXpZA/HSoGHA6bawfXHtPtm9BjbfUPs/GClYzIpdzvZYGYJlsBTW0wdeabZmlpqJNMjTmuaaqIwwQ=
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr6499930ljf.95.1553015481638;
 Tue, 19 Mar 2019 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190319124034.13ff6044@canb.auug.org.au>
In-Reply-To: <20190319124034.13ff6044@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 13:11:10 -0400
Message-ID: <CAHC9VhQB2OECVhgQNmwikBNs=RwC+Of7kUFLfUze+Dp3WYu2Gg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the selinux tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 9:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the selinux tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from /home/sfr/next/next/scripts/selinux/mdp/mdp.c:35:
> /home/sfr/next/next/include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No such file or directory
>  #include <generated/autoconf.h>
>           ^~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   e37c1877ba5b ("scripts/selinux: modernize mdp")
>
> I have used the selinux tree from next-20190318 for today.

Thanks for the report, I just merged the fix below into selinux/next:

  commit ccd19d4cafaaf36132c372e77ee9304b707c1e70
  Author: Stephen Smalley <sds@tycho.nsa.gov>
  Date:   Tue Mar 19 09:21:06 2019 -0400

   scripts/selinux: fix build

   We need to add the object tree include directory to the include path
   for building mdp in order to pick up generated/autoconf.h. Otherwise,
   make O=/path/to/objtree breaks.

   Fixes: e37c1877ba5b ("scripts/selinux: modernize mdp")
   Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
   Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
