Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7BC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BB421881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="CJKPC/f4";
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="ZqG4nvbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfIJOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:20:55 -0400
Received: from mail-out.elkdata.ee ([185.7.252.64]:63251 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:20:54 -0400
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-out.elkdata.ee (Postfix) with ESMTP id 023F337295B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:20:51 +0300 (EEST)
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 00CA58308C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:20:51 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay2.elkdata.ee ([185.7.252.69])
        by mail-relay2.elkdata.ee (mail-relay2.elkdata.ee [185.7.252.69]) (amavisd-new, port 10024)
        with ESMTP id bXGeo76rMJmW for <linux-kernel@vger.kernel.org>;
        Tue, 10 Sep 2019 17:20:48 +0300 (EEST)
Received: from mail.elkdata.ee (unknown [185.7.252.68])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 324F98308AA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:20:48 +0300 (EEST)
Received: from mail.meie.biz (21-182-190-90.sta.estpak.ee [90.190.182.21])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id 29A2A60BF2D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:20:48 +0300 (EEST)
Received: by mail.meie.biz (Postfix, from userid 500)
        id 1F3E1A9568B; Tue, 10 Sep 2019 17:20:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1568125248; bh=cKzJGcLcvGFlhWR96PpkKHDXEqAYhIVzH0O2bLoUI5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CJKPC/f4i5w/89FBdAFSaf/wh1f9EDZNuZbAZDpG/QceOYuay0VtRrxRnJa7dFMcW
         dZVoFcFvoUaPrCDAlolRfNdXjzNsmfwStk5IMvakRhg1ARhb8Mln3RyDs0BP8WocWs
         K9nvh1NFt67ORIAyLDVl3QzgTvLE+ZLiAg/CNFps=
Received: from papaya (papaya.meie.biz [192.168.1.206])
        by mail.meie.biz (Postfix) with ESMTPA id A476DA95685;
        Tue, 10 Sep 2019 17:20:47 +0300 (EEST)
Authentication-Results: mail.meie.biz; dmarc=fail (p=none dis=none) header.from=kraav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1568125247; bh=cKzJGcLcvGFlhWR96PpkKHDXEqAYhIVzH0O2bLoUI5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZqG4nvbgwQIPLlLUrxr8JwKybOsxS6R1lSq8I/RFqfuiBLssgCH2d5Zt+FtSzeNV2
         5qJ/q1CnGiEvaiRIjEoOZQC872RhMa7hj+G62JjO8hxvXGfoabJ5ZOS57Phd5CDYAd
         2LgEQPOGtuIaVpy3tm674rVQP/7HxJ+aYWHk/0KQ=
Received: (nullmailer pid 3786 invoked by uid 1000);
        Tue, 10 Sep 2019 14:20:47 -0000
Date:   Tue, 10 Sep 2019 17:20:47 +0300
From:   Leho Kraav <leho@kraav.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Martin Wilck <Martin.Wilck@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
Message-ID: <20190910142047.GB3029@papaya>
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
 <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:53:43PM +0100, Chris Wilson wrote:
> Quoting Martin Wilck (2019-08-09 13:41:42)
> > This happened to me today, running kernel 5.3.0-rc3-1.g571863b-default
> > (5.3-rc3 with just a few patches on top), after starting a KVM virtual
> > machine. The X screen was frozen. Remote login via ssh was still
> > possible, thus I was able to retrieve basic logs.
> > 
> > sysrq-w showed two blocked processes (kcompactd0 and KVM). After a
> > minute, the same two processes were still blocked. KVM seems to try to
> > acquire a lock that kcompactd is holding. kcompactd is waiting for IO
> > to complete on pages owned by the i915 driver.
> 
> My bad, it's known. We haven't decided on whether to revert the
> unfortunate recursive locking (and so hit another warn elsewhere) or to
> ignore the dirty pages (and so risk losing data across swap).
> 
> cb6d7c7dc7ff ("drm/i915/userptr: Acquire the page lock around set_page_dirty()")
> -Chris

Hi Chris. Is this exactly what I'm hitting at
https://bugs.freedesktop.org/show_bug.cgi?id=111500 perhaps?

It reliably breaks the graphics userland, as the machine consistently
freezes at any random moment.

Any workaround options, even if with a performance penalty? Revert
cb6d7c7dc7ff but side effects?

5.3 has useful NVMe power mgmt updates for laptops, I'd like to stick
with the newest if possible.

-- 
Leho Kraav, senior technology & digital marketing architect
