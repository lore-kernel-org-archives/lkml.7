Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B80C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1666B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hlL+PGhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfIYJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:30:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44899 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbfIYJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:30:50 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so11968756iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoKG+LEFGGjI80cfy/D8ELzKAiYahl1c5RXmUNYC+MI=;
        b=hlL+PGhKZHqXkIrAM8xIuFShQ8wQnlsRZcnM2vj3YkeSeWJpVR88bFQhXz4MZtuGeS
         kqJjXt/mGlSEPAYOOkZLIWazJf71G+XBErbJCPU4PUmInALl+VVLucN8zUeHkdxYs2bw
         bg13NOTniesCBXTZZr2monswaTop11zSrbQ7yduFSvZlzO6MxmpApMQ0e5A2Nh40ZlqZ
         HeTgbTCwvsJpHEfZnqI6tN/iVidSxoht3RfM1usHk3PfIRFU1urbk3A0RclOkcoDucfK
         ipYqYLE+eXjwch+gfdRKpFGphdi3XdiDZglTG8GDVnIKMhaBbesreNxF7KAgIMB5DkUg
         /4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoKG+LEFGGjI80cfy/D8ELzKAiYahl1c5RXmUNYC+MI=;
        b=VUCom+AyILhRUP19h9M3BlzOXbhJVOoWGnODPwqo4pw3J1OJ7IYPw7egWpAaNNlDl+
         mHEahVH32o2NbtT8uhUuVElM4JrfCdQ698bNNlDw5f6mdH6lmvngA/ZYs8dU+poMBL8J
         yR4UUfZ1xHdo3hrXeUzdn0HWdNLSFCz3B4n0+ojNe2MHWT0S6i0o/qLRHeXDQnDTjx+w
         prmXJwRX0f84E5+rweNIrUExC4+tHAm/puhUAPPo72nz4MbGdGf0q3yPUD+gtK0qlgy6
         Chp8+99CWGJ99FAHx3+xzUeP0VxoZViArIKbYfQKzoDp2k2lSatOyekfX/qVl83bNxOg
         7FMQ==
X-Gm-Message-State: APjAAAUQ5+V9vq/cI/s6T7ualvLfvwhCmhkRddwG/IVmEPG/RSrGrtIM
        3kikMcJhQhyfUyEOhz3ixlYEE4mygSKTK/AusK+A
X-Google-Smtp-Source: APXvYqyyT66uWyKaxU76gMaJXwjt3UXvaHQdez83u1Nu9ZObDjlxmg6jMKi37TKZg1HGf9jqZA0a8/XAG7TcZU/VniY=
X-Received: by 2002:a5e:cb49:: with SMTP id h9mr8756390iok.307.1569403848522;
 Wed, 25 Sep 2019 02:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-2-jinpuwang@gmail.com>
 <4cad763a-e803-1dd8-4ea5-d7ceab929841@acm.org>
In-Reply-To: <4cad763a-e803-1dd8-4ea5-d7ceab929841@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 11:30:37 +0200
Message-ID: <CAHg0Huxk5fFxzzjSR0FnGfWk6cGjfad022J_R2f60mVFeE423w@mail.gmail.com>
Subject: Re: [PATCH v4 01/25] sysfs: export sysfs_remove_file_self()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 7:21 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > Function is going to be used in transport over RDMA module
> > in subsequent patches.
>
> It seems like several words are missing from this patch description.
Will extend with corresponding description of the function from
fs/sysfs/file.c and explanation why we need it.
