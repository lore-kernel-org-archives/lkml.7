Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB891C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8D206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ8f+5k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfHMVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:43:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44932 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHMVno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:43:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so109117256wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HA9k4jWcE6EwpyfOVUWvgKBkx2GCDQVhMAM3RavZwSg=;
        b=MZ8f+5k/fznc/QyZGQ49I994yYlfbf9RAnpB0jyHIPrUh3mMdiOFe3fkYs2TiTiBPy
         Wl7N73j2Ax6sZSOd65X6LBFT5iH4lHRU2szMkMqFtwaDxrGnjON8WdtK3vKq6eCLxIdc
         yVPjBrtZgx6r5OocIKhakmMryH4iulCdqewIr6aoyLxlVTiPtpCfja4ZUdWK6EBLZ5CT
         Oml3VqmkzSkURgzZEzLmRNyRJbxqlQ+bTgIXnZYigiiNv9twJdtivck2hFpp4lRMxLu1
         oynIeRB8iADJn5Yfy9PMQxsF6Lplkhqt3oOmP5L2OfA7XQJ0l+gnyu/r5gHKvH8wA2TK
         GJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HA9k4jWcE6EwpyfOVUWvgKBkx2GCDQVhMAM3RavZwSg=;
        b=LSgkXjCnzlC3nvHH0xMrYM1EVyi4sMDQpJXicoHy/ItavKfSSqELKXzjUr9f2epYk1
         130NVVYGwPB6UWzRPkhDwG7bRV+vbQdV1fu/sBUNout2Dz9IFF+/yuq0qFcytDBRbey0
         wcSB0nUhkYBewKyV9jqZCDnUgdXTcSQFGTZBhIzYVhqjN0DPSsQGoRLvKzGaEPNaj5i2
         zJAH6FJJmMLp9MYXUNqJmCKneTFm/2mPOzmxsBDzn7BMZOeUPHY5yj7gd/vGhdaACL+y
         1aMo1GDmmoMI9SYE1aBLUZFCbAtaliXz5QI2gdZX04sAtuzHjBifuCW7NTcUcGRqj2+W
         ffnw==
X-Gm-Message-State: APjAAAXjnj/9YO/hU26oHOic89HZSfCbmjwIgehJQzATvsIf/i2ephho
        9VxXH5gk6krRcZfQ1GopqTkg8JHl/5bdhg63A/9wXw==
X-Google-Smtp-Source: APXvYqzyOwmCS3luTkiGFItwHavkb2r/eG0oc98BsPGyOILjb86vRta7cOC8vBlzNcCh/BeA/oRT6W0V30fAh4qSWU0=
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr44881907wrx.100.1565732621921;
 Tue, 13 Aug 2019 14:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvxEAGtQDFm4G3orY+M9yuthDA4j0+u=HbE9DKuo7H8WCg@mail.gmail.com> <0B80F9D4116B2F4484E7279D5A66984F7A7472@dggemi524-mbx.china.huawei.com>
In-Reply-To: <0B80F9D4116B2F4484E7279D5A66984F7A7472@dggemi524-mbx.china.huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 13 Aug 2019 23:43:30 +0200
Message-ID: <CAFLxGvz__aw+BnfmGS3XXGqT6n6q-9miLPoVcL9KuvaZ2QbVUQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps
To:     chengzhihao <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:21 AM chengzhihao <chengzhihao1@huawei.com> wrote:
>
> OK, that's fine, and I will continue to understand more implementation code related to this part.

I think we can go with the realloc() approach for now.
Can you please check whether the assert() triggers?

-- 
Thanks,
//richard
