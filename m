Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17DE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BmDj/yVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393051AbfISVlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:41:03 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:32964 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbfISVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:41:02 -0400
Received: by mail-ed1-f48.google.com with SMTP id c4so4565096edl.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEP4asvWahvB/ByMxaI4e4W6i3Uh1P6APAc6QuG8yno=;
        b=BmDj/yVXQI1xNehGBnaYafRi6EGb9bKgZd31R41qDqeJeU7zMho89QecXC+w2uIsh2
         06xxE6KKmvtBFgXmmxpi8gh0LjFMbEHLCkAMiBsQcYWYdDXd6CHyYwfani0b8ENaleZq
         5+x/lDA7+CqTzQa8/5dvIrCX9BmVycjFGxTHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEP4asvWahvB/ByMxaI4e4W6i3Uh1P6APAc6QuG8yno=;
        b=GOlYIltP9UUPNrTKDxfkYHa8Umf/GvxVofBRdEu86KUGBEBOv1VjN5uv5MHyMjPp9k
         5OnLr5KRQ8GshVXQod3l33/c8XzskpzC4C7J1h1gPnAcrJiAfW7FRjS1NikT/ZIEv1iD
         BvbjQxNgaE+DHvpC42TiwGZq7oqgWXjvrh6DuLGMtf61qDGNvPGA6Vx+xXacUTkYs7Nx
         Q2oW0+V/CEV4lM9NCr5vlM5rGrT5/8Ku5GGORKrWEyprc+KNMA6RHksUFktfyjiIDlVu
         UOc85aQlukNuhZ867h9GxyXIQWexfgYEm3WQdNLl1+shDgLnt/F3yfIFQDJJfn9lGfFg
         ftmg==
X-Gm-Message-State: APjAAAXYgkUvYMvm9hKID0WZCA5D7P1ifBxZXk7zKwA5xJ5tp6HID5AM
        brRuTORaJPAHYegogwRsr72zTM2rnH8=
X-Google-Smtp-Source: APXvYqxNF4z6pcjzLHlj8dLGNTJzXKzkdZVvRX2AUjNDugXQWntUdk53ngG+aZH6OPlXpvXiVHxXmg==
X-Received: by 2002:a17:906:fc2:: with SMTP id c2mr225273ejk.261.1568929259099;
        Thu, 19 Sep 2019 14:40:59 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 60sm1850855edg.10.2019.09.19.14.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 14:40:57 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id b24so28545wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:40:57 -0700 (PDT)
X-Received: by 2002:a1c:110:: with SMTP id 16mr27409wmb.88.1568929256997; Thu,
 19 Sep 2019 14:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190828183758.11553-1-rrangel@chromium.org>
In-Reply-To: <20190828183758.11553-1-rrangel@chromium.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 19 Sep 2019 15:40:45 -0600
X-Gmail-Original-Message-ID: <CAHQZ30AGSxmjn4q6=bi6dJO1uSdpcG5jPGfUX7R2t2489qt9gw@mail.gmail.com>
Message-ID: <CAHQZ30AGSxmjn4q6=bi6dJO1uSdpcG5jPGfUX7R2t2489qt9gw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix struct init in update_bounding_box
To:     amd-gfx@lists.freedesktop.org
Cc:     Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Nikola Cornij <nikola.cornij@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping for review.

Thanks
