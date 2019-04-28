Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E1C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C1120693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556470817;
	bh=HAEghlCzUCCIZHy1LEKj6xAj/6M1XR1i1cZSzi2ej/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mfj++qKqOrynnpk930osqL6fbaA27aYMdUaIujoyCJlDCVJC7JwtF4SVeKWFAS9+i
	 00md0VFl0AP78K0Tz9YbNcy553gSelh14djOJjV+toACq274y17a9iVSU/nhaC6wBk
	 HdunLhCDpdwvju7uqS+K6N7AdtkxJfTsE6AJUTuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfD1RAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:00:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46226 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfD1RAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:00:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so5984271lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9n7p8AKaL1Ow84inuud1G/Lxyp2SJrfAsXQfEX1Lsc=;
        b=J1onYtxnImkD1yCPEBS9gRLDZmeabFG1KQ2zd//GuygjdySPtdijgil8yhuvmqIlBz
         vhB00quVwkLwhxbBRedTIz1L2NtTHT2V0SppiKXa/7ZkwlU43rJfzA+Rf1pRriD/B8lt
         D9OMVrZFGZiWAvrgv2Lt6616X3D9jvjZDhuZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9n7p8AKaL1Ow84inuud1G/Lxyp2SJrfAsXQfEX1Lsc=;
        b=LfJOyD2aa1okgcFYrraLIfwbskWCZ5TjdvahNXmRHqEixL7TpnrwfxhKhOv1v+xZZV
         m8zWtoY+uDvoNIpPMlp/I6RUF/HUwFOw4diMSyh7h4sMAvTIf3r7erNNulsGx6UywZs3
         yHYfDBCFNzrtNtvVCMV55idD/EUKuNcZZZ/HNTzLsuFRCBZehmDiTp8j0BCm5krrRiKX
         T8M1I5i2FHhypYdM96Nkx0ZmIo1N58BSFvhbJJSkYqgT0K2U5DVkvn/xaf7SslKqV9Bj
         6Vt/jTiL+S3EPl5S/PwBDZUWPOfMdw2M8nzlybu6XuEduRwxNZER4rn/mxJwOkD7cyyk
         92RA==
X-Gm-Message-State: APjAAAVJtcgORcGzEQWhhkCpZvNprZm/TJzdN5/K4tMOufP40xxRgsWP
        fY+O1a4N1rF8Ak0c0jKzoy1nbTPd+hE=
X-Google-Smtp-Source: APXvYqzNnS58pXG3Y1BI1eHy1VrWnZUbfsdRTnru4yul2x4eyXU2jqCmJATOD1lNmX2itms83iKIaA==
X-Received: by 2002:a19:1949:: with SMTP id 70mr22020469lfz.103.1556470813235;
        Sun, 28 Apr 2019 10:00:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g6sm6432343lja.64.2019.04.28.10.00.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 10:00:12 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s7so4517717ljh.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:00:12 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr4985655ljg.135.1556470811917;
 Sun, 28 Apr 2019 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190428115207.GA11924@ziepe.ca>
In-Reply-To: <20190428115207.GA11924@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 09:59:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
Message-ID: <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 4:52 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Nothing particularly special here. There is a small merge conflict
> with Adrea's mm_still_valid patches which is resolved as below:

I still don't understand *why* you play the crazy VM games to begin with.

What's wrong with just returning SIGBUS? Why does that
rdma_umap_fault() not just look like this one-liner:

        return VM_FAULT_SIGBUS;

without the crazy parts? Nobody ever explained why you'd want to have
that silly "let's turn it into a bogus anonymous mapping".

I've pulled this, but why do the rdma and SCSI people always do these
strange and pointless things?

                  Linus
