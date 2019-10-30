Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC9CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741D32083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aKsZ4bdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfJ3WGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:06:23 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43045 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3WGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:06:23 -0400
Received: by mail-il1-f194.google.com with SMTP id j2so1433302ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7mK3Uoiwaws9OYl+5bVE084OvHB6LGX6Sfc0eSAjwc=;
        b=aKsZ4bdZUSBifwnA9EI/sfdmKnP62vGSwIqzhbMUiTCUkHM2p7iqF53Jzgdv5kXvv6
         GBFkJoqdRYLQIybUp5uZd8C9F7L2xM/7BvH0VitcMonLl80SQX9+/8cxz1Pb55faR4eW
         W84909D8+2Y2GxJriYNmqjYg9MaPiledZHFQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7mK3Uoiwaws9OYl+5bVE084OvHB6LGX6Sfc0eSAjwc=;
        b=i4I0otBkosKqjCQFbr8aMGrXJ3QVc6Y/bmxcPzQyJCH3I3qlYTXxyeFhyArYxhFjlk
         qyM2u8efBIdm8db6fOv2FB0nCaDNTvvGLvo55w9079Z695tEHD0VF9+POvWlPDYSsE2M
         DO8EK6+pGovVDNTmk2HcHSVNGHwglDTuxbmQ9YLga3/CZOwGZBA3iC7m3qDEuTcyASY2
         m6JzCW/iNC7hVRialdN3tZn5N+wCXSAIdg/PdH22443YGmDPOPzGk2z0Sv1Hw+Rwj44D
         sT+C1oTrJ8Fx68l/XMAllQKJ6ZQqEJTl46y8AbSSFQmU8UJHlI4Cp8aI04gyw94RuEk5
         xU8A==
X-Gm-Message-State: APjAAAVfwE8rqYIu/CnfRsTv39uKYQU5wfvfY39cK9iZC6ifXoJybL7t
        H74XZn5rBtLe6g86eP+PmYrF88R/DME=
X-Google-Smtp-Source: APXvYqxXsUNRqCZbku+KXV5t170QpBTIz+VRZPyfehC+jWghKPVA7pYFUDS4TfmqzF/7+GbrV2xKfQ==
X-Received: by 2002:a92:4555:: with SMTP id s82mr2543530ila.228.1572473181888;
        Wed, 30 Oct 2019 15:06:21 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id w69sm218828ili.84.2019.10.30.15.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 15:06:21 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h5so3530971ilh.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:06:21 -0700 (PDT)
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr2484026ili.269.1572472754921;
 Wed, 30 Oct 2019 14:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191030100618.1.Ibf7a996e4a58e84f11eec910938cfc3f9159c5de@changeid>
 <20191030173758.GC693@sol.localdomain> <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
 <20191030190226.GD693@sol.localdomain> <20191030205745.GA216218@sol.localdomain>
In-Reply-To: <20191030205745.GA216218@sol.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Oct 2019 14:59:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6Q3QZaND-tfYr9mf-KYMeKFmJDca3ee-i9roWj+GHsQ@mail.gmail.com>
Message-ID: <CAD=FV=X6Q3QZaND-tfYr9mf-KYMeKFmJDca3ee-i9roWj+GHsQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ext4 crypto: fix to check feature status before
 get policy"
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Chao Yu <chao@kernel.org>,
        Ryo Hashimoto <hashimoto@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Guenter Roeck <groeck@chromium.org>, apronin@chromium.org,
        linux-doc@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 1:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> FWIW, from reading the Chrome OS code, I think the code you linked to isn't
> where the breakage actually is.  I think it's actually at
> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/chromeos-common-script/share/chromeos-common.sh#375
> ... where an init script is using the error message printed by 'e4crypt
> get_policy' to decide whether to add -O encrypt to the filesystem or not.
>
> It really should check instead:
>
>         [ -e /sys/fs/ext4/features/encryption ]

OK, I filed <https://crbug.com/1019939> and CCed all the people listed
in the cryptohome "OWNERS" file.  Hopefully one of them can pick this
up as a general cleanup.  Thanks!

-Doug
