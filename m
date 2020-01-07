Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7EC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FDF2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VcnYI9Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgAGPsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:48:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38904 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:48:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so54518195wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKH9iM1/iG8zWx2xNV+zLPV8iovcpOyyXJoSIxqdbRk=;
        b=VcnYI9AkDcSpvZxqfakPF0VUIvVs6cdZjxpLiY4QgG7rkRNj1VtVjcVLvPw+ALUCoo
         gzKrXcOFdzaWRY7NS4FOUS6Sk3iQfoxdSNFA/KyV+fKOHLMQUaEIUttgA/eyGEqPGN4E
         ONMSnAN3TjRTrvBXa+e9K9twu69SAs/P43wss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AKH9iM1/iG8zWx2xNV+zLPV8iovcpOyyXJoSIxqdbRk=;
        b=fLP4SFAzin3OVtElRVsT/wOoLy+tzbZcQR4ZTDxfIo5jXBB0aFmEG/1HhMYNHXnt1S
         BE13HNQ6HmmaLkdwVRtutkC6dh+vu2WB32ERvVF4yb7ZGSCLdtk2u+7QYAHoR1IV/bea
         azI98BBCmeD2dCSlRI5mMkoM9PfEoAFD8Qz4aCiu6mYIi4OmhvLugQyMOTXs825a0VSv
         E5dJ/C9zHAYiVse52JSen3VOkQXjyuUgd8XGTESYYZRWrDyMTjytuGYJDrNOP9qqNExa
         266wpI9KRxP4IrSsLG3kp3LTRPdwvIwfl++c+L92u7LZSzFz74iqtfJJJ/MMvEAHc/N1
         NIYg==
X-Gm-Message-State: APjAAAVdMqvHuocN52QZZ0uHYPNzbKk3ytiR2/zcUYolrPPGZDS0mAEw
        qMprMWEl7fqz3jihnkH9LeY8/A==
X-Google-Smtp-Source: APXvYqzD68uooO7ZcoDZN1tshuC4uGYDnvSgRZJxqX3p24va63g3pm/AWE8wq12cU/IU5J8Nos3Kbw==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr109349448wro.202.1578412078158;
        Tue, 07 Jan 2020 07:47:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id z187sm39236wme.16.2020.01.07.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:47:57 -0800 (PST)
Date:   Tue, 7 Jan 2020 16:47:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>
Cc:     Rex.Zhu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, b.zolnierkie@samsung.com,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        david1.zhou@amd.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in fb_release
Message-ID: <20200107154755.GB43062@phenom.ffwll.local>
Mail-Followup-To: syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>,
        Rex.Zhu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, b.zolnierkie@samsung.com,
        christian.koenig@amd.com, david1.zhou@amd.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
References: <00000000000082b80f059a56da1f@google.com>
 <0000000000002074ef059a5c86e2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002074ef059a5c86e2@google.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 02:31:01AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit e3933f26b657c341055443103bad331f4537b113
> Author: Rex Zhu <Rex.Zhu@amd.com>
> Date:   Tue Jan 16 10:35:15 2018 +0000
> 
>     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs

Pretty sure you don't even have that driver loaded ... from the config:

# CONFIG_DRM_AMDGPU is not set

:-)

Cheers, Daniel
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e00000
> start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
> dashboard link: https://syzkaller.appspot.com/bug?extid=d130c4a0890561cfac5b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000
> 
> Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
> Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage
> support in sysfs")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
