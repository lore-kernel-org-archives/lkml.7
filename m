Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AFEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD48216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZ4XWFAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfETN4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:56:49 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42789 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfETN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:56:48 -0400
Received: by mail-lj1-f176.google.com with SMTP id 188so12524861ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8FyerFcC8rxtoPBlcw4IeblJtG6XuunC6x9HaI2Vo4=;
        b=lZ4XWFAVApokp7FGmIea8ZO7d/lO54NT7Mk6geukFClNbjbB9OsRjDbSqBA1B6ZERq
         fej8pGOFNRK9PTvs6BsC6chSjlCvMApLP6HX9nqIdQhKHpF6VZrPuo1k8jd33QhiMQe0
         yB9y0T4cmEn+tw1Z2wVdqCcmbZ7+0pcPT/izzIMiOcKI+S9oz6FIojBkygnOr/37yY2a
         hxSBpDibrpTU0b/1xqh4yZFqfSgUB5P80XdHHY7XVIuaJNWESGE65pHhM/77kItMsYuO
         uo+DYI1YSBG84BlwsVDBN1TkplClG5pgXJlI/1vRgq8Mq7r0xJvDvnp/+yl4Gntzxpar
         6STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8FyerFcC8rxtoPBlcw4IeblJtG6XuunC6x9HaI2Vo4=;
        b=glpyWWVj7c0yl825dn2ljCkrgTP4tWv2IUXD/lczRNCmCuCHK+zA9CRlXJJ3CMxYfL
         qQdfj5/hfd2mbliAQNuxRgoEubaBD8ZSuo7A9G5NvERFapa2rNnpLEmwm/IE+Fjjm3vd
         /jZAJccD1pjvBBGWhY3ztnePuerFjNnrSlLP/wVifr+71+QB0nXv49bdsiL9ZR5d/Rjt
         zllyzE0xYVLLE3kWnsSbCykLFXKAB2uN1mdEmpYS4cKmnC6ZzlVdNltCSF+R9Q8WbgrM
         0c/2ZO5+lILGaWqfL3k7q5whFoAulFL1dZ6rnHFqmMHx2YQPFwHEnUNqs5G0MB9zmMq3
         Ljug==
X-Gm-Message-State: APjAAAXtauQBd1xUGnF4QxrezPkecGDP/RG6a53UKs9hQjK36fsuQe6n
        E0tayBv5pvHNslihvYhOB+uSRLzwAaRaEB4Z+hrJmA==
X-Google-Smtp-Source: APXvYqw37JWr2ZHF3WkgKza90V0bWwsnMPl8Ui4YFzyw4nbDcjCtd10JcYxvYpIBOJ0fdTyE45QWI6ryVDU3xxTN8Xc=
X-Received: by 2002:a2e:7411:: with SMTP id p17mr21387151ljc.24.1558360605783;
 Mon, 20 May 2019 06:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuC8dgKs04HmyCaKeQ_xwqKBxnh=zsOFjQK+3Fq7AZRyw@mail.gmail.com>
 <5de0df37-f0d0-f54c-2eef-a7533cbe7a25@xs4all.nl>
In-Reply-To: <5de0df37-f0d0-f54c-2eef-a7533cbe7a25@xs4all.nl>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 May 2019 19:26:34 +0530
Message-ID: <CA+G9fYtbb82EPY9gG63+U2FTVswt7f3FjHdaHMA2kibxgVvZcw@mail.gmail.com>
Subject: Re: test VIDIOC_G/S_PARM: FAIL on stable 4.14, 4.9 and 4.4
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        paul.kocialkowski@bootlin.com, ezequiel@collabora.com,
        treding@nvidia.com, niklas.soderlund+renesas@ragnatech.se,
        sakari.ailus@linux.intel.com,
        Hans Verkuil <hans.verkuil@cisco.com>, mchehab@kernel.org,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, 13 May 2019 at 19:08, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 5/13/19 3:32 PM, Naresh Kamboju wrote:
> > Do you see test VIDIOC_G/S_PARM: FAIL on stable 4.14, 4.9 and 4.4
> > kernel branches ?
>
> Probably related to commit 8a7c5594c0202 (media: v4l2-ioctl: clear fields in s_parm).

I have cherry-picked on stable rc 4.9 branch and tested and test got
PASS on x86_64.

Test output:
----------------
test VIDIOC_G/S_PARM: OK
https://lkft.validation.linaro.org/scheduler/job/736243#L1744

log:
----
git  cherry-pick  8a7c5594c0202
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at
least 9371 and retry the command.
[linux-4.9.y 7b9dab8fe870] media: v4l2-ioctl: clear fields in s_parm
 Author: Hans Verkuil <hans.verkuil@cisco.com>
 Date: Sat May 12 10:44:02 2018 -0400
 1 file changed, 16 insertions(+), 1 deletion(-)

Thank you.
Naresh Kamboju
