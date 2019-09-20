Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE77C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDBB2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="necAoHoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405931AbfITJ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:29:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46486 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390037AbfITJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:29:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so4088970pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKysXkUjJIDiC70dCWkExHMAiHuCTeID2peKi8oJejc=;
        b=necAoHoe2AbHu+zV2D58A4p6CxwsYKFUkIAZ/KhJAxWQiIrYHLi5aNIfvZeUzMOWJ5
         gNmJ19ErqfCO2qA1S/M6fgj6+lz5+MmiLwIrbOMcR2mU4v+QF/HFI+QdyrIJ3Yzw+o/z
         ey3+8Rs6qG3t3RfQYeR4WS9BRChqYlAQcizpeAU/6MzuM0TyriYrcvJqcwV1PyjwVVg9
         +EUBq+gqPZ3QEVj4TuPjKSG5Njfmy2hXQda3wDH98KBolLjLz5QhK3G+zM2Z/ViWcK9l
         CzEDyWUg9o5XpIZ/n4n7RNV2oyJBmontSuyFKWedZ3HYFSmmsYx5wfwUxmH1Xpc7IoWu
         LPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKysXkUjJIDiC70dCWkExHMAiHuCTeID2peKi8oJejc=;
        b=rmZaDNkSaWvHXQf5cBuXHy70oKjlkcC1+aUVQYhTsmnDopgX0YXpk8ia5MEFOSVa3u
         GvAdF1Ebe+oeRdqGtURuPMgQkziwFVVGTsTSWFmqkokTLgNLLcbDScYaGYSX/cUZ3wHK
         rLz4cOvr3u8plYVKFYnRE7NNnVLfwfdY9C1dhHEIvDdRI2hO7t0ZXjBdgHNv+IGQijzU
         cWASM3Hx50V4wpGOTpDlaUibQGLeFG89sxuMJm3ptZf2g5y1TiGhwNb9GvOMJhcm5sqv
         s2op5GvIEA18r8+as8dRyizhQw/JggL5LaqjPzviNNgjV2XeG3++19knkNM89OL8cCqG
         gamw==
X-Gm-Message-State: APjAAAUBi0gdOC0C423cCFOkym6qqVnenR+STzZi1PHTkK1854wlpeCz
        SvEsBiB+GhnMxCeCH2LgubM=
X-Google-Smtp-Source: APXvYqyB2QDLa3h/eKl3m58OnNyKtDHYOCHOUHdb/TjBD45VMltFo5iEGFphWKLYjrn7h3/TnaAYnQ==
X-Received: by 2002:a17:90a:9409:: with SMTP id r9mr3637574pjo.10.1568971766528;
        Fri, 20 Sep 2019 02:29:26 -0700 (PDT)
Received: from localhost ([175.223.11.25])
        by smtp.gmail.com with ESMTPSA id w6sm3905558pfj.17.2019.09.20.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 02:29:25 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:29:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
Message-ID: <20190920092922.GA15815@jagdpanzerIV>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/20/19 14:25), Kefeng Wang wrote:
> There are pr_warning and pr_warng to show WARNING level message,
> most of the code using pr_warn, number based on next-20190919,

Looks good to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
