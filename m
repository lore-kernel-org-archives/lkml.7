Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ED3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB69E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAl4SQVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfKKUkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:40:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKKUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:40:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so9335163wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4nvLrdx58iTQZ6N0N6ar6xSXvE2RheRcR91Pr33ZJdo=;
        b=sAl4SQVA1XL6xYS8dD+KPj3pCSbhGzwGugygLa4XU61pv5iUJOSH6HOIarP03kx+fp
         04CIFp08Vhuiz23E1bqndaDpbVbFURH8YINvtkocJpTIolpjU1Z61dTpSkx7GU9VpZAQ
         kjzALFNS+P4vNxIaD+7MROiJ/ZDPRbT+HBpKZC3g8kBXrTEamKgf8myQStjyS5iWsUn7
         jYDk5rzs2aZ/0FYHDOmKXhQw2PZYt4VZ/xJqeeQQeTTvfGZRyXd+oF9lr1mWHu6AmBiR
         It/HdX3Bh+N14Zak/iAzpfEy/pMjRwc5AGvPuxsb5hxKj6H+Mw0bbsBYoGvAaNY8LNOc
         4Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4nvLrdx58iTQZ6N0N6ar6xSXvE2RheRcR91Pr33ZJdo=;
        b=DNE5l6hnxt8/Kw0ZT5tjyItWvgBBzJPxJ4GL4cEMNwEUnPi/6J3UT6SYA7uXNcGWlk
         3fQejQFYEbSrhaUWAKa7qifG1f93aWlbtZEtWi6V3eZp/J9PfE+ORldEHhsl/lKXyOpl
         VOTCtI8JDWoLZ4YhiQ8IiHal8G6e2IR+zKSIrDRkc8kNxEJZfd3o7DdD2T4WPE5bzBm0
         HQc+bKAnOdiGEP0ekuOxexv8NF9WZi4qFufzfHUA5NzXF8IOwi2mDh58MYeJeMTuTKML
         DcF/+Z5eRQimHdJ879OmlcPOm4NYciW+qlmewL0UnjcOFV3uobWi/rQHh8WU8KYNnc7k
         mzhA==
X-Gm-Message-State: APjAAAV3ih9Ckh49jFomTo/rvgeSvSv6udd4JRWIVPOa8pz6J+lm/Qs4
        rLSHUgcYBzYDFxbIWBlnLQ==
X-Google-Smtp-Source: APXvYqwUnhII8PBtxjecZDOkD5q6CHSKHpSxugow0yERzB5IwfcEtSMay3D73FlNA417wA2jtsbAEQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr648257wru.224.1573504835467;
        Mon, 11 Nov 2019 12:40:35 -0800 (PST)
Received: from avx2 ([46.53.250.235])
        by smtp.gmail.com with ESMTPSA id z11sm19549649wrg.0.2019.11.11.12.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:40:34 -0800 (PST)
Date:   Mon, 11 Nov 2019 23:40:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191111204032.GA14256@avx2>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
 <20191110153424.GA5141@avx2>
 <9fe3a096-20b9-979a-d4d7-48a37b059dff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fe3a096-20b9-979a-d4d7-48a37b059dff@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 09:58:14PM +0100, Paolo Bonzini wrote:
> On 10/11/19 16:34, Alexey Dobriyan wrote:
> > In the other direction: describe every field of /proc/*/stat file
> > without looking to the manpage:
> > 
> > $ cat /proc/self/stat
> > 5349 (cat) R 5342 5349 5342 34826 5349 4210688 91 0 0 0 0 0 0 0 20 0 1 0 864988 9183232 184 18446744073709551615 94352028622848 94352028651936 140733810522864 0 0 0 0 0 0 0 0 0 17 5 0 0 0 0 0 94352030751824 94352030753376 94352060055552 140733810527527 140733810527547 140733810527547 140733810532335 0
> 
> That's why this is not what I am proposing, and also not what Greg has
> mentioned.

The argument was that text is somehow superior to binary. Experiment shows
that userspace can make a mess of both modes therefore preferring one
to another should be based on something else (preferably objective).

/proc have these two problems:
First, noticeably slow:

	https://news.ycombinator.com/item?id=21414882

Second, overinstantiating inodes and dentries:

	https://lore.kernel.org/lkml/20180424022106.16952-1-jeffm@suse.com/

statfs maybe never get to that level but it is not hard to see what lies
at the end of the tunnel.
