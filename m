Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44147C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3D2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cfMU6fH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGNWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 18:30:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfGNWaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 18:30:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15104250wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJDoWZq1UfjuhWi9b+fXLGvlFZyrc6BPzhFLNvSkD60=;
        b=cfMU6fH7t9UEuZcu5zBBKYE9pQ3pWoqcYSCiKQxYXFe0ZtWhHmwymk0pbagzY89bQN
         D6K5j383ddSrBkHHHB5TXlQcWY4QX6XZswhEq1MeLLKzmvp/zbSKG8VkW0HLQywoCJ8b
         e7gQZbcVqlZknAQ5oIi8BZ6eAh0h3y0hRxTSboIXa3Db3PyLreiekwT8cYVvDDHAyDh+
         QvvQNsyWhyUuJvM7ul+H1rDCZ42vhsrBZlTxKip2dNN+eY9PITHZ3n+JsZKXjl/UxXU+
         en1IqLYrpXIVtEfWbf/8owY2PI8ikK5QQ+qK+hcbeXiZ4z8sbAdxCVv8rDzPnJrIUl1I
         YPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJDoWZq1UfjuhWi9b+fXLGvlFZyrc6BPzhFLNvSkD60=;
        b=eOzDNcDGeHAXgzmHGwvl6843bqVEGpb7NqijxKEzIjCufct4Szd/daCjr8pvEmVQ3k
         Rbnzk7/hRWeIpK+lUZK/QZnUu+x8tv4VHiI4qNnAaSGObK9Izg0mdy6ra7NdiNrU46iJ
         GJ4QyprTnBPaG7Q33LHzdf2N1KGFsBwHfr8q7WHZoKhKKwVSWLhw+K9A+qX6FwNtDO2o
         WPa2SMjgRmvNN5UWwJwRPUhk2WEoUxRHozTjqc59sa/sVOKOiQbZNt9nR+EKirQ9lk7g
         U9HoPPMVGjDx0qJ0x6Zc+PJLK0JBs6Yqp83iN8BgGbjXhKbdigO7ar6c5n9ph4t3q4Vq
         aMiw==
X-Gm-Message-State: APjAAAU+Lrd1W0p0eThzG+SpAjLs5o/x/OkT6SiDo0v5MHwGBwo9eGdb
        cU+rCqMNvD5EVYLLD5FGkrGiEyPb9LQ=
X-Google-Smtp-Source: APXvYqyrdTE5lv+5hjpxXbKCdc1uU3TeXHZJRPFUT/gTAkt8OFbX4wmYPDR7A0famaPgqkEVYEDrdg==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr17161492wrq.52.1563143418465;
        Sun, 14 Jul 2019 15:30:18 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id o20sm38752047wrh.8.2019.07.14.15.30.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 15:30:17 -0700 (PDT)
Date:   Mon, 15 Jul 2019 00:30:17 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] clone3 fixes
Message-ID: <20190714223016.5pzrlsasylcd73jy@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <CAK8P3a23y0UFbu-po-Umh-=9DUTpRyzRkB=RxJd1A+YJVTTGrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a23y0UFbu-po-Umh-=9DUTpRyzRkB=RxJd1A+YJVTTGrA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 10:07:13PM +0200, Arnd Bergmann wrote:
> On Sun, Jul 14, 2019 at 9:22 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Hey everyone,
> >
> > Here are two small fixes/improvements for the clone3 syscall that I plan
> > on sending soon.
> >
> > The first patches reserves the clone3 syscalls number 435 across all
> > architectures by placing a commit in the corresponding syscall tables of
> > architectures that do not yet implement clone3. This is done to preserve
> > the identical numbering for all new syscalls that Arnd introduced.
> >
> > The second patch dates back to a discussion with Arnd when I suggested
> > reserving the syscall number. Arnd suggested to ensure that we catch all
> > arches that do implement clone3 without explicitly setting
> > __ARCH_WANT_SYS_CLONE3.
> 
> Both patches
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks! Moved into my fixes tree.

Christian
