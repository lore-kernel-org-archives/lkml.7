Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C626ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6891E21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LUP7B66+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfJIHq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:46:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34440 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:46:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so897912lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KOoyq8RqjZWNlPjmqQisdxVkSm46lwidU3y+cPs0IOg=;
        b=LUP7B66+wEM8L5sUI+Hb62UygnXuS5HBMHRMUQ23XTZ3ZM4KcwDbIzhWRRIO0WkeSB
         1JOotOaghsMdH/IscJ8V8HYypVS99dBJu51Fz9W0rPa6Vpn9W/mluhriAa10jnIF20MC
         6Bs9GTH3J1CaxAUekp4Ru6I80r0pYPDJVcXKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOoyq8RqjZWNlPjmqQisdxVkSm46lwidU3y+cPs0IOg=;
        b=N03XeuDKG34EclsSqQLwgS1cgRmvenSF6L8aSzIFDatvNmURN6aAirFdlU4FiMGMd+
         NQ7+Ehf5XNyA8spTqmGnFTPd5ngoijj8b8MXVMndjmcTi8L+724nsx+33GSmeOEg3fVN
         1Y4fLfj7+SZ75WgLUusJvODe0FZzPGvuEyYSOifuFDduCZhhZCsBfsZfk5YBEtpiYD9a
         GJmECphV3gBnhsIW3cnibLNSpkDuY3tyyBjGMDBlKUVBN9xkUy06a8yCSlcJqg8cgbVM
         bVBzq8PIZ2+yWIZlrXifMatN9aLFvlczN0OQ2Jub/Itdy1bNexMjdwEd312qDVWOrFUa
         FpUg==
X-Gm-Message-State: APjAAAWudEOw+8bisuxXZxmzX7HcQFiH5CYhg9TJ9pIfMS1+Z6Qe5RcI
        aZijGcvtJusXQx4KBpj/qVsw63O8Hiyfngco
X-Google-Smtp-Source: APXvYqwfAAzqX3zsxoWi6OCBpof60gACh0ZPTFnk+uDgyVKE6P3tO0/u4qyRn3gBy6YF5BnuRUuBKw==
X-Received: by 2002:ac2:5df0:: with SMTP id z16mr1243326lfq.36.1570607183397;
        Wed, 09 Oct 2019 00:46:23 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t8sm278076ljd.18.2019.10.09.00.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 00:46:22 -0700 (PDT)
Subject: Re: [PATCH] kernel/groups.c: use bsearch library function
To:     Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org
References: <20191007192632.29535-1-thomas@m3y3r.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <60e43953-a7f9-c52e-150c-74059d1b377b@rasmusvillemoes.dk>
Date:   Wed, 9 Oct 2019 09:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007192632.29535-1-thomas@m3y3r.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 21.26, Thomas Meyer wrote:
> commit b7b2562f7252 ("kernel/groups.c: use sort library function")
> introduced the sort library function.
> also use the bsearch library function instead of open-coding the binary
> search.

Yes, but please note the difference between sorting the group_info and
searching it: The former is done quite rarely - the setgroups syscall is
used roughly once per login-session.

But the searching of that structure is done more or less every time a
user accesses a file not owned by that user (e.g., any time a normal
user accesses anything in /usr) - at least if I'm reading
acl_permission_check() right.

So using a callback-based interface, especially in a post-spectre world,
may have a somewhat large performance impact.

Rasmus
