Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF77C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5872073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfrGBxtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgAAScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:32:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46034 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAAScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:32:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so30009594qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 10:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q2Ccz2OnLgnjl5REhxz8UKHwpG1ptp4cNKXpqe74brI=;
        b=RfrGBxtnogBHboyuNOlbVwAZmirzY4kuH40QCBn9Sj27oqLMPH+djGRkpJIiVnL1hG
         yC1qzhgoC40jC4VdSK6xd5ZICyn9Dab1cAFgrtN5TPmg7xqL52Fl7KUn660dqiro0V/F
         7M094jheYW+9AZ7B8UF6zJ7rKIw+2PTT03SmVKirw4q8N4TxsxBcmJ3s9wbpYbc2/qSC
         o1YVtzpJVIBrteK/2/6msEEcA+0+074O1WRveoJZ4ZHJjqISRXBD+msbtDZQw0MbFSeC
         PlTCB/ZApyrR2jkM/wLxz6aNAlCKzA6hyiJOyhP4oHzSlhRPesk98ct3I9+jbXZ38lEU
         LtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q2Ccz2OnLgnjl5REhxz8UKHwpG1ptp4cNKXpqe74brI=;
        b=Z72caURebMG/0Go1w2JAOLb6zKggUG1o2mWVOQNlO3Yq1zcirEssYbnDwJ7qO2Gj0a
         4dgJIgqnz698Fdn6YEgG8b51aOzM/5SLbROHXpYvoyd6AJzDm4UgezZrhF3uRMIGyQ4d
         WM2nqIEPCnJjZxZeFRonhVbJ0juh1ZpaVedennJ2N3VssuPNLW1v3ABJyUmo1musROXK
         SNCCiiAOZQXniYStzj+AO1x60uIyKUzJHfR/Kua90z+1lx7GFad8Xr6BHGxQyol7KXgE
         9PQsOGr4Q1UfKpT9xbHlL3i9i33mJ0uTM+5riuklxCv1RMX0yUwfde2MfDgdvIMiZNbs
         /DIg==
X-Gm-Message-State: APjAAAWKA7v6FXSbF+e8kZg22pqxAnh46gfAqldZj8VzLfJrFuzuAg/V
        niy+F93ffoxzLa5L2b0Z22s=
X-Google-Smtp-Source: APXvYqwiSMCw5qGN+pqwqkFQKeTlZOkxeb8SBmiWlCwk3Q2kPcI1VaMy5ok5+SF2fXjc7+Bm47IcvQ==
X-Received: by 2002:a05:620a:20c7:: with SMTP id f7mr64250292qka.440.1577903565858;
        Wed, 01 Jan 2020 10:32:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i23sm14471478qka.113.2020.01.01.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 10:32:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 13:32:44 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, youling257@gmail.com
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101183243.GB183871@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200101003017.GA116793@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 07:30:19PM -0500, Arvind Sankar wrote:
> On Tue, Dec 31, 2019 at 04:02:26PM +0100, Dominik Brodowski wrote:
> > If force_o_largefile() is true, /dev/console used to be opened
> > with O_LARGEFILE. Retain that behaviour.
> > 
> 
> One other thing that used to happen is fsnotify_open() -- I don't know
> how that might affect this, but it seems like the only thing left that's
> different.

Also, this shouldn't impact the current issue I think, but won't doing
filp_open followed by 3 f_dupfd's cause the file->f_count to become 4
but with only 3 open fd's? Don't we have to do an fd_install for the
first one and only 2 f_dupfd's?
