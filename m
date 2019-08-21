Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBBC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951F720856
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="M/JE1rZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfHUPhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:37:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37825 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfHUPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:37:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so2149816lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2619U9Tm5TYEgcBQkA05KbEPScI41FeuQa1aH7Sw3kQ=;
        b=M/JE1rZZm/RfbqUxzJX37QJ/vamqziXn2XHNDm0iZw1yd9BEhyNhUIiTk3/KAhR54O
         Y9PwNHb97zozoLcuUnc46BF0qDf6vA9b/F4w36fsU4uTtjjANfXa/vz/qSZ6leZcV1Mq
         UvlMpumI9H33UjgxfvjEMHRYeTpcfDa+S9yLLhIY0T5Hkz4MK+2zpOxo0PLE5/FOI4tV
         62pqd8EQo5WVNke4HmUwGQBrnWc+pi2V9UB082jC2pEynBpKZqbjRk9zV05e/pXaOWCA
         rdvRY9J97Qr3Le4nJQfBpDoKXxG9vH6d6pCChNzkfbez6FOgfuABS4iKn3Wu8pEaG1Au
         MDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2619U9Tm5TYEgcBQkA05KbEPScI41FeuQa1aH7Sw3kQ=;
        b=hoS9co+RZpGeaH6P+LBpZae5WatZEEtq4kUlNOT1Xm8HoxY230jkwbiR8jo6/aoh3d
         b1XYrHR80EAFtXb8+di7PTkxU61BFhWgw8704AH3nQJwg30IbOGKgZBWUyFcu2E0HbpQ
         0F4KGGEszZwvgvIBjoJ87jWu3vSzWqkZNplNJZ+HNe0FniGggvLZXIhKrX3eCVj75u1L
         cF9fR4tMC4Gs+oYj7ahKx6qTS7BEs14o48eHVJrPZDoUKsxJ26LwFsHe4d1b5x5MG6Dw
         3/qMuvWrNcIAVapgeExPjHZOdY9gnjJpJ0pKOZ0NhnoOhmwIgr/msvjjdUt+1bebRIdY
         LH0w==
X-Gm-Message-State: APjAAAUAKUMd0T+fkB6+07WTSzKaI7aitA/BtTW5g25kDOz2mwkAizgO
        eJiHg/PzHmunsJ3HXBmDFamB6H/UBywE66pUBH8b
X-Google-Smtp-Source: APXvYqwqThu91Iy3zjtydclgxUMDIcs4QNLzXbu5HbIKVhlNSP6g2YCGmjVSAy6XIf80VuoG1dcRm55IgYUdgInPglU=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr437303lfq.119.1566401821240;
 Wed, 21 Aug 2019 08:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <4997df37-4a80-5cf5-effc-0a6f040c4528@huawei.com>
In-Reply-To: <4997df37-4a80-5cf5-effc-0a6f040c4528@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Aug 2019 11:36:50 -0400
Message-ID: <CAHC9VhS_DCBRX6kkmiSYBzq+ELN2AYRypRN6vR_J1+JOi2FDvw@mail.gmail.com>
Subject: Re: [Question] audit_names use after delete in audit_filter_inodes
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:31 AM Chen Wandun <chenwandun@huawei.com> wrote:
>
> Hi,
> Recently, I hit a use after delete in audit_filter_inodes,

...

> the call stack is below:
> [321315.077117] CPU: 6 PID: 8944 Comm: DefSch0100 Tainted: G           OE  ----V-------   3.10.0-327.62.59.83.w75.x86_64 #1
> [321315.077117] Hardware name: OpenStack Foundation OpenStack Nova, BIOS rel-1.8.1-0-g4adadbd-20170107_142945-9_64_246_229 04/01/2014

It looks like this is a vendor kernel and not an upstream kernel, yes?
 Assuming that is the case I would suggest you contact your distro for
help/debugging/support; we simply don't know enough about your kernel
(what patches are included, how was it built/configured/etc.) to
comment with any certainty.

Linux Kernels based on v3.10.0 are extremely old from an upstream
perspective, with a number of fixes and changes to the audit subsystem
since v3.10.0 was released.  If you see the same problem on a modern
upstream kernel please let us know, we'll be happy to help.

-- 
paul moore
www.paul-moore.com
