Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A20BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9AF20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="jQtFbDri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfFNNln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35818 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfFNNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so1678742qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=jQtFbDrieAPENr34h0NUQDNe209XEw+cgr6byx7mhVe+H/I4OpVT5Rmtkwu7rOTXDf
         UZyyDSms5H7OeZUnR29dpbgr+m10jg7GwyH4EjG9Ift7e1mZBpK4rQRKA5x4zK9cIUam
         PFXJWxFZ6irPMweVHfjT48XHVwUaLlv+WO9I8Y36/SMVyJdGBJdbhncsXKKVQ7hH+pq1
         lqPArqtDo8LoKzaNMBpxhNCABn++pc4m+hJgJEN5Lt2W6uFoh20WmEjYvxnYorDjx7sw
         aS7oYnV14PWuNtxeFf9la+DtngnBiNQEOROSSRJrSkgZJRuTXnUNfuUU02ZE43H3xx1Y
         d5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=D4pn2VXulVi2K/VFG5WM0dEklZem60BfGnIiwdQ3IOjjzvOstAFwV+2CGjPEE1wcSM
         oW8Mti8f+T0+mib+hLdJ7We4ns1gJviC19VwqlMm2ledC3eabjs1e2tqutZ4GnUWqfZs
         bMEslJl99tKnDhjATI+hJJ8RLS2UoEuDnG4FiOvE9ypPf30GYLbBI4jYCB8OuouLqfKT
         DFrBPF3UByHhKYiJcPi1BWRwmrjlCxLZX3KhzyuEgXWc5hqr/pjmx0c5afcfxvN3oyZC
         aqljWyUZa0rABkbe5+X3rd6VnrnXdnItCejg5ioivPl5f5m2I9K8qG594EJt+KeqpNQ+
         oImg==
X-Gm-Message-State: APjAAAW58cmULvQQ+/NiBcfh2xUoULi8dyXX5a3RixIYzjLohZZdfp3Z
        uh0/65D8/y3FwbVp+WDZ6ak6Dg==
X-Google-Smtp-Source: APXvYqy95F8IXy3awZMsVz6XFn2JcaEs7ITo2Lhv35mkO5CbPjyv/eOkl5aUm+OphfRVf0h+M09noQ==
X-Received: by 2002:a37:4b56:: with SMTP id y83mr32892834qka.338.1560519702426;
        Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id l88sm1602172qte.33.2019.06.14.06.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:41:41 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:41:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/8] blkcg, writeback: Implement wbc_blkcg_css()
Message-ID: <20190614134139.miko2ypm5znqho6f@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-3-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:44PM -0700, Tejun Heo wrote:
> Add a helper to determine the target blkcg from wbc.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
