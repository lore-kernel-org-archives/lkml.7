Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152A9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48820833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="w8X3UASC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfEPQyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:54:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46295 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:54:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so2644535qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RSXji2gu6PTmCCcGE3ApJyZXicrhpNir4c6ptrlMBZw=;
        b=w8X3UASCEUM3vJvJ4NqGiATkR0s8WmNbhjJJSUDD4HQ5v2XUQijD5IJAoCIwFIhnIj
         yNJkhZYd7EOu7n7SoaVlYcXwxxjQKwyi/SFjLgKx66liMvMlrocYvplC/NEHCFvtfN1k
         Lhu4GdtukplsBg9cVyo/2p/lF/duxEKZhUOyrWibtP6yVb/v7XY3D179ye4XGcdRUpvw
         VBtXRW73769UYS9SMc3eo16qzfMNhEBSNnpV/FNMxkacKLujZ4mbEiM4GLZfmWc/0mh6
         8V2onWzspsxdE4pGSB/44M+XrNRnL3RHDWgg+m1CIMruHaQFLlgAPhErMXplm+cg6ZnC
         pT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RSXji2gu6PTmCCcGE3ApJyZXicrhpNir4c6ptrlMBZw=;
        b=SCMmREu0NOtE7Db0YSJbyuiQkETcOXrqiM/jnrSlkG2wTn7xj4DxPjXLo5/nXzy/gE
         fNuR8f69kQrDXMqzTMoI/hnLx5UjE2xWSNMo0NlEcOnuXeKW1YI6w6baPu1WLL7jZ7yo
         PDSYm1LnUX/czKuAzLf8s+iXOYlI2NqxFNRdIc2jKD3AleAOjHHCNo9zjKIc8eXDqsRL
         NErLrNlPzxV8Y3m7+BiHMgBX4okaGkj8ydf6j7tcp6pJ+9fCnP9G7Rm3y8GOyAaLFZxs
         tv3T42PEo+2YY/7Z5Qo12mwpQyYySoxRJ1agsVeoxTbjUGhiy1xKU2CY24Y21V1SNM79
         B5YQ==
X-Gm-Message-State: APjAAAWVDJgwkZnQQB7Yf5HIHLStvoCepWFOHfMP981nimy53lM4l/hH
        lImCNetasRc+T1UDL/n4tKWaPg==
X-Google-Smtp-Source: APXvYqzFFPIoAoCXHLuAi3qkHjprBS7BtRM/qvWx3GdjcQWNy0cAs5xxZ7wEPTSo5KalHZN4PMzVWQ==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr12814987qkl.243.1558025693089;
        Thu, 16 May 2019 09:54:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 91sm2696400qte.38.2019.05.16.09.54.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 09:54:52 -0700 (PDT)
Date:   Thu, 16 May 2019 09:54:26 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Krzesimir Nowak <krzesimir@kinvolk.io>
Cc:     bpf@vger.kernel.org,
        Iago =?UTF-8?B?TMOzcGV6?= Galeiras <iago@kinvolk.io>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ogerlitz@mellanox.com
Subject: Re: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester
 could not run a program
Message-ID: <20190516095426.2e0d838f@cakuba.netronome.com>
In-Reply-To: <CAGGp+cEFxzbH-8vnSAK3sZkM-u3WN4HGnkYvhFwBp85yVtD7Xg@mail.gmail.com>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
        <20190515134731.12611-3-krzesimir@kinvolk.io>
        <20190515144537.57f559e7@cakuba.netronome.com>
        <CAGGp+cGN+YYVjJee5ba84HstSrHGurBvwmKmzNsFRvb344Df3A@mail.gmail.com>
        <20190516085035.3cdb0ae6@cakuba.netronome.com>
        <CAGGp+cEFxzbH-8vnSAK3sZkM-u3WN4HGnkYvhFwBp85yVtD7Xg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 18:21:32 +0200, Krzesimir Nowak wrote:
> On Thu, May 16, 2019 at 5:51 PM Jakub Kicinski wrote:
> > On Thu, 16 May 2019 11:29:39 +0200, Krzesimir Nowak wrote:  
> > > > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > > > > index ccd896b98cac..bf0da03f593b 100644
> > > > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > > > @@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> > > > >                               tmp, &size_tmp, &retval, NULL);
> > > > >       if (unpriv)
> > > > >               set_admin(false);
> > > > > -     if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
> > > > > -             printf("Unexpected bpf_prog_test_run error ");
> > > > > -             return err;
> > > > > +     if (err) {
> > > > > +             switch (errno) {
> > > > > +             case 524/*ENOTSUPP*/:
> > > > > +                     printf("Did not run the program (not supported) ");
> > > > > +                     return 0;
> > > > > +             case EPERM:
> > > > > +                     printf("Did not run the program (no permission) ");
> > > > > +                     return 0;  
> > > >
> > > > Perhaps use strerror(errno)?  
> > >
> > > As I said in the commit message, I open-coded those messages because
> > > strerror for ENOTSUPP returns "Unknown error 524".  
> >
> > Ah, sorry, missed that.  I wonder if that's something worth addressing
> > in libc, since the BPF subsystem uses ENOTSUPP a lot.  
> 
> The "not supported" errno situation seems to be a mess. There is an
> ENOTSUP define in libc. ENOTSUP is usually defined to be EOPNOTSUPP
> (taken from kernel), which in turn seems to have a different value
> (95) than kernel's ENOTSUPP (524). Adding ENOTSUPP (with two Ps) to
> libc would only add to the confusion. So it's kind of meh and I guess
> people just moved on with workarounds.

Yes, ENOTSUP is never used in the kernel, but it's a mess.

This commit a while ago said ENOTSUPP is from NFS:

commit 423b3aecf29085a52530d4f9167c56a84b081042
Author: Or Gerlitz <ogerlitz@mellanox.com>
Date:   Thu Feb 23 12:02:41 2017 +0200

    net/mlx4: Change ENOTSUPP to EOPNOTSUPP
    
    As ENOTSUPP is specific to NFS, change the return error value to
    EOPNOTSUPP in various places in the mlx4 driver.
    
    Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
    Suggested-by: Yotam Gigi <yotamg@mellanox.com>
    Reviewed-by: Matan Barak <matanb@mellanox.com>
    Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

But it's spreading throughout the kernel like a wildfire, I counted 1364
in my tree :/  Some are in tools/, but still.  My understanding was that
system calls should never return values above 512, but I'm probably
wrong about that.

Given the popularity, and the fact its an ABI at this point, we
probably have no choice but to add it to libc, but to be clear IMO it's
not a blocker for your patches.
