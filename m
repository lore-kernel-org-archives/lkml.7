Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73624C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FAA217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqYBXo2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfHFVgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:36:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45750 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfHFVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:36:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so42251151pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=sBUBN0HUJIZIc0mN4TKD7pQCJPPlngOTzkG4tsBEHQ8=;
        b=dqYBXo2iI80lp7HI/aQ+4TEJ3+6YGbaMGSLfCX5yRQ1xyPIxYYF0jAIw7jAvfmZck+
         VVVLR3JPxdakG9bGLYORyCDvj1r8IyC2mfFa5yNhZJJURLDPhGkEBlicdkSZTffCF7Pb
         mG8cqcnXLUN7eRzGjzFocQxh52GYsCIsE8hKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=sBUBN0HUJIZIc0mN4TKD7pQCJPPlngOTzkG4tsBEHQ8=;
        b=n2h2PAWL+sVc8tRmfxevXPad6WJzCctT05Bcyhtp1sHqtg/tXgJwxY89pEdPKiLxo6
         DEuhwM9Qlq/7ARKAN11b33MAWAxEOdY7uFvIi8oXfGa5c4WjY9EJEM96OYntCO9tr2g/
         yimNHiAI8mh1m9XtlMecvZkzzTt84ZF6VI/JXTBz+7J36sczYt9hF7d17IVjLm5egBPQ
         bzH8Ibu5rJZ7+B5alTm3rLdnP+V6fyBn7LrVE3CFkFp+X0ZViWw6Nl2ydvMCX7oxVGCC
         zI/+cEAiqwUQoRKE+hd72+tlxLVqutuCys31sSqWRElVHEGRAxNiAxXImekfqjoww7ta
         26Gw==
X-Gm-Message-State: APjAAAXypABXvq4c0X2ew8zBttTM9pXgI2y6b2L57AVVzikW+/TJn+gr
        EhDcMaBrWWkgBV+d/Am6cOBe4Q==
X-Google-Smtp-Source: APXvYqx2v/Npwsw5HQ1lbRkveEdPoaGHJWsJF/WOnckfF74AKjXuJJIAxEcpNUNzYFEXHu6vs59ZxA==
X-Received: by 2002:a62:4d85:: with SMTP id a127mr5858389pfb.148.1565127406818;
        Tue, 06 Aug 2019 14:36:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u23sm91643036pfn.140.2019.08.06.14.36.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:36:46 -0700 (PDT)
Message-ID: <5d49f2ee.1c69fb81.881ec.1cf7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190806204752.GG17747@sasha-vm>
References: <20190806175940.156412-1-swboyd@chromium.org> <20190806204752.GG17747@sasha-vm>
Subject: Re: [PATCH 4.19] Revert "initramfs: free initrd memory if opening /initrd.image fails"
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>
To:     Sasha Levin <sashal@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 06 Aug 2019 14:36:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sasha Levin (2019-08-06 13:47:52)
> On Tue, Aug 06, 2019 at 10:59:40AM -0700, Stephen Boyd wrote:
> >This reverts commit 25511676362d8f7d4b8805730a3d29484ceab1ec in the 4.19
> >stable trees. From what I can tell this commit doesn't do anything to
> >improve the situation, mostly just reordering code to call free_initrd()
> >from one place instead of many. In doing that, it causes free_initrd()
> >to be called even in the case when there isn't an initrd present. That
> >leads to virtual memory bugs that manifest on arm64 devices.
> >
> >The fix has been merged upstream in commit 5d59aa8f9ce9 ("initramfs:
> >don't free a non-existent initrd"), but backporting that here is more
> >complicated because the patch is stacked upon this patch being reverted
> >along with more patches that rewrites the logic in this area.
> >
> >Let's just revert the patch from the stable tree instead of trying to
> >backport a collection of fixes to get the final fix from upstream.
>=20
> The only dependency for taking the fix, 5d59aa8f9ce9, into 4.19 is
> 23091e28735 ("initramfs: cleanup initrd freeing") which is not too
> scary.
>=20
> Is it the case that 25511676362d8 shouldn't have been backported to 4.19
> for some reason? If it fixes something on 4.19, I think it's better to
> take the dependency and the fix instead of reverting.
>=20

Ah thanks for taking a second look. I missed that we call free_initrd()
in one more case when unpack_to_rootfs() fails and goes into the else
statement. I suppose bringing in 23091e28735 ("initramfs: cleanup initrd
freeing") in addition to 5d59aa8f9ce9 works just as well, but I'll defer
to the persons working in this area.

