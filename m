Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D802BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D802083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VlcXFcnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:20:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=66W5GS/zY8qTFQUWMa+wFKVFo3L3ckC3GQICJK5JDgg=; b=VlcXFcnfC63/WvOEcs2GtWUJPs
        /lCpFwhBaIJUHhaH6qXvKYkTYw/YhRhVOKJ0lS6Az5jBi/Av1Q50mC6iCWAIp7qodoiaiREn3nNb0
        y3JoVsK2atjsPJnKerhifoZ2jZvHtrwmMkTeCP6+f4ZbvwB7GXYJTXh+LWZCTz2XX5zidmLgP4r9k
        UQ9JuiD4yaQ1N/14xMu4geF6lb8tcR7eDX8xp5lEzLMWNsNeBO6ph9qf9QIeN3w3PbhE+rWfl97Z2
        BHpGzHo3bMlmPtsLXP8Qoc8Bqe6HucW4pXqXhAzOfkC4PJHGTA1h72fh9ZA8xTKa0M6Pp6YIVKPde
        BCGSpa3A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbUh-0002vy-O2; Thu, 11 Apr 2019 15:20:04 +0000
Subject: Re: linux-next: Tree for Apr 11 (net/xfrm/xfrm_output.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20190411164912.5168be0d@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0568f8c-cc47-257d-c36e-0ca7505a33d0@infradead.org>
Date:   Thu, 11 Apr 2019 08:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190411164912.5168be0d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:49 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190410:
> 
> The orangefs tree gained a build failure so I used the version from
> next-20190410.
> 
> The drm tree still had its build failure for which I disabled a driver.
> 
> The drm-misc tree still had its build failure for which I marked a driver
> as BROKEN.
> 
> The apparmor tree gained a conflict against Linus' tree.
> 
> The scsi tree lost its build failure.
> 
> The akpm tree gained a conflict against the vfs tree.
> 
> Non-merge commits (relative to Linus' tree): 6028
>  5900 files changed, 189559 insertions(+), 92953 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 298 trees (counting Linus' and 69 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

on i386 or x86_64, when CONFIG_INET is not set/enabled:

../net/xfrm/xfrm_output.c: In function ‘xfrm4_tunnel_encap_add’:
../net/xfrm/xfrm_output.c:234:2: error: implicit declaration of function ‘ip_select_ident’ [-Werror=implicit-function-declaration]
  ip_select_ident(dev_net(dst->dev), skb, NULL);
  ^


-- 
~Randy
