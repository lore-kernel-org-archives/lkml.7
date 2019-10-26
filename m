Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E32CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACE62064A
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572090144;
	bh=TpNJ9M/aHGKMeuV1K+J7ZHg5joOibP6ceb16GqldDXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U/r7SRjd2BvIkKFRkn1LyM2WWOfBfJeWLIRKKjAX3Sg8AEGgn7+VpR1yL0UlQ1Lwb
	 UTgig0uLKt7SspMV88PmzjJgqMqagClXNMfSlrM5AkPbaEW2KFCCuh487V6SNxvj4n
	 iLqVhQNSlpllp1VHzRBddgy12anJuvcmoqdgFCjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfJZLmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:42:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfJZLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:42:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so4817717wmk.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGGHrxvstYz8pQS+YAa540baDYCxlz4g7i+Hb7CCqdM=;
        b=ccPwIMUEktLCO4qzCrz5Qyl21vYRHCdI7R+JonzV9tZnjeIU0/XVRP6AM3TtIu5bKM
         Kl1l6PcuJ2KjfdHy92qbeVYaW23K42t1V1njTXOPt6KGB7V7+EjSjImBTC+Ys026yeCL
         o9KlW/Cu72mbK3nDE0W8IudshOIQYg9EMqMQxFGZflAoAJVDFh2e8+8FqmdilUjoqBb3
         GLxtQG/iepLAMfCQLRio2nhDfAtXBWOKDRa0kiR64lvwkwDhyWW4os+igdB2PkniYrxB
         49PW720G5G4ocyEtZYBo+RYrkzkncCxH4SC0vav2UEiDizE9Bs4dz9FrtFx9H8bopNuW
         eFBw==
X-Gm-Message-State: APjAAAVfPtKEPF2TsxGbZfUTAn3LBTgtbyY3GWKgKCQT/yKequ9xSGqF
        QdVRAY5E4yOHLsV4/v2rYbTPeaG0ZNZUge3Qxyo=
X-Google-Smtp-Source: APXvYqwaaiyCROEKYfoRqFE7ch+aPnOsGCy/y8qykI5iISzl9tI9p3/Bmv9NxoR6B+ZhYx4NP8E1M7lAfI7g05pthCg=
X-Received: by 2002:a1c:2d49:: with SMTP id t70mr7559068wmt.131.1572090141550;
 Sat, 26 Oct 2019 04:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com> <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <20191025110623.GH3622521@devbig004.ftw2.facebook.com> <20191025184714.GJ3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191025184714.GJ3622521@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Oct 2019 20:42:10 +0900
Message-ID: <CAM9d7cguuEC1bpYgqX58KqX-H9C2B=XQE+grkxdsG2MQ8WyJnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 3:47 AM Tejun Heo <tj@kernel.org> wrote:
> So, something like the following.  Just to show the direction.  Only
> compile tested and full of holes.  I'll see if I can get it working
> over the weekend.

Thanks a lot for doing this!
Namhyung
