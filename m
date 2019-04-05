Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBFDC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F84721738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5a0/qwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfDESay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:30:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55614 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfDESax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:30:53 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so4431051itc.5;
        Fri, 05 Apr 2019 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6TlcubHlXKJDz2HgaUxMqtqUbPGV3QCmyVIqTuPCF0=;
        b=n5a0/qwxYeSZu+/73B7fDXhqn9zsEyY7eUmilUe7n8NGE5WdXYPQ8klwI760WOCu6i
         W1+N+yK/5Hyb35GXaczmINKsBK2dZGnIZFHaOPxJfG1GKmWE2wTUrJzVWPlbsOFQJGWX
         ug0/Lm5afAYIocHgrlEHvzMR3dvaQ9CKthCGxeOhNUPdPJf39eoX6g0Q8+X36NKuOaVf
         dHTmFwKVPtJTU91rbC1Axx9Q0XtzX92xqW/J/Nl+l+hDF2zJtKXelV7O3EqAeXFC5yX7
         ZcCLELJVBy3AWullRwq4iNAH2wyZsKdLr/xMgeU+9FSb+yfIc3V91bkODM0rYpZyLO6T
         zv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6TlcubHlXKJDz2HgaUxMqtqUbPGV3QCmyVIqTuPCF0=;
        b=pywaYil6kVE9FoMgTBhxX/6YQMsVlWqoiNbJ1MRm9fy2AJOGt0wVJnjWTUahnTfimv
         LUTb9SVSQ3ou/o6Uk6x12zs27ufpEdcOieO77bJXn9Bv0DsNEELIFnL+9niqg8+1Q16c
         L54Sw1vYR6qEbEFG/wD8SU3tKlzzo8cY9x79tzfZlft1463LVGlD/q0zCJQilwppWhC6
         Z983Lh/Bdt1rKpSeEZhNXvCRM/hd+/WdCt7KS6qA5yxTBkKs4Hbta5DyDr8f+iWnwIs6
         aHUDIxGStE5SpDVA1XXmoE9XCblC8rcPM237sq51881jAiGaLi/DnlLJv0YliNn97eIw
         u3NA==
X-Gm-Message-State: APjAAAUu654aqpGyT/eZeTFOsTIoRMrMHviDB3JVePcIycTFPAzQpAFv
        ZkIM9QM/Rp7mLRvu0YXN6p2q7ro0L6xTdj5mfE0=
X-Google-Smtp-Source: APXvYqwhI8i2yn6RTuiRykOQGOADYuqsIN5BD3f9wJULWnB86k+0SqXzY7LBuN+upj/rZkuguI+RhSTL/eKpdd0d13Y=
X-Received: by 2002:a02:1d03:: with SMTP id 3mr11016326jaj.73.1554489052662;
 Fri, 05 Apr 2019 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-12-andrew.smirnov@gmail.com> <6b2bb239-dc98-df92-1999-0ae914732e17@linaro.org>
In-Reply-To: <6b2bb239-dc98-df92-1999-0ae914732e17@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:30:41 -0700
Message-ID: <CAHQ1cqGohyy=0yFjaVK1Xy=MBDmca9B1Ea+dfDWwmGs65G6uxw@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] thermal: qoriq: Do not report invalid
 temperature reading
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 2:05 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Before returning measured temperature data to upper layer we need to
> > make sure that the reading was marked as "valid" to avoid reporting
> > bogus data.
>
> Is it possible to add a comment above the read_poll to describe the
> layout of the register ? That will help to understand the valid bit.
>

Sure, will do.

> Is the valid bit reset after reading the value?
>

It works a bit differently. Here's the description form the datasheet:

Valid measured temperature.
   0    Not valid. Temperature out of sensor range or first
measurement still pending.
   1    Valid.

Thanks,
Andrey Smirnov
