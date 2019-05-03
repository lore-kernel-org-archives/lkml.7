Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901B62177B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556899076;
	bh=7UvSCsvaU3FibAjgp3LxMomulZ/CBjuKxs/Y/E35SNw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WpAN0k4e3h1tp4vVA9o1gUDqq9csnKRpHOftsNgAg5iQ89+a02gyvOrQ8+i6+pRGX
	 TdeOn14wPx6ddCnPeREBYmbLIhjwVl4j48GROjNpN6HoBUNPsjTM6uPXq0ePMEPJww
	 ToczvUnE2kRSeMZNNlY8ZT07ppwYsjvDqWIRCWGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfECP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:57:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfECP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:57:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id d8so4747693lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ibRuMb4Bna9Lf59jNSb/p17IRXiYMOZB66PZMleQAFs=;
        b=Mq5eVoczRJURfZsdXhS9oP3NhpZv5wXhXnOqp8qHWiNvQOz+rETlU/A2QcKUFDFnz5
         Sq1JQFVWaj/80vebLcI8fipUuRYHaPgAnuXp33kyQZgYoXDOR0aLYLuDD2rALAjF+Zhy
         dpbVZPOmZt+6TOX9GKp1HHfqn5zT7UxqO+9KZkoZuJn69h2Kjni3cRm4us8aF1UVB7DT
         jb3IDXkG8+1Ykv5CZKGKOhB99FAKcu3zP5Ckv+iUsTV7e+2RRy7OylJyhZY32uuSpS48
         pDAelmOujjfiAEOHFKtjcHTue6xN0OTBKHqHzL8JDJvFNCIQOQFgtngRhrkmofxfxRl7
         mRlQ==
X-Gm-Message-State: APjAAAVjL0UXRIZnlxiEbIA0G7kpwhTsGl6JVNf65gsN5BqJeIi/AhqV
        WtGAqWJ3jrQdQXrCA8HB48e6ogEb
X-Google-Smtp-Source: APXvYqxNrvBi+4h1bzhwzbJoyVnewtUL64RWBQcrUpTLhoG9hITlqJWzOLTFjKvD9azlcPU/xPKz1Q==
X-Received: by 2002:a19:550d:: with SMTP id n13mr5390047lfe.127.1556899073034;
        Fri, 03 May 2019 08:57:53 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q21sm491761lfa.84.2019.05.03.08.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 08:57:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hMaZZ-0003Ix-4B; Fri, 03 May 2019 17:58:05 +0200
Date:   Fri, 3 May 2019 17:58:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 5.2-rc1
Message-ID: <20190503155805.GA12685@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.2-rc1

for you to fetch changes up to 7cc10c5cb14397d61d203d0a319ef796d4f6d943:

  gnss: ubx: add u-blox,neo-6m compatible (2019-04-04 12:46:19 +0200)

----------------------------------------------------------------
GNSS updates for 5.2-rc1

Here are the GNSS updates for 5.2-rc1; only a new u-blox compatible.

All have been in linux-next with no reported issues.

Signed-off-by: Johan Hovold <johan@kernel.org>

----------------------------------------------------------------
Ondrej Jirman (2):
      dt-bindings: gnss: add u-blox,neo-6m compatible
      gnss: ubx: add u-blox,neo-6m compatible

 Documentation/devicetree/bindings/gnss/u-blox.txt | 1 +
 drivers/gnss/ubx.c                                | 1 +
 2 files changed, 2 insertions(+)
