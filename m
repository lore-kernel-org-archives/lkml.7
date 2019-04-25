Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A3C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1598D20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216715;
	bh=tgEW5/s6NdX6SuOu1jeqxF64FOhyrmVSaVqdSzcfOI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JPPSq+87viEhTTbcW0WMBO4jCPWfKk0cIUdyuMYkO/xvh9pfH6+Dh1Rj7xYYEAd0l
	 D/maW9RE8bqjHZ4h/sg3MktZ6JxQ4Fs9i8yXmDwUkCPMN7f3nVr1uQXDGoe10tCAgh
	 MfuFTIpB8ZM2ZpodBjeHCCkFv64tqUOAmd/rQA1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfDYSZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:25:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35722 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDYSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:25:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so526138lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3CIt5v8ectzqInoADnE99wswPv+W1nMVgiIgTbyt7s=;
        b=V0TFVzLNnWWUVnszaJ0/UQAyhreYBK6PghXUFIlTVUzb2Xq5tP8ZEvnT5Uulbeux6F
         zzgrAgkQmKgzztL1EMaKso1QwX9q2SC0XVcvpBWDUBj7lg1W7MrCiX6OQhpJOMsf8GBS
         g9IGXOuU53gpws+M+XvC0JK+Um2OWnHg0rFAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3CIt5v8ectzqInoADnE99wswPv+W1nMVgiIgTbyt7s=;
        b=dFBqvpCF88QoMFGf5Ut/7a6Q/AfQzfyCcm4LwTInuv+kS/c69eev2CHaGmcPa9Qmcb
         BQdzxhpL+c6YoD6Vv04rjj98gg/RO5+DMCVbT91R7aERimrdy/1yXaB8yE2GhtJ+eNUG
         5FaF3z/2s3NDt5ncdBLW/vRPYNZjpus3Ga2tqhh+of9CiD3G7t+8nOno2pL/RVomjW30
         TieGRp3gjstCZnHYIJDj05pWmjUvnRcApY1OeLrbNHyakxYTqIJU3oIj40mte2A31njy
         +h6eUqeFi5F/sOZGw4v0r5crdbiVSnZ6iSM1jxYy2ewtV3ScQ0wXkzHVzOeEIacUHjVh
         H13g==
X-Gm-Message-State: APjAAAXPMfpoWBHICNsOUtU5XY8+QIqOqz/cNiRevrr/cHxXRq5ZQ3bj
        VBFhblepzW6ex020Y6wKml1VKUgbyoU=
X-Google-Smtp-Source: APXvYqxuHaDGPJI4wt6LPPYWi1GyHTWsK+PmYjwMOxgtt5Se0dKPqCfSbrT08lj6cag9LmCmRDSH0g==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr21798765lfk.125.1556216710824;
        Thu, 25 Apr 2019 11:25:10 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n9sm5139591lfl.35.2019.04.25.11.25.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:25:10 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v13so536047ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:25:09 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr21696301lja.125.1556216709489;
 Thu, 25 Apr 2019 11:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <20190425182100.GU2217@ZenIV.linux.org.uk>
In-Reply-To: <20190425182100.GU2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 11:24:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Message-ID: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
> ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
> over that, but what does it protect against?  Sure, you'll get
> something that was valid while you held ->d_lock, but what good
> does it do to the callers?  If they really have to care about
> races with d_move(), which value do they want?

I suspect they only care that the data they gather for the network
packet is coherent, and passes internal sanity tests. You get either
old or new, but at least you don't get "not NUL terminated because the
length didn't match the data".

                    Linus
