Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913C206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="e4JoJDQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfDWCAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:00:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39919 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfDWCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:00:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so11965453ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gp1rA/0P7mAB/pu8KddpyXzR0nOmw5sq4fc3I/JBBE=;
        b=e4JoJDQxfMbIATBDxKMMC4AOcbJkPaMv6/80LGPWNStfcv8TTh+NQmp/UwRByBosaI
         e8LGfFlg/D6+WXI3KvDy1KZJ+m8QEydQcK0NAVmzOxsK5xjr7E5cAGaySf9dhmVpcf8U
         l/4adJdLSi7Ah7ObXIYKhQM79fDMzxdvxa0VA7acUZRf5Fkfub4iyKDGgMYiqp/6PX/z
         tBMlHFYac+aifUHuci0IMC+RW/YhDW2dSQqyxY79Qnhcd6qQoRb1UwdBXZKhhzPXGNqQ
         mMkv1+e4wlKtKYFfIpB5cqtXr7hK3XVjwFK7/mVUP/9sM+zhBqZEIiki8S/BIWbJiIRe
         vN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gp1rA/0P7mAB/pu8KddpyXzR0nOmw5sq4fc3I/JBBE=;
        b=B5KdPf0bJ6mb95xtU7znvtggjikcG96s8XCIGlgc24mG3uTOqe7AJ4KTYvG7XVSCyR
         6koslQ1B2Sk9DEED18jVXiRXTT5vVv6fEe4wR5bfFKcEbUXiW7tpkiuwHO++3kEv8zuV
         r/RrwLfA8nt+ctMS6/mUh0swzsq6TKvzyej/ZmahDSQLKcUw6422YqTfq1ehn12TMORO
         PYeVpk7VkQAVxsQVcbLSy+Bb/uxhEFhPs/uEQHyNIoCZYkpUPDm7W1kopqNKUP9KRGIc
         GrW5woN4W0ZjKUDKC0bRNw0XRpmHgSipXMh5jGNgfXPN4vybtq9RHC2mDKYZRAJZbuYv
         9mvQ==
X-Gm-Message-State: APjAAAXoq1t+g5GIm7BpyXxVsauhFUkECQ1h6Lrt1O7ajpQGy+0e/iA7
        olbFHdZdROrj9ndsVHjmxk2vF2gezW6TtwGA62hR
X-Google-Smtp-Source: APXvYqw+nisAqhxZuWlXrurzzEeBurRHeQVcGAan/T+SJXw2CYQjjrOi5CgLltRWUPwQwEw4B7BIkuLsQfCUiODNnP0=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr11943236ljk.5.1555984798619;
 Mon, 22 Apr 2019 18:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190422210041.GA21711@archlinux-i9>
In-Reply-To: <20190422210041.GA21711@archlinux-i9>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Apr 2019 21:59:47 -0400
Message-ID: <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
Subject: Re: scripts/selinux build error in 4.14 after glibc update
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 5:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Hi all,
>
> After a glibc update to 2.29, my 4.14 builds started failing like so:

...

>   HOSTCC  scripts/selinux/genheaders/genheaders
> In file included from scripts/selinux/genheaders/genheaders.c:19:
> ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
>  #error New address family defined, please update secclass_map.
>   ^~~~~

This is a known problem that has a fix in the selinux/next branch and
will be going up to Linus during the next merge window.  The fix is
quite small and should be relatively easy for you to backport to your
kernel build if you are interested; the patch can be found at the
archive link below:

https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac

-- 
paul moore
www.paul-moore.com
