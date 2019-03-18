Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD152086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q66cPKdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCRDGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:06:43 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:46771 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCRDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:06:43 -0400
Received: by mail-vk1-f179.google.com with SMTP id j68so3430227vke.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S08EWlyIiw11CAl4rcCV7UD2pvFPYI+nvogh/obEu7s=;
        b=Q66cPKdt7dmowtxuN8nI5I0aRNXhyp0moq52V6+YX2YweOVOorq8C1edkVWWq0MBGz
         DPumjsNJmqezZIAPMePKZOFO6dtp6BuKKaK6n94WlRtZgMWeGFY0xyk8IBFiBkdHvUEf
         7jZr0zyCQ9i6YwzhOxr5SFWHDdnFGPF3Ox1uGJuWiBJumeCwt8CtPN4bbQpWP1R80BPH
         UKWczTrZ8XTF1uDAmKyX0zZsZlKwc5uF62mwNKGmgCTNu4zlwYrheOYXJXimF+oIUOid
         0/T4DheGG7dG3FAnZjVpx5gaNTtMXfYDRP5wMN7NAq4WN5/c5bxitWbUkA8Cff6pLYhs
         h4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S08EWlyIiw11CAl4rcCV7UD2pvFPYI+nvogh/obEu7s=;
        b=jlkOdnBF7ZlYazV9JDhmeIoZzCre0G9l/PrIzI1bFF2BWxLpfZuTgRFCI5syPo3I9j
         G9PLzz1oDwGNxwigGJGzwPaXVF5JkImOKzrNQowdN0U/CC7/nxrAelm9UVPWpqEjGHmc
         iUt5J63o9z8T31oJOcivQzMB/DZmtu37C7jtpiUhAp6nAfYsY3EugWcyaPP+WOoEMACx
         6F9LGJLJipumBSNaiNVnn2xpoWPNKqkkrQ4mDsOheU3taeNVylE3lpjMykbjghRzxVWb
         jeG2OCxc+u3uqK4AEGndRSwhow/CpeF67e9USd17le9iHuPk3mgwGy9ZErxoxBS7VnEv
         WXxQ==
X-Gm-Message-State: APjAAAVf7kco710le9G5UlqLoCOo7WiSZb93fi+PzAdNzEFhkWa7vQVV
        l4msy3o5zW9I3CTgF+CYpVjYtUVea868oZsqnYA=
X-Google-Smtp-Source: APXvYqy8iM6OKI2rhdWaKI4Z47+8djtPhHYMs1RhiNsHPk/1aQCqemNbMTSWJaAjAoGe5cDeN0qF85/8i2Js/NTz6mk=
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr7896822vkq.92.1552878402057;
 Sun, 17 Mar 2019 20:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190314032047.15790-1-vichy.kuo@gmail.com>
In-Reply-To: <20190314032047.15790-1-vichy.kuo@gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Mon, 18 Mar 2019 11:06:30 +0800
Message-ID: <CAOVJa8F8P-NC-xT3bZ8-kJwH5sS=hG4WGRu7Mw5ZQdcwGT2EZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, Catalin and Will:
>
> in the previous case, initrd_start and initrd_end can be successfully
> returned either (base < memblock_start_of_DRAM()) or (base + size >
> memblock_start_of_DRAM() + linear_region_size).
>
> That means even linear mapping range check fail for initrd_start and
> initrd_end, it still can get virtual address. Here we put
> initrd_start/initrd_end to be calculated only when linear mapping check
> pass.
>
> Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
> Changes in v2:
> - add Fixes tag
>

Would you mind to give some comment and suggestion for this v2 patch?
If there is anything that are not noticed, please let me know.

Sincerely appreciate ur kind help.
