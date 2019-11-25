Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDAC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EDA20815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="A8kCdasR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKYJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:15:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42218 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKYJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:15:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so14877814ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FcfAwDLFSNgmDLyFmP3mnRn5XPVP/dHuo5ueDN07hL8=;
        b=A8kCdasRJZBhUbUFtfqb5rMrJhY6qNfcEijrrxgkjPoeUE5M2cQ/cSebh/iOdguAYB
         8wSrm2cFQTzJbET8njVhqjivMpt+smTtDA5bfSKYqOsNdUkqXz4lolnMUheJjAnf5LVd
         j0Sz0rfYd1faPSXbjyizjLxqyTGe6WcM6s+e1UpALYOVJOBwZKHlG/jasxCvLaZTK2Po
         p+xbhoGkmYrAbHynoCLWeYk0/ZzQF/eOXjTVawRfbWB07ciCticc+gPdgP9yG2WPcs2y
         /6FfE7UxlgQH4+5R/939uPj/IcpEYlo57sLeQW3AgAJH+dEYhDkhPo6LCuwUQmnkHDps
         lOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FcfAwDLFSNgmDLyFmP3mnRn5XPVP/dHuo5ueDN07hL8=;
        b=uoTl7Y4N9RYbtVWt0akZuuZQ0Cb4EI9OgJUxE52uweMDbKo7LLeyKDw8mnHmrxxF03
         X9mb8nOofsnLpqC9b6bRoP0wxooY63S9R33811N12bO+KGGMRxkI6ySjBJh3zxpCQHow
         W133O18AWxs7Ad9PNLGxecrDUKWhOufnRoGgja6HPUh3GvAxuSedXXRmWl0TaHDRTOem
         qXviy9KyutOVqgmve5b8+gkOdnS7zg31QPQnscPvFch4x4bsw6qk/TxapGNgROD3l927
         f1Js/WGBf7xxkG2x7o51wHysjg994Ju+rdmXyEhg1BzTuUYlHnvjnL2LLamhVWaJdkmN
         7+xA==
X-Gm-Message-State: APjAAAX7BKTJpviTP4ek8rdiuEW1ZjMpyPQh2EIbPkvCoGRVFvEjEIIV
        4snQsKjD5Ghb/eIIBSVa+V2zgw==
X-Google-Smtp-Source: APXvYqx3omxBvBBPAeuC2qvJocDKxfyY/bfPA/SuPulk3OiGBBrujyPNMsYgSAQTEVKepMR1D/JfQg==
X-Received: by 2002:a2e:9695:: with SMTP id q21mr20770656lji.206.1574673300853;
        Mon, 25 Nov 2019 01:15:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q21sm3267727lfo.4.2019.11.25.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:14:59 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CA1C11032C4; Mon, 25 Nov 2019 12:15:08 +0300 (+03)
Date:   Mon, 25 Nov 2019 12:15:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, cluster-devel@redhat.com,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC PATCH 3/3] gfs2: Rework read and page fault locking
Message-ID: <20191125091508.3265wtfzpoupv2lj@box>
References: <20191122235324.17245-1-agruenba@redhat.com>
 <20191122235324.17245-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122235324.17245-4-agruenba@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:53:24AM +0100, Andreas Gruenbacher wrote:
> @@ -778,15 +804,51 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct gfs2_inode *ip;
> +	struct gfs2_holder gh;
> +	size_t written = 0;

'written' in a read routine?

-- 
 Kirill A. Shutemov
