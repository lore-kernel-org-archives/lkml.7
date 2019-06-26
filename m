Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tO2G+Zjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFZQBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:01:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GnPHeYQAyV1bj18lebqeKcP5mH5ZIM5W4pKT9Ho81xg=; b=tO2G+Zjcc4QuYrS5gBSZXJcGGd
        xtVkG432/Sdz/qEa6WG6V+xeN9gxQmd38CGR+RW1L/V6opA+js4Vbx8yUdC6FR+Deau+WGuIPf+O+
        xx+vj/pz8ghtFYvDke3WnfFALJTtQ0HDT8AKbP1f9EACdfndQx/QGDzmJm5C7juX3smTINFmMuUEu
        Ab5XoyWQidj9J8qhqIT0CEUu0Xigho7q4XiHE9owC6MOUjCTrTCqVDV46CDdRhu0RaUXuZ3GyFuVE
        Gd1LQurM3QCySstulvWx7YzNA1yu5JIrIQkGqo1kq6NqEqNP/2HlRYeCRLDBSoHlDqekaGpLrHQYB
        Sjj8u8vQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAMp-000888-9V; Wed, 26 Jun 2019 16:01:51 +0000
Subject: Re: linux-next: Tree for Jun 26 (task_struct: cached_requested_key)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20190626231617.1e858da3@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d868a7a-0a15-e2b1-d73b-13d9229855ad@infradead.org>
Date:   Wed, 26 Jun 2019 09:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626231617.1e858da3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 6:16 AM, Stephen Rothwell wrote:
> Hi all,
> 
> The sparc64 builds are broken in this tree, sorry.
> 
> Changes since 20190625:
> 
> 
> The keys tree gained conflicts aginst the ecryptfs and integrity trees.

Multiple build errors like this when CONFIG_KEYS is not set/enabled:
(this was seen on one i386 build)


# CONFIG_KEYS is not set
CONFIG_KEYS_REQUEST_CACHE=y


  CC      arch/x86/crypto/crc32-pclmul_glue.o
In file included from ../include/linux/export.h:45:0,
                 from ../include/linux/linkage.h:7,
                 from ../include/linux/kernel.h:8,
                 from ../arch/x86/entry/common.c:10:
../include/linux/tracehook.h: In function ‘tracehook_notify_resume’:
../include/linux/tracehook.h:191:22: error: ‘struct task_struct’ has no member named ‘cached_requested_key’
  if (unlikely(current->cached_requested_key)) {
                      ^



-- 
~Randy
