Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F3A208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb8rJCy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfCHNvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:51:16 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:34939 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:51:16 -0500
Received: by mail-qt1-f177.google.com with SMTP id p48so21215781qtk.2;
        Fri, 08 Mar 2019 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJo6mF/GTQKNHpXwgB1/oZ8Ef9TkHkg4UA5Mh+n+Jtc=;
        b=Cb8rJCy67t39utiI+pA6eSHeLS4uLVbQ499SKAFI9DbcIwId/nz47H3j0Q4E8OVE1h
         48ExOFlYuMVOgtajXKg82yXfVBxP+AZ208cmvRbkhAz5STMNy80oz/1R2ftGqN5doI+y
         XuOt7gjoFFfooymHmScjyi8JtOEOPt6fTomwjZo6+OTMTiZEIMvoFZORyiAWOSp3QU7o
         VlcbfooerkZM7snoUyRT2RvJoaQnlg4Ja/v544k49RXEiZIIK/OBOQ4ibtsJLfByZ33c
         sbqWFXeuVwppQ0Aw/hr+jLgzPJEAY2mo9WQ/Lecl86XFEwOPBdNvURL4wmoXMl0TkXtk
         FhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJo6mF/GTQKNHpXwgB1/oZ8Ef9TkHkg4UA5Mh+n+Jtc=;
        b=cCRedteJnXjc+IOCcEokxL1wWMG2X446c0Eurg8OspZeo7/29JDl5L0WKh7ucIEqPq
         vEBwVAZr3aRTSIYkG5gB9GMsFKAmH/9WbiNTEhZYRysj+xjplBHuu4rN2oUzKY1eCy4N
         6a/lBK81tyN0ndMvyHrN98Or8tvN9WtsxsnRo8BOpOpjmO0pak0vS2JtJbPft4SXZQfZ
         wy969V0i99BBqXDHNJmVjJbpxT1KA9oNowk5YnaE7yLs6EKY3V1MjKVp2++oPsTbWStO
         oyHlAu7IG6Tx+T92kud7IlrHQ6inu2lKn151v4gB4qvh2Jpl3L9Qh3xAZM9NJ0rbWQID
         w/rQ==
X-Gm-Message-State: APjAAAXkiXXONMatEvJt71x1U6U2lUCruIp3TSL8w4ZfMd/483SOvuf7
        DzwKbN/QC2oqf1PCjvoxqpg=
X-Google-Smtp-Source: APXvYqxiRb8xa8JV7fYhljY23EY23oGa+BDlHT1yn/4iaAlVT4NBuufy6nCoQnu4iNBNu5jnEJ55Yg==
X-Received: by 2002:a0c:d60d:: with SMTP id c13mr15583477qvj.43.1552053075341;
        Fri, 08 Mar 2019 05:51:15 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id z43sm4908453qtj.66.2019.03.08.05.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:51:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10F974039C; Fri,  8 Mar 2019 10:51:11 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:51:11 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 10/15] perf tools: Add utility function to print ns
 time stamps
Message-ID: <20190308135111.GE26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305144758.12397-11-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 06:47:53AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a utility function to print nanosecond timestamps.

Applied.

- Arnaldo
