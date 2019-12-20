Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA8EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31982206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AEuugIbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:26:43 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35801 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLTQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:26:42 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so8454820ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=AEuugIbB9WF845MSH5WI6aAhvlU0SMwnsAkN5hO2bYAsqNIwrUOXb5eSnBTsDtYftJ
         jjtpHfTfy7MvgKkeQ+aJ4scdVeZKOb7UNymDQjdYn9K290SGfuYR3Hf4wyqfvUIdpBVy
         xGnMQHopqgNrfj0GHWMUCmEy4+hBc5m9SBXIQz0b/3v6Hc9f2igwwqhCqPvqdEGD4SgH
         alwXEnkX19G7hb2LjRi97+NG4ndRVomaLuZpZ6gutg/DTRC6gggGLBEdX+1WG7yh0S29
         qCQd2aZpQmfwWcgneT49zSCxvqrBpL7IDDube6EDsAzWPfjlLHYrS4fbBvM9Ntabozew
         0FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=CGbeV524oLq6QOkc0Jz0neckwb+4amt1ZTq9mhKUTGgtmOR7cwSl/XT/aEqzx+r+Bt
         pATd/OLd0PW2BRNoPWireoKp9eUM9lhG2WYzbMfIlDVuEgLoCjzgs1HPismtXtJ4C0nC
         IYiiPmJsjW0ByGkBv2qQAIwxDtlBz2A1S/NdX7ao8Fx68qfEa/vvc+2IrwgcebS/DtZZ
         ceMF8pNE4vLTdstax8BEwRk3LX20ffE15I2r4+o0I2NylDrpTQn1JlGyREmngXoN5W1I
         eoTrRH44PkAeIe5qAFp3SAt+lFK8r7v3MemM0WOO70S5k7iLUH59KCsF1E6afauv8zgp
         n62A==
X-Gm-Message-State: APjAAAUPKD4DazTxNGFKsRRbcoLdrqfsaME8+01QxNPw/kGde88BfxyL
        9+pYCoJIZqIcmhzEmIaWxNqYh0Qtvb5UNvrbdDLJJ3yx
X-Google-Smtp-Source: APXvYqwuLs7NjC3AP9OHJgs9RHyJryAKeItR8Tg55boVjTWuxFzoVgvETeExPk+NFhdbfwfZE34jAox3WSo+hyDsZm8=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr13316300ill.71.1576859202125;
 Fri, 20 Dec 2019 08:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-2-jinpuwang@gmail.com>
In-Reply-To: <20191220155109.8959-2-jinpuwang@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 20 Dec 2019 17:26:31 +0100
Message-ID: <CAMGffE=GDo8BgKGXpvTHZNOuCXViyfG2QfOzNDpCJR9kjFSnmg@mail.gmail.com>
Subject: Re: [PATCH v5 01/25] sysfs: export sysfs_remove_file_self()
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.iono.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:51 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> From: Jack Wang <jinpu.wang@cloud.iono.com>
>
> Function is going to be used in transport over RDMA module
> in subsequent patches, so export it to GPL modules.
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> [jwang: extend the commit message]
> Signed-off-by: Jack Wang <jinpu.wang@cloud.iono.com>
Sorry, I made a mistake, the email address was wrong, should be cloud.ionos.com,
I've fixed it locally, it will be fixed next round if necessary.

Regards,
Jack Wang
