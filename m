Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A930CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572466454;
	bh=COfCXFzHprFhxFxRMwe4Jl7Ti+0t2sr8gRDERuMYhlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uM5U7XZnhMqiC9DibjgP9UaahHnM29MldckO9lTmiCTLEp2rFi9U1cjYhjBa3KjYz
	 2Ye0kMXWQfv/u5f2HEgYyNo4n8XwkoteEeBKomhMKcMvUWzN3EtDDeWYLbl6k1pguu
	 FELifIRgprNjUCxPNP/dXlsHNpcCn3NmdnT9wVgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJ3UON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfJ3UON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:14:13 -0400
Received: from linux-8ccs (unknown [92.117.144.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB8C20659;
        Wed, 30 Oct 2019 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572466452;
        bh=COfCXFzHprFhxFxRMwe4Jl7Ti+0t2sr8gRDERuMYhlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YZ4uHiaIA0oGsIm4GiapO/wVRNQ6a3nTLDtZEEetrIRpvlmWStFFnRhckfQIehq2
         vSNi5CKFMCE+Bkh07mQhBryebVuskV/8O4iQecQz5LC4HeJpYsWylpBHhkc2iLUwq+
         Yv8YtBHvZCRcGotP2AmGqJV4mYTVTbMhSyoAAgPM=
Date:   Wed, 30 Oct 2019 21:14:04 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] More nsdeps improvements
Message-ID: <20191030201402.GD13413@linux-8ccs>
References: <20191029123809.29301-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191029123809.29301-1-yamada.masahiro@socionext.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [29/10/19 21:38 +0900]:
>This series improves nsdeps more by addressing the root problem.
>
>Based on linux-next.
>
>This series does NOT apply to the Linus tree because
>I updates modpost from my Kbuild tree.
>
>I can pick up this series to kbuild tree if there is no objection.
>If it goes to the module tree, we need to discuss how to deal with
>the conflicts.

Please feel free to take these through the kbuild tree. Thanks!

>The modpost is actively touched these days
>from both kbuild and module trees.
>
>
>
>Masahiro Yamada (4):
>  modpost: do not invoke extra modpost for nsdeps
>  modpost: dump missing namespaces into a single modules.nsdeps file
>  scripts/nsdeps: support nsdeps for external module builds
>  mospost: remove unneeded local variable in contains_namespace()
>
> .gitignore                                   |  2 +-
> Documentation/core-api/symbol-namespaces.rst |  3 ++
> Documentation/dontdiff                       |  1 +
> Makefile                                     | 10 ++--
> scripts/Makefile.modpost                     |  8 ++-
> scripts/mod/modpost.c                        | 55 ++++++++------------
> scripts/mod/modpost.h                        |  4 +-
> scripts/nsdeps                               | 29 ++++++-----
> 8 files changed, 53 insertions(+), 59 deletions(-)
>
>-- 
>2.17.1
>
