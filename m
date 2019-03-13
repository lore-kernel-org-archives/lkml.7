Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF48AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743682183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMc+aucu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCMH0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:26:53 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45618 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMH0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:26:52 -0400
Received: by mail-vk1-f193.google.com with SMTP id v187so228696vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ae40H9IKfy3EMm0llrxMqpT7OdgTAt0+PtoohB5PGs=;
        b=KMc+aucuIhq/Gh7o57y4aFDq3K49QUFWDYkwDdr2j51k1vZwkU8jHpE1brcsHpm2D7
         6s1FOWjtDRkWygWSHu+iN/5yi92TfWptEKfSw+J6jzcvbH1RLS5F6OtZNzKUmSZMdDnu
         qv/W0RgnbfZL57zmLaHu3DbWP10OAMmxO6MA3qX/EXFjiGegMTbLDScPH9X71dEO9WyE
         By4YY7mfSzOpRM+o2uo3BIU9mVc/w267SkZL9foob4qEWRFB8rkLVPoSmzfghbvhusqb
         9TEzVCCcC0+BZhyEmk8LtwXVI+eKkG1pqLwMC4zDD2IVHjF4IDI3pZbeCGgNMnPYSBQG
         7Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ae40H9IKfy3EMm0llrxMqpT7OdgTAt0+PtoohB5PGs=;
        b=ZwZ+XbhkY6mUP2KqiwGIuNPpOZgxVXI9Nw+gFA5mlhrJBIemTMizV5l2m9wKk8PMho
         CdCiiFbWl/UpbLmjfNh+EU1PtH7faJs3cYEzZShd/HLhEecafIrriBLJKjelS4nI3x37
         761w7V9C08r87az+WPKGDqnobq8xMu+jMxlLlUFcPwH63KDyzIVYKqSdpVxTwvXKi5Gd
         50Usugvgjy/3BW0q6lKE2zIY/ZkjwQsjdCotm6CxpXx0+NTQpreaP9JoIxxs+hwjWpeB
         ZTXJ149SofAYF0jVXC7DYWibXcH9RgSnY6K6etzAQSVFNMBU2nKp0fiFv9nkpwUcztqd
         Fq5Q==
X-Gm-Message-State: APjAAAUMU5G/5TLoGPSZOBl3lLGPp+fgcYYMnlTqcSoQS3QiNFaKtNZA
        pY2UaaCuYsE58HE/7KxBuoeyccpBKc7FaHv9uL4=
X-Google-Smtp-Source: APXvYqyFhpTxaoT5By+preODqe0U6oa/FmaK4P3t+VeWJp4OFS1Z6Pd2KSKXFsc5cnIQ6mrCJeGuPQAxo+GcR0jp76E=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr15684321vkf.51.1552462011918;
 Wed, 13 Mar 2019 00:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190102004002.GB17624@shao2-debian>
In-Reply-To: <20190102004002.GB17624@shao2-debian>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 13 Mar 2019 15:26:39 +0800
Message-ID: <CAC=cRTO8RC0kEz9B-vx5sO=6uXwsu2tE9rd_NKH1XjVRr9easA@mail.gmail.com>
Subject: Re: [LKP] [ext4] fde872682e: fsmark.files_per_sec -38.0% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP ML <lkp@01.org>, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ted,

On Wed, Jan 2, 2019 at 8:40 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -38.0% regression of fsmark.files_per_sec due to commit:
>
>
> commit: fde872682e175743e0c3ef939c89e3c6008a1529 ("ext4: force inode writes when nfsd calls commit_metadata()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

It appears that this is a performance regression caused by a
functionality fixing.  So we should ignore this?

Best Regards,
Huang, Ying
