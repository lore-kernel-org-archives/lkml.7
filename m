Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD3C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AEC214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 07:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wsud5zYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFHHNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 03:13:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39241 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfFHHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 03:13:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so3606175ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DegCVmGIdd0bLWL8bA/nsvYbcUC9KgI6I8cADXdqPho=;
        b=Wsud5zYlPvfWDBl2yhnNC7ok6cBEDBcBXxxLGFBcGkEFEBv/7kPpcCPNBJt/GDoz2t
         YTCmuFmNoj3oT9tjVAb4LnIOAkJAiDVjrO3WaUa5dGXRfl8Af/ljGlRHqAN4z6qWHF23
         1LdDpK4ClPi9GaNDGXumiwke6q+5i0eAcDpOOZX6bDCdnKSfmavGTayjR6dV2Vxwd+M7
         AGzL0SHaU9/s7uVirttj27vdXUIOxxmTlUHNYBxH9dotNILbM8DBUIzIXOE4l7T8T3hO
         GBnFDynfhXR8CM4sjJN6QjRpE1U87h36uKQKsmdevfFtPwM+ZfKWHrc8cFjoJlRXvdZH
         jX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DegCVmGIdd0bLWL8bA/nsvYbcUC9KgI6I8cADXdqPho=;
        b=UBJq3lGPrwCBSpeT8ro0r5mdOKop6z6F+tPdQSjbsGUFTesp30XRFqNU3KDkQvkgod
         ipuwnaq9S7VGEzD2TM71f00aiOylcN0FvXpQyWf9kEXMNmaAslte8/nAvLkySlLuuB47
         73LPHMf1eV9XVzF+NTecre43/YXOzj/wIIxZ7BI0KYd4f+SSPuiBbZp+5xo3lcglGObn
         tBe5ZY3kkweMD2RwbeeJf3y8vxYJf7Iu5MJ6F5Rwo3grbn1/7iQBp+oyqPnzJUe4OWUz
         Y0JAXyZH6sZkw0jerzr1QfVBC7DpEEHvVZR+cOQHabyVplUP9I/9wSw3trCkEp9Ms1Zo
         5GAw==
X-Gm-Message-State: APjAAAVWhwPL6RrYO3Q5Iruet2Q9x9eUsBmVltXtI2LixvEZvpb7eQ50
        thQWZ/tKeLd473QnXnnlgh/cZZET7GbazLoaVSZoFg==
X-Google-Smtp-Source: APXvYqyKv5fkqvShFOYSR0yEMa8+LXGoV/8oU6hLRVakSWiNWIqbdBNLWpLiaEG/rKoIbph8ziLNaH657x76oNKFsHk=
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr18170669ljg.182.1559978022100;
 Sat, 08 Jun 2019 00:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190607153848.271562617@linuxfoundation.org>
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 8 Jun 2019 12:43:31 +0530
Message-ID: <CA+G9fYtmR8mtSzxLzKjCuKaWzd=zzyFKnUG0pG69+EkEpRQA0A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/69] 4.14.124-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, fdmanana@suse.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 21:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.124 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 09 Jun 2019 03:37:08 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.124-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

compile kernel module failed for arm and i386.

> Filipe Manana <fdmanana@suse.com>
>     Btrfs: incremental send, fix file corruption when no-holes feature is enabled
>
> Filipe Manana <fdmanana@suse.com>
>     Btrfs: fix fsync not persisting changed attributes of a directory
>
> Filipe Manana <fdmanana@suse.com>
>     Btrfs: fix race updating log root item during fsync
>
> Filipe Manana <fdmanana@suse.com>
>     Btrfs: fix wrong ctime and mtime of a directory after log replay

fs/btrfs/inode.c: In function 'btrfs_add_link':
fs/btrfs/inode.c:6590:27: error: invalid initializer
  struct timespec64 now = current_time(&parent_inode->vfs_inode);
                          ^~~~~~~~~~~~
fs/btrfs/inode.c:6592:35: error: incompatible types when assigning to
type 'struct timespec' from type 'struct timespec64'
  parent_inode->vfs_inode.i_mtime = now;
                                  ^
fs/btrfs/inode.c:6593:35: error: incompatible types when assigning to
type 'struct timespec' from type 'struct timespec64'
  parent_inode->vfs_inode.i_ctime = now;
                                  ^

Full build log link,
https://ci.linaro.org/job/openembedded-lkft-linux-stable-rc-4.14/487/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
