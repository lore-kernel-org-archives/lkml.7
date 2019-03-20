Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBF4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YFtoHdtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCTU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:59:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37487 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfCTU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:59:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id w66so3170540ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dlgp2MdnsREd+nc4jSTOXVYFicF0JfUh7ydGu+tAmLg=;
        b=YFtoHdtQVZ9UvOqKhzJE/FYr9snrw4U6DTalkvSVji/qTo+Xewly3DaO54P3LXZ00N
         DCkyCPgHLU6+6peHoQGzFBSNMQ1D4WoC/K1tOo2p1k1QMllPOcX8vSVwg9ot+itOWnBs
         MFSu8ao8DVt34JuqAB4FTA2K8AzQbqj4tAMwjc16oPP9nyN3gqyDdycq/R2eLmQM1eCm
         CnCh36QBmpaU1h3lP7b4Ro7nEi9FuAIhuZCMDi2tUulho3iic+3sgGjB6yCKgjn0ex4S
         yCIqdP/J6iBjKtO2cK0DNc80TYtqEbIYBWvnXXYaQEyWh5PpPvvGz5YB8bpekTOlJPAr
         wsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlgp2MdnsREd+nc4jSTOXVYFicF0JfUh7ydGu+tAmLg=;
        b=EYo1xuTSQOiZdL1PoW10dbnEuc4EU88zd9eSYZvN+nhUlbuzTqlQWS0Ckjg75SewWv
         fWk8C+Bm/VP0IOA8cwWp03+x/pcKDacoLOY4mejkWdsu3A7kz8GdM2cwhwVtTh/fP6tX
         mimGeysO1ZC1Hobfue7cKGF5dIF7ZzaAN+JVcZrx+z7T8sFPk3dlZX6ShbwBMJAzNRoj
         pvhQIrVzDej+PjO/Gzc+Lbwqc85F+g74ZUtf5gtFB1NSGWwznQRDMSMeggRANcs1kgNE
         tXlySxcu8txkAZC+GTsd5jMnLkqQYuN/NTv4uysYvYtNN69tw89fq/JBeQwKO6hI+rK9
         yGyg==
X-Gm-Message-State: APjAAAUT3qG20dpn6ZdgU0v6wyPAmowu2VovgvDE3u8wDmPhOWRK4GSF
        3JhoapmuQvsU/krczC66v+thhw==
X-Google-Smtp-Source: APXvYqzXoLupL+n72SdHmbmKb5aynrZfObbwlDHWH7olugK1jMsRTp+3aMDyANbp/+KSCDMMXL6v6A==
X-Received: by 2002:a25:e54a:: with SMTP id c71mr6067ybh.336.1553115557703;
        Wed, 20 Mar 2019 13:59:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:b52c])
        by smtp.gmail.com with ESMTPSA id s18sm974233ywg.100.2019.03.20.13.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:59:16 -0700 (PDT)
Date:   Wed, 20 Mar 2019 16:59:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 4/7] psi: split update_stats into parts
Message-ID: <20190320205915.GC19382@cmpxchg.org>
References: <20190319235619.260832-1-surenb@google.com>
 <20190319235619.260832-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319235619.260832-5-surenb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:16PM -0700, Suren Baghdasaryan wrote:
> Split update_stats into collect_percpu_times and update_averages for
> collect_percpu_times to be reused later inside psi monitor.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
