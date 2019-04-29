Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0142C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4A20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="JwqPiMml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfD2LFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:05:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38089 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:05:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so15091962wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JyCdc5gZkR3Qq1DjvPmdztMb+4DbBLd30vsC8ayEy68=;
        b=JwqPiMmlkBbRl+8STUVjxV7mu9j7I9gu+7xnz+6/MRSZPfd0eELUIPE13g2nyX1BcP
         UJ3Rfh2muIiKCN+2iUciSFXr9sgT3tYCivqYlZB5CWJBd9DXFdvJAiA8ZkzLlAEgbG7m
         3LIWHCLCnZa+bQNv0EB1Xga3wL+CF+uEDr+8kYERbI2zFYf947r5Z/2Xo8zUpg1RoZEX
         tRhQVLMuF/TO/OHURICfhahTD61AnI6q92mzExtbtl7Un0WSPReAuC7MZCt9seOwI6Vm
         TJlf2YCzkw8qBGfmLQ/dRZ//eEd8pBGPKFDljgyRL+/dYfRMksu3/NDmFevCwp2B41IF
         WGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JyCdc5gZkR3Qq1DjvPmdztMb+4DbBLd30vsC8ayEy68=;
        b=YrVNRBSTYkcYI9+K43Rwsa3qPMuDn22H3ZNRJuOWgJCcBoVCUwZz/3lmFtle47he33
         tktdIvwNyn1zgnTlOYiB1K6JnJyMp3Ly9RCA5VkQyG+Ps0C/Toe4RKm0M4erFAfV5Nir
         iNDfJXSJlM8gq+7K4XWULl6C3KxVUSC6hr7q5varOFRn8SbmsH3ZWNtYFasgVqR7BZjZ
         LyMBV3Tkh8fTyPiuekqtMPUzpFMmYErWD0oAr82AseiyiRVG/V+dquBdYEm4LRYUw4Wd
         8BKKexQcTZt6xhiX5I8hofP5FiBUwQbo9i0vGUZ36oe3hx0pWix0QgPbG/ulal2ip7Bg
         eP7Q==
X-Gm-Message-State: APjAAAWPXYxR4aBevfPbYTXmq9hduG4aqKUBmBeT1Hkj6p5M3LaGDwpP
        9IX64T6oU5/J1QNAvn2dyYg8Jw==
X-Google-Smtp-Source: APXvYqw/L3v97PCfK7QGFiHA4eaBEqBhwMoz4vrRQKAAJImMY8oVJ6Nxd5q9Cnl7N71aiEA5Q9rUmQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr16610408wmf.13.1556535913172;
        Mon, 29 Apr 2019 04:05:13 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id z4sm10799474wrq.75.2019.04.29.04.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 04:05:12 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:05:11 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Saeed Mahameed <saeedm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Change devlink health locking mechanism
Message-ID: <20190429110511.GD2121@nanopsycho>
References: <1556530905-9908-1-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556530905-9908-1-git-send-email-moshe@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Apr 29, 2019 at 11:41:45AM CEST, moshe@mellanox.com wrote:
>The devlink health reporters create/destroy and user commands currently
>use the devlink->lock as a locking mechanism. Different reporters have
>different rules in the driver and are being created/destroyed during
>different stages of driver load/unload/running. So during execution of a
>reporter recover the flow can go through another reporter's destroy and
>create. Such flow leads to deadlock trying to lock a mutex already
>held.
>
>With the new locking mechanism the different reporters share mutex lock
>only to protect access to shared reporters list.
>Added refcount per reporter, to protect the reporters from destroy while
>being used.
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
