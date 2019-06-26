Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC212147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="NjgJOZQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFZN0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:26:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44434 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:26:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so1558832lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KQNsn2fCmYitiDv9gkNd7pWrAY8HVNXqrIMAFIYMEU=;
        b=NjgJOZQI/OY7TPBgoHm3D6Ry2QJNB0nWXc0QO3Y/AkulA6b6x+4s07J6po52HkDEYI
         9J/z9rxXHc8JWuQbQsoWS1T9uOphoAQrhpC0dfhmfm0UgaGuTeiOaJaD3mPn+hEaAvPi
         1gT+zh2HDcwd2D880J4ulsETR5gWrqkvu5b5ufYiWntVh9jp8BN2fTnpAQZJW5cJBnDR
         zxujoB0IlUBTZgJ1Zg4DctC6+uuN1b4IxwlDSrI1Roeq3t2hdUendNPOgFMnQynDC9Nm
         4rTSCrqxrqWiCQV7Zse2njjzpojDiJ7nxY5eRW+cmjAv/5nnnPheoK1E2NENiZtEt68s
         l7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KQNsn2fCmYitiDv9gkNd7pWrAY8HVNXqrIMAFIYMEU=;
        b=jAgEuiyAE2/pmQekovSDRaxQJ85qBkFvp/Y/+Y2zhWrR6gL39a/aoLsoEISUhvVZjY
         14yAmsaf3eEVa/2W5H6DnfL70Bhg8d8QsaEM/2muuCkmwotslbdMfIXjwD2ryvFDCM3h
         Wggf1O5/HJ7D8MYh/0+ktOfEvlcjV8BxIpx5tBClUKgI6+We5uHcnFB8LLvW/AGq3piS
         41DjTqSrDzfpvKWHW8gUYCsQJx7A4B5pKCCYe6w6on59Ub//p0RQ4euIE858ebdwDtfd
         mdRdA0CJns3r97HJCGfEnMOY9BaGzL/QlAxTWl2MyVeGWjl06OINAz++2XY6d8CnImI1
         FcFQ==
X-Gm-Message-State: APjAAAVI/dQ4u+3JUsWBvOm3SDIVaddACcVCXAcqvVpP3nwdHGIAnsKT
        RuoLQjTfcCsVP3kKrewNlXMxTQWGqPgMEBN6ri0LNg==
X-Google-Smtp-Source: APXvYqybuKo1OFuGMvZFtMATVhgvwQ0TaQVnkAkxGJ6JbLBBP+WfwR/5MF8aidBvBHtvBRNzwMnOhbAikP47ncpNnJ4=
X-Received: by 2002:ac2:495e:: with SMTP id o30mr2678993lfi.140.1561555600322;
 Wed, 26 Jun 2019 06:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132427.12615-1-colin.king@canonical.com>
In-Reply-To: <20190626132427.12615-1-colin.king@canonical.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 26 Jun 2019 14:25:34 +0100
Message-ID: <CAPj87rM9y5Zen5A5KkiCqqUF5m+vAwwtLj-iJrcwFfzMev+Mrw@mail.gmail.com>
Subject: Re: [PATCH][next[ drm/amd/display: fix a couple of spelling mistakes
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Wed, 26 Jun 2019 at 14:24, Colin King <colin.king@canonical.com> wrote:
> There are a couple of spelling mistakes in dm_error messages and
> a comment. Fix these.

Whilst there, you might fix the '[next[' typo in the commit message.

Cheers,
Daniel
