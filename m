Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A77C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912F72133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hP912DHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404203AbfEXPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:00:47 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33959 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404095AbfEXPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:00:47 -0400
Received: by mail-yw1-f68.google.com with SMTP id n76so3760767ywd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbtKxkwrkp0kCxg+pHFi0H5w7pzQ4JvysCOdR65ntSs=;
        b=hP912DHlGGxRkOBOGBRcPLrqi+t2Legh/a7RXslTTOjNWN/BunUwJY8ncQXH+52AGc
         mZ7lQSLnopPsPQLeYAeYlh+UV35O7I/BKhpKv7vvo42UFjCPFx+13C/+1sPuQw2jt2k5
         WwrHaSgXDfBbvYxynUpJzGAaPgVIQa5cWOJLHImaCFnvA04JhA33DnBMV1jjw34QT+7O
         VZZxBS5lO0XZTNUxGsgPtAG4RMsoE4qA7oiHf6cCuLdHT0JoN6VKxdhLV2aEJ8i9FluJ
         MGukUT3RXdCORp2RRIvhk8rR2A2pRJRkNLc+hJ9ygZlh5lw8sFL7kYZQuUKtZyDo0eO2
         2qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbtKxkwrkp0kCxg+pHFi0H5w7pzQ4JvysCOdR65ntSs=;
        b=HT4PuIznlZTwzB/jKfwhYAV761gfsbJPL/zHn/oM9hMcT0tV6jGufBhljwZaGN6KID
         hBJID7j8quuzGh2PBfGIo0LQT0waYvAcB7YD9dAe2fpMcM1YdFQwkdwCKJx01ojb2JIe
         DSjugTWWCBOPeV3qS3NU9CTBLmEZ/KQ92615/HlRRtFZYOw+dIT8Zr6qFSGniNBxvF0D
         MreklOTHQF87QLqXEflohIJBB+amBIxGfD+s2pqGivfqrZ0GAF1VK/TwbiZAmpgwxPY3
         k3EuYxpJfHvRNsh2JIIwN/5PBRzRUC1Ipq7AIrPY9/Pho87AOfXKWpoC/7lvvNlLQVse
         Kicw==
X-Gm-Message-State: APjAAAXwf19rU2AU1kiC31CWWk+5tqPXadzRupU3rDJO/mZdmjFsZ62M
        +hrZwUEZaJzmGasfHkeLg/Pi5y9SDUatNNs55EbG/g==
X-Google-Smtp-Source: APXvYqzdSQ99BC3X75DHWp283GJcyJz95TzzlKhMVclhU4yqACB3NNj8Rh8ZXkerSG7bbs0cjnou+j0YYlW9FA+Qxes=
X-Received: by 2002:a81:3217:: with SMTP id y23mr47288650ywy.386.1558710046098;
 Fri, 24 May 2019 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190524143827.43301-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20190524143827.43301-1-wangkefeng.wang@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 24 May 2019 08:00:34 -0700
Message-ID: <CANn89i+rSEJ3Rqd5JW-w7aLzETMX89Qgg3wne9Ae7WWDBe3yZg@mail.gmail.com>
Subject: Re: [PATCH] kernel: sysctl: change ipfrag_high/low_thresh to CTL_ULONG
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 7:30 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> 3e67f106f619 ("inet: frags: break the 2GB limit for frags storage"),
> changes ipfrag_high/low_thread 'type' from int to long, using CTL_ULONG
> instead of CTL_INT to keep consistent.


What about  compatibility with existing applications ?
Will there sysctl() fail if they provide 32bit variable ?

/proc/sys/net  files are text files, but sysctl() system call has been
discouraged for more than a decade.
