Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A87C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0968420709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Uw7IDaRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:38:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36884 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:38:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so6550167ljg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ny04lhAVNIULrfBpZhO5VcAHqzBDDJ5pBM6lI84KV5I=;
        b=Uw7IDaRh+nOcy8K9buBuxba9lOBogk/ws5fb3LJBttaDslNFXVLKQKRaY31iAiZu0h
         cErijldB8ypl+n3xrCR31wOmFYFl5MlxZucRoLaqhjXtbWsEYVRoMwFeK7WVQ2dzcs8a
         20ixjkfh6Wpf+PyCbVJVSyOMs40rMxDFW6GTLaeZ+f5i/dHMZF7vGmhc5aprOtSWtz0Q
         G15eyMIj20zxMirmEFCwmIhmNOtw1O9SdULHdW4h1DNwYbyQzIh0ncDvvPDv0jKVV2v8
         PbCCtO7BXM+cjETAlKEcT4xkWfOPrW9CXFdnIC4U80Apv6A36F3dVPWkMhiOQg0r26HS
         C2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ny04lhAVNIULrfBpZhO5VcAHqzBDDJ5pBM6lI84KV5I=;
        b=V2ymxaSWA4MX3P5X+B96e/nVsQeM1xu+rsTmRC7+ZHvWdn34ZNDzuKpujygoB33Llv
         aoRrM2JK+nGp1HciX8pdrwRhp9noexZ6AG4hFCeRTp+GANnnhw7GFFU2LSMgd9bDnoHN
         imBMjiDkP5BWdDKXBncCfSLwi3J1WjvC36eH/UHtaqOKqXwS45mDcFLTOtUT+enjt7Q/
         ouvMP4QPs19ivwOqB/sBqv85UFAGSmhki1uJUsBIktMG3VULaa4O592DLqq3W6knpLxw
         K5Ewv4EA083BKq+mOHvT6fKsYvpuGLGjI43CliJxzAiFFcLj1PIqK/KnV3ioUC9lgqgf
         ICUQ==
X-Gm-Message-State: APjAAAW3qSHfbyx8DsId348Z89OnZ4cKQ9PofOUu+aje5b8j8u3OfWjo
        KjOnfWbbGFEmxVnpN8+SpT/lGtOX4QBzyvldgGaw
X-Google-Smtp-Source: APXvYqyFlRwV4FD8ips+n7kQ7dPz3Uevw54PJr2E4X4dV9/id4+HDR5MJFciz6tXbFmHHaqu33YEYNWX9fliLPqk15k=
X-Received: by 2002:a2e:8188:: with SMTP id e8mr11474700ljg.57.1577111884984;
 Mon, 23 Dec 2019 06:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20191223091512.GL2760@shao2-debian>
In-Reply-To: <20191223091512.GL2760@shao2-debian>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 09:37:53 -0500
Message-ID: <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
Subject: Re: [selinux] 66f8e2f03c: RIP:sidtab_hash_stats
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 4:15 AM kernel test robot <lkp@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 66f8e2f03c02e812002f8e9e465681cc62edda5b ("selinux: sidtab reverse lookup hash table")
> https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
>
> ...

Jeff, please look into this.  I suspect we may need to check
state->initialized in security_sidtab_hash_stats(...) (or similar).

-- 
paul moore
www.paul-moore.com
