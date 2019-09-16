Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45035C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1555C206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SiThYn/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfIPE11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 00:27:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36246 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfIPE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:27:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id s18so35048457qkj.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XoVOeFGGpV3NsaCJeRAeZx/5oPFfdQGr3uV2lPYd14=;
        b=SiThYn/jHEgjXTKt5tFheJ16F146aA4+g3/oEFUFc9xnOzCIkEkMsfp0W1k/bNvkO2
         Sble5sCBKiFAuTBst2wmEIh7L10XbYxXYXtEetW62FKP788Uv1+uiezj3/272jW5UD8v
         3qyAjU54jI6b/4xDNAV7pW78rOJq+UpM3Of5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XoVOeFGGpV3NsaCJeRAeZx/5oPFfdQGr3uV2lPYd14=;
        b=aPkpK05tlhJSao9+0zDDF7p3ub4as4I3J9kw5bqOOYWX3/3v35EaMtayTsQjBosneg
         iRN/C5475+pY7x0wM/veUw9CAzxXuav5wy6wJjhk3xyoSx9HwlJ8GLHYVcZPCA5op03o
         DUce4noC3SeOu+q6ltzudgkN8tYRoCnjvj2F6/sCXaBJa9WJ7B6W1kl96mg+G4c3cPuB
         B515dLiBwc/F5q4lSBH7BvtGFJUy/8BlAgm+Tcz1uwgi1yGJmchYxKyeFOvgbbL3a9pI
         XBQ9MJ5itpNu5tzX+fNa76qAQOXhAcIyeIWXjwbYLXxgmta9I6zOOJhYSogRDNqn+Zy0
         7dzg==
X-Gm-Message-State: APjAAAXcVUzRooPtnMqoIYqINuxTaYqJ0b8Zm0kP7Dw++e11ljNDDkDH
        5pv8rzhy1Tm8C4mw5nScTNTO8zVdSAOPJAgTj3ikYg==
X-Google-Smtp-Source: APXvYqy3B5SLSjcNbHTRQV986urbgzRFhAJlX+7JHJVf+p+Rdmhf4pmAdsFzzlWtstjEUkxHrDwxjI5SO425T5cQqFE=
X-Received: by 2002:a37:4c54:: with SMTP id z81mr26591697qka.18.1568608045551;
 Sun, 15 Sep 2019 21:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190912090404.89822-1-jitao.shi@mediatek.com>
In-Reply-To: <20190912090404.89822-1-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Sep 2019 12:27:14 +0800
Message-ID: <CANMq1KBdZmGEO-MH33mhc4wCheJE2TBiUAXtt=YVr5aARDpiJg@mail.gmail.com>
Subject: Re: [PATCH 0/3] add panel driver for innolux,p097pfg with ssd2825 bridge
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        cawa cheng <cawa.cheng@mediatek.com>,
        =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <bibby.hsieh@mediatek.com>, CK HU <ck.hu@mediatek.com>,
        stonea168@163.com, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao,

On Thu, Sep 12, 2019 at 5:04 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Add driver to support panel innolux,p097pfg with bridge ssd2858.
> SSD2858 can spilt dsi 4 lanes to 8 lanes.
>
> Jitao Shi (3):
>   drm/panel: panel-innolux: Allow 2 reset pins for panel
>   dt-bindings: display: Add documentation for innolux,p097pfg_ssd2858
>     panel
>   drm/panel: panel-innolux: Add support for P097PFZ behind SSD2858

I'm the author of at least the first patch, and at least part of the
third one, so it would have been better if you clarified the origin of
the patches.

Also, I do not believe that this is the right approach (this was
always a temporary hack that we had no intent to upstream as-is), we'd
probably want to add a proper bridge driver for SSD2858, and allow
arbitrary panels behind it.

Please consider this series
Nacked-by: Nicolas Boichat <drinkcat@chromium.org>

Thanks,

>  .../display/panel/innolux,p097pfg_ssd2858.txt |  39 +++++
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 140 ++++++++++++++++--
>  2 files changed, 164 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt
>
> --
> 2.21.0
>
