Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40BAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18C720675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfD3KrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:47:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44969 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfD3KrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:47:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id h18so10315545lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 03:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmpVtnJXoZD7hpcFvy3KfMWpWjz8E7iIMZMr/p/hx08=;
        b=Mzsigt0Iay9a1zb9TTpjkIZGvp44KL5sd4n3bRpVTXs+YFe5oxFZKqLrFBq5Ra5Etj
         Z+WCSxLm1WWRD4B7opQN2po8AX5JkGNNQgyJs7SQibqzIgxuEJvGEJl9xzj6hjZjmkxh
         bP+Khy4pRmJ2HK+e8A/sNg/XFgZQpL9Fk12eXq+wzrtIBVHGobfsGXGkmePJIixpx5TM
         TSdL7cIB8FrWX8C+naV+yI354mdLIJnCc4au81gAopTghmzzk4nkZ9Qcrgf03nFp2YaM
         I6mCH4c5tEMdp/GOXLLnvXjmOwq6eZTLEUFoBt3VoCVEkfG3pTZKCy6ToPhl+wwrGXwJ
         yQFg==
X-Gm-Message-State: APjAAAWSnR6ZzKFkpBJfxU5rXVa3EWKszyhgexDSeLSLTMmFWOaQsZeY
        H4ISwjmDxE75jSiQSl5Xa7jK5jGP+XOMZDumczcoVTA/
X-Google-Smtp-Source: APXvYqwQw358S3PMpr7zTHIOWFDZ2GZkPL/RkKarMWKmXIh0nGsO6gwvqzyuRx+/utLNMRV4qHESkYTIoNTKFCQ2AY0=
X-Received: by 2002:a19:a417:: with SMTP id q23mr34990275lfc.110.1556621228264;
 Tue, 30 Apr 2019 03:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com>
In-Reply-To: <20190429222613.13345-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 30 Apr 2019 12:46:31 +0200
Message-ID: <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Add a const int array containing the most commonly used values,
> some macros to refer more easily to the correct array member,
> and use them instead of creating a local one for every object file.
>

Ok it seems that this simply can't be done, because there are at least
two points where extra1,2 are set to a non const struct:
in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
and a struct net.

So, sadly making extra1,2 const is a no-go :(

Andrew, I'm thinking to add the "sad and lame" cast in the macro, to
have a single point where hide it


Regards,
--
Matteo Croce
per aspera ad upstream
