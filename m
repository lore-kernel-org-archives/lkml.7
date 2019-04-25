Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CCC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F127206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556215396;
	bh=+4Gq1yABi7UPuDvXewVrbYiBCkxY6P3/cgaVjng3pxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wi8zD2iDHDg+Lt8UiIte9pbsF5G1bes9BvM2CE7ujrEl5wiu1OVxpZlkJ+mgxHO9a
	 gnEQbYY3gufr8zUa/cXlerkRvouj6CSV1HtmaA/f89+1w+1RHfhdLXaOoz9P9KxD2O
	 tfFIQNc+qKFP6jfYOZEE7uKVGXcUCogyVFepIXJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfDYSDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:03:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38736 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDYSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:03:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so457059lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyZAYSHu1LajQMoMWHpQO7QvTyyTgInrg6r4Gak6t7c=;
        b=Dy0sWirr0QwFOPm0eDuzgyxTW2b6C5hpX6p2HWdQtlXDzV3j2TrAB7gZg6Yn/QN9hK
         TJczCoO7YAuZSaYoZLlj6xd/RKfIDg9gzN3STrJG+xPQnly9RJ9ZXBUrWl4GNTgMPWBz
         JFzWUY45N7Ux3otgGiixw3ebOt5Tx6em+4Iw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyZAYSHu1LajQMoMWHpQO7QvTyyTgInrg6r4Gak6t7c=;
        b=IweuaDP8emHhej2WxAvsXTz0vcKF2/QvGcNd+SXNwsfFZ4KIP7BIqCjdI/3d+RxqJR
         Us1BVLpWyEBI+4kA/1TPN+dgj52ozuXeTV+t9aZeRmsSMsV80NP9tJLX9jdrXpY0dlUM
         U4/etGxzGz9zjSGZ4bFjY0XxFf5/7Yftco1qrw/5Wy091PZeiH+rnhdgWlL44r1YT1yV
         0nDo3liBxBleR6/pqGwvt9abvajILzL1fh3JseuitySOWq1Kd+h5XPoqn3LPkgaafAfT
         kUjKRpHzN58C13ksY0CwcZ7mFAKSzO8pShAByN7KAq+DKIbkm3Km32ahpZCRFsme0Qye
         TNWQ==
X-Gm-Message-State: APjAAAXLWEqfYeCbo118FTNMAaO2e3Ty77BMmSms/r3jGux52umEkM6H
        Q1bc9ymlUzchS647Ayq92m2MsfacXMQ=
X-Google-Smtp-Source: APXvYqx1TxxxC/WxTrKZs72yG1SxRfNqoUvDGThV0gBmndYjDizoihkvKFNFQOG0iy/VCWcL8xJjXA==
X-Received: by 2002:a19:9792:: with SMTP id z140mr4066414lfd.75.1556215391623;
        Thu, 25 Apr 2019 11:03:11 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z17sm4739155lja.26.2019.04.25.11.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:03:10 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l6so487365ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:03:10 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr7412241ljg.118.1556215390270;
 Thu, 25 Apr 2019 11:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190425174739.27604-1-idryomov@gmail.com>
In-Reply-To: <20190425174739.27604-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 11:02:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
Message-ID: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
To:     Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:48 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> dentry name handling fixes from Jeff and a memory leak fix from Zheng.
> Both are old issues, marked for stable.

Hmm. You probably should have talked to Al about the dentry name
issue, because he'd most likely have pointed you towards our helper
function for exactly this thing:

    struct name_snapshot stable;

    take_dentry_name_snapshot(&stable, dentry);
    ... use stable.name ..
    release_dentry_name_snapshot(&stable);

which doesn't need any extra memory allocation outside of some fairly
limited stack allocation for the 'name_snapshot' itself, because it
knows about the dentry name rules, and

 - for inline names, it copies it under the d_lock into the fixed
DNAME_INLINE_LEN-sized buffer

 - for out-of-line names, it knows that the name allocation is stable
and ref-counted, and just increments the refcount and uses the
existing name pointer.

now, maybe you need to always do that name allocation anyway (looking
at the diff it looks like you often do that for other cases), so maybe
the name snapshot capability isn't all that useful for you and the
above wouldn't have helped, but I suspect you might not even have
realized that there was an option like this.

I've pulled this, but maybe Jeff wants to look at whether that
snapshotting model could have helped.

                       Linus
