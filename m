Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBDFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DDF2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563219127;
	bh=YjaElKgh6V5+V8h894mheJRH0y+FW+QKQjxIt+i/LYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H3M15gX6ua5mz6RJSv0FGIR0+I3Syp84L6H65pApK1G7QyThgsqIlgg39KhQ0ZNfO
	 r5/sHak4aU4Aira+9JNZ0FFTJrZ+GNowH/IcQDOzi5WVACIPApvU+wMdAq7JRMaIMX
	 Ulojk1/OHE/tzZl2PDi3Ab2GbtYztSUPHH7uzw7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfGOTcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:32:04 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:46083 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfGOTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:32:04 -0400
Received: by mail-lf1-f42.google.com with SMTP id z15so7553546lfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QH6mzwJIBaZ3G36AHlLbxgzJ8rwuVsgI+lLEoxYsK9w=;
        b=fZquCJKyVQmNiOuila449WNml0toGrUhvi/TXjq6RmeJeTSHXMPfrC1NN9OKxfEA1T
         pgWXSeBYNLl98LgbeaKaiAwNtqam9tD+vpgz79U6td8Cesv7eEszSbvGC3jcYfZC7jaX
         rBMA37V6hr/kMJRWw/9WJWu6Tm8uev7R4tEG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QH6mzwJIBaZ3G36AHlLbxgzJ8rwuVsgI+lLEoxYsK9w=;
        b=dAQosUzEBPb1yEYBJE6saNRMrq/lOmqqn57CacU6AX/naCuo9b1B+PWnvbiNTg2aQm
         x+AR9IL2enavXGf7xgQ192KqW5defFbqou7z/WDh/8zBDEqrGXKau2SFHHgiX7P2+GHa
         O1VLOtFRzEapmzQxNmcMZc9gXDBxBFzyKjC5uUHxVtc+xf6HJ2AaKl/MB8kC3SAj7+dM
         XED+auGGvDDnASDG3gXaHkx93yzXq34iJlXq8TFMt0BqxbNxv4CTN1JFLxvWRTDdIraG
         wmOxewqwf0/ytw2rzfMuxzZt7etyVLqB6TTKBSIRjMC0KjFAsFaoNjPicuIV3SQEZS4/
         LLZA==
X-Gm-Message-State: APjAAAW28l/tB/aE5LJl04De0TIlCJcizI5MQkJhVWn6et6htOJRMakO
        pRuAJ6fv79xf/2p7MGeKOw5LKEyPYDg=
X-Google-Smtp-Source: APXvYqzLjFNO/k+B+N2oKJQ0foMyN1U096WcmVKTAf4JRVjZ7QPZaGLsSQEL4AaxSRzy3nEK6/3qXw==
X-Received: by 2002:a19:914c:: with SMTP id y12mr12356165lfj.108.1563219121537;
        Mon, 15 Jul 2019 12:32:01 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e26sm3331461ljl.33.2019.07.15.12.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:32:00 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id b29so4590548lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:32:00 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr12319620lft.79.1563219119724;
 Mon, 15 Jul 2019 12:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com> <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
 <20190715191702.GD5043@mellanox.com>
In-Reply-To: <20190715191702.GD5043@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 12:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH=SduQ+2bSERNuf9TC-NQn-3=BqToDuL8diB=k8_+vA@mail.gmail.com>
Message-ID: <CAHk-=wiH=SduQ+2bSERNuf9TC-NQn-3=BqToDuL8diB=k8_+vA@mail.gmail.com>
Subject: Re: DRM pull for v5.3-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:17 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> About the only thing I could concretely suggest for working with -mm
> is if there was some way the -mm quilt patches could participate in
> 'git merge' resolution at your level.

Andrew did make noises about having multiple git branches. We'll see.

                    Linus
