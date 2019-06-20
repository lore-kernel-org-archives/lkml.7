Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D9AC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC6B2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="f9xwjH92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfFTUHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:07:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38830 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfFTUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:07:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so4346061wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RfU1Hknmojux+IVGlJVcimM6SZLRtUFMkSWlx6MpZm8=;
        b=f9xwjH92YLxEqLA2Gac3BLzW8ln/+WixuL2e++rz/p9b0wcGXJ4oiFtXjP8PP/7lFV
         xANSmHAqcDdV4YifC7O6dxsJnklI3dZGWZHWrlKQG4glqdL32g+ZmeoonwzCyNqjxtRs
         /degJ+zRJVonRXCzcv02o0XmPfP9tzNGI7P0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RfU1Hknmojux+IVGlJVcimM6SZLRtUFMkSWlx6MpZm8=;
        b=ckA7I9ZNN4hB7+wcw3S/V6bquRlb2qZPx7DEEn5rEFDe8HdXN2C6po2wMa+KV5MT+K
         wT23+XSOAMBSwDLH6GVbu4Sr2GaQK5zbXMccOsSTwZiMoVXR1zOlxWnB4RfI35KcOZXK
         Bwwsi2onOofBXXPw5wsl7W9OPtu2Fu6EMcn6YfwaUrBV1VUqkjxjtyPSu1nyMZAemqnB
         GSmuaaqTT0TYYBRYqbv5aptQAYO70zgng7zV3Uebp/z+RHGOySth8bHHtAXdJLzEvAxc
         tg5Ca3+3Jan+fJSh8OPV/o6PIaPwP4zdd8YjUSo7ZiGEB4GAAz2UlW9aqelPJGGftl2z
         QS4g==
X-Gm-Message-State: APjAAAWjS8uD8FBsXO+sXnHgB3sLxYnv5JsyqE1mK8odWpymNvMNgEpQ
        004pQCEcM7zrFo3YfzSbQfksQg==
X-Google-Smtp-Source: APXvYqxMDgTpOVzO9SzO9IASeizCj4iR2lNwOplQUQwZH4plnJXEy+o+aQV0j09AVb2qCyKmBsvqBw==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr795818wmf.19.1561061266686;
        Thu, 20 Jun 2019 13:07:46 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id c15sm615441wrd.88.2019.06.20.13.07.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:07:45 -0700 (PDT)
Date:   Thu, 20 Jun 2019 22:07:37 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.2-rc6
Message-ID: <20190620200737.GA10138@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc6

Just a single revert, fixing a regression in -rc1.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      Revert "fuse: require /dev/fuse reads to have enough buffer capacity"

---
 fs/fuse/dev.c | 10 ----------
 1 file changed, 10 deletions(-)
