Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2910C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA1C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="M7Ew+e8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfG2Imc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:42:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37371 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfG2Imc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:42:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so35757768wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HM9wt+7L8iCxq+XhLcq/mYJLhBqmWxeU0HeP7054uFI=;
        b=M7Ew+e8V8IYqDaBkX9ZqaOWxitWlDsnStPaZJZocWesm17uealDovRVwxHNaw5Ww7x
         s5//Gxpc3fLoi7ksTk3qDFih0C3QUNtPN9Hthj/kWn26w5RatTy8DdJ3n4cyvh4ZPDCI
         Vu2CA7Fa9ymRTgw33vwx5Dmhh1QJMhnpMlFweCaaA+WXKF0o3BzF7NEF6wDLPyaUO4Ym
         5rOoG6gM2QBJUL/kZSGsV/rab+xx5zXg4PLx1HT6UpNTxX7aEZ+iys+alntQl5a8hELQ
         r5eMb8oAyM1hfJ4sjxv2Wo0dXi3ahq1nTZ2Txioql/YsWGF1JsHvPHYo6NscGifbDTUy
         sbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HM9wt+7L8iCxq+XhLcq/mYJLhBqmWxeU0HeP7054uFI=;
        b=P8lBCaDP8H7YKZVMD4hrVAjneqcdGtMsmBypq6EUyJ8cbu54FNHz/F1RYeYpjP7D2a
         /JIxQFjj8D2U3P8tlYY8xDQa6ctS6Kl7gd7IGr0TbR7pkIFP7lsOxGmhB97Kml7MhHES
         T9IvaFwTO73UcX/g7AtiOuwzhhZ3A0gxoZQg9GQS9hEPuXOD/KNVEct9J0EmPvMyMLmf
         6PQqxqUzjB+vlnrvLia+6URZvf59BN+wQH3WVC3OcN1TA49m2n01cyzB2hjIZz+Z7lTI
         ypn+RCXQbLfP95RWL/vvpWdz9MF0j+7uxoFgLRCY405E0EzXllOWX2lOb9W5AMOXHjxg
         CEgA==
X-Gm-Message-State: APjAAAWKg7tC0AhZPy8VKAUi8FbUTogf5UGRXYiy+6ArYGKbMfrhtteX
        3Je47DlrZxQMEyWVV492lJ8=
X-Google-Smtp-Source: APXvYqyZM49wAAISdKAPa1qeQvCisClNRF0liq1nsGklqMEN5hl9QSImiAElZn2gaM/Fj3NkJvA+RQ==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr114007668wrt.227.1564389750065;
        Mon, 29 Jul 2019 01:42:30 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id c78sm84201547wmd.16.2019.07.29.01.42.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:42:29 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:42:28 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: sched: Fix a possible null-pointer dereference
 in dequeue_func()
Message-ID: <20190729084228.GD2211@nanopsycho>
References: <20190729082433.28981-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729082433.28981-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 29, 2019 at 10:24:33AM CEST, baijiaju1990@gmail.com wrote:
>In dequeue_func(), there is an if statement on line 74 to check whether
>skb is NULL:
>    if (skb)
>
>When skb is NULL, it is used on line 77:
>    prefetch(&skb->end);
>
>Thus, a possible null-pointer dereference may occur.
>
>To fix this bug, skb->end is used when skb is not NULL.
>
>This bug is found by a static analysis tool STCheck written by us.
>
>Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
>Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
