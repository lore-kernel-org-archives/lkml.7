Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC809C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A324448
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6yWGboP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfE3Czj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:55:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33767 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfE3Czj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:55:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id p18so2961949qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXC4kHzYwJGnl8YXVUWx0puoDDwpLZgED1hwjltNjg4=;
        b=K6yWGboPMYwUdNCjC32JmzZHDaPsR9bN4M9bMJOWj6QNjlo3n58nUVIKLrzji8AhDW
         7QezzgWoWhv/YRJ2k7nX4f7ltYiLhEMyhrCUrbTEXlKVqJC0bvB2UyywYyuaFizo68zv
         ugWTtb5QNrzFd7wJvqKR8eeF8DfRbkXiaWjn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXC4kHzYwJGnl8YXVUWx0puoDDwpLZgED1hwjltNjg4=;
        b=INCDXETz4Y1Q+oAYnk0xvZWRwzwczJ+kSvC7yRvhK94etDZ6NbFfM3WzmikfNadEu1
         JIS8DWtJexdywoc34ilyH4t1pFRB4ZNcthKe/kGM3MC8MJiuTDIRYme9MyioYufuXsbr
         C9ps5yUvqO6+tC04E+wKdpa9e6ily58G3jM41y4nsgSxszJUNQbNOgFtu0+tbP71YClh
         OOTQmJty5T1sx0m0Cp0yNv1knxT6U2bc5mYfPjjUFRRlb0AyK/mmi4/e5m0O8hDOFdql
         h9U9zAVlSKeUOZSn8DJQ1K2krVxTZlbw41bzUlRwokJ71Uo1ypC/xgw8PmDZDa5ObjQq
         Ieeg==
X-Gm-Message-State: APjAAAVUo1oPVyHkLHYs1NveDCN+Fzbs1OpNhlm5KYHTSRCt+T+phTQQ
        oYnxmQvwdnKYPdDN/4PFMOL4yYu2jYsdJ8vD72DuGg==
X-Google-Smtp-Source: APXvYqwbvVCUHkyZ1UVrW3CoWKtkXaSs4V4XiLDBo7b0pM95AINVAYXNQOY+l2q5rzTV9S+lLKzvEUHvy1askLPhD+c=
X-Received: by 2002:a05:620a:1425:: with SMTP id k5mr1062627qkj.146.1559184938564;
 Wed, 29 May 2019 19:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190528073908.633-1-hsinyi@chromium.org> <1559033586.5141.3.camel@mtksdaap41>
In-Reply-To: <1559033586.5141.3.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 30 May 2019 10:55:12 +0800
Message-ID: <CAJMQK-ir9J-JN9DDZPBA1nVkJUZ_6A+fY4fA6jx6zOh_9q5a-w@mail.gmail.com>
Subject: Re: [PATCH v3] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
To:     CK Hu <ck.hu@mediatek.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 4:53 PM CK Hu <ck.hu@mediatek.com> wrote:

> I think we've already discussed in [1]. I need a reason to understand
> this is hardware behavior or software bug. If this is a software bug, we
> need to fix the bug and code could be symmetric.
>
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2019-March/018423.html
>
Hi CK,

Jitao has replied in v2[1]
"
mtk_dsi_start must after dsi full setting.
If you put it in mtk_dsi_ddp_start, mtk_dsi_set_mode won't work. DSI
will keep cmd mode. So you see no irq.
...
"

[1] https://lore.kernel.org/patchwork/patch/1052505/#1276270

Thanks
