Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14934C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFD9227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avEufOmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLTFSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:18:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLTFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:18:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so8131023wrn.7;
        Thu, 19 Dec 2019 21:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=4+wjQc43o9dT8sTyzqXcM6Q5iP3S8TVqsdDe6tdjj4c=;
        b=avEufOmY9TC+QOYLEgyqg95h5vYO/m7RDU38Gy3ATTR21z31HogXAhp+6OVQdZMhQ4
         ojwSVAAW7MmS0mh8ZqtQhAGDlu/GmIw1GNYXLGesyyFPnSFQkWMu0hCbKLT88O//JbC6
         ME4WdeEZGMZpUwMVvpy5YtXvR3vyy8K6UO5Z0uvjMikM2gDA5xVkYR4qjfqdDdP1HOW4
         VTXJtyTT4Xzj13jTcRLWu/x+Bnq87PIjVmbXS8SbNZ4VE+IybIDciXmU/jvf5DM+dPnx
         utF1+Zia1DjNOzbYdIg1hv0GbiDMOjrUE5c3aeLlg+ShiTWUvqcEHzNUaGcW55u2MTj/
         xE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=4+wjQc43o9dT8sTyzqXcM6Q5iP3S8TVqsdDe6tdjj4c=;
        b=EYcv4kbFHcypJhZUGonf9gigyJLHSUvOOez+yNxpZfdghLaExZvzeWPCR6NaGlFiQb
         nF9RSASbFn3iXfeujFymFRy5L/ZOmG1c74rV2vQHcmdNpLbtY/q8bbET4KlfYhoI483A
         UsztoKWTeTqgJLtFt4g15vZnsyP/iatSh3F3S0q3unGgUCsMQ7T7h8w/7reW2O3DyUDA
         KMnWHZGw1Mmc3KYXxzUW9I7PisP4bK6MMDK3iVsoWNThOkpn8GepBjPm67IvDStXOET3
         hHDu6uxwU8MAXhgu3UmGrAL4jm3JwPTKpHYU7HnyOWxP/HW2XyZhLHVyR2jXLuJv9uly
         LW9w==
X-Gm-Message-State: APjAAAWy+9tY8f1DIFUegfvVYc3Y3hWZTFUMPEPg9J8qCxl0zbocHUUh
        6k61R43JEheq10qrY4u/Fw4=
X-Google-Smtp-Source: APXvYqwNlJjJ9tox9SPxML8q+PqF9vyoai/IiFmR2JQafLxBihNEdpp+nJ8qR061hlM3FBT2wZnQlg==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr13414279wrw.233.1576819126081;
        Thu, 19 Dec 2019 21:18:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id b10sm8626987wrt.90.2019.12.19.21.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 21:18:45 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, brendanhiggins@google.com,
        sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sjpark@amazon.de
Subject: Re: Re: Re: [PATCH v6 0/6] Fix nits in the kunit
Date:   Fri, 20 Dec 2019 06:18:31 +0100
Message-Id: <20191220051831.25296-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191220050121.24334-1-sj38.park@gmail.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 06:01:21 +0100 SeongJae Park <sj38.park@gmail.com> wrote:

> On Thu, 19 Dec 2019 16:37:28 -0700 shuah <shuah@kernel.org> wrote:
> 
> > On 12/11/19 7:27 PM, SeongJae Park wrote:
> > > This patchset contains trivial fixes for the kunit documentations and
> > > the wrapper python scripts.
> > > 
> > > 
> > > Baseline
> > > --------
> > > 
> > > This patchset is based on 'kselftest/fixes' branch of
> > > linux-kselftest[1].  A complete tree is available at my repo:
> > > https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6
> > > 
> > > 
> > > Version History
> > > ---------------
> > > 
> > > Changes from v5
> > > (https://lore.kernel.org/linux-kselftest/20191205093440.21824-1-sjpark@amazon.com):
> > >   - Rebased on kselftest/fixes
> > >   - Add 'Reviewed-by' and 'Tested-by' from Brendan Higgins
> > > 
> > > Changes from v4
> > > (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
> > >   - Rebased on Heidi Fahim's patch[2]
> > >   - Fix failing kunit_tool_test test
> > >   - Add 'build_dir' option test in 'kunit_tool_test.py'
> > > 
> > > Changes from v3
> > > (https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
> > >   - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
> > >     set default value of 'build_dir' as '' instead of NULL so that kunit
> > >     can run even though '--build_dir' option is not given.
> > > 
> > > Changes from v2
> > > (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
> > >   - Make 'build_dir' if not exists (missed from v3 by mistake)
> > > 
> > > Changes from v1
> > > (https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
> > >   - Remove "docs/kunit/start: Skip wrapper run command" (A similar
> > >     approach is ongoing)
> > >   - Make 'build_dir' if not exists
> > > 
> > > SeongJae Park (6):
> > >    docs/kunit/start: Use in-tree 'kunit_defconfig'
> > >    kunit: Remove duplicated defconfig creation
> > >    kunit: Create default config in '--build_dir'
> > >    kunit: Place 'test.log' under the 'build_dir'
> > >    kunit: Rename 'kunitconfig' to '.kunitconfig'
> > >    kunit/kunit_tool_test: Test '--build_dir' option run
> > > 
> > >   Documentation/dev-tools/kunit/start.rst | 13 +++++--------
> > >   tools/testing/kunit/kunit.py            | 18 +++++++++++-------
> > >   tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
> > >   tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
> > >   4 files changed, 30 insertions(+), 21 deletions(-)
> > > 
> > 
> > Hi SeongJae Park,
> > 
> > Please make sure your From and Signed-off-by addresses match. I tried
> > applying these patches and I am seeing warnings.
> > 
> > WARNING: Missing Signed-off-by: line by nominal patch author 'SeongJae 
> > Park <sj38.park@gmail.com>'
> 
> I tried to reproduce the warning on my side using 'git am' and 'checkpatch.pl',
> but those doesn't show me such warnings.  Could you please let me know what
> command you use?  Or, you could simply ignore the warning and use 'SeongJae
> Park <sjpark@amazon.de>'.

Seems like 'send-email' has ignored 'From:' in my original patche files.  I
rebased those on latest kselftest/fixes and sent v7.  If anything wrong, please
let me know.


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
> 
> > 
> > thanks,
> > -- Shuah
> 
