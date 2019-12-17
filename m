Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93691C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655A120733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok5ZndZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLQFpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:45:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfLQFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:45:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6896097pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 21:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfrN/rZcexgOtVdjDxoUvjNUMsDg+9GTHwLKXMJB6OE=;
        b=ok5ZndZqbdzT+n4aXHxDzOFxBdDtA4GkjyyGXB5IQqqSqIc1n3nbT+HTQHrjj38KG1
         3ROrba07sGe9zVDooPo8lwUfdkbXD7AseV/8SaGn8nPrqOVkk1mLXLPmYdPzJpno4s6C
         EFBIqEOZIsEjmKRITIEWLqn92jDBOdRLx2gXTo1fYzqVE048/dR/as8/o9GuCL3W/nhC
         GGDWc4uVumOyhl8Zy7P68UcVWF55DZ0BXN9sbsVpF9sWynkyPQjHlFgxRn9EXlu8cboK
         g+hToWP/7D2GiCNMZj0IKamZmYTByHqRBdOVVZ1TGFdIILcX1dggnqEC8H8kXiOV5pBg
         weuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfrN/rZcexgOtVdjDxoUvjNUMsDg+9GTHwLKXMJB6OE=;
        b=HL/F8/vGc7hQfRMN8ih1jtWoeDLKidQvdxUDRHknnKaEuGTeio0nuOALwJMuSfDdR9
         sqIcgIkmswb1cH33bI2HWD6r9+v9imucZ99dtsQIJmY77SN4ACnzRGMIJ6SiR/qRkmLJ
         l4sOPSIbn39XvW083U6zgu1Zk+7fdTqDvpqs6B5TkT6iPrwynhX/Hx0E5Y5VfzuWgMk9
         tFRAG47Ts5KVqHK7AQVvcCuc6misI9WVzbW9vixGhTrzDNu+j9oCAjMUbrZQ8cuWhIWU
         oiTeYqST0Rp00osgwoxUyosnExW4DBKB3yuyEc23tleh9nSipTIHJMMJdoKQpQPJWqDY
         DGvg==
X-Gm-Message-State: APjAAAUgJtowM66X3Vc96j2aPcEMJ1HSWEDfeZn248geTdyeCtlBlqRx
        FFCqMYwxz+bNqAHrVfgi9Yo=
X-Google-Smtp-Source: APXvYqyfX/1IDat9rsde9SvozIGGj7ikL/4og0PV7qeQ/S+T04Gfuh6h4A7T1uDnUMFPfbZt21fkUQ==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr23083911pgi.32.1576561518330;
        Mon, 16 Dec 2019 21:45:18 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id w3sm24411420pfd.161.2019.12.16.21.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 21:45:17 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:45:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20191217054515.GB54407@google.com>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/16 12:08), Benjamin Herrenschmidt wrote:
[..]
> 
> This tentative fix changes the loop in register_console to scan first
> for consoles specified on the command line, and only if none is found,
> to then scan for consoles specified by the architecture.
> 
[..]

Looks good to me.

	-ss
