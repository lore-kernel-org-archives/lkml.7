Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EDEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46683206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN55qC1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLPPEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:04:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39991 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfLPPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:04:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so4581722plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ru9ZP393xiQIU3liCuClOmen3ZB2IdI5AXnFhsH91tk=;
        b=bN55qC1+/7z1fMH1E0MDfoD1t47wTn+0IotXduAtzVcQ+VwLmdXBLlKH51AxC6J8Xa
         WqNGZJKctm7b7AOFBUzcrweG+aXOSoenBUgjb4JSjXwamAD9miWbE0AwAZLTMmuRUmA/
         HXG8MKQZ4NbTuKw1OJGhq7fbu5qD3V4m6MzJWpZFgjtK1vMpVIjJ5RtHKuNATFNfeBAH
         0c0ESEX3sh8dYnHUu8RnXZRdOmkRo6rMmFa+nHriinNXZK3wr7MUO9laIKDyg6390Mu0
         20xCy+FzpwWnUaLh6NgGckN/63EXs+EYLO90e5nMO5ZInvojZKTigh26ddF3F5dcFlVt
         1ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ru9ZP393xiQIU3liCuClOmen3ZB2IdI5AXnFhsH91tk=;
        b=MHDBoaHuxXDiBdE2QHxo2U/DJuDrq8abN8DI+eDTD+oECZQUqwBCCmLsFIPk1OGDSu
         hR7jOKJEl11hjoY8Kt3fyHhuQ5PdoD6NETwzXBAiFf67b8GxEHqfWQNajkg4fqrkcLpe
         TAXp6EsS+BACyPmcoqvj1w6YF3DmkgjS6yzjxkIWx62ymIeYLrK/RjV9fy+4q8jaZULx
         xBFTqOk5Ch+kjf2qVTsnSsXCOBaVTHVYD8GTfnrVPKRrI9S3hPFZ4JLYnOfwRAl/yBLJ
         HcRvPIDZvLssWL93dOzJxFeDcNhbeTynabRkzdHTbKstFtNoZ+7+oKdSZXE4keVmA4I/
         xRYQ==
X-Gm-Message-State: APjAAAXmWE99OObo6zJjk9qdAJEGMMHsM40JDFZqUDRMMttivxEl+1kb
        HUth4E2qhpZBgBlJ7JRpYWw=
X-Google-Smtp-Source: APXvYqwkkB1JurKWfEsYRLKpdUlD2MLUcdxdz6Dt1z054l7AE2iErWltqDe5zi7OIuJvA0YBQwt08w==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr16955873plr.215.1576508654750;
        Mon, 16 Dec 2019 07:04:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16sm21965957pff.181.2019.12.16.07.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 07:04:14 -0800 (PST)
Date:   Mon, 16 Dec 2019 07:04:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216150412.GA19519@roeck-us.net>
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216013536.5wyvq4vjv5efd35n@core.my.home>
 <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 07:50:23PM -0800, Linus Torvalds wrote:
> On Sun, Dec 15, 2019 at 5:35 PM Ondřej Jirman <megi@xff.cz> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 
> Duh. So much for the trivial obvious conversion.
> 
> It didn't take "data might be NULL" into account.
> 
> A patch like this, perhaps? Untested..
> 
>                Linus

That one must be a record.

Qemu test results:
	total: 387 pass: 93 fail: 294

For my education, what is so bad with calls like ksys_mount() that warrants
the extra code needed to remove it (and, of course, the resulting breakage) ?

Thanks,
Guenter
