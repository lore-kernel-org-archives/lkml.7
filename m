Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBA20657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfCIXTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 18:19:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32903 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCIXTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 18:19:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so726035qkf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 15:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IctX6Lc+WsgET9r+Z5B19nTNPXzqoQl3ARLlRVXlxA=;
        b=irZ+NepYs7IlQtjT7D/32ktN931Wi+YRrhK24t4PcgNmuuNZL8SaT685QFrOF+vvdn
         nGH/AQlj7rUhvobezRneeeOwGHqaOHMR3kQYQwr9h8GrMW7aa3lWq4Ov0oZBjeyfibco
         Cn9R+fN9Pk4ulh/cIjZA7HeWqBattpzPzqXp1xFar8Y2MuAullqd9qYGSvDhILWk4Ac4
         0MANTMv3nMTZZIY0BJ/CAy8facw0wMfsyIhCQoTMI6eQn394nOwBE4kqBmd/AsjisNuG
         gafyknzDqRmquvAw1FkkXshduGmxRQWPy5t1ZrZJ+RmEtL+awxwrStuSwasw3luIfHsN
         TKFw==
X-Gm-Message-State: APjAAAVhDY9S+GJeIP2QSgPDgskNBgp2xHoI+hYUqDj2k+oUv2wzRKMl
        7PmibU2DBqqu3ZeUOcyM12bQHQ==
X-Google-Smtp-Source: APXvYqyhn7x8tjFgHqERe/TtlptF7Bnm4+QNGPEuYhY0YmP8XjRpTaFC5jm61To+R0wnsLrZ5gfFsg==
X-Received: by 2002:ae9:f10e:: with SMTP id k14mr7706097qkg.328.1552173550591;
        Sat, 09 Mar 2019 15:19:10 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id b21sm858727qkl.17.2019.03.09.15.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 15:19:09 -0800 (PST)
Date:   Sat, 9 Mar 2019 18:19:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, jasowang@redhat.com, stefanha@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: silence an unused-variable warning
Message-ID: <20190309181754-mutt-send-email-mst@kernel.org>
References: <20190306110602.2529137-1-arnd@arndb.de>
 <20190308.151726.1373226353046701716.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308.151726.1373226353046701716.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:17:26PM -0800, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed,  6 Mar 2019 12:05:49 +0100
> 
> > On some architectures, the MMU can be disabled, leading to access_ok()
> > becoming an empty macro that does not evaluate its size argument,
> > which in turn produces an unused-variable warning:
> > 
> > drivers/vhost/vhost.c:1191:9: error: unused variable 's' [-Werror,-Wunused-variable]
> >         size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> > 
> > Mark the variable as __maybe_unused to shut up that warning.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'll apply this, thanks Arnd.

I queued this for next linux already and it's been in linux-next
for a while. Sorry that I didn't reply, will try to remember to do it
next time.

