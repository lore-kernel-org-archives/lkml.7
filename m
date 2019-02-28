Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB972133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Se5rlmp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfB1Rcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:32:46 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51719 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfB1Rcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:32:45 -0500
Received: by mail-it1-f194.google.com with SMTP id e24so15916873itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4251BuI3Z8Zik5GGfOhH2367xey9++P7cRd01Ywp5f4=;
        b=Se5rlmp1qtrkxIi3LndMEBWygpmfAhjGlfBPbdR4o/dPD32ZGkEL6sRJ3qQuErMvcb
         trZ4VJLh/5aDUeiEknvU7DkaZp/LnCs8xK9HAaUp9h8XrEREO0dFhCmsnss4yXP3Hfmk
         RUZiknQcZgkeOjfboSKddy8hx9Bx4kFlE4Kco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4251BuI3Z8Zik5GGfOhH2367xey9++P7cRd01Ywp5f4=;
        b=BjQfrvpkxzpab0mQ0QurOIGDyvR+76r119A+GgKeQGv3WQgm4rdzGG7mRVxaAlAfKB
         h2DWcVGCn+sTH6Tj9pRBWZbr4uTfr1hLj7A7qvo1P3mj5wcL8FYWp50SOOsyabyzX4wm
         zWrXYOl/5391TdNa86z6+VPqxnHJ+qPDoo8x5/fBRrLhqtw6Q+LPpufnTdLjC/aseqcm
         zx/ehnCgxLTr6/JeXfSq0RQoPS8TLh2VzcpZdOM9zdZSyndtzFdZJlKsQX83qALBsxDx
         /NKwHqcMJHLv1jW2/cLNvULLfkwizAl6XYtsiUQUoAcpCXBoXcL/yLl8V0CvQY7caSiO
         wr9Q==
X-Gm-Message-State: APjAAAUJKpFzZHr8tdxvAcmW+BMHfWGw8+aASe5iTpEF9TYwcIEdWkLH
        OLCXVyjSBH108cc97lLeBPlQ41Q6n4lpZXq7ChbbN3qkFtc=
X-Google-Smtp-Source: AHgI3IZFDOgyFfY42FZbwb5q80bcZYGyzja0035j8JBE901Mkfe7HfgRF/eIqxY7JmTjWSdsVteXpTmBSLnehSOPKfc=
X-Received: by 2002:a24:3655:: with SMTP id l82mr590984itl.107.1551375164856;
 Thu, 28 Feb 2019 09:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20190212204109.3528-1-jagan@amarulasolutions.com>
 <20190212204109.3528-2-jagan@amarulasolutions.com> <CAMty3ZA401nRh+nqFUcVMOv+or8NWoYU+y72gUPONy7ovyqgSw@mail.gmail.com>
 <20190218202705.GA19088@ravnborg.org>
In-Reply-To: <20190218202705.GA19088@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 28 Feb 2019 23:02:33 +0530
Message-ID: <CAMty3ZCQY+BSAFe=8Z0X29nK9tRz+7s3BFTiAmQ7CD_eNTL-LQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Tue, Feb 19, 2019 at 1:57 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Thierry
>
> > Pleas let me know if you any further comments on this?
> No further comments from my side, and I consider it
> ready to apply.

Would you please pick this?

Jagan.
