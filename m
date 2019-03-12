Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4821C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D172147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yrtpo0mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCLJDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:03:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCLJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:03:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so743340wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MzAeH8ZZDgRnZstP+oYaRCw8ZuFV+ggLOGU+WEvN84k=;
        b=Yrtpo0mkPptAvmBsK14Ux4K6hX+OE+aiY3EVVHVo4emfwBMRgVVBlJSbk2WTNY4ZC4
         3/YtJHiwLC1J4JiF0QDbuLuXUoTO6bFAb6s3q3zsxSA/HF5pWiBdR+ScaC4qRmYg5eR9
         DQ2Ht/JfK/sKEFhNMmaITlnZhwAoZwO/ZYkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MzAeH8ZZDgRnZstP+oYaRCw8ZuFV+ggLOGU+WEvN84k=;
        b=diQDmkhdmmBewvJcQSMq7YVCpqR5UqriQLnd6blHuF7WvrYo55Q+tSw8S/qQS5uaeb
         NKULgIv1ZflgmYvKmf24+kUxZf0cZKvt3QxCeIY8es5l5mXq7xC1J6B2IE8AwpUpBQNa
         ZY+KKUD+Sens7rDQ9mLbvLa7zCQ2ylVoV5guDpDS2MUDtu0TKDLKrjvfwbodFcXfNB9G
         breXrFbFh+RMeUdneo3bSBf8Xq0K8duwcjl4pn9A59wMTuYj+YjrlT110SOuSE58QqRF
         ps36sHz/+Z1ot219ZbSUT1CjQQdZXl2BsyVWgJEPcsUc5I76BsUx/LMf974BJZzizyMA
         HPVQ==
X-Gm-Message-State: APjAAAViiqytPTewPVKCQ1qb6M/Ddct9riMbhuOEJUpJSZyV5WncJT0i
        a7CNKaK6aOGC9rgngleBIJ5qT3kA6NQ=
X-Google-Smtp-Source: APXvYqxwsrY2sJsPcqBn/pgamR3wMM4UDPAEZg8JD1pBMOP/+08UC91k5f6kixHEKL8UfK+D44rmrw==
X-Received: by 2002:a5d:6a0c:: with SMTP id m12mr4653685wru.57.1552381392166;
        Tue, 12 Mar 2019 02:03:12 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (84-236-15-74.pool.digikabel.hu. [84.236.15.74])
        by smtp.gmail.com with ESMTPSA id b133sm970255wmh.35.2019.03.12.02.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:03:11 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:03:09 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.1
Message-ID: <20190312090309.GB30899@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.1

Fix copy up of security related xattrs.

Thanks,
Miklos

----------------------------------------------------------------
Vivek Goyal (2):
      ovl: During copy up, first copy up data and then xattrs
      ovl: Do not lose security.capability xattr over metadata file copy-up

---
 fs/overlayfs/copy_up.c   | 59 ++++++++++++++++++++++++++++++++++++------------
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/util.c      | 55 ++++++++++++++++++++++++++++----------------
 3 files changed, 81 insertions(+), 35 deletions(-)
