Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29E21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568881445;
	bh=hWc+t6nq3i7mONrIipZxHhpBOrpFsJGWZn/etnKMVMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2UPckZDkRmIAgqfdsNXsOu8m2BPKzL0loh1Lj7bQkRkvTe+8vZPXFqU8bXA+c+Ca4
	 LvEkJhM+wVPoWz1C5YkB+mcfN/Wuo/SJMDm1CoqiaR+71ydgOIGKzzY3NiirfPzYXu
	 yg+3P4k6Qjyd8SnrKPOZaouqWRMNgxyYxx6mrdgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfISIYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:24:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37163 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbfISIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:24:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so2670074lje.4;
        Thu, 19 Sep 2019 01:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iN+TLWF8p09S714aWtfN4Hu69Xi2AvWDJuLstvjUtUw=;
        b=P6mB0lqYWn8TjqAuwSnIeTYKGdlcO+9j7aay16wdGpWK/6k/BOaUNHv3fzKTfd+rMZ
         gvOzBjzn0KfkMGPFAS2kh1WSNntClB7KVJ6uGrBYeA99lIPIsoJZ/1XcGmEAGt5Nbe/E
         pwpcafNP4yjU21pwXGxzgBNnuO34TovtEYDOGKY0gUzBb5n4VThElKL1dPFWbI2LbZzJ
         cJ/Ud81BxFZzlcoRT2e95JlerPpYTxXBI7piCz3AYxOGexmyt2L/fxeazzOWhR6goO+y
         TmOMaqBLI0z2lhaCBOaPsPTgALS4pOJo8JicrQmAjKcONbX2hI0Aj8uQKSGA1KdNqW2Q
         s5zw==
X-Gm-Message-State: APjAAAUP+p4KngBKHcG4I9241mQRac/dyqOdLvrRJMLjIJj+jehFD0Bz
        La4bzKD9PINUHw3Xi3xJck2rGuwT
X-Google-Smtp-Source: APXvYqy2XbfUzHTPO9pDYLdielNGRUvJLhSPJXh0+BSVs7kHFo4azrsSXfq0yC35UxvtjWk58iiK9w==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr4836970ljb.4.1568881440489;
        Thu, 19 Sep 2019 01:24:00 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id l23sm1472197lje.106.2019.09.19.01.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 01:23:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iArjL-0007yl-BQ; Thu, 19 Sep 2019 10:23:59 +0200
Date:   Thu, 19 Sep 2019 10:23:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+66935bec147fbf68d9f8@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        legousb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, starblue@users.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in tower_open
Message-ID: <20190919082359.GA30545@localhost>
References: <000000000000e669b80592ab96fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e669b80592ab96fc@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:29:12AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c8d14e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=66935bec147fbf68d9f8
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+66935bec147fbf68d9f8@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.3.0-rc7+ #0 Not tainted
> ------------------------------------------------------
> syz-executor.1/8155 is trying to acquire lock:
> 0000000086c1bdfc (open_disc_mutex){+.+.}, at: tower_open+0xce/0x9b0  
> drivers/usb/misc/legousbtower.c:335
> 
> but task is already holding lock:
> 000000000f520f73 (minor_rwsem){++++}, at: usb_open+0x23/0x270  
> drivers/usb/core/file.c:39
> 
> which lock already depends on the new lock.

This looks like a duplicate of

https://lkml.kernel.org/r/000000000000d58eb90592add24e@google.com

Not sure if this is the right way to report this (quoting needed?):

#syz dup: possible deadlock in usb_deregister_dev (2)

Johan
