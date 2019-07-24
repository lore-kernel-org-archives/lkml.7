Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24759C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE802190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563990200;
	bh=UMa/0b1hwJ0lrCKTHBGMhCP/iazhM4L7wIqllP7/+Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1h809t+Mxp60sVgQIgCLJVz61oplDbnn+DfhvOQExDjJmwWfKypDRS7JN/Oi3Wq7i
	 y+HlzlUuhlo+PSTHS/knJaQXAIIfJwUADXuG7nWP3SvpaGHJy6OslCF216k/dmHEmJ
	 DW0fjrB8U0aBt4huGdbAkr8MEgBiwmbJ74pHHMeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfGXRnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:43:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfGXRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:43:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so21295949pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6NIpAzsMcO7sZ0vTNzGF2DuYbeRYnuvh/l2IwKG0Uw=;
        b=GmCZRa/hEE0OV7HpRBKrMl9lgxb1Q0Ka+gEHXUeNKNKVoh6LjuHvGcYzXiTXCmwl+o
         wRRkVlo/Y0RlcTqEl3N7P2p7LiSyYmjSipP8zRocQwnmnQ7xAXQOxDoRsPqZtBdZ0QEI
         SOCZv3uLsVecKNByY3trviY9Ak5iM1lcFO7nDZAitE0w2XyjFa6hLLOf7j+NdttRQ+q3
         yYZ3qIQ7BF8dyVqlD9z4LnanqVo+PawoeGUbAXodCfNEpDyydF1iCygccrjmLSqFcTbb
         N3KKj8rzA2dQaFpqh/KV4+oPoysjPPwQq/LzBANakR0kLpvmApO2hVy/yxTCAJBIINxm
         3H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6NIpAzsMcO7sZ0vTNzGF2DuYbeRYnuvh/l2IwKG0Uw=;
        b=KT+ZaYPtESp0r70SGRCV9/alZvKyTGtyk4nAldAeWIlP6TG8Cm0F8qoEzjudbiB3cP
         YQu6vWJvufdUcgC93J4KxHPeDnlGXxvHXWkt8J7utvkaGRkocfJIUNEtIhwtPSzTVPx5
         VqRfMOYh0g5gmFS3bZEaFIAVfb3h7KvurKQlmXj9AG+kGI1eE8XM7lH8WjAnXgmkXipX
         qfYol94Ii8L9MmwHtTt6EzxkHXJs3sNiFeStq+JFQswGuGyJ4phsNVLXz3tdrKKEVCVe
         OPjgiF5PNLT6ZW5EhmVAtG+ZleknGY6m3k5WqgHOHtzPqMn7jSmpU1JpexKmKOq0lRrm
         vOwA==
X-Gm-Message-State: APjAAAUQx4JSJAFsWbVObaQvyfuGYWITJCA0xzFG63G7DrHC82GWhTN4
        0hDNtjql6APQFZotDjfpCMo=
X-Google-Smtp-Source: APXvYqyzOzhPeh+GdEwAECuBfAlPOZIKs1zQssZJ3KsiOYgu/hJmbUc4PI/LbMHPrJ0s3KzmsoiVwQ==
X-Received: by 2002:a63:31c1:: with SMTP id x184mr78327780pgx.128.1563990197550;
        Wed, 24 Jul 2019 10:43:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c91a])
        by smtp.gmail.com with ESMTPSA id u69sm57694267pgu.77.2019.07.24.10.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:43:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:43:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
Message-ID: <20190724174315.GC569612@devbig004.ftw2.facebook.com>
References: <000000000000f19676058ab7adc4@google.com>
 <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
 <20190611185206.GG3341036@devbig004.ftw2.facebook.com>
 <CACT4Y+ZNTh=t62oj_Y5XyQwjOJp3AWwWi8c-4DrX+jKNCVqzzg@mail.gmail.com>
 <20190723163126.GB23641@gmail.com>
 <20190724174129.GE213255@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724174129.GE213255@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:41:29AM -0700, Eric Biggers wrote:
> The real boot error "general protection fault in dma_direct_max_mapping_size" is
> fixed in mainline now.  I believe that unblocks syzbot testing, since it doesn't
> appear to have been blocked by "WARNING: workqueue cpumask: online intersect >
> possible intersect" by itself.
> 
> Anyway: Tejun and Michael, any other ideas for why "WARNING: workqueue cpumask:
> online intersect > possible intersect" is still happening?

That code hasn't changed in years.  It gotta be changes in cpumask
initialization ordering or sth like that.  The easiest way to find the
culprit would be bisecting.  I can't get to it right now.  Anyone
interested?

Thanks.

-- 
tejun
