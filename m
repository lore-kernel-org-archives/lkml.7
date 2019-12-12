Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EACBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90C124671
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNYnQoHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfLLSlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:41:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34283 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfLLSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:41:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so3901689wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=72YajA1rnf1+0GYcRZg+w7DqemoBrj7bzh2eLFUJiCE=;
        b=jNYnQoHT9D/iVwOUAeI1nYXpjIriEoi9Dw5l2o9FH2p/aEb+0YBuSa9axL/yreKfaq
         di+zCTiZj7gbHshdS5Y93GwwfD+rw3u9hwsdKLLlXyPe6zNVmCpaM6zIgdU+T61xCM3c
         QYv9CuD4Q6beHt6nMaR8GNpKLwk7obh9YzSAUv8VeCaG7hmhxaanGMcrSYbV7p9nQtHD
         UVDWO+7uAryoOkuMcvyKqw2rhgfRREpsAwjdP9T4wxgCQygIN5MAaPN0Fb8g/chmATOv
         06WVcz23ABetfzmtG5CA+MjyvkWTR9T0uJgs9jT7ZMiv96jiGpktQluK+X/M1YQ5U8Uh
         YVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=72YajA1rnf1+0GYcRZg+w7DqemoBrj7bzh2eLFUJiCE=;
        b=fKN1zkGYxJR2vapfwGPF0C87S2Fz7vpHbSG0rYr9WaloziDwQ5fMW1ABz/g5677sTb
         t6w96WeFvHmeXeqEn9AEPeF/Yjka+6OwYvLKKBnsPuhw7GXGF/rhbWlxFhgA6WZmwczN
         tzfL5U97NL3rNcZDcVPqRMpEjbpgAc7gFO0t9qAn+K4tFeMzWDEXGNI/De0tlvvrV/VN
         JBYaCIkNxg3Y4YLMVOqFTrI+ee+FuOYWuiZZq9oQUyAz8JN5B6XhXVDFYJiy6aRwvLZf
         q3dxd0AN2Xy0RxPu7c2uYfUfXIG3Igh0mOYua7IrYBbtawwlTmiUeisz9gK4CGV7NvQV
         RKxg==
X-Gm-Message-State: APjAAAW2QWWXpdrcmWGMiGT2GfJ/8A8/LsGms+BVnED7kYRNkJ3uo14q
        c5ZheAD1n2KIIfGl3qnZvXA=
X-Google-Smtp-Source: APXvYqx8ZThmxV87EE0UzwxMrK2+QTlXaMc9wq2IkRJkHgaXl++grGfqBwQvYlBMrQV4hI1I2Y1oUw==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr8246259wro.105.1576176108476;
        Thu, 12 Dec 2019 10:41:48 -0800 (PST)
Received: from localhost ([5.59.90.131])
        by smtp.gmail.com with ESMTPSA id k8sm7056412wrl.3.2019.12.12.10.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:41:47 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 3 PID: 1 at =?iso-8859-1?Q?=5F=5Fflush=5Fwork.isra.47+0x22c/0x248?=
Date:   Thu, 12 Dec 2019 19:41:46 +0100
MIME-Version: 1.0
Message-ID: <8dec2d95-f483-44a9-8223-0f8f3de33238@gmail.com>
In-Reply-To: <5708082a-680f-4107-aaf8-a39d76037d77@gmail.com>
References: <5708082a-680f-4107-aaf8-a39d76037d77@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 12, 2019 12:09:21 AM CET, Vicente Bergas wrote:
> Hi,
> since v5.5-rc1 four equal consecutive traces appeared that seem related to
> rockchip sound. As i wasn't sure to whom sent the report just added
> everybody from
> ./scripts/get_maintainer.pl sound/soc/rockchip/rk3399_gru_sound.c
> which is the file containg one of the functions in the trace.
>
> By the way, sound works fine. After all traces, there is this message that
> could also be related:
> [    0.625354] da7219 8-001a: Using default DAI clk names:=20
> da7219-dai-wclk, da7219-dai-bclk
>
> Regards,
>  Vicente.

Please, ignore this email. The issue has already been solved with
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=3D=
for-5.5&id=3D4bf2e385aa59c2fae5f880aa25cfd2b470109093

Regards,
  Vicen=C3=A7.

