Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F49C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6B421BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBNtQWhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfHGNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:46:53 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37423 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbfHGNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:46:52 -0400
Received: by mail-pl1-f171.google.com with SMTP id b3so40946537plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySKqQSG2Sdtb6NR7X5LBOcrvnI79dZs/JcxGOAF7z8s=;
        b=CBNtQWhZ4fSsR34rE64Wm2VTpkIt5MmcmcO/RsPUtQY6k/6KjqInWnu0lk3clDPf7E
         bHESMJKisHtEChM7g3O7jPk+cyzVRc/MBuNvQKDysVLAV1Qm6o71U2LXB2PN5zter2BQ
         pvUyB4WFpXx2e+dDFbcv2cMR3Cz7gtY4hdqYP5NGn9viFBzkSTxIe/+eZov9xSj74/rj
         w7blLMQZGVOVq7HNM7ubADXYuT1UDy6uXmRacZ1VF5sJyp7PQnz0mMsPnWhSYH+x5mOJ
         TdNVFYWGpGZ4/Qa+QeeHoVSmnJnLUsnDeuLRlrYUUWfZr0bnih/B/QUzhdAgRs2gq1Y6
         67bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySKqQSG2Sdtb6NR7X5LBOcrvnI79dZs/JcxGOAF7z8s=;
        b=LqhM9d0kTKjMZWyCW7FEK81puTg/HbJGDoeuGpILHgcbFDPhQxQZghqeGRn2MlSWOR
         s+AFJ9UAWhWdoVA/wD9c/xmnnU47rceZqSG2mAM9o9dqQf1EnsfC22iPmZVqqRxj3q7K
         KuhtRTJlqF2FmVtiV7bGGHeocM3fJ4eVLqELswyxLG9QHg2TDqELFY2/Oy2pBFb4ci5k
         5Z4YmLmNcLwUbzPf7RBtFIafhXxSymWJLCGPZ7i3EGNruLo3pTG6J77Yh2TVFNr6oimI
         hQPV5flrzwF5etLLFGD8RcvbHnXMaRpXWOBRmb6HM/QKCGL0jBW2MLVehbk20N+Z4P3/
         15sA==
X-Gm-Message-State: APjAAAVbmFKLBD3HlXxobzdeRTf68qwwDt/QWiNtnOSxlvysIlujrdz/
        mzSR5A6qHpMMBX0ldL0sWTSor8KUghMnZ1K/HpNN7g==
X-Google-Smtp-Source: APXvYqwuJwIi1+8bhY+iSZWSE7B73AMVMzCQHsoMCu3BHZ260yvxNMQ9E/NW99umFwPd3dN4BLTvVPw5fH0LbL1UhJk=
X-Received: by 2002:a63:3006:: with SMTP id w6mr7898479pgw.440.1565185611746;
 Wed, 07 Aug 2019 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org> <1565105624.8136.32.camel@suse.com>
In-Reply-To: <1565105624.8136.32.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 15:46:40 +0200
Message-ID: <CAAeHK+wJ_26rFeeQkfELO5nXn57-1Wo4iodLJNY=9iTeaduHyA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 5:34 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Dienstag, den 06.08.2019, 10:19 -0400 schrieb Alan Stern:
> > In any case, I don't know if this missing "get" would cause the
> > problem, but it might well.
>
> Hi,
>
> upon further thought, this should be automated. Checking for
> refcount leaks is KASAN's job. In particular, refcounts
> should not
>
> * decrease in probe()
> * increase in disconnect()
> * change in case probe() fails

It's probably a job for some other refcount debugging tool, but yes,
it would be nice to have a detector for this kind of stuff. It will
probably require some annotations in each place we want this kind of
checks to be performed.

>
>         Regards
>                 Oliver
>
