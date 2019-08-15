Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5A2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+rFIHHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfHOHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:50:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43343 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbfHOHug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:50:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so1060589lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HQ26YjFqd095HuQvJkZw1Unk1E5d9gNZv6ke3nfrfU=;
        b=r+rFIHHqW5m0YFQe1g8i7BLnASGugeC2XmMV0v2rXhVAqgAuup9I5P8hJNWRuVWtxD
         evsDnCtNZbRfrAKslsFUEAGfRiZSIw7t/8YWJCyZM+tCvItHgQLmqGHBhEtVSatfxZ+1
         zDewhNUYNHAgGkZfvZ4BXRdZ6Wq2OaZtZMmwl+SOiWrZZID7ZIoMKK0L/U9/EOS9NUhG
         +Pi6B8DFqwsGnCb6rZBcVrgrXs5Lu3MEN7/gRrhZZiKRQnDP0Mkn1o2o2UBIMOLAaSqa
         2+X7n001LrALm1cKCDDZpKyHydiAtOFNIT2gBWMYynGwfqyyFFfzbCqG+kOIYBY7GO4C
         llWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HQ26YjFqd095HuQvJkZw1Unk1E5d9gNZv6ke3nfrfU=;
        b=VrToq53FjM1RTi5Ky+Q7wtZjv4mO/dAia+vjpQDiJZ7UV0lK1Plf2XP1H5bK7TvxfF
         4Caucimt3H60zl+cLPfcQtSxP5v429kw0Uec1CSUarjv0BTQYSIg+9lO9RIdnWDS+RiD
         C5LuS5nHJodsFKkp2lsTRrzBAB1zisWvNlHzle3HjHOT7d1ZJW12IkXXGfnvbNV9uums
         4neUg1rG/vhhmC9KnzymZLLUf4jaX+5tvLgxO8c1XMB+HmRo2i6xBt+ovg9jmMv2U4Vr
         m8B3wd9/8IL/PM1jnlmi/VePy6dSvGUc4Q3JhrgsosoZ2FVaov6lB4dy4gNLozqw+u92
         HJrA==
X-Gm-Message-State: APjAAAXcXw/VrcgZZWvPr+AqAPnAAFNlYzDua/jmKIa4qvq0t3WcnchK
        QOA83P6TI+LkAw/4k+zslBs=
X-Google-Smtp-Source: APXvYqxPngTmU8hHwXQJ/jC6MPCH6+qWwKTY7y7FwWq4oEEAAkQYdQz/c7ZUOSXecQ0h6K3+SksSIQ==
X-Received: by 2002:ac2:4644:: with SMTP id s4mr1709242lfo.158.1565855434435;
        Thu, 15 Aug 2019 00:50:34 -0700 (PDT)
Received: from localhost ([178.127.188.12])
        by smtp.gmail.com with ESMTPSA id b6sm353677ljk.31.2019.08.15.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 00:50:33 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 15 Aug 2019 16:50:33 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
Message-ID: <20190815075033.GA26479@tigerII.localdomain>
References: <20190809071034.17279-1-hslester96@gmail.com>
 <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/14/19 12:49), Petr Mladek wrote:
> On Fri 2019-08-09 15:10:34, Chuhong Yuan wrote:
> > strncmp(str, const, len) is error-prone because len
> > is easy to have typo.
> > The example is the hard-coded len has counting error
> > or sizeof(const) forgets - 1.
> > So we prefer using newly introduced str_has_prefix()
> > to substitute such strncmp to make code better.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by:  Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
