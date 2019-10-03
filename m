Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B70C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963BD222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU7RgrOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfJCADw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:03:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfJCADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:03:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so506593pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/87K90rkNZRaYvz9rAg8yrl4MvV1oEAOdaoOSOr7ubA=;
        b=LU7RgrOXbPjW4wzLCpf8pKZBHQPm1m2td2OgjDiRu+Vl/HDfX29LwFjolaJTBh1tV5
         vAOtgEJlToS+bwFUFJoA+3hSdg5LdANdvPfqnXIvDwQIxn+7/5A7ZOjOd6E9wrP3/ew1
         md21W6/7L3qH2WK3B3ZZPNlzp/IbuTRjFF20xTPhw05jjxuZbL2s2+YJz5mRIVHh2jHv
         yK6uz7zzpLjPfLqpC5LQtaGdK0Zm2GmzRGkrltzVSFFxXxQ+WwcpWN52sG3XDQM0u+/7
         5+xQRwlj9weFJMtlsboUDRmgfl5j5IOe+hPgg0F0FdvLzCNRMEO595+tKgWZUlwXUCEQ
         C+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/87K90rkNZRaYvz9rAg8yrl4MvV1oEAOdaoOSOr7ubA=;
        b=MZMk841ZCpbEpqYWRDQsj6zCvkWGqjBHDCw3SizT8y73A4MQln6Xa79/heWGTp54X5
         bih/O2MLOnfA6ZOHiOvV3+Bds4hrIU7zxnQF0eqNUqFZsBH6gKLrpwVkLL2yj+BxIwcv
         VIe8zUeJG7Y5DargHYretrfNuHKb96wqhJMrJ4sGdkL3sTPx8sgkXU32lqCM6RamumoO
         LsKxAbod8oBEHfDI0AdTYyvz3Ar4V+/Plc1hfFfa07/vvbA7y04UueblDD4IXoV5ygMT
         T7E89aZdtjzrciVzqEK983qrbJEns84iX/ZjX4Nf82esnvuhtkdVHcqBW+PlW8mdF5mL
         KvCQ==
X-Gm-Message-State: APjAAAUg1aOhc7c1HwpEEfmSJmVtIspOIO9vze0AcWjhkah8iu3FbTuy
        hqpOnadzgUHTeO1clPY3l5A=
X-Google-Smtp-Source: APXvYqzGuPU4Q25x1oeZ7ibWpmqwO9v90kFfiTUB0AfNS5+mKwmpf3LYxfFj1+jYQEYe+pgJR7ZLFA==
X-Received: by 2002:a17:90a:256c:: with SMTP id j99mr7279921pje.125.1570061031052;
        Wed, 02 Oct 2019 17:03:51 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a17sm514807pfi.178.2019.10.02.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 17:03:50 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:03:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lis3lv02d: switch to using input device polling mode
Message-ID: <20191003000348.GD20549@dtor-ws>
References: <20191002215658.GA134561@dtor-ws>
 <201910030738.k8Pojn6c%lkp@intel.com>
 <20191002235943.GC20549@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002235943.GC20549@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:59:43PM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 03, 2019 at 07:30:23AM +0800, kbuild test robot wrote:
> > Hi Dmitry,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on char-misc/char-misc-testing]
> > [cannot apply to v5.4-rc1 next-20191002]
> 
> This is weird, I just tried applying it to both next-20191002 and Greg's
> char-misc/char-misc-testing and it applied cleanly and compiled (on x86).

You seem to have tried applying it to this commit:

Merge tag 'char-misc-5.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc

Pull char/misc driver updates from Greg KH:
 "Here is the big char/misc driver pull request for 5.4-rc1...

so of it failed because at that time Linus' tree did not have the
necessary input changes. I am not sure why you decided to apply the
patch to this particular commit.

Thanks.

-- 
Dmitry
