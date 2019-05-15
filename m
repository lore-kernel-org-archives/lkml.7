Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F805C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06E520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe53eolI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEOJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:05:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38792 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:05:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id y19so1392580lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dsiZB9nVEVR8ihY/V7TPcVlkfDTLZU7ZnIyB9Kdlm0s=;
        b=fe53eolIL/3iYiMnsq+1fXzykGVvwxyKevubcWnZKt5EOSxiBQCaqTTbU78kF7PCXa
         +wvCfluF3bI+I5OUGCPYwR+gay2dlzf3EpA7is3C+xg78U4Pqkq7xLZzxfpfk9lHHCJy
         0SyuK1T0jYk4EsY4slOaWmzfR1U8cFZoZisIiYr4DgnAonBW8ltQIGkSPq5QxQa7d3tS
         D6oohPDjEAy9t/Z4APcbjRMzuXxiNWlEewbgc+fLtQM8MIQI7oeuAHZ65SbYeQnzru/U
         tx+dU3PcZ10l8JzPDzWlmj/y2BXvWX5DVtSnGknVSVfo3/FX0vfTIIAqxPAs+oNHOv8W
         IxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dsiZB9nVEVR8ihY/V7TPcVlkfDTLZU7ZnIyB9Kdlm0s=;
        b=TbN/7k/ERPSkInSb2fZJo8uh9PPVFYwhkldrQZcuKELxrRedWkZEHdKY4V2q1kEpqT
         t15XVZ0Qa0xkgtXKCuCPhEJnaXX8Yg8QevC+96Uq8U81y3uukpEGpWcr8KfBcFnU6GYV
         cB+I35x12xQ8R+1mhCu1VIDcazOyDG27/ZEvDvqzq5nT888CaDqy5F6aNawa+8ki22Y1
         ub3fiakhop1kgZDI0qGVEgyd3Sv4QBYlz6/fL4KlJb23BO3nuFlRI/uB9xpKhnI9/SA7
         vK3N6PBK/qKHwlOtLVFDugC9L+7iYI1GvVE5jQSxc3uXrX+tPq0stI9QzGO14GIJKtZY
         iccg==
X-Gm-Message-State: APjAAAUNbbKyk22MU7S5iy3mjNeRP+6IPlx/aoQD77IBi86PL2Fei+lD
        V1k+VRk96bmeutzzgVmiWKQ=
X-Google-Smtp-Source: APXvYqxk8AMzC4DKr6czDtY/cExV67S3F3wZiIOy6PKstKBlhndOD4EYhMZcM28Xe2C1SIWv1DsFKQ==
X-Received: by 2002:a19:711e:: with SMTP id m30mr17636859lfc.106.1557911119589;
        Wed, 15 May 2019 02:05:19 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id f11sm272370lfa.48.2019.05.15.02.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 02:05:18 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 807AD460442; Wed, 15 May 2019 12:05:16 +0300 (MSK)
Date:   Wed, 15 May 2019 12:05:16 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/5] proc: use down_read_killable for /proc/pid/maps
Message-ID: <20190515090516.GB2952@uranus.lan>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:41:12AM +0300, Konstantin Khlebnikov wrote:
> Do not stuck forever if something wrong.
> This function also used for /proc/pid/smaps.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

All patches in series look ok to me (actually I thought if there
is a scenario where might_sleep may trigger a warning, and didn't
find one, so should be safe).

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
