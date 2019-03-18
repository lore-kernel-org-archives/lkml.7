Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACDF2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552898738;
	bh=eY6UeMqNHFzUHcskmkSJLzlujj++kRPbwSLNPy3IP8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uIhjAyDyNvGMtWHb1bwylZbvuhbZbXD/ElvmkOC0s1JfvBMhuY/uTzDbCnZc2CYu3
	 FBY+TvN8ZhQaUhHNJoOAYkb/OV1jyR3pU/mDhBZGqkrwnDhGKCx2EkoYX7msDJqQPB
	 /ybP8+ay2sUhYFz0L156rD9fzP08zKuYqjO6dK+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCRIph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfCRIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:45:35 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F53021734;
        Mon, 18 Mar 2019 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552898734;
        bh=eY6UeMqNHFzUHcskmkSJLzlujj++kRPbwSLNPy3IP8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yKD15rZdzX7TK2tDg+pBq7G6TjcN7qxM9fTlYqbVqQYcO9eMS+ba/zlgiUERrP8GE
         O2wRWrylTo6a4zLTCHJABnVRbcNpuwFn5aO/UkNmbVN2I6+rGPuSeq0Xu+yHbSQoBy
         ZZ4VKxQNHwd1AssJlIxdIc/NpnBF8f2p6JlGdVH0=
Received: by mail-wr1-f48.google.com with SMTP id d17so15992164wre.10;
        Mon, 18 Mar 2019 01:45:34 -0700 (PDT)
X-Gm-Message-State: APjAAAWoQ7NP1agdBtkYXnU+vkkh667scNBftRMVH4/0XnraiXdnIsx4
        8zfMAjAL4UN7mf9A2gwVtVx1mZMkfv+mbkvFQ1k=
X-Google-Smtp-Source: APXvYqxaypGJAiWKT4MWTUcyVvwA75sk0mfZ51BDOOMgMTQBroeWSG8ai6opX6k7EAVzWP07rhdQc7XTyiIC6PUPNyo=
X-Received: by 2002:adf:c002:: with SMTP id z2mr7157499wre.177.1552898732921;
 Mon, 18 Mar 2019 01:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190318073354.12151-1-wens@kernel.org> <20190318073354.12151-5-wens@kernel.org>
 <20190318084212.lv2lorskizl65uzg@flea>
In-Reply-To: <20190318084212.lv2lorskizl65uzg@flea>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 18 Mar 2019 16:45:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v67H9FkjKjSE5a7fUCb_t95Zfuk1p0bjWYJxjMqhMN-hfg@mail.gmail.com>
Message-ID: <CAGb2v67H9FkjKjSE5a7fUCb_t95Zfuk1p0bjWYJxjMqhMN-hfg@mail.gmail.com>
Subject: Re: [PATCH 4/6] nvmem: sunxi_sid: Read out data in native format
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 4:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Mon, Mar 18, 2019 at 03:33:52PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Originally the SID e-fuses were thought to be in big-endian format.
> > Later sources show that they are in fact native or little-endian.
> > The most compelling evidence is the thermal sensor calibration data,
> > which is a set of one to three 16-bit values. In native-endian they
> > are in 16-bit cells with increasing offsets, whereas with big-endian
> > they are in the wrong order, and a gap with no data will show if there
> > are one or three cells.
> >
> > Switch to a native endian representation for the nvmem device. For the
> > H3, the register read-out method was already returning data in native
> > endian. This only affects the other SoCs.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I thought only the newer SoCs were impacted by this issue?

It is noticable on the newer SoCs. The old ones only have the 128-bit SID,
which could be read either way, as AFAIK it's just a serial number.

If you think we should leave the old ones alone I can factor that in.

ChenYu
