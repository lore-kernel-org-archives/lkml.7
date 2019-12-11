Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7417BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1602073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576025523;
	bh=Gmj//zcm8fxwhe89OVHTfbVlyud7kzEoKjqmOhMmvNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Hckc47YbtipSV11NrGXQAI5Vwnym7SxM181Ynu3XIQC+Qkv690hNEvpGPPTYWajm9
	 XWgePnhK9hYQ/S9CXDYIL8qW5ozTPxaxwj80wS0J3OVvmRLye8KqSXKGOU+MzA17Dg
	 YHeDdE4F24N9wV4G1Crp1OYqPftB4S8DGfs2UI9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLKAwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLKAwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:52:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7A3206D9;
        Wed, 11 Dec 2019 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576025521;
        bh=Gmj//zcm8fxwhe89OVHTfbVlyud7kzEoKjqmOhMmvNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CXNDcxTHMPMK9Ne+mkKixn7astwJb4fgJu2cfd0Y5NSf3a2NWtvt3HWdZ6U8HnVEB
         qdie9HnwL0luO6emzSASA6tQIHZRnh5hedzZJQCxC/EkC1hnLDXgKoC4mHtY6stxZE
         LPVju9ETWlOji4aGV4IHjFzUzGB8QCRxkvAVcCqE=
Date:   Tue, 10 Dec 2019 16:52:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     zhanglin <zhang.lin16@zte.com.cn>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Steven Price <steven.price@arm.com>, david.engraf@sysgo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] initramfs: forcing panic when kstrdup failed
Message-Id: <20191210165200.a3c542b74afe7dd846a87e1a@linux-foundation.org>
In-Reply-To: <CAMuHMdUWeH9u0hP9wCfgb7TJ0nQkbQTPREX+fpTh+ZVrTsCobg@mail.gmail.com>
References: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
        <CAMuHMdUWeH9u0hP9wCfgb7TJ0nQkbQTPREX+fpTh+ZVrTsCobg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 09:15:54 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -125,6 +125,8 @@ static void __init dir_add(const char *name, time64_t mtime)
> >                 panic("can't allocate dir_entry buffer");
> >         INIT_LIST_HEAD(&de->list);
> >         de->name = kstrdup(name, GFP_KERNEL);
> > +       if (!de->name)
> > +               panic("can't allocate dir_entry.name buffer");
> >         de->mtime = mtime;
> >         list_add(&de->list, &dir_list);
> >  }
> > @@ -340,6 +342,8 @@ static int __init do_name(void)
> >                                 if (body_len)
> >                                         ksys_ftruncate(wfd, body_len);
> >                                 vcollected = kstrdup(collected, GFP_KERNEL);
> > +                               if (!vcollected)
> > +                                       panic("can not allocate vcollected buffer.");
> >                                 state = CopyFile;
> >                         }
> >                 }
> 
> Do we really need to add more messages for out-of-memory conditions?
> The trend is to remove the printing of those messages, as the memory
> allocation subsystem will have printed a backtrace already anyway.

Yup.  And we traditionally assume that memory allocations won't fail at
init time anyway.  The reasoning being that the system is so enormously
messed up that the problem is both unrecoverable and very obvious.

