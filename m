Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2CFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4FB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S60IcC8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLKWJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:09:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38302 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKWJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:09:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id z15so430412qts.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7d7WsbP3LoU75+WuemV9UlLvjwYU63WdP9k7hHQzFM=;
        b=S60IcC8q2ZKHlkDtHhETX2BprZm1KILkOpTxAFaysmnH1ZUe5PKiDzDAbQA0+L2aG5
         jGoaV42u5oEaJmjpcsbN+sT+pm6ZJSgih5K4iICnmqQ7Ofcygc/D7shmAAtbrZH8Vanz
         iz2lsJhsiZjz0UfO25zlNcbayx9quiDGiIur4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7d7WsbP3LoU75+WuemV9UlLvjwYU63WdP9k7hHQzFM=;
        b=qm9/8kfyLojcPSJTVGR/ug2vtNQInSOwsHrr0vDarZk6/T9ZMW/1aYgRd2MJyjKzzl
         E/ubckgBkXfTegPTQaKDvbsBMtL4I6a8PxwFZDMHJjRkMBeQcfT1OsGKaK+gvL57cGD5
         KdasAWqkKIYmAf6wq8M3lDbeo+4ZE+fcuypqjDo3JgvknX8INJRy4J/xd+5XOnXrjiya
         2R2WcdhmPbHEzecA1bcdsDf4b79JUwuTvrWpSIBZoyeOqJrRrazd+4hkAckNwGY12l0O
         97/VDts1hljW9xMFZqP4mMwUZBM9Zm4RiVG/qGcGHKwjWWJNphtn7s+0NiNw2PS+aAD6
         jd2w==
X-Gm-Message-State: APjAAAXcE/RJqqVD4BtZQsAI0iqjom0NBLMZMemu8ElXrdhdfwJ5AV0w
        MdNyYFiQxAKwz41xg7xRUrqiK/u+TKxmdpi9Bc5f9w==
X-Google-Smtp-Source: APXvYqzIan/p6MBZBXr7KxGgHZna/XiKYTqTn0jrIbFub78HgMIxWvp4zsQZYS6tItRiacNkgg/lWajfwPljnjTUUZI=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr4934746qtb.278.1576102161712;
 Wed, 11 Dec 2019 14:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
In-Reply-To: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 11 Dec 2019 14:09:10 -0800
Message-ID: <CANMq1KCTJQL+GFqo8HYM8cEpzXJmebJ=9ju4CzHLwyuQfbZEAA@mail.gmail.com>
Subject: Re: [PATCH v17 0/6] support gce on mt8183 platform
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Quick question, any reason you picked only patches 2+3+6 from this
series, and not the 3 others?

Thanks.

On Wed, Nov 20, 2019 at 5:54 PM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
>
> Changes since v16:
>  - naming the poll mask enable bit
>  - add a patch to fiup the input order of write api
>
> Changes since v15:
>  - rebase onto 5.4-rc1
>  - rollback the v14 change
>  - add a patch to fixup the combination of return value
>
> Changes since v14:
>  - change input argument as pointer in append_commend()
>
> Changes since v13:
>  - separate poll function as poll w/ & w/o mask function
>  - directly pass inst into append_command function instead
>    of returns a pointer
>  - fixup coding style
>  - rebase onto 5.3-rc1
>
> [... snip ...]
>
> Bibby Hsieh (6):
>   soc: mediatek: cmdq: fixup wrong input order of write api
>   soc: mediatek: cmdq: remove OR opertaion from err return
>   soc: mediatek: cmdq: define the instruction struct
>   soc: mediatek: cmdq: add polling function
>   soc: mediatek: cmdq: add cmdq_dev_get_client_reg function
>   arm64: dts: add gce node for mt8183
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi |  10 ++
>  drivers/soc/mediatek/mtk-cmdq-helper.c   | 147 +++++++++++++++++++----
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  11 ++
>  include/linux/soc/mediatek/mtk-cmdq.h    |  53 ++++++++
>  4 files changed, 195 insertions(+), 26 deletions(-)
>
> --
> 2.18.0
