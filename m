Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BBF20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkxmP9mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLJKmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:42:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39351 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLJKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:42:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so7150604plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfdQQeeLkcakBGBCZLadlJ1Gb6o3OJURT7E+WRswKJ4=;
        b=UkxmP9mxRXTpS8hT7YgShz2dcmP5Hwuqr2jD3WSGJ07fm4fm+lPoO9zMD+Zvi3djZr
         zM+8T3oWM2JVrYhcTfAykTmzzCnhoKjtu4Zes0V/pqrwXR8nLTLKTAU6sIVfhT1okOmW
         55ztvGctEHx/cIOzl3BRQKwnHP2BCnNvrgFzYX7W+sVztMrPlLQ/VTqo1PT3l8V9hr64
         z8S54c4gW7y5vZnsE3TCdaaK88Mz8SpPXBmwese0apssXggOKhO5Lc9P+s5rc6wqqxQw
         aKRtUoiowJ//JLoPVtDjRBrokwibIk3gQgbIXML4PgZVwfvE4WAUt9Es2K4AINj4WoRm
         3U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfdQQeeLkcakBGBCZLadlJ1Gb6o3OJURT7E+WRswKJ4=;
        b=j0dtVt1DLsYQFM2jpkjwikRUaZpc3r+FcYM529tBktyVuSceLqMtsgrZRiKm+UZt5C
         x6Tq0k3YxwD+pRkn7MSfKxGzEksYO0ahy7CoqrWofYYNhGlxgm9AysdIoR66iqybLDO9
         RKwWV4ROSEk8jawhBbWvO56dBLIwq1oBms/xHT9IHoffUNaB+8v7s0MYBPoW/IDeSAWb
         2mr+91qfZOhPvUoRsnMefl33sgSfFo1DlPVPFVUmHwPAQ5LpNJlJOKnhssAplvR7VNVS
         y8zXTMld7fnf7u4XYgR6mZP48GhB1u3dJYNLh0Sp103bWSpmjfxO0GrWztxA3Ujx+6Mq
         CoqQ==
X-Gm-Message-State: APjAAAUa0PsaT/mPS1G0Awl1YqZQ+pTGlxwc1L1ejJyMdek7E39dzaB+
        Wty+ZrdB/S7ZIqmbCxe8CsU=
X-Google-Smtp-Source: APXvYqwu+tTCvyc9M4sHHFPFQ80Mkvn4JOQJ9Afdczl4FWLtBn8MV1Rpo6aKaRC84TjVx5vssAJ3mQ==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr3996110plj.312.1575974537741;
        Tue, 10 Dec 2019 02:42:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a26sm2993251pfo.5.2019.12.10.02.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:42:16 -0800 (PST)
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Florian Westphal <fw@strlen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Sandro Volery <sandro@volery.com>,
        Paul Burton <paulburton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Valery Ivanov <ivalery111@gmail.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
Date:   Tue, 10 Dec 2019 02:42:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 1:15 AM, Greg Kroah-Hartman wrote:
> This driver has been in the tree since 2009 with no real movement to get
> it out.  Now it is starting to cause build issues and other problems for
> people who want to fix coding style problems, but can not actually build
> it.
> 
> As nothing is happening here, just delete the module entirely.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: David Daney <ddaney@caviumnetworks.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Wambui Karuga <wambui.karugax@gmail.com>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Branden Bonaby <brandonbonaby94@gmail.com>
> Cc: "Petr Štetiar" <ynezz@true.cz>
> Cc: Sandro Volery <sandro@volery.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Giovanni Gherdovich <bobdc9664@seznam.cz>
> Cc: Valery Ivanov <ivalery111@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
