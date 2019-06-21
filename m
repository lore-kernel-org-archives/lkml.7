Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5DBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951AA208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561136311;
	bh=qcAmA6iF0AIm7/tu2hMQ8OQryWmpvx9GB4nsOh/Bb7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tvhMwyS/pnlrrmDvJCa/NgBBTGCu423HPMQ+bWC/dfDmS5JHbtWBB0uIsV6Mcfwk8
	 hsUB9lH1QfwK6ugRHHO3aCsOgPppyK0KLMjpDLyvnsYCFi5wTZBI/OnHeoY/fWSHvK
	 IDHf+3wpNn/MumwORoj/kgNuXh53EscCF55TkjXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFUQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:58:30 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34659 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:58:29 -0400
Received: by mail-lj1-f170.google.com with SMTP id p17so6610831ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqgwigxeGvjK7xvfQe9Dvq5Cf0ZDiG37Tc57yFWJcMQ=;
        b=HLPSctb6nl32d222OwEgCE8oXMwKKjmA5QJ5svDz1qmhQDBKuR4ch/qK2amWcD9BAr
         nwk3pIDezfn/h8eg4B6mI5VTRVMWDjnPVhM5AN5msZa2mEd0pBEChghfh/EjDx6RAgZM
         MFQltZWhYR0PlHn4Nr0+9mdGGZV+iUXEPTUNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqgwigxeGvjK7xvfQe9Dvq5Cf0ZDiG37Tc57yFWJcMQ=;
        b=V65HWF+O0/1nMOf1UAag6f4kSSFVXG0te8DJzw3QfuDinKuqsaHTFF2zfL8msjSV8X
         18Vcong76PfXi0B2/JlVO+Kj6Im4vtOdr/gnjyuVdW0Uxo0a9vEBmPCg7fDzwVYApNxa
         eT4IUntang+Pv8nal8awf9MJoqrC4UCC71WnlzgPXgQmSG/bTMHNdWQlXXWh50gnNxcf
         3dceW0P0sc4Az0QFClU6qE+7NtDWwxSH8ONUm3lPfl+qUTCwcH9WLdPIRBZDhiYU36VT
         qJQCzwaSkzRFf5fghjfq/LO9YCzApk1umQdGv3ZUfB2wVj8R+Tg135UWcTNzUUX8K7W9
         0LxA==
X-Gm-Message-State: APjAAAV1XlrThhrUo2GS1vAafqsQYKYvUCvjwXy63SwGL0TyhnEJ4Lz/
        wVnJzl2ByAaEOgJ0arFFwepm8oxG/DY=
X-Google-Smtp-Source: APXvYqyUT4yAEiM5wmEgqF0V1kglPNcoRq/9DC/kssp5Msut5NW/b5xqkeZvtlwaSi3/P8wCOArllA==
X-Received: by 2002:a2e:9d18:: with SMTP id t24mr45175579lji.2.1561136307253;
        Fri, 21 Jun 2019 09:58:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b25sm459924lff.42.2019.06.21.09.58.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 09:58:26 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a25so5582286lfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:58:26 -0700 (PDT)
X-Received: by 2002:a19:f808:: with SMTP id a8mr5270618lff.29.1561136306025;
 Fri, 21 Jun 2019 09:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
In-Reply-To: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 09:58:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifNAnkd+bXfoNWXO1K5NQ8Tr+Hc13SgaBXU3RoQB7Pwg@mail.gmail.com>
Message-ID: <CAHk-=wifNAnkd+bXfoNWXO1K5NQ8Tr+Hc13SgaBXU3RoQB7Pwg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.2-rc6
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 9:21 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Just catching up on the week since back from holidays, everything
> seems quite sane.

.. well, except for anongit.freedesktop.org itself, which seems very
sick indeed.

Does it work for you? I'm getting a connection reset, no data.

               Linus
