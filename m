Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF98C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A943C2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c75jPblu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEAQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:37:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43997 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEAQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:37:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id e108so593539ote.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOL/hDvBnc7rmGBE1EnGCKIi8mO9oib6E1dFquz5h4Y=;
        b=c75jPbluZAl8W6FXzvNlmsZ0hn9bJOhswQdaPn85lp942KF8fyUY6DCj19iNroLLEA
         9KJm6G5HuxpDsdZmHjYaTomJ+WqkDyPuKIhBuHX51/zwB0DI9EuFpUay0wfb10rtuo1O
         YVbqWBBweiD1SgVsqtBjPWTnTr7rbME2IZgME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOL/hDvBnc7rmGBE1EnGCKIi8mO9oib6E1dFquz5h4Y=;
        b=FCrAS3DX86N2oZr7HXvX87lTRhqLxto8jDma3sE/aiKbKqXooq8HodWjzr4sPkF7Mo
         svC0DefZcoUYaGO+71w6Vh+r0gCfPqWq8y7jZiYZws6OkhAtpcbINdyuLpZw53VsV9xO
         eK4jANUevJtAKmIQ/JNeeFxw8RAhgnqlOxW/aK/Gtg7hSf/VoVSkWxGXSmUfxSpRyeSj
         atUcI4oGbS3F+0aUfXWtGAjRNEOt5EhuLIEHo2C/95ksW9G8DTuiKE2v3xzHpixqiAH0
         nth/87pS4502jOGA1hr5KYy8tw0yLfSfLK96diD+FUsNnx3N+va0tDR3hG80+k6ugaT9
         XiXQ==
X-Gm-Message-State: APjAAAXSDBqHZfWZxA0b6LZ7yQmKUZtheq4QblJ9Xoo2a94q1w2HaBGr
        cTicAP5JRYc4C4TN9zosU6IoK2Um5GA=
X-Google-Smtp-Source: APXvYqyZARWjqqZ2+jOzbjmJvMStIVj51KUVgoEUXB+NQcsHLoB2wG4HXAwnk+PjqUakMQCEiaxDlQ==
X-Received: by 2002:a9d:5908:: with SMTP id t8mr6729987oth.45.1556728649595;
        Wed, 01 May 2019 09:37:29 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id e23sm15924156otl.61.2019.05.01.09.37.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:37:28 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id g24so10630893otq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:37:28 -0700 (PDT)
X-Received: by 2002:a9d:30f:: with SMTP id 15mr16646743otv.236.1556728647806;
 Wed, 01 May 2019 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190422180754.99383-1-ncrews@chromium.org> <20190422180754.99383-2-ncrews@chromium.org>
 <22ee5583-58db-39c8-5273-34f1a4ee190d@collabora.com>
In-Reply-To: <22ee5583-58db-39c8-5273-34f1a4ee190d@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 1 May 2019 10:37:16 -0600
X-Gmail-Original-Message-ID: <CAHX4x86jGf9diGJhdBmqQskPxCFOLzVKHrP9F8LbHp-JpJSpCA@mail.gmail.com>
Message-ID: <CAHX4x86jGf9diGJhdBmqQskPxCFOLzVKHrP9F8LbHp-JpJSpCA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] power_supply: platform/chrome: wilco_ec: Add
 charging config driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, jchwong@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric and Sebastian,

I sent out a v8 to address Enric's nits:
https://lore.kernel.org/patchwork/patch/1065815/

Thanks,
Nick
