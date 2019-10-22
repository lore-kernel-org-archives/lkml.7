Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27A821906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="v2Z48XpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfJVTlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:41:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39085 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfJVTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:41:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so18482413ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=IsSJ5eVHCLYF53VNonxhHNCQH5QFu6jimMBy8vLyOog=;
        b=v2Z48XpBFwFxbMTkDf5egKRLy0tlp5zDEydT5/ivTps8yEnycEIoL8jhDGVwWfGvuI
         ppvyGHZ+DubsGU6a4x8vJX5X5CMUORUc+1cW5DRzs+Ke+Y9l+dXtC010OxB0Xg++o1pp
         gqb2Vad2XVp7sY546Rfu+2Jo6osuGA9tiwrBDaMHXX9G4V+v9cslCip/jMjYnA/9QZp9
         5Sq+yRvUN3ooc4mwRKWhsMXBSDeK7rIbpKt7xZtBfPdxFCCVh29BXIwQIX1sI3Q0+HAh
         e7yIyte7XiodG0qau49JmLor0pn10VNoV/udV5S8PuvxYA6HzhO+kGoogMs2EurO/DOk
         XOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=IsSJ5eVHCLYF53VNonxhHNCQH5QFu6jimMBy8vLyOog=;
        b=cu5iaNZfLAJKNd2yU7N3bCuvJ9x+eYDQwc+CYGhiZInbp199h8KJI+GuJz3nIM/dJG
         Rl56wZSq3pRQAd8uyZ/FzooClrAlm0+lx5nIVNQ+wht8nCmjDXV8Cco0NbQk32d8ZXqG
         t7VLV1g0AVBcfod53nid0Zmd0DSt/fdv4Q3k+SvUk1/OgynYvROfuPNBJoXVHkRQ47WJ
         vL9a3dQffukwXjcV2v0EOB1FLKZJ6fepWclZzVeVrryWpSvewlHn6iAhlG4lu1wzQNcR
         BDjH8CAoMhh/w9flKwfR/1oF4Zu7xoh5MebBqf9Hs4+3ljv87OYUN4oxoiARgZ9BGN/s
         8yIQ==
X-Gm-Message-State: APjAAAUmUgFUlST6xA99Vo/Wb7qXbj/sPC2W8lxWl1gsQEBbLmSwzJs7
        QNKgqkSthakPXOsMhZxCJAZCeg==
X-Google-Smtp-Source: APXvYqxMFv7GkiMNTgA/JKRIE2HHriZcON5ChaFS8ph0JapaLSggHpKAx0YiA0yGbLKB+T6OFe3KJQ==
X-Received: by 2002:a2e:8118:: with SMTP id d24mr2950056ljg.111.1571773313303;
        Tue, 22 Oct 2019 12:41:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l24sm1168910lfc.53.2019.10.22.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:41:53 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:41:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/16] net: dsa: turn arrays of ports into a
 list
Message-ID: <20191022124146.25c1fdbc@cakuba.netronome.com>
In-Reply-To: <20191021205130.304149-1-vivien.didelot@gmail.com>
References: <20191021205130.304149-1-vivien.didelot@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 16:51:14 -0400, Vivien Didelot wrote:
> The dsa_switch structure represents the physical switch device itself,
> and is allocated by the driver. The dsa_switch_tree and dsa_port structures
> represent the logical switch fabric (eventually composed of multiple switch
> devices) and its ports, and are allocated by the DSA core.
> 
> This branch lists the logical ports directly in the fabric which simplifies
> the iteration over all ports when assigning the default CPU port or configuring
> the D in DSA in drivers like mv88e6xxx.
> 
> This also removes the unique dst->cpu_dp pointer and is a first step towards
> supporting multiple CPU ports and dropping the DSA_MAX_PORTS limitation.
> 
> Because the dsa_port structures are not tight to the dsa_switch structure
> anymore, we do not need to provide an helper for the drivers to allocate a
> switch structure. Like in many other subsystems, drivers can now embed their
> dsa_switch structure as they wish into their private structure. This will
> be particularly interesting for the Broadcom drivers which were currently
> limited by the dynamically allocated array of DSA ports.
> 
> The series implements the list of dsa_port structures, makes use of it,
> then drops dst->cpu_dp and the dsa_switch_alloc helper.

Applied, thanks!
