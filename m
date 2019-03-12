Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5CLgleb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfCLStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:49:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLStK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:49:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so3870363wrs.8;
        Tue, 12 Mar 2019 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NA/EOJELzXKnvvWlFYT+E/rD0WQrVgx/MZwKV0NqSkA=;
        b=M5CLglebF0mieCp7oZYm9x+qH+iFgZN7A5mTgNrqlTfwxjZx2wn/ffsk55SUy+ha2P
         ROJJ6KYhdTd9U9hFMih63WUiKhOpfcFVYp1InKvYAy5Zv1Khv5sKZwyQTRBszJU9UZq6
         K+6xODLsEZ/8iNhyagyPNiWF8g9PJWL0NucYmVJjgAePii1WaAl3pTR5bPQATstI0Kaq
         zORW3pihZJw9wNith6oarLNOH3NATrTeWd6VikVAHgjesny6xST+zM1Ag7Zuab17NFZz
         i+7xX2Kjkdypv0hP8ZznoMIkxB6ZNoSfySSxv9GOlF7IA3A/KlS9O2JUkNCsbQhtv9cF
         34FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NA/EOJELzXKnvvWlFYT+E/rD0WQrVgx/MZwKV0NqSkA=;
        b=Tyd5h+TbGyveKN+CkUdW4dfMH5syX5zVofRh6uJWtVETsXy1UqxA+G6yOltDUkBnnI
         C8EW9LOlivPQMww1YlK99hKrsRTJVZOrKbn+G6Y+oaVNlVQE2qQrUeBdHfW9qC/r0YaJ
         jtfmrHvDSJIBKw/CgKES55aocQfCxDL+UcwIeh3hEoF9+a1ZHewh/MOW+3pCxibnwRQ4
         WukCw541qCj3M7mr83cdDPYsaQClnOHoLBx1ALPTLxxyB6MGksaWPlR2MX1KDMlzp2Uz
         yJZNP1KWAV/vU1ldcnUohrAGnB7uIGGKy9oWxrAY4tY6GeqPRJdm0KtprcUGKyO7efZC
         sEEQ==
X-Gm-Message-State: APjAAAUE0XHYMOOTGX1fQN4pLi3Z6DRjOPGIebul+fE2TiRYM6QAdtuv
        CqXl9+dwEeQ2WZQUb2C/XXJGdmxWYO/a84fIfyY=
X-Google-Smtp-Source: APXvYqywgFg9Im8VjS2IbnAntyqrMmCVGCVsvAjqvVkUQuBllv2q2/4iXn/je7e3EY/aaHh4/qQBb+ws8TPrM/FcmG0=
X-Received: by 2002:adf:ba12:: with SMTP id o18mr26621630wrg.326.1552416548559;
 Tue, 12 Mar 2019 11:49:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c8cd:0:0:0:0:0 with HTTP; Tue, 12 Mar 2019 11:49:08
 -0700 (PDT)
In-Reply-To: <20190306224113.24853-2-jbx6244@gmail.com>
References: <20190306224113.24853-1-jbx6244@gmail.com> <20190306224113.24853-2-jbx6244@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Date:   Tue, 12 Mar 2019 19:49:08 +0100
Message-ID: <CA+z=w3XtC-_rJsE5oYKzQdiXteHyCYM2ya1Q+unRO2UBDz9BHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm: rockchip: introduce rk3066 hdmi
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would like to add some "Tested-by:" tags.
Is Rockchip or someone with RK3066 hardware able to test this patch
with a HDMI TV or DVI monitor and give a report?

Power domain doesn't seem to turn off the vop and hdmi in v5.0-rc8.
The bug is due to a patch revert earlier this year.
To shutdown MK808 one can continue to use the patch at the link below until this
issue is fixed by them.

drm/rockchip: shutdown drm subsystem on shutdown
https://patchwork.kernel.org/patch/10556151/

[for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
https://patchwork.kernel.org/patch/10714725/
