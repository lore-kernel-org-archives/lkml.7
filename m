Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB1ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E26B21925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="QgkcK1SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbfJON6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:58:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33450 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJON6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:58:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so30737743qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=54xgkVzZgk7ykJH9b+4053yO/DDlwH10i1FWiEony/E=;
        b=QgkcK1SDRmdM24Gc134VjPVmhLV6mwGA/y5dQFuwD01b2+nusETsUNhZqSr+/nW0rZ
         +JiFKqDXMV99qpXURKZp0uQD00zX5hXOeUBwctQ7JGaTCO9j2awkot5GhW1w5/PtRcxw
         syPoKkaffB7NqLm9jaN8767HkzroYFmMZy4qaTAFdiEEfo4LfvsjtHH7VonrLZRcg93k
         lh7a/GGnR7RGgJZZvcxFp6naPzQ1ghFkt8ArvOJ4KxEKp7hD3C6df3OlzYTmkec1H+0G
         vd/3Ef1LaMjVbh2IYoGhYNQcaallFT9QYxppp6EGNhKxWPxaRqBccWzBuJZTgA26dz+H
         Su7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=54xgkVzZgk7ykJH9b+4053yO/DDlwH10i1FWiEony/E=;
        b=uH/p4W7UIV2+bmxAOjhIVvA1LECjWE+/zTRfkzIO2UBfgp5tOpmHRKz14E/DD2O2Jd
         DC5NUZPwx05HgEFZ6DClxxluW75UXZ6jTAuYmmkDahdMvpyYwonQSmn5D/188FJu8hwV
         KKbjRj/b580BCDsFuQbko3g9/q/S8CqEkhldoZuY/KPvkvKyXTOvC7/AOXoZl/mqUfhe
         Jfko63Aq5IXU+dx3oIT+3HKVxyYN20h9iIaxp5mAdZQo8hUcYCI+CrCoHs/xcoDchwpi
         KT1QkUIj8VqIYQFawXFhJbnJvWEv7M902SG3/ndaAqsRJOFAo9ihKcJNZXaAuaJdIQZv
         tp5A==
X-Gm-Message-State: APjAAAWSXrxvLD8vUFRm4/xsCRzRDt25ic9vqOa/su/ivV4KdVvtX2ay
        JOL0m6GyJ1rqH4D3fJw9afwHqw==
X-Google-Smtp-Source: APXvYqz0JATTqXiR7wH8+G40/GHaOMt5Y9Pn9yF5nkxLTiCLAwyGRlhU27d3qMcJw2uhMdc7HMTtqA==
X-Received: by 2002:ac8:2191:: with SMTP id 17mr39780242qty.112.1571147920936;
        Tue, 15 Oct 2019 06:58:40 -0700 (PDT)
Received: from [192.168.1.10] (201-92-249-168.dsl.telesp.net.br. [201.92.249.168])
        by smtp.gmail.com with ESMTPSA id h10sm11260478qtk.18.2019.10.15.06.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:58:40 -0700 (PDT)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     Michal Hocko <mhocko@kernel.org>,
        Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
 <20191015121803.GB24932@dhcp22.suse.cz>
From:   "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Message-ID: <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
Date:   Tue, 15 Oct 2019 10:58:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015121803.GB24932@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 9:18 AM, Michal Hocko wrote:
> I do agree with Qian Cai here. Kdump kernel requires a very tailored
> environment considering it is running in a very restricted
> configuration. The hugetlb pre-allocation sounds like a tooling problem
> and should be fixed at that layer.
> 

Hi Michal, thanks for your response. Can you suggest me a current way of 
preventing hugepages for being created, using userspace? The goal for 
this patch is exactly this, introduce such a way.

As I've said before, Ubuntu kdump rely on rootfs mounting and there's no 
official statement or documentation that say it's wrong to do this way - 
although I agree initrd-only approach is more safe. But since Ubuntu 
kdump rely on rootfs mount, we couldn't find a way to effectively 
prevent the creation of hugepages completely, hence we tried to 
introduce one.

Cheers,


Guilherme

