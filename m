Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921A820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEOHh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:37:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39816 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:37:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so1377568wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yj9XZyJEigbRqa/osUD7R/GjHPQqzoncrjwPfcCT3g0=;
        b=UTwxU87aVxw+hx4LoaTGbzHSWQXcUtRxhsSQnoqkiqYjq5mrS37dQ7VRMtctHbXj5d
         u1QcAZjFWJuNMFv91PCdF69OzSNq2cCXE4BpPCxRZ8JJy/U3+miLqM5DPQcokHCZNgM7
         yN88rFqYXf4q6cTgz2VPZOrox2tCXlqWMvEKUlMnO7GUBocdbRuen70B/sdk90Zh7biH
         MPqEieCp4Zf2XZSQpEqRcUUHa9owfkDF7FosX9lFBGdvdfG+NVpErDzLGhQ8aVGvBLRx
         oCdZFYUKRRoudSMmadO9k8SmhEA9cWhpncSEUaCvNmAkyvNAKTj/u03gBNXdPFu34RsL
         y1xg==
X-Gm-Message-State: APjAAAUk77qxZko7R8idCw3V6uqQSXGgYT4Vj2/7SLzLJIjCpJsEdTss
        77KMMoNi7562pBD2jtw8dPQhBw==
X-Google-Smtp-Source: APXvYqy5zHWEswH5rTU3ScYtOdXyuOYlmXMo5vxxHaeTCW2lRo0/VMy/6pvvXOi9nmKf0bD4sOWD2A==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr10334074wmj.87.1557905845417;
        Wed, 15 May 2019 00:37:25 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n15sm1056219wmi.42.2019.05.15.00.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 00:37:24 -0700 (PDT)
Date:   Wed, 15 May 2019 09:37:23 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515065311.GB16651@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, May 15, 2019 at 08:53:11AM +0200, Michal Hocko wrote:
> On Wed 15-05-19 08:25:23, Oleksandr Natalenko wrote:
> [...]
> > > > Please make sure to describe a usecase that warrants adding a new
> > > > interface we have to maintain for ever.
> > 
> > I think of two major consumers of this interface:
> > 
> > 1) hosts, that run containers, especially similar ones and especially in
> > a trusted environment;
> > 
> > 2) heavy applications, that can be run in multiple instances, not
> > limited to opensource ones like Firefox, but also those that cannot be
> > modified.
> 
> This is way too generic. Please provide something more specific. Ideally
> with numbers. Why those usecases cannot use an existing interfaces.
> Remember you are trying to add a new user interface which we will have
> to maintain for ever.

For my current setup with 2 Firefox instances I get 100 to 200 MiB saved
for the second instance depending on the amount of tabs.

1 FF instance with 15 tabs:

$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
410

2 FF instances, second one has 12 tabs (all the tabs are different):

$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
592

At the very moment I do not have specific numbers for containerised
workload, but those should be similar in case the containers share
similar/same runtime (like multiple Node.js containers etc).

Answering your question regarding using existing interfaces, since
there's only one, madvise(2), this requires modifying all the
applications one wants to de-duplicate. In case of containers with
arbitrary content or in case of binary-only apps this is pretty hard if
not impossible to do properly.

> I will try to comment on the interface itself later. But I have to say
> that I am not impressed. Abusing sysfs for per process features is quite
> gross to be honest.

Sure, please do.

Thanks for your time and inputs.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
